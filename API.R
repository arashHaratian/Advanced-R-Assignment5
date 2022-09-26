# library("httr")
library("jsonlite")



dataset_query <- function(column_idx = NULL) {
  URL <- "http://data.riksdagen.se/personlista/?iid=&fnamn=&enamn=&f_ar=&kn=&parti=&valkrets=&rdlstatus=samtliga&org=&utformat=json&sort=sorteringsnamn&sortorder=asc&termlista="
  response <- fromJSON(URL)
  df_response <- data.frame(response)

  df_raw <- response$personlista$person
}
