library(shiny)

shinyServer(function(input, output) {

    output$textpred1 <- renderText({"test"})

})
