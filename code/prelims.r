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

