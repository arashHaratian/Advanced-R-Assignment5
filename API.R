# library("httr")
library("jsonlite")

URL <- "http://data.riksdagen.se/personlista/?iid=&fnamn=&enamn=&f_ar=&kn=&parti=&valkrets=&rdlstatus=samtliga&org=&utformat=json&sort=sorteringsnamn&sortorder=asc&termlista="
Response <- fromJSON(URL)
df_Response <- data.frame(Response)
