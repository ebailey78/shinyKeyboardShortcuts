library(shiny)
library(shinyKeyboardShortcuts)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Old Faithful Geyser Data"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30),
            tags$p("Alt+Shift+a: Decrease Bin Count"),
            tags$p("Alt+Shift+q: Increase Bin Count"),
            tags$p("Alt+Shift+r: Reset Bin Count"),
            keyboardShortcut('bins_down', key = 'a', alt = TRUE, shift = TRUE),
            keyboardShortcut('bins_up', key = 'q', alt = TRUE, shift = TRUE),
            keyboardShortcut('reset_bins', key = 'r', alt = TRUE, shift = TRUE)
        ),
        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output, session) {

    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white')
    })

    observeEvent(input$reset_bins, {
        if(input$reset_bins > 0){
            updateSliderInput(session, 'bins', value = 30)
        }
    })

    observeEvent(input$bins_up, {
        if(input$bins_up > 0) {
            b <- input$bins + 1
            updateSliderInput(session, 'bins', value = b)
        }
    })

    observeEvent(input$bins_down, {
        if(input$bins_down > 0) {
            b <- input$bins - 1
            updateSliderInput(session, 'bins', value = b)
        }
    })

}

# Run the application
shinyApp(ui = ui, server = server)