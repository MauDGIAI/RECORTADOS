library(shiny)

function(input, output, session) {
  
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
  
}
