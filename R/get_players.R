get_players <- function() {
  
  players_url <- "https://stats.nba.com/stats/commonallplayers?LeagueID=00&Season=2015-16&IsOnlyCurrentSeason=0"
  
  request <-  GET(players_url, add_headers(request_headers))
  
  players_data <- fromJSON(content(request, as = "text"))
  players <- tbl_df(data.frame(players_data$resultSets$rowSet[[1]], stringsAsFactors = FALSE))
  names(players) <- tolower(players_data$resultSets$headers[[1]])
  
  players <- players %>% 
    mutate( 
      player_id = as.numeric(person_id),
      rosterstatus = as.logical(as.numeric(rosterstatus)),
      from_year = as.numeric(from_year),
      to_year = as.numeric(to_year),
      team_id = as.numeric(team_id),
      name = display_first_last) %>% 
    # data starting 1996
    filter(to_year > 1996) %>% 
    select(player_id, name)
    
  return(players)
}
