# library(shiny)
# library(lab5package)
# library(tidyverse)




#' The function to run the Shiny app
#'
#' This function will run the app created by shiny, for plotting some information from the `get_politicians_data()` dataset.
#'
#' @return NULL
#' @import shiny
#' @export
run_my_app <- function(){
  shiny::shinyApp(ui, server)
}
