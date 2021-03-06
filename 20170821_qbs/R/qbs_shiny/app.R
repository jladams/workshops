
library(shiny)
library(tidyverse)

ui <- fluidPage(
   
   titlePanel("Iris Data"),

   mainPanel(
     plotOutput("irisPlot")
   ),
   
   sliderInput(inputId = "pl", label = "Petal Length", min = 0, max = 10, value = c(0, 10), step = 0.5)
   
   
)

server <- function(input, output) {

  df <- reactive({
    data <- iris %>%
      filter(Petal.Length >= input$pl[1] & Petal.Length <= input$pl[2])
    
    return(data)
  })
     
   output$irisPlot <- renderPlot({
     ggplot(df(), aes(x = Petal.Length, y = Petal.Width)) +
       geom_point(aes(color = Species))
   })
}

shinyApp(ui = ui, server = server)

