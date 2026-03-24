library(shiny)

function(input, output, session) {
  
  observeEvent(input$RvsC, {
    output$caratula <- renderUI({
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
      )
    })
  })
  
  observeEvent(input$CvsC, {
    output$caratula <- renderUI({
      fluidRow(style = "background-color: #F4A460; align-items: center; justify-content: center;",
               column(5,
                      fileInput("recortado0", label = tags$h4(style = "font-weight: bold;", "Ubicación CUADROS 1"), 
                                accept = ".xlsx", width = '100%', multiple = TRUE)
               ),
               column(5,
                      fileInput("cuadro0", label = tags$h4(style = "font-weight: bold;", "Ubicación CUADROS 2"), 
                                accept = ".xlsx", width = '100%', multiple = TRUE)
               ),
               column(2, hr(),
                      actionButton("cotejo0", label = tags$span(style = "font-weight: bold;", "COTEJO"), width = '100%', icon = icon("jedi"))
               )
      )
    })
  })
  
  observeEvent(input$cotejo, {
    source("cotejo.R")
    recortado <- input$recortado[order(input$recortado$name),]
    cuadro <- input$cuadro[order(input$cuadro$name),]
    ceros <- f_confronta(as.character(recortado$datapath), as.character(cuadro$datapath),
                         as.character(recortado$name))
    updateSelectInput(inputId = "indicador", choices = names(ceros$II))
    
    output$veredicto <- renderText(ceros$I)
    output$confronta <- renderDataTable({ ceros$II[[input$indicador]] }, 
                                        options = list(paging = FALSE, searching = FALSE, info = FALSE, ordering = FALSE))
  })
  
  observeEvent(input$cotejo0, {
    source("cotejo.R")
    recortado <- input$recortado0[order(input$recortado0$name),]
    cuadro <- input$cuadro0[order(input$cuadro0$name),]
    ceros <- f_confronta2(as.character(recortado$datapath), as.character(cuadro$datapath),
                         as.character(recortado$name))
    updateSelectInput(inputId = "indicador", choices = names(ceros$II))
    
    output$veredicto <- renderText(ceros$I)
    output$confronta <- renderDataTable({ ceros$II[[input$indicador]] }, 
                                        options = list(paging = FALSE, searching = FALSE, info = FALSE, ordering = FALSE))
  })
  
}
