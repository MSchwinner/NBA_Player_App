# shiny
library(shiny)
library(shinydashboard)
library(shinyBS)
library(shinyWidgets)

# wrangling
library(tidyverse)
library(lubridate)

# visualization
library(plotly)
library(RColorBrewer)
library(DT)

# data import
library(httr)
library(jsonlite)

# data

iris_df <- datasets::iris
all_species <- unique(iris_df$Species)
kpis <- names(iris_df)[1:(length(iris_df)-1)]
kpis

source("R/http_settings.R")
source("R/get_players.R")
source("R/get_player_data.R")
source("R/get_player_photo.R")

players <- get_players()


season <- paste0(year(Sys.Date())-1, "-", year(Sys.Date())-2000)


