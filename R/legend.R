#'Legend Keys
#'
#'Produce html for keyboard keys
#'
#'@export
keys <- (function() {

  make_key_function <- function(key, icon = NULL) {

    function(animated = TRUE, ...) {

      attr <- list(...)

      if('class' %in% names(attr)) {
        class <- strsplit(attr$class, " ")[[1]]
      } else {
        class <- c()
      }

      if(animated) {
        class <- c(class, 'animated')
      }

      class <- paste(unique(class), collapse = " ")

      if(nchar(class) > 0) {
        attr$class <- class
      }

      attr["data-key"] <- tolower(key)

      if(is.null(icon)) {
        l <- key
      } else {
        print(class(icon))
        if(class(icon) != 'character') {
          l <- icon
        } else {
          l <- shiny::icon(icon)
        }
      }

      htmltools::attachDependencies(
        structure(list(name = 'key', attribs = attr, children = l),
                  class = "shiny.tag"),
        sKSdepend()
      )

    }

  }

  standard_keys <- c(LETTERS, 0:9, "Ctrl", "Alt", "Shift", "Tab",
               "Home", "End", "PageUp", "PageDown", "Insert", "Delete", "Escape")
  icon_keys <- list("ArrowUp" = "up-arrow", "ArrowDown" = 'down-arrow', "ArrowRight" = 'right-arrow',
                 "ArrowLeft" = 'left-arrow', "Meta" = 'windows',
                 "Enter" = shiny::icon('level-down-alt', class = 'fa-rotate-270'))
  special_keys <- c(tick = "`", dash = "-", equals = "=", bslash = "\\", fslash = "/",
                    star = "*", plus = "+", semicolon = ";", single_quote = "'",
                    comma = ",", period = ".", space = " ")

  standard_key_functions <- lapply(standard_keys, function(key) {
    make_key_function(key)
  })
  icon_key_functions <- lapply(seq(length(icon_keys)), function(i) {
    make_key_function(names(icon_keys)[i], icon_keys[[i]])
  })
  special_key_functions <- lapply(seq(length(special_keys)), function(i) {
    make_key_function(special_keys)
  })

  names(standard_key_functions) <- standard_keys
  names(icon_key_functions) <- names(icon_keys)
  names(special_key_functions) <- names(special_keys)

  return(c(standard_key_functions, icon_key_functions, special_key_functions))

})()


#'Create a Shortcut Legend Entry
#'
#'This function allows you to add a description of a keyboard shortcut to your app.
#'
#'@param animated Should the legend be animated?
#'@param description What does the shortcut do?
#'@param size The size of the shortcut `lg` for large, `sm` for small, or missing for regular
#'@param \dots The keys that should be pressed to activate the shortcut
#'
#'@export
shortcut_legend <- function(..., animated = TRUE, description, size = NULL) {

  if(is.null(description)) {
    stop("You must provide a description of your shortcut (A little about what it does)", call. = FALSE)
  }

  sc_class = c()

  x <- list(...)

  keys <- lapply(seq(length(x)), function(i) {
    z <- keys[[x[[i]]]](animated = animated)
    if(i < length(x)) {
      return(tagList(z, " + "))
    } else {
      return(z)
    }
  })

  print(keys)

  if(!is.null(size)) {
    if(size %in% c('lg', 'sm')) {
      sc_class <- c(sc_class, size)
    } else {
      stop('`size` must be lg or sm. Cannot create shortcut.', call. = FALSE)
    }
  }

  if(length(sc_class) > 0) {
    sc_class <- paste(sc_class, collapse = " ")
  } else {
    sc_class <- NULL
  }

  htmltools::attachDependencies(
    tag('shortcut', list(
      class = sc_class,
      tag('keys', keys),
      tag('description', description)
    )),
    sKSdepend()
  )



}
