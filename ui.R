library(shiny)

shinyUI(fluidPage(
    
    titlePanel("Age of Orange Trees Prediction"),
    
    sidebarLayout(
        sidebarPanel(
            radioButtons(inputId = "Tree",
                        label = "An ordered factor indicating the tree.",
                        choices = c("A" = 3, "B" = 1, "C" = 5, "D" = 2, "E" = 4),
                        inline = TRUE),
            
            sliderInput(inputId = "cir",
                        label = "Trunk Circumferences (mm):",
                        value = 150,
                        min = min(Orange$circumference),
                        max = max(Orange$circumference)+1,
                        step = 10),
        ),

        mainPanel(
            htmlOutput("pred"),
            plotOutput('plot', width = "90%")
        )
    )
))
