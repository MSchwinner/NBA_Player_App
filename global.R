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

# data
# TODO: import here the R script where you have loaded and transformed your data.
# For demonstration purpose, the iris datset is loaded here.
iris_df <- datasets::iris
all_species <- unique(iris_df$Species)
kpis <- names(iris_df)[1:(length(iris_df)-1)]
kpis
