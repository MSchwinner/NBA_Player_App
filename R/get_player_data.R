get_player_data <- function(player_name, type, season_type) { 
  
  selected_player <- (players %>% filter(name == player_name))$player_id  
  
  url <- paste0("https://stats.nba.com/stats/playerdashboardbyyearoveryear?DateFrom=&DateTo=&GameSegment=&LastNGames=0&LeagueID=00&Location=&MeasureType=",type,"&Month=0&OpponentTeamID=0&Outcome=&PORound=0&PaceAdjust=N&PerMode=PerGame&Period=0&PlayerID=",selected_player,"&PlusMinus=N&Rank=N&Season=",season,"&SeasonSegment=&SeasonType=",season_type,"&ShotClockRange=&Split=yoy&VsConference=&VsDivision=")
  
  request = GET(url,add_headers(request_headers))
  
  df <- fromJSON(content(request, as = "text"))
  
  df2 <- data.frame(df$resultSets$rowSet[[2]], stringsAsFactors = FALSE)
  names(df2) <- c(df$resultSets$headers[[2]]) 
  
  return(df2) }