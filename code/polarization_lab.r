### file description ###########################################################
##                                                                            ##
## This file processes polarization lab data                                  ##
##                                                                            ##
##      Data included:                                                        ##
##        polarization lab survey                                             ## 
##                                                                            ##
##      Output | Last Save:                                                   ##
##                                                                            ##
##                                                                            ##
## ########################################################################## ## 


#   ____________________________________________________________________________
#   load libraries                                                          ####

source("./code/prelims.r")
library(fs)

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
#   load data                                                               ####

w32_2024 <- read.csv("./data/PolarizationLab/polarization_lab_allData/s99-2024-week32.csv") %>% 
    select(democrat_therm_1, republican_therm_1, general_trust, 
           institutional_corruption, institutional_response, vote_importance,
           pride, norm_executive, norm_executive_perception, norm_censorship,
           norm_censorship_perception, norm_loyalty, norm_loyalty_perception,
           starts_with("violence"), birthyr, gender, race, educ, marstat,
           employ, faminc_new, child18, pid3, pid7, inputstate, urbanicity2,
           votereg, ideo5, newsint, religpew)
