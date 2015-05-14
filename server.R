library(shiny)
library("ggplot2")
library(datasets)


mmcars <- mtcars


# Define server logic required to plot various variables against mpg colored by trasmission
shinyServer(function(input, output) {
    
    # Compute the forumla text in a reactive expression since it is 

    formulaText <- reactive({
        paste("mpg vs", input$variable)
    })
    
    # Return the formula text for printing as a caption
    output$caption <- renderText({
        formulaText()
    })
    
    # Generate a plot of the requested variable against mpg 
        
        
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
