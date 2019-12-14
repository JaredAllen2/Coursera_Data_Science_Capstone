library(shiny)

shinyUI(fluidPage(
    titlePanel("Coursera Capstone: Word Prediction App"),
    fluidRow(
        column(10, offset=1,
               "Text prediction app:
               Input your text in the input box below, and the most likely three words will be supplied.
               Additionally the top 5 words will be summarised in the barchart, and a wordcloud will be generated 
               to summarise additional candidate words sized by their likelihood score.")
    ),
    hr(),
    fluidRow(
        column(1,
               "input text:"
        ),
        column(4,
               ui <- fluidPage(
                   textInput("a","")
               )
        )
    ),
    hr(),
    fluidRow(
        column(2, offset = 1,
               ("Suggestion 1:")
        ),
        column(2,
               ("Suggestion 2:")
        ),
        column(2,
               ("Suggestion 3:")
        )
    ),
    fluidRow(
        column(2, offset = 1,
               textOutput("b")
        ),
        column(2,
               textOutput("c")
        ),
        column(2,
               textOutput("d")
        )
    ),
    hr(),
    fluidRow(
        column(5, 
               "Suggestions for next word: top 5 ranked by likelihood score"),
        column(5, offset = 1,
               "Wordcloud of predicted next words, sized according to likelihood")
    ),
    fluidRow(
        column(6,
               plotOutput("wordprobgg")
               ),
        column(6,
               plotOutput("wordprobcloud")
               )
    )
))