library(httr)
library(jsonlite)
library(xml2)
library(lubridate)
library(tidyverse)

request_headers = c(
  "accept-encoding" = "gzip, deflate, sdch",
  "accept-language" = "en-US,en;q=0.8",
  "cache-control" = "no-cache",
  "connection" = "keep-alive",
  "host" = "stats.nba.com",
  "pragma" = "no-cache",
  "referer" = "https://www.nba.com/",
  "upgrade-insecure-requests" = "1",
  "user-agent" = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.113 Safari/537.36"
)

player_id <- 2544
season <- paste0(year(Sys.Date())-1, "-", year(Sys.Date())-2000)
type <- "Advanced" #Base, Advanced, Misx, Scoring, Usage

url <- paste0("https://stats.nba.com/stats/playerdashboardbyyearoveryear?DateFrom=&DateTo=&GameSegment=&LastNGames=0&LeagueID=00&Location=&MeasureType=",type,"&Month=0&OpponentTeamID=0&Outcome=&PORound=0&PaceAdjust=N&PerMode=PerGame&Period=0&PlayerID=",player_id,"&PlusMinus=N&Rank=N&Season=",season,"&SeasonSegment=&SeasonType=Regular+Season&ShotClockRange=&Split=yoy&VsConference=&VsDivision=")

request = GET(
  url,
  add_headers(request_headers)
)

df <- fromJSON(content(request, as = "text"))

df1 <- data.frame(df$resultSets$rowSet[[1]], stringsAsFactors = FALSE)
names(df1) <- c(df$resultSets$headers[[1]])

df2 <- data.frame(df$resultSets$rowSet[[2]], stringsAsFactors = FALSE)
names(df2) <- c(df$resultSets$headers[[2]])
