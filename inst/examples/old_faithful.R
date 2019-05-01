library(shiny)
library(shinyKeyboardShortcuts)

# Define UI for application that draws a histogram
ui <- fluidPage(
    tags$head(
        tags$script("
          $(document).on('keydown', function(e) {
      
            let key = e.originalEvent.key.toLowerCase();
        
            $('key').each(function() {
              if($(this).data('key') == key) {
                $(this).addClass('pressed');
              }
            });
      
          });
    
          $(document).on('keyup', function(e) {
      
            let key = e.originalEvent.key.toLowerCase();
        
            $('key').each(function() {
              if($(this).data('key') == key) {
                $(this).removeClass('pressed');
              }
            })
          });
       ")  
    ),
    # Application title
    titlePanel("Old Faithful Geyser Data"),
    includeCSS("old_faithful.css"),
    tags$script("
      $(document).on('keydown', function(e) {
      
        let key = e.originalEvent.key.toLowerCase();
        
        $('key').each(function() {
          if($(this).data('key') == key) {
            $(this).addClass('pressed');
          }
        });
      
      });
    
      $(document).on('keyup', function(e) {
      
        let key = e.originalEvent.key.toLowerCase();
        
        $('key').each(function() {
          if($(this).data('key') == key) {
            $(this).removeClass('pressed');
          }
        });
      
      });

"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30),
            HTML("
    <shortcut class = 'sm'>
      <key data-key = 'alt'>Alt</key>+<key data-key='shift'>Shift</key>+<key data-key = 'a'>A</key>
      <description>Increase Bin Size</description>
    </shortcut>
    <shortcut class = 'sm'>
      <key data-key = 'alt'>Alt</key>+<key data-key='shift'>Shift</key>+<key data-key = 'q'>Q</key>
      <description>Decrease Bin Size</description>
    </shortcut>
    <shortcut class = 'sm'>
      <key data-key = 'alt'>Alt</key>+<key data-key='shift'>Shift</key>+<key data-key = 'r'>R</key>
      <description>Reset Bin Size</description>
    </shortcut>  
            "),
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
