library(shiny); library(bslib); library(DT)

fluidPage(
  fluidRow(style = "background-color: #000000; align-items: center; justify-content: center;",
    column(2),
    column(3,
           actionButton("RvsC", label = tags$span(style = "font-weight: bold;", "RECORTADOS vs CUADROS"), width = '100%', icon = icon("gamepad"))),
    column(2),
    column(3,
           actionButton("CvsC", label = tags$span(style = "font-weight: bold;", "CUADROS vs CUADROS"), width = '100%', icon = icon("feather"))),
    column(2)
  ),
  
  uiOutput("caratula"),
  
  fluidRow(style = "background-color: #F5F5F5; align-items: center; justify-content: center;",
           column(2,
                  selectInput("indicador", label = tags$h5(style = "font-weight: bold;", "~ INDICADOR ~"), choices = list("-" = "-"), selected = 1)
           ),
           column(10, hr(),
                  card(textOutput("veredicto"), height = "100%"), hr()
           )
  ),
  
  card(dataTableOutput("confronta"), height = '1000px')
)
