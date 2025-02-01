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
#   load libraries                                                          ####

library(tidyverse)          # data handling
library(haven)              # read .sav files
library(flextable)          # pretty tables | cross tabs
library(modelsummary)       # pretty tables
library(labelled)           # view variable names and labels


#   ____________________________________________________________________________
#   table design                                                            ####

set_flextable_defaults(
    font.size = 12,
    font.family = "Garamond",
    space = 1,
    table.layout = "autofit"
    )


#   ____________________________________________________________________________
#   format flextable numbers                                                ####
fmt_me <- function(ft) {
    ft %>% 
        flextable() %>% 
        colformat_double(big.mark = ",", digits = 2, na_str = "N/A")
}


#   ____________________________________________________________________________
#   create age range variable                                               ####

age_range <- function(df, age) {
    # age <- readline("What is the age variable called? ")
    df <- df %>% 
        mutate(age_range = case_when(!!sym(age) >= 18 & !!sym(age) <= 24 ~ "18-24",
                                     !!sym(age) >= 25 & !!sym(age) <= 34 ~ "25-34",
                                     !!sym(age) >= 35 & !!sym(age) <= 44 ~ "35-44",
                                     !!sym(age) >= 45 & !!sym(age) <= 54 ~ "45-54",
                                     !!sym(age) >= 55 & !!sym(age) <= 64 ~ "55-64",
                                     !!sym(age) >= 65 & !!sym(age) <= 74 ~ "65-74",
                                     !!sym(age) >= 75 & !!sym(age) <= 84 ~ "75-84",
                                     !!sym(age) >= 85 & !!sym(age) != 999 ~ "85+",
                                     .default = NA))
}
