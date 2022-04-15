
function(input, output, session){
  output$nombre_naissances_temps <- renderApexchart({
    apex(
      data = naissance_france,type =  "line",  mapping = aes (
      x = as.Date(paste0(ANNEE,"-01-01", format = "%Y-%m-%d")),
      y = NBRE_NAISSANCES
      )
    ) %>% 
  ax_xaxis(labels = list(format = "yyyy")) %>% 
  ax_tooltip(
      x = list(format = "yyyy")
    ) %>% 
    ax_title(
      text = "Nombre de naissances entre 1975 et 2020"
    ) %>% 
    ax_colors("#112446")
  })
  
  output$taux_natalite <- renderApexchart({
    apex(
      data = naissance_france,
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