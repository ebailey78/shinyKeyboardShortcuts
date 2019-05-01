#'@export
runExampleSKS <- function(example = NA, port = NULL, launch.browser = getOption("shiny.launch.browser", interactive()),
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
