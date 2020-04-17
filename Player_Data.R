players_url <- "https://stats.nba.com/stats/commonallplayers?LeagueID=00&Season=2015-16&IsOnlyCurrentSeason=0"

request_headers <- c(
  "accept-encoding" = "gzip, deflate, sdch",
  "accept-language" = "en-US,en;q=0.8",
  "cache-control" = "no-cache",
  "connection" = "keep-alive",
  "host" = "stats.nba.com",
  "pragma" = "no-cache",
  "referer" = "https://www.nba.com/",
  "upgrade-insecure-requests" = "1",
  "user-agent" = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_2) AppleWebKit/601.3.9 (KHTML, like Gecko) Version/9.0.2 Safari/601.3.9"
)

request <-  GET(players_url, add_headers(request_headers))

players_data <- fromJSON(content(request, as = "text"))
players <- tbl_df(data.frame(players_data$resultSets$rowSet[[1]], stringsAsFactors = FALSE))
names(players) <- tolower(players_data$resultSets$headers[[1]])

players <- players %>% 
  mutate( 
    person_id = as.numeric(person_id),
    rosterstatus = as.logical(as.numeric(rosterstatus)),
    from_year = as.numeric(from_year),
    to_year = as.numeric(to_year),
    team_id = as.numeric(team_id),
    name = display_first_last
)

if (Sys.Date() <= as.Date("2017-10-20")) {
  players = mutate(players, to_year = pmin(to_year, 2016))
}

players$name = sapply(players$display_last_comma_first, function(s) {
  paste(rev(strsplit(s, ", ")[[1]]), collapse = " ")
})