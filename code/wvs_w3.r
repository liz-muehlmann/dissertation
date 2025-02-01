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


variable_values <- paste(c("V"), c(2, 4:10, 12:41, 47:55, "56_01", 57:60, 65:66,
                                   86, 89, 92:96, 98:123, 124:132, 135:148,
                                   151:152, 154:171, 179, 182, 192:206, 208, 
                                   210:217, 226, 227, 228), sep="")

## 56_01 too
# n = 1542 (US)
wds_w3 <- readRDS("./data/WVS/WV3 - F00008205-WV3_Data_R_v20180912/F00008205-WV3_Data_R_v20180912.rds") %>% 
    filter(V2 == 840) %>%                                      # filter for USA
    select(all_of(variable_values)) %>% 
    rename(country = V2,
           importance_family = V4
           importance_friends = V5,
           importance_leisure = V6,
           importance_politics = V7, 
           importance_work = V8,
           importance_religion = V9,
           feel_happy = V10,
           respect_parents = V12,
           responsibility_parents = V13, 
           child_manners = V14,
           child_independence = V15,
           child_hardWork = V16, 
           child_responsibility = V17,
           child_imagination = V18,
           child_tolerance = V19,
           child_thrifty = V20,
           child_determination = V21,
           child_religion = V22,
           child_unselfish = V23,
           child_obedience = V24,
           child_learn1 = V25,
           child_learn2 = V26, 
           trust_people = V27, 
           )


