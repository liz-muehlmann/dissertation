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


variable_values <- paste(c("V"), c(10:24, 27, 28, 30:35, 37, 51:57, 65, 66, 75:87, 89, 92:96,
                                   106, 110:124, 135:138, 140, 141, 144:146, 178, 179, 192:205, 214:216,
                                   218:220, 226, 232, 233), sep="")

# n = 2596 (US)
wds_w7 <- read.csv("./data/WVS/WV7 - F00011356-WVS_Cross-National_Wave_7_csv_v6_0/WVS_Cross-National_Wave_7_csv_v6_0.csv") %>% 
    filter(B_COUNTRY_ALPHA == "USA")# %>%                                       # filter for USA
# select(all_of(variable_values))

