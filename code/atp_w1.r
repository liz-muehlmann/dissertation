### file description ###########################################################
##                                                                            ##
## This file processes pew's american trends panel data                       ##
##                                                                            ##
##      Data included:                                                        ##
##        pew wave 1 -                                                        ## 
##                                                                            ##
##      Output | Last Save:                                                   ##
##                                                                            ##
##                                                                            ##
## ########################################################################## ## 


#   ____________________________________________________________________________
#   load libraries                                                          ####

source("./code/prelims.r")

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

atp_w1 <- read_sav(file = "./data/Pew/W1_Mar14/ATP W1.sav") %>% 
    select(starts_with(c("Q1_", "Q7_", "Q8_", "Q9_", "Q10_", "Q16_", "Q17_",
                         "Q18_", "Q19_", "Q25_", "Q33_", "Q34_", "Q35_", "Q36_",
                         "Q41_", "Q42_", "Q44_", "Q46_", "Q47_", "Q48_",
                         "REGSTATUS", "UPDATE", "CONTACT1", "CONWHO", "SEARCH",
                         "SEARCHWHAT", "PARTY", "PARTYLN"))) %>% 
    rename()


























