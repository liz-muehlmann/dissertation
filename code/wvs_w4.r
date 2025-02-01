### file description ###########################################################
##                                                                            ##
## This file processes the world values survey data                           ##
##                                                                            ##
##      Data included:                                                        ##
##        wvs wave 4 -                                                        ## 
##        https://www.worldvaluessurvey.org/WVSDocumentationWV4.jsp           ##    
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


variable_values <- paste(c("V"), c(2, 4:34, 37:67, 68:76, "77_01", 78, 79, 83, 98:100,
                                   103, 106, 109:145, 147:159, 161:163, 164:175,
                                   186, 200:213, 216:218, 220, 223, 225, 237, 
                                   "237B"), sep="")

wds_w4 <- read_dta("./data/WVS/WV4 - F00011152-WV4_Data_R_v20201117/WV4_Data_stata_v20201117.dta")

# n = 1200 (US)
wds_w4 <- wds_w4 %>% 
    filter(V2 == 840) %>%                                      # filter for USA
    select(all_of(variable_values)) %>% 
    age_range(., "V225")



