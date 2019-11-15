library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    fluidRow(
        column(4,
               "input text:"
        ),
        column(4, offset = 4,
               " "
        )      
    ),
    fluidRow(
        column(2, offset = 1,
               "option 1"
        ),
        column(2,
               "option 2"
        ),
        column(2,
               "option 3"
        ),
        column(2,
               "option 2"
        )  
    )
))