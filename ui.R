library(shiny); library(bslib); library(DT)

fluidPage(
  hr(),
  
  fluidRow(style = "background-color: #66CDAA; align-items: center; justify-content: center;",
           column(5,
                  fileInput("recortado", label = tags$h4(style = "font-weight: bold;", "Ubicación RECORTADOS"), 
                            accept = ".xlsx", width = '100%', multiple = TRUE)
           ),
           column(5,
                  fileInput("cuadro", label = tags$h4(style = "font-weight: bold;", "Ubicación CUADROS"), 
                            accept = ".xlsx", width = '100%', multiple = TRUE)
           ),
           column(2, hr(),
                  actionButton("cotejo", label = tags$span(style = "font-weight: bold;", "COTEJO"), width = '100%', icon = icon("jedi"))
           )
  ),
  
  fluidRow(style = "background-color: #F5FFFA; align-items: center; justify-content: center;",
           column(2,
                  selectInput("indicador", label = tags$h5(style = "font-weight: bold;", "~ INDICADOR ~"), choices = list("-" = "-"), selected = 1)
           ),
           column(10, hr(),
                  card(textOutput("veredicto"), height = "100%"), hr()
           )
  ),
  
  card(dataTableOutput("confronta"), height = '690px')
)
