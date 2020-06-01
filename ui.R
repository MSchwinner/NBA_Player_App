

# Header -----------------------------------------------------------------------

header <- shinydashboard::dashboardHeader(
  title = "NBA Player Performance",
  titleWidth = 310
  )


# Sidebar ----------------------------------------------------------------------

sidebar <- shinydashboard::dashboardSidebar(
  
  width = 350,
  
  # hide the default logout panel
  shiny::tags$head(shiny::tags$style(shiny::HTML('.shiny-server-account { display: none; }'))),
  
  shiny::uiOutput("userpanel"),
  
  fluidRow(
    column(12, align = "center", uiOutput("player_photo"))
  ),
  
  shiny::br(),
  
  shiny::selectInput(inputId = 'players',
                     label = 'Player:',
                     choices = players$name,
                     selected = default_player,
                     multiple = FALSE
  ),
  
  shiny::selectInput(inputId = 'data_type',
                     label = 'Data:',
                     choices = c("Base", "Advanced", "Misc", "Scoring", "Usage"),
                     selected = default_type,
                     multiple = FALSE
  ),
  
  shiny::selectInput(inputId = 'season_type',
                     label = 'Season:',
                     choices = c("Regular+Season", "Playoffs"),
                     selected = default_season,
                     multiple = FALSE
  ),
  
  
  # shiny::actionButton(inputId = 'update', label = 'Update Data'),
  
  shiny::br(),
  
  shinydashboard::sidebarMenu(
    
    shinydashboard::menuItem(text = 'Tab1', tabName = 'tab1',
                             icon = shiny::icon("compress"))
    
  ),
  
  shiny::br(),
  
  shiny::h4(shiny::HTML('&emsp;'),
            "Built with",
            shiny::img(src = "https://www.rstudio.com/wp-content/uploads/2014/04/shiny.png",
                       height = "40px"),
            "by",
            shiny::img(src = "https://rstudio.com/wp-content/uploads/2018/10/RStudio-Logo.png",
                       height = "40px"),
            "."
  )
  
)


# Dashboard body ---------------------------------------------------------------

# Initialize dashboard body ----------------------------------------------------

body <- shinydashboard::dashboardBody(
  
  shinydashboard::tabItems(
    
    # Dashboard body: tab1 --------------------------------------------------
    
    shinydashboard::tabItem(
      
      tabName = "tab1",
      
      shiny::fluidRow(
        shinydashboard::box(title = "",
                            status = "primary",
                            width = 12,
                            dataTableOutput("table1"))
      ),
      
      shiny::selectInput(inputId = 'kpi_ts',
                         label = 'Variable visualized:',
                         choices = var_names,
                         selected = "GP",
                         multiple = FALSE
      ),
      
      shiny::fluidRow(
        shinydashboard::box(title = "",
                            status = "primary",
                            width = 12,
                            dygraphOutput("timeseries"))
      )
      
      
    )
    # Dashboard body: Dokumentation --------------------------------------------
    
    # TODO: uncomment following lines once you have a README usable to document
    # your dashboard.
    # Notice that the following code snipet has functions calls not preceded by
    # their affiliated packages (not necessary since commented).
    
    # tabItem(
    #   
    #   tabName = "dokumentation",
    #   
    #   fluidRow( box(title = NULL,
    #                 status = 'warning',
    #                 width = 12,
    #                 includeMarkdown('README.md') ) )
    #   
    # )
    
  )
  
)

ui <- shinydashboard::dashboardPage(skin = "blue",
                                    header,
                                    sidebar,
                                    body)