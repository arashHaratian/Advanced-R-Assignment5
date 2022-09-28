server <- function(input, output, session) {


  data <- get_politicians_data()

  # updateSliderInput(inputId = "year",
  #                   min = min(unlist(data$Years)),
  #                   max = max(unlist(data$Years)))


  data_react <- reactive(data %>%
                                  dplyr::filter(Sex %in% input$genders) %>%
                                  dplyr::rowwise() %>%
                                  dplyr::filter(input$year %in% Years))


  party_react <- reactive(data_react()[["Party"]] %>%
                                   forcats::as_factor() %>%
                                   forcats::fct_infreq() %>%
                                   forcats::fct_lump(n = 10) %>%
                                   as.data.frame())

  output$age_dist <- renderPlot({
    if(is.null(input$genders)){
      ggplot2::ggplot() +
        ggplot2::geom_point() +
        ggplot2::labs(x = "Years", y = "density")

    } else{
      data_react() %>%
        ggplot2::ggplot() +
        ggplot2::geom_density(ggplot2::aes(Birth_Year, group = 1), alpha = 0.5, fill = "lightblue") +
        ggplot2::xlab("Years") +
        ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 90, vjust = 0.5, hjust=1))
    }

  })

  output$prop_parties <- renderPlot({
    party_react() %>%
      ggplot2::ggplot() +
      ggplot2::geom_bar(ggplot2::aes(., fill = .)) +
      ggplot2::labs(x = "Parties", y = "Number of Politicians", fill = "")
  })

  output$prop_gender <- renderPlot({
    data_react() %>%
      ggplot2::ggplot() +
      ggplot2::geom_bar(ggplot2::aes(x = Sex %>% forcats::fct_infreq(), fill = as.factor(Sex) )) +
      ggplot2::scale_fill_manual(values = c("#FF6666", "blue", "black")) +
      ggplot2::labs(x = "Sex", y = "Number of Politicians", fill = "")
  })

}

