### file description ###########################################################
##                                                                            ##
## This file processes the bright line data sets sets                         ##
##                                                                            ##
##      Data included:                                                        ##
##        Bright Line Watch Wave 19                                           ## 
##        Bright Line Watch Wave 20                                           ##
##        Bright Line Watch Wave 21                                           ## 
##                                                                            ##
##      Output | Last Save:                                                   ##
##                                                                            ##
##                                                                            ##
## ########################################################################## ## 

#   ____________________________________________________________________________
#   load libraries and data                                                 ####

source("./code/analysis_prelims.r")


#   ____________________________________________________________________________
#   custom functions                                                        ####

labels <- function(ft) {
    ft %>%
        labelizor(labels = c("age_range" = "Age Range",
                         "Mar. pct" = "Column ; Row %")) 
}

center_header <- function(ft) {
    ft %>% 
        align(align = "center", part = "header")
}


#   ____________________________________________________________________________
#   Bright Line Watch 19                                                    ####
blw19 <- read.csv("./data/BrightLineWatch/Wave 19/Public_Wave19.csv") %>% 
    select(birthyr,age9, rating_USA, biden_winner, media, pid7, educ7, ethnicity,
           polinterest, approve_biden, approve_trump, more_supporter,
           starts_with(c("fraud","statments", "January"))) %>% 
    mutate(age_range = case_when(age9 == 2 ~ "18-24",
                                 age9 == 3 ~ "25-34",
                                 age9 == 4 ~ "35-44",
                                 age9 == 5 ~ "45-54",
                                 age9 == 6 ~ "55-64",
                                 age9 == 7 ~ "65-74",
                                 age9 == 8 ~ "75-84",
                                 age9 == 9 ~ "85+")) %>% 
    mutate(rating_us_range = case_when(rating_USA == 0 ~ "0",
                                       rating_USA >= 1 & rating_USA <= 10 ~ "1-10",
                                       rating_USA >= 11 & rating_USA <= 20 ~ "11-20",
                                       rating_USA >= 21 & rating_USA <= 30 ~ "21-30",
                                       rating_USA >= 31 & rating_USA <= 40 ~ "31-40",
                                       rating_USA >= 41 & rating_USA <= 50 ~ "41-50",
                                       rating_USA >= 51 & rating_USA <= 60 ~ "51-60",
                                       rating_USA >= 61 & rating_USA <= 70 ~ "61-70",
                                       rating_USA >= 71 & rating_USA <= 80 ~ "71-80",
                                       rating_USA >= 81 & rating_USA <= 90 ~ "81-90",
                                       rating_USA >= 91 ~ "91-100")) 


##  ............................................................................
##  age vs us rating                                                        ####
ageRating <- proc_freq(blw19,
                       "age_range", 
                       "rating_us_range", 
                       include.table_percent = FALSE) %>% 
    labels() %>% 
    labelizor(labels = c("rating_us_range" = "US Rating")) %>% 
    add_header_lines("Bright Line Watch Wave 19") %>% 
    center_header()

### . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . ..
### save table                                                              ####

ageRating %>% 
    save_as_docx(path = "./results/prop_tables/250124_blw19_ageRating.docx")


##  ............................................................................
##  age vs biden winner                                                     ####

ageBiden <- proc_freq(blw19,
                      "age_range",
                      "biden_winner",
                      include.table_percent = FALSE) %>% 
    labels() %>% 
    labelizor(labels = c("biden_winner" = "Do you consider Biden the rightful winner of the 2020 election?",
                         "1" = "Definitely rightful",
                         "2" = "Probably rightful",
                         "3" = "Probably not rightful",
                         "4" = "Definitely not rightful"),
              part = "header") %>% 
    add_header_lines("Bright Line Watch Wave 19") %>% 
    center_header()

### . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . ..
### save table                                                              ####

ageBiden %>% 
    save_as_docx(path = "./results/prop_tables/250124_blw19_ageBiden.docx")

##  ............................................................................
##  age vs Jan6 protest                                                     ####

ageJan6_protest <- proc_freq(blw19,
                             "age_range",
                             "January_6th_a",
                             include.table_percent = FALSE) %>% 
    labels() %>% 
    labelizor(labels = c("January_6th_a" = "Is it appropriate or not appropriate to describe January 6th as a legitimate protest?",
                         "1" = "Appropriate",
                         "2" = "Not appropriate",
                         part = "header")) %>% 
    add_header_lines("Bright Line Watch Wave 19") %>% 
    center_header()

### . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . ..
### save table                                                              ####

ageJan6_protest %>% 
    save_as_docx(path = "./results/prop_tables/250124_blw19_ageJan6_protest.docx")

##  ............................................................................
##  age vs Jan6 riot                                                        ####

ageJan6_riot <- proc_freq(blw19,
                          "age_range",
                          "January_6th_b",
                          include.table_percent = FALSE) %>% 
    labels() %>% 
    labelizor(labels = c("January_6th_b" = "Is it appropriate or not appropriate to describe January 6th as a riot?",
                         "1" = "Appropriate",
                         "2" = "Not appropriate",
                         part = "header")) %>% 
    add_header_lines("Bright Line Watch Wave 19") %>% 
    center_header()

### . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . ..
### save table                                                              ####

ageJan6_riot %>% 
    save_as_docx(path = "./results/prop_tables/250124_blw19_ageJan6_riot.docx")

##  ............................................................................
##  age vs Jan6 insurrection                                                ####

ageJan6_insurrection <- proc_freq(blw19,
                                  "age_range",
                                  "January_6th_c",
                                  include.table_percent = FALSE) %>% 
    labels() %>% 
    labelizor(labels = c("January_6th_c" = "Is it appropriate or not appropriate to describe January 6th as an insurrection?",
                         "1" = "Appropriate",
                         "2" = "Not appropriate"),
              part = "header") %>% 
    add_header_lines("Bright Line Watch Wave 19") %>% 
    center_header()

### . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . ..
### save table                                                              ####

ageJan6_insurrection %>% 
    save_as_docx(path = "./results/prop_tables/250124_blw19_ageJan6_insurrection.docx")






    
blw20 <- read.csv("./data/BrightLineWatch/Wave 20/Public_Wave20.csv")
blw21 <- read.csv("./data/BrightLineWatch/Wave 21/Public_Wave21.csv")


 


















