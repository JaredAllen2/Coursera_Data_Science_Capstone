library(shiny)
library(tidyverse)
library(data.table)
library(wordcloud)


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
  output$wordprobcloud <-
    renderPlot({
      if (input$a == "") {
        NULL
      } else {
      wordcloud(wordpredict(input$a)$word,wordpredict(input$a)$KNscore)
      }
    })
  output$Wordprobgg <-
    renderPlot({
      if (input$a == "") {
        NULL
      } else {
        ggplot(dplyr::top_n(wordpredict(input$a),5,KNscore),aes(x=reorder(word,-KNscore), y=KNscore)) +
          geom_point()
      }
    })

})
