library(shiny)
library(shinyKeyboardShortcuts)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Old Faithful Geyser Data"),
    tags$style("

      key {
        display: inline-block;
        font-family: monospace;
        font-weight: bold;
        box-sizing: border-box;
        border: solid #333 2px;
        text-align: center;
        min-width: 2em;
        min-height: 2em;
        padding: 0.5em;
        margin: 0.25em;
        background-color: #F6F6F6;
        color: #333;
        border-radius: 5px;
        box-shadow: 0.25em 0.25em;
      }
      
      key.pressed {
      
        background-color: #7FDBFF;
        box-shadow: 0 0;
        transform: translate(0.25em, 0.25em);
      }

      shortcut {
        display: block;
        font-family: sans-serif;
        font-weight: bold;
        color: #333;
      }
      
      shortcut.lg {
        font-size: 30px;
      }
      
      shortcut.sm {
        font-size: 10px;
      }
           
      shortcut.sm > key {
        border: solid #333 1.25px;
      }
      
      shortcut > description {
      
        font-size: 1.2em;
      
      }
      
      shortcut > description::before {
        content: ":";
        padding: 3px;
      }
      
"),
    tags$script("
      $(document).on('keydown', function(e) {
      
        let key = e.originalEvent.key.toLowerCase();
        
        $('key').each(function() {
          if($(this).data('key') == key) {
            $(this).addClass("pressed");
          }
        });
      
      });
    
      $(document).on('keyup', function(e) {
      
        let key = e.originalEvent.key.toLowerCase();
        
        $('key').each(function() {
          if($(this).data('key') == key) {
            $(this).removeClass("pressed");
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
      <key data-key = 'control'>Ctrl</key>+<key data-key='alt'>Alt</key>+<key data-key = 'a'>A</key>
      <description>Increase Bin Size</description>
    </shortcut>
    <shortcut class = 'sm'>
      <key data-key = 'control'>Ctrl</key>+<key data-key='alt'>Alt</key>+<key data-key = 'q'>Q</key>
      <description>Decrease Bin Size</description>
    </shortcut>
    <shortcut class = 'sm'>
      <key data-key = 'control'>Ctrl</key>+<key data-key='alt'>Alt</key>+<key data-key = 'r'>R</key>
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
