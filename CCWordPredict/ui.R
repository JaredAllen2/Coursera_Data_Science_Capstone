library(shiny)

shinyUI(fluidPage(
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
    fluidRow(
        column(4, offset = 0,
               plotOutput("wordprobgg")
               ),
        column(4,
               plotOutput("Wordprobcloud")
               )
    )
))