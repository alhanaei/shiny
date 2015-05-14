library(shiny)

# Define UI for miles per gallon application
shinyUI(pageWithSidebar(
    
    # Application title
    headerPanel("Miles Per Gallon and Transmission"),
    
    # Sidebar with controls to select the variable to plot against mpg
    # and to specify whether outliers should be included
    sidebarPanel(
        selectInput("variable", "Variable:",
                    list("Gross horsepower" = "hp", 
                         "Weight (lb/1000)" = "wt", 
                         "Displacemen" = "disp")),
        
        selectInput("model", "Model:",
                    list("Linear model" = "lm", 
                         "General linear model" = "auto")),
        
        checkboxInput("split", "split regression", FALSE),
        checkboxInput("se", "show Confidence Interval", TRUE),
        
        sliderInput("level", "Confidence Interval", min=0.6, 0.999, value=0.95, step = 0.001)
    ),
    
    # Show the caption and plot of the requested variable against mpg
    mainPanel(
        h3(textOutput("caption")),        
        plotOutput("mpgPlot"),
        
        
        h1("Documentation"),
        p("This application show the effect of type of transmition on Miles Per Gallon(MPG) and based on different variabless"),
        
        p("you can select different variables to predict the outcome MPG using different regression model"),
        br(),
        h2("Input"),
        p(strong("Variable:")," Select the variable that is the predictor of the outcome"),
        p(strong("Model:")," Fit the data to linear model or general  model"),
        p(strong("split regression:")," If true, two fit lines will show one for automatic and one for manual transmissions"),
        p(strong("show Confidence Interval:")," Select whither to show the confidence intervals or not"),
        p(strong("Confidence Interval:")," select the confidence interval (60%~99,9%)")
    )
))