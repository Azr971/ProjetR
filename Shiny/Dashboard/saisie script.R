pal <- colorNumeric(
 palette = "Purples",
 domain = data.frame(contour_regions)$NBRE_NAISSANCES
)
leaflet() %>% 
  addTiles() %>% 
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