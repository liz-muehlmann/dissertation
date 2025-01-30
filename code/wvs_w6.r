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

# n = 2232 (US)
load("./data/WVS/WV6 - F00011103-WV6_Data_R_v20201117/WV6_Data_R_v20201117.rdata") 

wds_w6 <- WV6_Data_R_v20201117 %>% 
    filter(V2 == 840)# %>%                                       # filter for USA
# select(all_of(variable_values))

