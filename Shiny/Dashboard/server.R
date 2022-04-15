
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
}