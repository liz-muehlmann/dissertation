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
    age_range(., "V216")     # V216


#   ____________________________________________________________________________
#   look at variables with labels                                           ####

# view(look_for(wds_w3))

#   ____________________________________________________________________________
#   cross tabs                                                              ####


##  ............................................................................
##  age vs tv frequency                                                     ####

ageTV <- proc_freq(wds_w3,
                     "age_range", 
                     "V228", 
                     include.table_percent = FALSE) %>% 
    labels() %>% 
    labelizor(labels = c("age_range" = "Age Range",
                         "V228" = "How frequently do you watch Television?")) %>% 
    add_header_lines("World Values Trend (USA), Wave 3") %>% 
    center_header()

#### save file ####
# ageTV %>%
#     save_as_docx(path = "./results/prop_tables/250131_wvsw3_ageTV.docx")


##  ............................................................................
##  age vs trust                                                            ####

ageTrust <- proc_freq(wds_w3,
                   "age_range", 
                   "V27", 
                   include.table_percent = FALSE) %>% 
    labels() %>% 
    labelizor(labels = c("age_range" = "Age Range",
                         "V27" = "Generally speaking, would you say that most people can be trusted or that you can't be too careful in dealing with people")) %>% 
    add_header_lines("World Values Trend (USA), Wave 3") %>% 
    center_header()

#### save file ####
# ageTrust %>%
#     save_as_docx(path = "./results/prop_tables/250131_wvsw3_ageTrust.docx")

##  ............................................................................
##  tv vs trust                                                             ####

tvTrust <- proc_freq(wds_w3,
                      "V228", 
                      "V27", 
                      include.table_percent = FALSE) %>% 
    labels() %>% 
    labelizor(labels = c("V228" = "How frequently do you watch Television?",
                         "V27" = "Generally speaking, would you say that most people can be trusted or that you can't be too careful in dealing with people")) %>% 
    add_header_lines("World Values Trend (USA), Wave 3") %>% 
    center_header()

#### save file ####
# ageTrust %>%
#     save_as_docx(path = "./results/prop_tables/250131_wvsw3_tvTrust.docx")
# 

##  ............................................................................
##  tv vs happiness                                                         ####

tvHappiness <- proc_freq(wds_w3,
                     "V228", 
                     "V10", 
                     include.table_percent = FALSE) %>% 
    labels() %>% 
    labelizor(labels = c("V228" = "How frequently do you watch Television?",
                         "V10" = "Taking all things together, would you say you are...")) %>% 
    add_header_lines("World Values Trend (USA), Wave 3") %>% 
    center_header()

#### save file ####
# tvHappiness %>%
#     save_as_docx(path = "./results/prop_tables/250131_wvsw3_tvHappiness.docx")

##  ............................................................................
##  tv vs political interest                                                  ####

tvPoliticalInterest <- proc_freq(wds_w3,
                         "V228", 
                         "V117", 
                         include.table_percent = FALSE) %>% 
    labels() %>% 
    labelizor(labels = c("V228" = "How frequently do you watch Television?",
                         "V117" = "How interested would you say you are in politics?")) %>% 
    add_header_lines("World Values Trend (USA), Wave 3") %>% 
    center_header()

#### save file ####
# tvPoliticalInterest %>%
#     save_as_docx(path = "./results/prop_tables/250131_wvsw3_tvPoliticalInterest.docx")

##  ............................................................................
##  tv vs signed a patition                                                   ####

tvUnofficialStrike <- proc_freq(wds_w3,
                                 "V228", 
                                 "V121", 
                                 include.table_percent = FALSE) %>% 
    labels() %>% 
    labelizor(labels = c("V228" = "How frequently do you watch Television?",
                         "V121" = "Have you joined an unoffical strike?")) %>% 
    add_header_lines("World Values Trend (USA), Wave 3") %>% 
    center_header()

#### save file ####
# tvUnofficialStrike %>%
#     save_as_docx(path = "./results/prop_tables/250131_wvsw3_tvUnofficialStrike.docx")




























