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
        column(8, offset = 1,
               plotOutput("wordprob"))
    )
))