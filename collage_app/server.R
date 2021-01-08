server <- function(input, output, session) {
  ## App data
  survey <- readRDS("data/collage_data.rds")
  
  idx <- sample(nrow(survey))
  card_swipe <- callModule(shinyswipr, "myswiper")
  appVals <- reactiveValues(
    name = survey$name[idx[1]],
    picture = survey$picture[idx[1]],
    current_program = survey$current_program[idx[1]],
    previous_program = survey$previous_program[idx[1]],
    academic_interests = survey$academic_interests[idx[1]],
    swipes = data.frame(name = character(), swipe = character())
  )
  
  output$name <- renderText(appVals$name)
  output$picture <- renderImage({
    # Return a list containing the filename
    list(src = appVals$picture,
         height = 250)
  }, deleteFile = FALSE)
  output$current_program <- renderText(appVals$current_program)
  output$previous_program <- renderText(appVals$previous_program)
  output$academic_interests <-
    renderText(appVals$academic_interests)
  output$resultsTable <- renderDataTable({
    appVals$swipes
  })
  
  observeEvent(card_swipe(), {
    # Record our last swipe results.
    appVals$swipes <- rbind(data.frame(name = appVals$name,
                                       swipe = card_swipe()),
                            appVals$swipes)
    # send results to the output.
    output$resultsTable <- renderTable({
      appVals$swipes
    })
    
    
    
    appVals$name <- ifelse(nrow(appVals$swipes) < nrow(survey),
                           survey$name[idx[nrow(appVals$swipes)+1]],
                           "Done! Your first step in getting to know your fellow students!")
    appVals$picture = ifelse(nrow(appVals$swipes) < nrow(survey),
                             survey$picture[idx[nrow(appVals$swipes)+1]],
                             "pictures/thumbs-up.png")
    appVals$current_program = ifelse(nrow(appVals$swipes) < nrow(survey),
                                     survey$current_program[idx[nrow(appVals$swipes)+1]],
                                     " ")
    appVals$previous_program = ifelse(nrow(appVals$swipes) < nrow(survey),
                                      survey$previous_program[idx[nrow(appVals$swipes)+1]],
                                      " ")
    appVals$academic_interests = ifelse(nrow(appVals$swipes) < nrow(survey),
                                        survey$academic_interests[idx[nrow(appVals$swipes)+1]],
                                        " ")
    
    # send update to the ui
    output$name <- renderText(appVals$name)
    output$picture <- renderImage({
      # Return a list containing the filename
      list(src = appVals$picture,
           height = 250)
    }, deleteFile = FALSE)
    output$current_program <- renderText(appVals$current_program)
    output$previous_program <-
      renderText(appVals$previous_program)
    output$academic_interests <-
      renderText(appVals$academic_interests)
  }) # close event observe.
}