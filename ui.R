

# Header -----------------------------------------------------------------------

header <- shinydashboard::dashboardHeader(
  title = "BILLA Digital My title",
  titleWidth = 310,
  shinydashboard::dropdownMenu(type = "messages", badgeStatus = "danger",
                               shinydashboard::notificationItem(icon = shiny::icon("envelope"),
                                                                status = "danger",
                                                                "Email author",
                                                                href = "mailto:digital.analytics@billa.at")
  )
)


# Sidebar ----------------------------------------------------------------------

sidebar <- shinydashboard::dashboardSidebar(
  
  width = 350,
  
  shiny::tags$head(shiny::tags$link(rel = "stylesheet", type = "text/css", href = "billa_design.css")),
  
  # hide the default logout panel
  shiny::tags$head(shiny::tags$style(shiny::HTML('.shiny-server-account { display: none; }'))),
  
  shiny::uiOutput("userpanel"),
  
  shiny::h5(shiny::HTML('&emsp;'), 'Parameter auswählen und auf "Aktualisieren" klicken:'),
  
  shiny::selectInput(inputId = 'species',
                     label = 'Species:',
                     choices = all_species,
                     selected = NA,
                     multiple = TRUE
  ),
  
  shinyBS::bsTooltip(id = 'species',
                     title = paste('Wenn das Feld leer ist, sind alle Schwertlilien',
                                   'Spezies ausgewählt.', sep = ' '),
                     trigger = 'hover',
                     placement = 'right'
  ),
  
  shiny::actionButton(inputId = 'update', label = 'Aktualisieren'),
  
  shiny::br(),
  
  shinydashboard::sidebarMenu(
    
    shinydashboard::menuItem(text = 'Petalen', tabName = 'petalen',
                             icon = shiny::icon("compress")),
    shinydashboard::menuItem(text = 'Sepalen', tabName = 'sepalen',
                             icon = shiny::icon("expand")),
    shinydashboard::menuItem(text = 'Dokumentation', tabName = 'dokumentation',
                             icon = shiny::icon("question"))
    
  ),
  
  shiny::br(), shiny::br(),  # HTML line breaks (also <br> within a string)
  
  shiny::h4(shiny::HTML('&emsp;'), "NUR FÜR DEN INTERNEN GEBRAUCH"),
  
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
    
    # Dashboard body: Petalen --------------------------------------------------
    
    shinydashboard::tabItem(
      
      tabName = "petalen",
      
      shiny::fluidRow(
        
        shinydashboard::box(title = "KPI für Histogramm",
                            status = "warning",
                            width = 2,
                            shiny::selectInput(
                              inputId = 'pet_x',
                              label = 'Petalengröße zum Auswählen:',
                              choices = c('Petal.Length', 'Petal.Width'),
                              selected = 'Petal.Length',
                              multiple = FALSE
                            )
        )
        
      ),
      
      shiny::fluidRow(
        
        shinydashboard::box(title = 'Petalengröße Austeilung',
                            solidHeader = TRUE,
                            status = 'warning',
                            width = 10,
                            plotly::plotlyOutput('pet_plot')
        )
        
      ),
      
      shiny::fluidRow(
        shiny::HTML( paste0( shiny::HTML('&emsp;'),
                             shiny::tags$img(src = "ols_logo.png", height='50') ) )
      )
      
    ),
    
    # Dashboard body: Sepalen --------------------------------------------------
    
    shinydashboard::tabItem(
      
      tabName = "sepalen",
      
      shiny::fluidRow(
        
        shinydashboard::box(title = "KPI für X-Achse",
                            status = "warning",
                            width = 2,
                            shiny::selectInput(
                              inputId = 'sep_x',
                              label = 'Sepalengröße zum Auswählen:',
                              choices = c('Sepal.Length', 'Sepal.Width'),
                              selected = 'Sepal.Length',
                              multiple = FALSE
                            )
        ),
        
        shinydashboard::box(title = "KPI für Y-Achse",
                            status = "warning",
                            width = 2,
                            shiny::selectInput(
                              inputId = 'sep_y',
                              label = 'Sepalengröße zum Auswählen:',
                              choices = c('Sepal.Length', 'Sepal.Width'),
                              selected = 'Sepal.Width',
                              multiple = FALSE
                            )
        )
        
      ),
      
      shiny::fluidRow(
        
        shinydashboard::box(title = 'Sepalen Attribute',
                            solidHeader = TRUE,
                            status = 'warning',
                            width = 10,
                            plotly::plotlyOutput('sep_plot')
        )
        
      ),
      
      shiny::fluidRow(
        shiny::HTML( paste0( shiny::HTML('&emsp;'),
                             shiny::tags$img(src = "ols_logo.png", height='50') ) )
      )
      
    )#,
    
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

ui <- shinydashboard::dashboardPage(skin = "yellow",
                                    header,
                                    sidebar,
                                    body)