library(shiny)
library(ggplot2)
range(Orange$age)
model <- lm(age ~ ., data = Orange)

shinyServer(function(input, output) {
    
    output$pred <- renderText({
        df <- data.frame(Tree = input$Tree, 
                         circumference = input$cir)
        
        age <- round(predict(model,df))
        
        typ <- ifelse(
            input$Tree == 3, "A" , 
            ifelse(input$Tree == 1, "B" ,
                   ifelse(input$Tree == 5, "C",
                          ifelse(input$Tree == 2, "D", "E"))))
        
        paste0("Trunk Circumferences is ",strong(input$cir),". The Type of tree is ", strong(typ), ". The prediction of the age of the tree is ", strong(age),".")
        
    })
    
    output$plot <- renderPlot({
        typ <- ifelse(
            input$Tree == 3, "A" , 
            ifelse(input$Tree == 1, "B" ,
                   ifelse(input$Tree == 5, "C",
                          ifelse(input$Tree == 2, "D", "E"))))
        
        df <- data.frame(Tree = input$Tree, 
                         circumference = input$cir)
        age <- round(predict(model,df))
        
        df2 <- cbind(df,age)
        
        ggplot(data = Orange, aes(x = circumference, y = age)) + 
            coord_cartesian(xlim = c(0, 250), ylim = c(0, 2000)) +
            geom_point(stat = "identity") +
            geom_point(data = df2, aes(x = circumference, y = age), color = 'red', size = 5) +
            geom_line(data = df2, aes(x = circumference, y = age), color = 'blue') +
            theme_minimal()+
            theme(legend.position = 'none')
            
    })

})
