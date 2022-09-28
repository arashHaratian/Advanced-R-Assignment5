
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
    mainPanel(
      plotOutput("age_dist"),
      plotOutput("prop_parties"),
      plotOutput("prop_gender")
    )
  )
)
