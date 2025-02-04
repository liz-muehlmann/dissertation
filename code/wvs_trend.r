### file description ###########################################################
##                                                                            ##
## This file processes the world values survey data                           ##
##                                                                            ##
##      Data included:                                                        ##
##        wvs wave trend                                                      ## 
##        https://www.worldvaluessurvey.org/WVSDocumentation.jsp              ##    
##                                                                            ##
##      Output | Last Save:                                                   ##
##                                                                            ##
##                                                                            ##
## ########################################################################## ## 

#   ____________________________________________________________________________
#   load libraries                                                          ####

source("./code/prelims.r")

#   ____________________________________________________________________________
#   load data                                                               ####

trend_variables <- c("version", "doi", "S001", "S002VS", "S020", "S021", "C001", 
                     "C005", "C037", "C038", "C059", "G001CS", "G002CS", "G007_17", 
                     "G007_18", "G007_33_B", "G007_34_B", "G007_35_B", 
                     "G007_36_B", "G007_37", "G007_64", "G007_65", "X001", "X002", 
                     "X003", "X007", "X025", "X045", "X051", "G006", "H001", "H009",
                     paste(c("A00"), c(2:6, 8), sep = ""),
                     paste(c("A0"), c(25:27, 29, 30, 32, 34, 35, 38, 39, 40, 41, 
                                      44:49, 57:66, 67:77, 79:94, 96:99), sep = ""),
                     paste(c("A"), c(100:120, 165, 168:170, 173, 189:199), sep = ""),
                     paste(c("D00"), c(2:9), sep = ""),
                     paste(c("D0"), c(10:16, 18, 19, 22:24, 54:63, 66, 77), sep = ""),
                     paste(c("E00"), c(1:9), sep = ""),
                     paste(c("E0"), c(10, 12, 14:20, 22, 23, 25:29, 32:37, 47:68), sep = ""),
                     paste(c("E"), c(104:125, 127:129, 133, 150, 188, 189, 196, 
                                     198, 205, 206, 213, 217:220, 222, 224, 
                                     236, 248:256, 258:264, 266:277, 289, 286:288, 
                                     291), sep = ""),
                     paste(c("F0"), c(24), sep=""),
                     paste(c("F"), c(108:110, 115:130, 132, 135, 136, 139:144, 164, 
                                     175, 189, 192, 193, 199, 200, 206), sep=""),
                     paste(c("G0"),c(019:021, 023), sep=""),
                     paste(c("H0"), c(010, 011), sep=""),
                     paste(c("I00"), c(001:002), sep=""))


wvs_trend <- read_dta("./data/WVS/Time Series - 1981-2022 - F00011932-WVS_Time_Series_1981-2022_Rdata_v5_0/F00011930-WVS_Time_Series_1981-2022_Stata_v5_0/WVS_Time_Series_1981-2022_stata_v5_0.dta") %>% 
  filter(COW_ALPHA == "USA") %>%                                # filter for USA
  select(all_of(trend_variables)) %>% 
  age_range(., "X003")

#   ____________________________________________________________________________
#   look at variables with labels                                           ####

view(look_for(wvs_trend))

#   ____________________________________________________________________________
#   look subset non-asked questions                                         ####

all_values <- function(x) {
    all(x == -4)
}

not_asked <- sapply(wvs_trend, function(x) {all(x == -4)})
not_asked <- data.frame(as.list(not_asked)) %>% 
    pivot_longer(!version, 
                 names_to = "variable",
                 values_to = "result") %>% 
    filter(result == TRUE) %>% 
    select(-version)

##  ............................................................................
##  filter out not asked questions                                          ####

wvs_trend <- wvs_trend[, -which(names(wvs_trend) %in% not_asked$variable)]

#   ____________________________________________________________________________
#   graphs                                                                  ####

wvs_trend %>% 
    # filter(E248 >= 0 & E263 >= -3) %>% 
    ggplot(aes(x=E248, y=E263)) +
    geom_point() 







































