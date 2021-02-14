# Libraries and options
library(shiny)
library(shinythemes)
library(sbo)
source("funs_textclean.R")

# Global variables
load("accuracy")
load("predtable")
p <- sbo_predictor(t)

# Define ui
ui <- fluidPage(
    # Theme
    theme = shinytheme("united"),
    # CSS format file
    includeCSS("modern.css"),
    # App title & text
    titlePanel(h2("Word Predictor")),
    p("This app takes an input phrase and outputs a prediction of the next possible word."),
    p("Based on n-gram tokenization models using the Stupid Back Off (sbo) package."),

    # Sidebar layout with input and output definitions
    sidebarLayout(
        # Sidebar with text input block
        sidebarPanel(
            h4("Instructions:"),
            tags$ol(
                tags$li("Enter a phrase in the text box."),
                tags$li("Probable predicted next words  prints below."),
                tags$li("<EOS> means no prediction or unknown input."),
                tags$li("Additional tabs show plots of the top ngrams in the dataset.")
            ),
            tags$br(),
            h4("Links:"),
            tags$a(href="https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip", "Capstone Dataset"),
            tags$br(),
            tags$a(href="https://github.com/pyfong1579/Coursera-Data-Science-Specialization_Course-10_Data-Science-Capstone", "GitHub Repo"),
            tags$br(),
            tags$a(href="www.Rpubs.com", "Rpubs Presentation")
            
        ),

                # Mainpanel
        mainPanel(
            # input
            textInput(inputId= "text", label= h4("Please enter some text:"), width= '200%'),
            
            # output
            h4("3 Best Predictions:"),
            verbatimTextOutput(outputId= "text", placeholder= T),
            tags$br(),
            h4("Model accuracy"),
            tableOutput(outputId= "table")
        )
    )
)

# Define Server
server <- function(input, output){

    # output prediction
    output$text <- renderText({
        if(input$text=="") {input$text} # blank output for blank input
        else {predict(p, fun.textclean(input$text))} # predicted output
    })
    # print accuracy table
    output$table <- renderTable({acc})
}

# Create Shiny App
shinyApp(ui, server)
