##Data Source - A3 - Tom Jubin

read_incarcerations_trends <- function () {
  filepath <- "../docs/incarceration_trends.csv"
  df <- read.csv(filepath, na.strings = c("", "NA"))
  return(df)
}

