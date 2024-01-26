source("packages.R")
source("global.r")

ui <- dashboardPage(skin = "black",
                    dbHeader,
                    dashboardSidebar(disable = TRUE),
                    dashboardBody(
                      box( title ="Important Information",
                           solidHeader = T,
                           p("This dashbord presents summarized data for one or multiple artits"),
                           p("Note: Only artists with at least 5 songs are included in the analysis"),
                           background = "green",
                           width = 12
                      ),
                      
                      
                      box(
                        title = "Artist",
                        solidHeader = FALSE, 
                        width = 6,
                        column(3, align = "center"),
                        column(6, align = "center",
                               pickerInput(
                                 inputId = "selected_artist",
                                 choices = unique(spotify_data$artist_name),
                                 selected = "BTS",
                                 options = list(`actions-box` = TRUE),
                                 multiple = TRUE
                               )
                               ,),
                        column(3, align = "center")
                      ),
                      box(
                        title = "Chat with ChatGPT",
                        solidHeader = FALSE, 
                        width = 6,
                        column(3, align = "center"),
                        column(6, align = "center",
                               br(),
                               br(),
                               br()),
                        column(3, align = "center")
                      ),
                      column(6,
                             box(
                               title = "Stats",
                               solidHeader = FALSE,
                               width = 12,
                               br(),
                               fluidRow(
                                 column(6, valueBoxOutput("numStreams", width=12)),
                                 column(6, valueBoxOutput("numTracks", width=12))
                               ),
                               fluidRow(
                                 column(6, valueBoxOutput("numArtists", width=12)),
                                 column(6, valueBoxOutput("numGenre", width=12))
                               )),
                             box(title = "Popularity per gender", width = 6,
                                 plotlyOutput("genrePopularityPlot"))
                             
                      ),
                      column(6,
                             DTOutput("datatable_track")
                      )
                    )
)


