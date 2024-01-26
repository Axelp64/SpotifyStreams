# Define the server logic
server <- function(input, output, session) {
  
  filtered_data <- reactive({
    spotify_data %>% 
      filter(artist_name %in% input$selected_artist)
    
  })
  
  # Calculate number of streams
  num_streams <- reactive({
    filtered_data() %>% 
      summarise(n_streams = sum(streams)) %>% 
      pull()
     })
  
  output$numStreams <- renderValueBox({
    valueBox(value = num_streams(), color = "olive",
             subtitle = "Number of streams",
             icon = icon("headphones"))
  })
  
  # Calculate number of tracks
  num_tracks <- reactive({
    
      nrow(filtered_data()) 
      
      })
  
  # Calculate number of artists
  num_artists <- reactive({
    n_distinct(filtered_data()$artist_name) 
   
  })
  
  # Calculate number of genre
  num_genre <- reactive({
    n_distinct(filtered_data()$genre_by_bpm)
   
  })
  

  
  output$numTracks <- renderValueBox({
    valueBox(value = num_tracks(), color = "green",
             subtitle = "Number of tracks",
             icon = icon("music"))
  
  })
  
  
  output$numArtists <- renderValueBox({
    valueBox(value = num_artists(), color = "green",
             subtitle = "Number of artists",
             icon = icon("microphone-alt"))
  })
  
  
  output$numGenre <- renderValueBox({
    valueBox(value = num_genre(), color = "olive",
             subtitle = "Number of gender",
             icon = icon("guitar"))
  })
  
  
  output$datatable_track <- renderDT({
    data <- filtered_data() %>% 
      select(artist_name, track_name , streams) %>% 
      rename(artist = artist_name, track = track_name, streams = streams) %>% 
      arrange(desc(streams))
    
    datatable(data, options = list(
      scrollX = TRUE,
      paginate = TRUE,
      lengthMenu = c(5, 10, 15),
      pageLength = 20
    ))
    
  })
  
  output$tracksPerYearArtistPlot <- renderPlotly({
    
    data <- filtered_data() %>%
      ...
    
    p <- ggplot()
    ...
      theme_minimal() 
    
    ggplotly(p)
    
  })
  
  # Render the interactive plotly plot
  output$genrePopularityPlot <- renderPlotly({
    
    data <- filtered_data() %>%
      ...
    
    p <- ggplot()
    ...
    theme_minimal() 
    
    ggplotly(p)
    
  })
  
}





