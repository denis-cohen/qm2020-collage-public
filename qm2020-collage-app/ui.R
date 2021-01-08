library(shinysense)
ui <- fixedPage(
  tags$head(tags$style(
    HTML(
      "
      @import 'https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700';
      @import url('//fonts.googleapis.com/css?family=Lobster|Cabin:400,700');

      body {
        background-color: white;
        color: black;
        font-family: 'Source Sans Pro', sans-serif;
      	word-wrap: break-word;
      	line-height: 1.7;
        text-align:center;
      }

      h1 {
        font-family: 'Lobster';
        font-weight: 500;
        color: rgba(0, 43, 86);
        text-align:center;
      }

      h2 {
        font-family: 'Lobster';
        font-weight: 500;
        color: rgba(223, 126, 80);
        text-align:center;
      }

      h4 {
        font-family: 'Lobster';
        color: rgba(223, 126, 80);
        font-size: 1.5em;
        font-weight: 200
      }

      p {
        text-align: left;
      }

      #myswiper {
        background-color: rgba(0, 43, 86)
      }

      .shiny-bound-output {
        color: white
      }

      #resultsTable {
        color: rgba(0, 43, 86)
      }

      #name {
        color: rgba(223, 126, 80);
        text-align:center;
      }

    "
    )
  )),
  h1("QM 2020 Interactive Student Collage"),
  p(
    "This is our interactive QM 2020 Student Collage, based on the R package shinyswipr."
  ),
  p(
    icon("hand-point-left"),
    "Swipe left if you share academic interests with a fellow student..."
  ),
  p(
    icon("hand-point-right"),
    "...swipe right if you would like to chat about their current or previous programs..."
  ),
  p(icon("hand-point-up"), "...swipe up if both apply..."),
  p(icon("hand-point-down"), "...and down if neither apply."),
  p(
    "You can either swipe by using drag and drop (i.e., clicking on each profile and moving it to one of the four directions before releasing the mouse button) or using your finger if your device has a touch screen."
  ),
  p(
    "Note that this app runs locally on your computer. It does not send or upload any data, so neither we nor any of your fellow students will know how you swiped. It is interactive in the sense that you can interact with the app; it does not allow you to interact with other students."
  ),
  p(
    "The app shows you a table with your swiping history for your convernience. You can, of course, save your own swiping history and use it to decide whom to talk to at our upcoming social event."
  ),
  hr(),
  shinyswipr_UI(
    "myswiper",
    h2(textOutput("name")),
    hr(),
    imageOutput(
      "picture",
      width = "100%",
      height = "250px",
      inline = FALSE
    ),
    h4("I currently study:"),
    textOutput("current_program"),
    h4("I previously studied:"),
    textOutput("previous_program"),
    h4("My academic interests are:"),
    textOutput("academic_interests")
  ),
  hr(),
  h4("Swipe History"),
  tableOutput("resultsTable")
)