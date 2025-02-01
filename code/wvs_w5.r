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


variable_values <- paste(c("V"), c(1, 2, 4:44, 46, 47, 51:55, 57:74, 76:103, 
                                   114:145, "146_05", 147:164, 166:169, 177, 185, 194:211, 223:233,
                                   235, 237, 238, 252, 256), sep="")

# n = 1249 (US)
wds_w5 <- readRDS("./data/WVS/WV5 - F00007944-WV5_Data_R_v20180912/F00007944-WV5_Data_R_v20180912.rds") %>% 
    filter(V2 == 840)  %>%                                       # filter for USA
    select(all_of(variable_values)) %>% 
    age_range(., "V237")

























