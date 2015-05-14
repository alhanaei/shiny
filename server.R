library(shiny)
library("ggplot2")
library(datasets)

# We tweak the "am" field to have nicer factor labels. Since this doesn't
# rely on any user inputs we can do this once at startup and then use the
# value throughout the lifetime of the application
mmcars <- mtcars


# Define server logic required to plot various variables against mpg
shinyServer(function(input, output) {
    
    # Compute the forumla text in a reactive expression since it is 
    # shared by the output$caption and output$mpgPlot expressions
    formulaText <- reactive({
        paste("mpg vs", input$variable)
    })
    
    # Return the formula text for printing as a caption
    output$caption <- renderText({
        formulaText()
    })
    
    # Generate a plot of the requested variable against mpg and only 
    # include outliers if requested
        
        
    output$mpgPlot <- reactivePlot(function() {
        
        mpgData <- data.frame(mpg = mtcars$mpg,
                              am =factor(mtcars$am,labels = c("Automatic", "Manual")),
                              var = factor(mtcars[[input$variable]]))
        
        
        
        
        if (input$variable == "cyl" || input$variable == "gear" ) {
            mpgData <- data.frame(mpg = mtcars$mpg, 
                                  am =factor(mtcars$am,labels = c("Automatic", "Manual")),
                                  var = factor(mtcars[[input$variable]]))
        }
        else {
            
            mpgData <- data.frame(mpg = mtcars$mpg, 
                                  am =factor(mtcars$am,labels = c("Automatic", "Manual")),
                                  var = mtcars[[input$variable]])
        }

        

        
        if (input$split) {
            p<- ggplot(mpgData , aes(y=mpg,x= var, color=am))+
                geom_point(aes(color=am), size = 4)
            
        } else {    
            p<-ggplot(mpgData , aes(y=mpg,x= var))+
                geom_point(aes(color=am), size = 4)            
        }
        
        p<- p+stat_smooth(method=input$model,se=input$se,level = input$level)

            
      
        
        p <-p+ylim(5, 35)+xlab(input$variable)
        
        
        print(p)
        
    })
    
})
