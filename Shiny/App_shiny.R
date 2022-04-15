library(shiny)

ui <- fluidPage(
  tags$h1("Distribution de proba en R"),
  fluidRow( 
    column(
      width = 4,
      wellPanel(
        tags$h3("ParamÃ¨tres :"),
        selectizeInput(
          inputId = "loi",
          label = "choisissez une loi",
          choices = list(
            "",
            "Normale" = "rnorm",
            "Uniforme" = "runif",
            "Exponentielle" = "rexp",
            "Poisson" = "rpois"
          ),
          options = list(
            placeholder = "Selectionner...")
        ),
        
        sliderInput(
          inputId = "bins",
          label = "Nombre d'intervalles",
          min = 30, max = 100, value = 30
        ),
        textInput(
          inputId = "Titre",
          label = "Titre du graphique : "
        )
      ) 
    ),
    column(
      width = 8,
      "Moyenne :", textOutput(outputId = "texte",inline = TRUE),
      plotOutput(outputId = "plot")
    )
  )
)

server <- function(input, output, session) {
  
 output$texte <- renderText({
  mean(valeurs_r())
 }) 
valeurs_r <- reactive({
  validate(
    need(input$loi !="", "vous devez sélectionner une loi")
  )
  valeurs <- if (input$loi == "rnorm") {
    rnorm(1000)
  } else if (input$loi == "rexp"){
    rexp(1000)
  } else if (input$loi == "rpois"){
    rpois(1000,1)
  }else if (input$loi == "runif" ){
    runif(1000)
  }
  return(valeurs)
})
 output$plot <- renderPlot({
   
  
   qplot(valeurs_r(), geom = "histogram", bins = input$bins) +
   labs(title = input$Titre)
 })
}

shinyApp(ui, server)