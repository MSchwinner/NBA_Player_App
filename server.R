server <- function(input, output, session) {
  
  # start message
  shiny::observe({
    shinyWidgets::sendSweetAlert(
      session = session,
      title = NULL,
      text = tags$div(HTML(paste0(
        shiny::tags$br(),
        shiny::tags$h2("Willkommen!"),
        "Zum starten bitte Input Parameter in der Seitenliste wählen und auf ",
        shiny::tags$b('Update'), 
        " klicken. Für eine Gebrauchsanleitung siehe Tab ",
        shiny::tags$b('Dokumentation'),
        ".")))
    )
  }) 
  
  # successful update message
  shiny::observeEvent(input$update, {
    shinyWidgets::sendSweetAlert(
      session = session,
      title = "Update erfolgreich!",
      text = "Daten werden neu geladen und Inhalte angepasst.",
      type = "success"
    )
  })
  
  my_df <- shiny::eventReactive(
    
    eventExpr = input$update,
    
    { my_df <- iris_df %>%
      {if (length(input$species) == 0) filter(., Species %in% all_species)
        else filter(., Species %in% input$species)} }
    
  )
  
  output$userpanel <- shiny::renderUI({
    if (!is.null(session$user)) {
      sidebarUserPanel(
        span("Logged in as ", session$user),
        subtitle = a(icon("sign-out"), "Logout", href="__logout__")
      )
    }
  })
  
  output$pet_plot <- plotly::renderPlotly({
    
    pet_plot <- plot_ly(my_df(), x = ~ get(input$pet_x), alpha = 0.6) %>%
      layout(xaxis = list(title = paste0(input$pet_x, ' in cm')),
             yaxis = list(title = 'Anzahl'),
             barmode = 'overlay') %>%
      add_histogram(color = ~ Species, xbins = list(size = 0.1))
    
    pet_plot
    
  })
  
  output$sep_plot <- plotly::renderPlotly({
    
    sep_plot <- plot_ly(my_df(), x = ~ get(input$sep_x), y = ~ get(input$sep_y)) %>%
      layout(xaxis = list(title = paste0(input$sep_x, ' in cm')),
             yaxis = list(title = paste0(input$sep_y, ' in cm')),
             legend = list(orientation = 'h', y = 1.3)) %>%
      add_markers(color = ~ Species,
                  hoverinfo = 'text',
                  text = ~ paste0(input$sep_x, ': ', get(input$sep_x), '<br>',
                                  input$sep_y, ': ', get(input$sep_y)))
    
    sep_plot
    
  })
  
}
