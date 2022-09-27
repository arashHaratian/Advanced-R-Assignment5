library(shiny)

ui <- fluidPage(

  titlePanel("Swedish Parliament Members!"),

  sidebarLayout(
    sidebarPanel(
      sliderInput("year",
                  min = 1971,
                  max = 2022,
                  value = 1999,
                  label = "Select the Year:"),
      checkboxGroupInput("genders", choices = c("man", "kvinna"), label = "Select the Sex:")) ,
    mainPanel(plotOutput("age_dist"),
              plotOutput("prop_parties"),
              plotOutput("prop_gender"))
  )
)

server <- function(input, output, session) {


  data <- get_politicians_data()

  # updateSliderInput(inputId = "year",
  #                   min = min(unlist(data$Years)),
  #                   max = max(unlist(data$Years)))


  data_react <- reactive(data %>%
                           filter(Sex %in% input$genders) %>%
                           rowwise() %>%
                           filter(input$year %in% Years))


  party_react <- reactive(data_react()[["Party"]] %>%
                            as_factor() %>%
                            fct_infreq() %>%
                            fct_lump(n = 10) %>%
                            as.data.frame())

  output$age_dist <- renderPlot({
    if(is.null(input$genders)){
      ggplot() +
        geom_point() +
        labs(x = "Years", y = "density")

    } else{
      data_react() %>%
        ggplot() +
        geom_density(aes(Birth_Year, group = 1), alpha = 0.5, fill = "lightblue") +
        xlab("Years") +
        theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))
    }

    })

  output$prop_parties <- renderPlot({
    party_react() %>%
      ggplot() +
      geom_bar(aes(., fill = .)) +
      labs(x = "Parties", y = "Number of Politicians", fill = "")
  })

  output$prop_gender <- renderPlot({
    data_react() %>%
      ggplot() +
      geom_bar(aes(x = Sex %>% fct_infreq(), fill = as.factor(Sex) )) +
      scale_fill_manual(values = c("#FF6666", "blue", "black")) +
      labs(x = "Sex", y = "Number of Politicians", fill = "")
  })

}



 shinyApp(ui, server)
