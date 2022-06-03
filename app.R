library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("Basic maths facts app"),
  
  # Sidebar with a slider input for number of bins 
  fluidPage(
    fluidRow(
      column(2, textOutput("question")),
      column(3, numericInput("answer", NULL, value = 5)),
      column(2, actionButton("check", "Check answer")),
      column(5, textOutput("outcome")),
    ),
    fluidRow(
      column(12, textOutput("count"))
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  nums = reactiveVal(sample(0:9, 2, T))
  output_text = reactiveVal("Can you solve this?")
  count_rct = reactiveVal(0)
  
  output$question <- renderText({
    paste0("What's ", nums()[1], " plus ", nums()[2], "?")
  })
  
  observeEvent(input$check, {
    if (input$answer == sum(nums())) {
      output_text("That's right!  Can you solve this?")
      nums(sample(0:9, 2, T))
      count_rct(count_rct() + 1)
    } else {
      output_text("No, try again!")
    }
  })  
  
  output$outcome <- renderText({
    output_text()
  })
  
  output$count = renderText({
    paste0("Problems solved: ", count_rct())
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
