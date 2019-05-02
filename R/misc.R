sKSdepend <- htmltools::htmlDependency(
  name = 'shiny-keyboard-shortcut',
  version = "1.0",
  src = system.file('www', package = 'shinyKeyboardShortcuts'),
  script = 'shiny_keyboard_shortcuts.js',
  stylesheet = 'shiny_keyboard_shortcuts.css'
)
