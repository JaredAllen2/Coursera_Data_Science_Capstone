library(shiny)
library(tidyverse)


shinyServer(function(input, output) {
  output$b <-
    renderText({
      if (input$a == "") {
        ""
      } else {
        wordpredict(input$a)[1,1]
      }
    })
  output$c <-
    renderText({
      if (input$a == "") {
        ""
      } else {
        wordpredict(input$a)[2,1]
      }
    })
  output$d <-
    renderText({
      if (input$a == "") {
        ""
      } else {
        wordpredict(input$a)[3,1]
      }
    })
  output$wordprob <-
    renderPlot({
      if (input$a == "") {
        NULL
      } else {
      qplot(wordpredict(input$a)$word, wordpredict(input$a)$KNscore)
      }
    })

})
