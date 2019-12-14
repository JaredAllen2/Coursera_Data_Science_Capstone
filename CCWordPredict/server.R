library(shiny)
library(tidyverse)
library(data.table)
library(wordcloud)

capstone_ref_new <- read.csv()

wordpredict <- function(input) {
  wordsin <- str_split(str_trim(tolower(str_replace_all(input, "[^a-zA-Z ]", "")),"both"),"[[:punct:] ]+",simplify=TRUE)
  stringlength <- length(wordsin)
  if (stringlength >=3) {
    suggestedwords1 <- capstone_ref_new[pword1==wordsin[stringlength] & pword2==wordsin[stringlength-1] & pword3==wordsin[stringlength-2],c("word","KNscore")
                                        ][order(-KNscore),]
  } else { suggestedwords1 <- capstone_ref_new[0,c("word","KNscore")] }
  if (nrow(suggestedwords1) <=5 | stringlength==2) {
    suggestedwords2 <- capstone_ref_new[pword1==wordsin[stringlength] & pword2==wordsin[stringlength-1] & is.na(pword3),c("word","KNscore")
                                        ][order(-KNscore),][! word %in% suggestedwords1[,word],]
  } else { suggestedwords2 <- capstone_ref_new[0,c("word","KNscore")] }
  if ((nrow(suggestedwords1)+nrow(suggestedwords2))<=5 | stringlength==1) {
    suggestedwords3 <- capstone_ref_new[pword1==wordsin[stringlength] & is.na(pword2),c("word","KNscore")
                                        ][order(-KNscore),][! word %in% suggestedwords1[,word],][! word %in% suggestedwords2[,word],]
  } else { suggestedwords3 <- capstone_ref_new[0,c("word","KNscore")] }
  
  suggestedwords <- rbindlist(list(suggestedwords1,suggestedwords2,suggestedwords3),use.names=TRUE, fill=TRUE)
  
  result <- dplyr::top_n(suggestedwords,50,KNscore)
  
  return(result)
}

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
  output$wordprobgg <-
    renderPlot({
      if (input$a == "") {
        NULL
      } else {
        ggplot(dplyr::top_n(wordpredict(input$a),5,KNscore),aes(x=reorder(word,-KNscore), y=KNscore)) +
          geom_point() +
          labs(x="predicted next word",y="likelihood score")
      }
    })

})
