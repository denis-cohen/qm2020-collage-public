The QM 2020 Interactive Student Collage
================

[Denis Cohen](https://twitter.com/denis_cohen), [Marcel
Neunhoeffer](https://twitter.com/mneunho) & [Oliver
Rittmann](https://www.sowi.uni-mannheim.de/gschwend/team/postdocs-and-doctoral-students/oliver-rittmann/)

# Facilitating Social Interactions During the Online Semester

The COVID-19 pandemic has forced universities around the globe to switch
from on-site teaching to online teaching. This comes with various
challenges.

On the one hand, online teaching makes it **harder for instructors to
get to know their students**. To alleviate this problem, we asked our
students to fill out this [short
questionnaire](https://github.com/denis-cohen/qm2020-collage-public/blob/master/QM%202020%20Survey.pdf)
on our course page on the learning management system ILIAS and to attend
our virtual office hours regularly.

On the other hand, online teaching also makes it **harder for students
to get to know each other** and to forge bonds for mutual academic and
personal support. To alleviate this problem, we developed a twofold
strategy. At the beginning of the semester, we asked students for their
consent that we use some basic information (name, current and previous
programs of study, academic interests, and profile pictures) from the
ILIAS survey to compose an interactive student collage and share it with
the class. Specifically, we developed a ShinyApp, based on the
[shinysense::shinywipr](https://github.com/nstrayer/shinysense) module.
This tool allowed participants to get to know each other and to find
mutual interests with their fellow students in a fun and interactive way
by swiping through fellow students profiles. This GitHub repository
contains the
[questionnaire](https://github.com/denis-cohen/qm2020-collage-public/blob/master/QM%202020%20Survey.pdf)
for our ILIAS Survey, code for data processing and the soruce code of
our ShinyApp. A demo of the App can be found on
[shinyapps.io](https://denis-cohen.shinyapps.io/qm2020-collage-app/).
Our guide for the local installation of the App can be found in the
[Getting Started](#getting-started) section below.

We followed up on this with two virtual social events in Weeks 4 and 8
of the semester that allowed students to mingle in an informal setting
in Zoom Breakout Rooms. Additionally, we encouraged students to actively
help each other in the student forum on ILIAS and fostered mutual
support systems by assigning weekly exercise that had to be completed
collaboratively, where groups changed every three weeks.

# Getting Started

Time to get to know your fellow students\! Based on the info you
provided on the ILIAS survey, we have compiled an interactive student
collage for you.

Instead of having you scroll through a long PDF document with 40+
student profiles as in a yearbook, we have developed a
[ShinyApp](https://www.shinyapps.io/) that allows you to actively engage
with each profile by swiping through them.

## How to Run the App

### Step 1: Packages

To run the ShinyApp on your computer, you first need to install and load
some packages, using the following code:

``` r
## ---- Packages ----
## Packages
pkgs <- c("devtools",
          "shiny",
          "dplyr")

## Install uninstalled packages
lapply(pkgs[!(pkgs %in% installed.packages())],
       install.packages,
       repos = "http://cran.us.r-project.org")

## Load all packages to library and adjust options
lapply(pkgs, library, character.only = TRUE)

## shinyswipr
if (!("shinysense" %in% installed.packages()))
  devtools::install_github("nstrayer/shinysense")
library(shinysense)
```

### Step 2: Downloading and Running the App

Next, download the `collage_app.zip` from ILIAS and save it to a folder
of your choosing. Save the path to the file as an R object `zip_file`.
Note that when using Windows, you must either replace the back slashes
(`\`) in the path with forward slashes (`/`) or double back slashes
(`\\`).

``` r
zip_file <- "/folder/for/my/download/collage_app.zip"
```

Then, specify a path to a folder where you would like to unpack the app
and save it in the object `out_dir`.

``` r
out_dir <- "/folder/to/unpack/collage_app"
```

You can then unpack and run the app by submitting these three commands:

``` r
unzip(zip_file, exdir = out_dir)
setwd(out_dir)
shiny::runApp("collage_app")
```

### Step 3: Using the App

You can then use the app by swiping through the profiles. You can:

<!--html_preserve--><i class="fa fa-hand-point-left"></i><!--/html_preserve-->
Swipe left if you share academic interests with a fellow student.

<!--html_preserve--><i class="fa fa-hand-point-right"></i><!--/html_preserve-->
Swipe right if you would like to chat about their current or previous
programs.

<!--html_preserve--><i class="fa fa-hand-point-up"></i><!--/html_preserve-->
Swipe up if both apply…

<!--html_preserve--><i class="fa fa-hand-point-down"></i><!--/html_preserve-->
…and down if neither apply.

You can either swipe by using drag and drop (i.e., clicking on each
profile and moving it to one of the four directions before releasing the
mouse button) or using your finger if your device has a touch screen.

Note that this app runs locally on your computer. It does not send or
upload any data, so neither we nor any of your fellow students will know
how you swiped. It is interactive in the sense that you can interact
with the app; it does not allow you to interact with other students.

The app shows you a table with your swiping history for your
convernience. You can, of course, save your own swiping history and use
it to decide whom to talk to at our upcoming social event.

## Selection Rules

We have included profiles of students who **completed and submitted**
the survey on ILIAS (or emailed us that they forgot to submit their
completed survey) *and* agreed that at least their **name** be used for
the student collage. Out of this subset, we have included **pictures**
if students agreed to the use of their pictures for the collage *and*
**uploaded** a profile picture. Lastly, we only included information on
academic interest and current and previous programs of study if students
agreed to the use of this information for the collage.

## Links

Interested in developing your own ShinyApp? Check out this [Methods
Bites
Tutorial](https://www.mzes.uni-mannheim.de/socialsciencedatalab/article/shiny-apps/)
by [Konstantin Gavras](https://twitter.com/kongavras) and [Nick
Baumann](https://twitter.com/Nick_Baumann97)\!
