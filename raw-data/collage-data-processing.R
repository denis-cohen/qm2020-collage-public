## ---- Packages ----
## Packages
pkgs <- c("readxl",
          "devtools",
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

## ---- Data ----


## Survey data
survey <-
  read_xlsx("raw-data/QM_2020_Survey_Per_Participant_Example.xlsx") %>%
  filter(!is.na(`Login`)) %>%
  rename(
    current_program = `...4`,
    current_program_num = `...5`,
    last_name = `Last Name`,
    first_name = `First Name`,
    login = `Login`,
    previous_program = `...7`,
    previous_university = `...8`,
    academic_interests = `...9`
  ) %>%
  mutate(
    current_program = ifelse(
      current_program_num == 4,
      `Other (please specify) [4]`,
      current_program
    )
  ) %>%
  mutate(
    not_name = is.na(`My name [1]`),
    not_picture = is.na(`My profile picture (uploaded separately) [2]`),
    not_info = is.na(
      `Information about my current and previous programs and my academic interests [3]`
    )
  ) %>%
  select(
    last_name,
    first_name,
    login,
    current_program,
    previous_program,
    previous_university,
    academic_interests,
    not_name,
    not_picture,
    not_info
  ) %>%
  mutate_at(
    .vars = vars(
      current_program,
      previous_program,
      previous_university,
      academic_interests
    ),
    .funs = ~ ifelse(not_info, NA_character_, .)
  )

## Add picture
survey$picture_path <- NA_character_
picture_folders <- list.files("collage_app/pictures")
for (i in seq_len(nrow(survey))) {
  if (any(sapply(survey$login[i], grepl, picture_folders))) {
    which_folder <-
      which(sapply(survey$login[i], grepl, picture_folders))
    folder_name <- picture_folders[which_folder]
    file_name <- list.files(paste0("collage_app/pictures/", folder_name))
    if (survey$not_picture[i]) {
      unlink(paste0("collage_app/pictures/", folder_name), recursive=TRUE)
      survey$picture_path[i] <- "pictures/no-picture.png"
    } else {
      survey$picture_path[i] <-
        paste0("pictures/", folder_name, "/", file_name)
    }
  } else {
    survey$picture_path[i] <- "pictures/no-picture.png"
  }
}

## Format
survey <- survey %>%
  filter(!not_name) %>%
  mutate(
    picture = picture_path,
    name = paste(first_name, last_name, sep = " "),
    current_program = current_program,
    previous_program = paste0(previous_program,
                              " (",
                              previous_university,
                              ")"),
    academic_interests = academic_interests
  ) %>%
  select(picture,
         name,
         current_program,
         previous_program,
         academic_interests) %>%
  saveRDS(file = "collage_app/data/collage_data.rds")
