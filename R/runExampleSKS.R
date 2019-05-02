#'Run shinyKeyboardShortcuts examples
#'
#'Run an example that shows capabilities of shinyKeyboardShortcuts
#'
#'@param example The example to run (currently only 'old_faithful')
#'@param port The TCP port that the application should listen on. Defaults to choosing a random port.
#'@param launch.browser If true, the system's default web browser will be launched automatically after the app is started. Defaults to true in interactive sessions only.
#'@param host The IPv4 address that the application should listen on. Defaults to the shiny.host option, if set, or "127.0.0.1" if not.
#'@param display.mode The mode in which to display the example. Defaults to showcase, but may be set to normal to see the example without code or commentary.
#'
#'@export
runExampleSKS <- function(example = 'old_faithful', port = NULL,
                          launch.browser = getOption("shiny.launch.browser", interactive()),
                          host = getOption("shiny.host", "127.0.0.1"), display.mode = "showcase") {

  examplesDir <- system.file("examples", package = "shinyKeyboardShortcuts")
  examples <- gsub("\\.R$", "", list.files(examplesDir))
  if(example %in% examples) {
    shiny::runApp(file.path(examplesDir, paste0(example, ".R")), port = port,
                  launch.browser = launch.browser, host = host, display.mode = display.mode)
  } else {
    stop("Valid examples are \"", paste(examples, collapse = "\", \""), "\"", call. = FALSE)
  }

}
