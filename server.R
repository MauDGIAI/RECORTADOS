library(shiny)

function(input, output, session) {
  
  observeEvent(input$cotejo, {
    source("cotejo.R")
    ceros <- f_confronta(input$recortado, input$cuadro)
    updateSelectInput(inputId = "indicador", choices = names(ceros$II))
    
    output$veredicto <- renderText(ceros$I)
    output$confronta <- renderDataTable({ ceros$II[[input$indicador]] }, 
                                        options = list(paging = FALSE, searching = FALSE, info = FALSE, ordering = FALSE))
  })
  
}
