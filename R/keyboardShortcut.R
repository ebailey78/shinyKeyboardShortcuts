#' Add A Keyboard Shortcut
#'
#' Creates a keyboard shortcut in a shiny app. It binds like an actionButton or actionLink. So
#' you can trigger reactive events like you would with a button or link.
#'
#' @param inputId The input slot that will be used to access the value.
#' @param key The key that must be pressed to trigger the keyboard shortcut
#' @param ctrl Does the Ctrl button have to be pressed?
#' @param alt Does the Alt button have to be pressed?
#' @param shift Does the shift button have to be pressed?
#' @export
keyboardShortcut <- function(inputId, key, ctrl = FALSE, alt = FALSE, shift = FALSE) {

  if(missing(key)) {
    stop("You must provide a `key`.", call. = FALSE)
  }
  if(ctrl==FALSE && alt==FALSE) {
    stop("At least one of `ctrl` and `alt` must be TRUE.", call. = FALSE)
  }
  if(nchar(key) > 1) {
    stop("`key` must be a single character.", call. = FALSE)
  }

  htmltools::attachDependencies(
    tags$input(type = 'hidden', class = 'shiny-keyboard-shortcut', id = inputId, `data-key` = key, `data-ctrl` = ctrl, `data-alt` = alt, `data-shift` = shift),
    htmltools::htmlDependency(name = 'shiny-keyboard-shortcut', version = "1.0", src = system.file('www', package = 'shinyKeyboardShortcuts'), script = 'shiny_keyboard_shortcuts.js')
  )

}

