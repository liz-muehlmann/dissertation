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


variable_values <- paste(c("V"), c(2, 4:10, 12:57, 60:80, 84:124, "125_05", 
                                   126:142, 144, 157:160, 170:180, 192:214,
                                   216:224, 225:228, 229, 238, 240, 242, 248, 
                                   254), sep="")

# n = 2232 (US)

wds_w6 <- read_dta("./data/WVS/WV6 - F00011103-WV6_Data_R_v20201117/F00011106-WV6_Data_stata_v20201117/WV6_Data_stata_v20201117.dta") %>% 
    filter(V2 == 840) %>%                                       # filter for USA
    select(all_of(variable_values)) %>% 
    age_range(., "V242")

