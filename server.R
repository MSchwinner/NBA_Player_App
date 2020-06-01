server <- function(input, output, session) {

# Misc --------------------------------------------------------------------

  # start message
  shiny::observe({
    shinyWidgets::sendSweetAlert(
      session = session,
      title = NULL,
      text = tags$div(HTML(paste0(
        shiny::tags$br(),
        shiny::tags$h2("Welcome!")
        )))
    )
  }) 
  
  # successful update message
  shiny::observeEvent(input$update, {
    shinyWidgets::sendSweetAlert(
      session = session,
      title = "Update successfull!",
      text = "",
      type = "success"
    )
  })
  
  # output panel
  output$userpanel <- shiny::renderUI({
    if (!is.null(session$user)) {
      sidebarUserPanel(
        span("Logged in as ", session$user),
        subtitle = a(icon("sign-out"), "Logout", href="__logout__")
      )
    }
  })
  

# Data --------------------------------------------------------------------
  
  output$player_photo <- shiny::renderUI(
    tags$img(src = get_player_photo(player_name = input$players), alt = "photo")
  )

  my_df <- shiny::reactive(

    # eventExpr = input$update,
    
    get_player_data(player_name = input$players,
                    type = input$data_type,
                    season_type = input$season_type) %>% 
      mutate(year = as_date(MAX_GAME_DATE))

  )
  

# Update Inputs -----------------------------------------------------------

  observe({
    updateSelectInput(session, "kpi_ts",
                      choices = names(my_df()),
                      selected = names(my_df()[1]))
  })

# Plots -------------------------------------------------------------------
  
  output$table1 <- renderDataTable({
    
    my_df() %>% 
      datatable(., rownames = FALSE, options = list(scrollX = TRUE))
  })
  
  output$timeseries <- renderDygraph(

    
    my_df() %>% 
      select(input$kpi_ts) %>%
      mutate_all(as.numeric) %>% 
      xts(., order.by = my_df()$year) %>% 
      dygraph() 
  )
  
}
