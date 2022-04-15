
function(input, output, session){
  
  Naissance_r <- reactive({
    if (input$niveau == "fra"){
      naissance_france
    } else if (input$niveau == "reg"){
      req(input$region_ou_dep %in% naissance_region$GEO)# pour être sûr que ce qu'on selectionne c'est le bon ex: la bonne region
      naissance_region %>% 
        filter(GEO == input$region_ou_dep)
    } else if (input$niveau == "dep"){
      req(input$region_ou_dep %in% naissance_departement$GEO)
      naissance_departement %>% 
        filter(GEO == input$region_ou_dep)
      }
  })
  
  
  observeEvent(input$niveau, {
    if (input$niveau == "reg"){
      updateSelectInput(
        inputId = "region_ou_dep",
        label = "Région :",
        choices = unique(naissance_region$GEO)
      )
    } else if (input$niveau == "dep"){
      updateSelectInput(
        inputId = "region_ou_dep",
        label = "Département : ",
        choices = unique(naissance_departement$GEO)
      )
    }
  })
  
  observeEvent(Naissance_r(),{
    Naissance_r() %>% 
      filter(ANNEE == 2020) %>% 
      pull(NBRE_NAISSANCES) %>% 
      format(big.mark = " ") %>% 
      updateStatiCard(id = "card_n_naissances")
    
    x <- Naissance_r() %>% 
        filter(ANNEE == 2020) %>% 
        pull(TAUX_NATALITE)
      updateStatiCard(id = "card_natalite", value = paste0(x, "\u2030"))
    
    Naissance_r() %>% 
      slice_max(NBRE_NAISSANCES, n =1) %>% 
      pull(ANNEE) %>% 
      updateStatiCard(id = "card_pic")
    
  })
  
  output$nombre_naissances_temps <- renderApexchart({
    apex(
      data = Naissance_r(),type =  "line",  mapping = aes (
      x = as.Date(paste0(ANNEE,"-01-01", format = "%Y-%m-%d")),
      y = NBRE_NAISSANCES
      )
    ) %>% 
  ax_xaxis(labels = list(format = "yyyy")) %>% 
  ax_tooltip(
      x = list(format = "yyyy"),
      y=list (
        formatter = format_num(format=",", locale = "fr-FR") # format les chiffres renvoyés en FR, avec le séparateur (voir ?format_num)
      )
    ) %>% 
    ax_title(
      text = "Nombre de naissances entre 1975 et 2020"
    ) %>% 
    ax_colors("#112446")
  })
  
  output$taux_natalite <- renderApexchart({
    apex(
      data = Naissance_r(),
      type =  "column",
      mapping = aes (
        x = as.Date(paste0(ANNEE,"-01-01", format = "%Y-%m-%d")),
        y = TAUX_NATALITE
      )
    ) %>% 
      ax_tooltip(
        x = list(format = "yyyy")
      ) %>% 
      ax_title(
        text = "Taux de natalité"
      ) %>% 
      ax_colors("#112446")
  })

  output$carte <- renderLeaflet({
    pal <- colorNumeric(
      palette = "Purples",
      domain = data.frame(contour_regions)$NBRE_NAISSANCES
    )
    leaflet() %>% 
      addTiles() %>% 
      setView(lng=2.8, lat = 46.8, zoom = 6) %>% 
      addProviderTiles(
        providers$OpenStreetMap.France, group = "OpenStreetMap.France"
      ) %>% 
      addProviderTiles(
        providers$Esri.WorldImagery, group = "Esri.WorldImaginery"
      ) %>% 
      addLayersControl(
        baseGroups = c("OpenStreetMap.France", "Esri.WorldImaginery"),
        options = layersControlOptions(collapsed = TRUE)
      ) %>% 
      addPolygons(
        data = contour_regions,
        label = ~ GEO,
        fill = TRUE,
        fillColor = ~ pal(NBRE_NAISSANCES),
        fillOpacity = 0.7,
        color = "#424242",
        opacity = 0.8,
        weight = 2,
        highlightOptions = highlightOptions(color = "white", weight = 2),
        popup = ~ paste0("Nombre de naissances : ", NBRE_NAISSANCES)
      ) %>% 
      addLegend(
        position = "bottomright",
        title = "Nombre de naissances en 2020",
        pal = pal,
        values = data.frame(contour_regions)$NBRE_NAISSANCES,
        opacity = 1
      )
  }
  )
  
  observe({
    if (input$niveau_carte == "reg"){
      contour <- contour_regions
    } else {
      contour <- contour_departements
    }
     if (input$variable == "Nombre de naissances") {
       palette <- "Purples"
      valeurs <- contour %>% 
        pull(NBRE_NAISSANCES)
     } else if (input$variable == "taux de natalité"){
       palette <- "Reds"
       valeurs <- contour %>% 
         pull(TAUX_NATALITE)
     } else {
       palette <- "PuRd"
       valeurs <- contour %>% 
         pull(AGE_MOYEN_MERE)
     }
     
    pal <- colorNumeric(
      palette = palette,
      domain = valeurs
    )
    leafletProxy("carte") %>% 
      clearShapes() %>% 
      addPolygons(
        data = contour,
        fill = TRUE,
        fillColor = ~ pal(valeurs),
        fillOpacity = 0.7,
        color = "#424242",
        opacity = 0.8,
        weight = 2,
        highlightOptions = highlightOptions(color = "#424242"), label = ~ paste0(GEO, ":", valeurs
    )
    )
      })
  }