#' dataset_query function
#'
#' This function queries the "data.riksdagen" API and retrieves all the available information of Swedish politicians.
#'
#' @return `data.frame` object
#' @export
#'
dataset_query <- function() {
  URL <- "http://data.riksdagen.se/personlista/?iid=&fnamn=&enamn=&f_ar=&kn=&parti=&valkrets=&rdlstatus=samtliga&org=&utformat=json&sort=sorteringsnamn&sortorder=asc&termlista="
  response <- jsonlite::fromJSON(URL)
  df_raw <- response$personlista$person
  return(df_raw)
}

#' years_function function
#'
#' Given a `dataframe` with the `from` and `tom` columns containing dates with format starting with the year,
#' this function returns a vector with all the years included in those intervals.
#'
#' @param dataframe_var is a `data.frame` object
#'
#' @return a `numeric` vector
#' @export
#'
#' @importFrom magrittr "%>%"
years_function <- function(dataframe_var){
  stopifnot(class(dataframe_var) == "data.frame",
            c("from","tom") %in% names(dataframe_var),
            !all(dataframe_var[["from"]] == ""))

  dataframe_var_filt <- dataframe_var[which(dataframe_var[["from"]] != ""),]
  dataframe_var_filt[which(dataframe_var_filt[["tom"]] == ""),"tom"] <- "2022"
  values <- dataframe_var_filt[c("from","tom")] %>%
    dplyr::rowwise() %>%
    dplyr::mutate(total = list(
      as.numeric(substring(from,1,4)):as.numeric(substring(tom,1,4)))
    )
  result <- unique(unlist(values[["total"]]))
  return(result)
}

#' get_politicians_data function
#'
#' This function gets the desired data of the Swedish politicians. It returns a `data.frame` containing the columns we want to extract from the original data,
#' plus the default columns.
#'
#' @param column_idx is `numeric` vector that indicates the columns to select in the original data.
#'
#' @return a `data.frame`
#' @export
#'
get_politicians_data <- function(column_idx = c(5,6,11)){
  if(!(is.vector(x=column_idx,mode="numeric"))){
    stop()
  }

  column_idx <- unique(c(5,6,11,column_idx))

  # Retrieving data
  df_raw <- dataset_query()
  rownames(df_raw) <- df_raw[["hangar_id"]]
  final_df <- df_raw[column_idx]

  # Processing data
  years_list <- list()
  for(dataframe in df_raw[[18]][[1]]){
    years <- years_function(dataframe)
    id <- dataframe[["hangar_id"]][[1]]

    years_list <- append(years_list,list(years))
  }

  final_df$Years <- I(years_list)
  colnames(final_df)[1:3] <- c("Birth_Year","Sex","Party")

  # Cleaning data

  final_df <- final_df[which(final_df[["Birth_Year"]] != "0"),]
  final_df$Party[final_df[["Party"]]=="" | final_df[["Party"]]=="-"] <- "Unknown"
  return(final_df)
}
