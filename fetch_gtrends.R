# Define keywords for Google Trends and fetch time series for them

ts_choices <- c(
  "super_bowl",
  "christmas",
  "facebook",
  "tiktok",
  "olympics",
  "covid",
  "taxes",
  "wedding",
  "tesla",
  "bitcoin",
  "impeachment",
  "terrorism",
  "python",
  "data_science",
  "harry_potter"
)
names(ts_choices) <- paste("Google Trends:", tools::toTitleCase(gsub("_", " ", ts_choices)))
saveRDS(ts_choices, "data/ts_choices.RDS")

for (term in ts_choices) {
  # Download from Google Trends
  ts <- gtrendsR::gtrends(
    keyword = gsub("_", " ", term), 
    time = "all", 
    onlyInterest = TRUE
  )
  
  # Bring into format that Prophet expects
  ts <- ts$interest_over_time[,c("date", "hits")]
  colnames(ts) <- c("ds", "y")
  
  # Clean y column
  ts$y <- replace(ts$y, ts$y == "<1", 0)
  ts$y <- as.numeric(ts$y)
  
  # Save to disk
  path <- paste0("data/", term, ".RDS")
  saveRDS(ts, path)
  
  Sys.sleep(1) # avoid making rapid requests to Google Trends
}
