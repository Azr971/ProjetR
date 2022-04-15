
fluidPage(
  
  theme = shinytheme("lumen"),
  
  tags$link(rel = "stylesheet", href = "style.css"),
  
  tags$h1("Les naissances en France métropolitaine",
          class = "titre"
  ),
  navlistPanel(
    widths = c(3,9),
    id = "navlist",
    header = tagList(# header : met le résultat tout en haut
      conditionalPanel(
        condition = "input.navlist != 'Carte'",
        fluidRow(
          column(
            width = 9,
            radioGroupButtons(
              inputId = "niveau",
              label = "Afficher :",
              choices = list(
                "France" = "fra",
                "Région" = "reg",
                "Département" = "dep"),
              selected = "fra",
              justified = TRUE
            )
          ),
          column(
            width = 3,
            
            conditionalPanel(
              condition = "input.niveau == 'dep' | input.niveau == 'reg'",
              selectizeInput(
                inputId = "region_ou_dep",
                label = NULL,
                choices = NULL
              )
            )
          )
        )
      )
    ),
    tabPanel(
      title = "Général",
      # 3 colonnes de largeur 4
      fluidRow(
        column(
          width = 4,
          statiCard(
            value = 0,
            subtitle = "Nombre de naissance en 2020",
            icon = icon("child"),
            color = "#112446",
            animate = TRUE,
            id = "card_n_naissances"
          )
        ),
        column(
          width = 4,
          statiCard(
            value = 0,
            subtitle = "Taux de natalité en 2020",
            icon = icon("chart-line"),
            color = "#112446",
            animate = TRUE,
            id = "card_natalite"
          )
        ),
        column(
          width = 4,
          statiCard(
            value = 0,
            subtitle = "Pic de naissance",
            icon = icon("arrow-up"),
            color = "#112446",
            animate = TRUE,
            id = "card_pic"
          )
        )
      ),
      fluidRow(
        column(
          width = 6,
          apexchartOutput(outputId = "nombre_naissances_temps")
        ),
        column(
          width = 6,
          apexchartOutput(outputId = "taux_natalite")
        )
      )
    ),
    tabPanel(
      title = "Carte",
      fluidRow(
        column(
          width = 8,
          radioGroupButtons(
            inputId = "niveau_carte",
            label = "Afficher :",
            choices = list(
              "Région" = "reg",
              "Département" = "dep"
            ),
            justified = TRUE
          )
        ),
        column(
          width = 4,
          prettyRadioButtons(
            inputId = "variable",
            label = "Choix de la variable : ",
            choices = list(
              "Nombres de naissances",
              "Taux de natalité",
              "Age moyen de la mère")
          )
        )
      ),
      leafletOutput(outputId = "carte", height = 600)
    ),
    
    tabPanel(
      title = "Données",
      reactableOutput("tableau")
    )
  )
)

