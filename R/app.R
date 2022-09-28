# library(shiny)
# library(lab5package)
# library(tidyverse)




#' running the app
#'
#' @return NULL
#' @import shiny
#' @export
run_my_app <- function(){
  shiny::shinyApp(ui, server)
}
