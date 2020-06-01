# shiny
library(shiny)
library(shinydashboard)
library(shinyBS)
library(shinyWidgets)

# wrangling
library(tidyverse)
library(lubridate)
library(xts)

# visualization
library(plotly)
library(RColorBrewer)
library(DT)
library(dygraphs)

# data import
library(httr)
library(jsonlite)

# data

source("R/http_settings.R")
source("R/get_players.R")
source("R/get_player_data.R")
source("R/get_player_photo.R")

players <- get_players()

season <- paste0(year(Sys.Date())-1, "-", year(Sys.Date())-2000)

default_player <- "LeBron James"
default_type <- "Base"
default_season <- "Regular+Season"


var_names <- names(get_player_data(player_name = default_player,
                type = default_type,
                season_type = default_season))

