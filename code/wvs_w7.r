### file description ###########################################################
##                                                                            ##
## This file processes the world values survey data                           ##
##                                                                            ##
##      Data included:                                                        ##
##        wvs wave 3 -                                                        ## 
##        https://www.worldvaluessurvey.org/WVSDocumentationWV3.jsp           ##    
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


variable_values <- paste(c("Q"), c(1:34, 36:46, 48:50, 56:89, 94:110, 113:120, 
                                   131:141, 149:163, 177:260, 262, 273, 290), 
                         sep="")

# n = 2596 (US)
wds_w7 <- read_dta("./data/WVS/WV7 - F00011356-WVS_Cross-National_Wave_7_csv_v6_0/F00010734-WVS_Cross-National_Wave_7_stata_v6_0/WVS_Cross-National_Wave_7_stata_v6_0.dta") %>% 
    filter(B_COUNTRY_ALPHA == "USA") %>%                                       # filter for USA
    select(all_of(variable_values)) %>% 
    age_range(., "Q262")

