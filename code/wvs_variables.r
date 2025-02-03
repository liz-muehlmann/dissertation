### file description ###########################################################
##                                                                            ##
## This file processes the world values survey data                           ##
##                                                                            ##
##      Data included:                                                        ##
##        wvs wave 1, 2, 3, 4, 5, 6, 7                                           ## 
##        https://www.worldvaluessurvey.org/                                  ##    
##                                                                            ##
##      Output | Last Save:                                                   ##
##                                                                            ##
##                                                                            ##
## ########################################################################## ## 

#   ____________________________________________________________________________
#   load libraries                                                          ####

library(openxlsx)
library(stringr)
library(stringdist)
data("mtcars")
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
#   wave 1                                                                  ####

# 
# wv1_variables <- paste(c("V"), c(10:24, 27, 28, 30:35, 37, 51:57, 65, 66, 75:87, 89, 92:96,
#                                    106, 110:124, 135:138, 140, 141, 144:146, 178, 179, 192:205, 214:216,
#                                    218:220, 226, 232, 233), sep="")

# n = 2325 (US)
wvs_w1 <- readRDS("./data/WVS/WV1 - F00008371-WV1_Data_R_v20200208/WV1_Data_R_v20200208.rds") %>% 
  filter(V2 == 840) %>%                                       # filter for USA
  # select(all_of(wv1_variables)) %>% 
  age_range(., "V216")


#   ____________________________________________________________________________
#   wave 2                                                                  ####

wvs_w2 <- set_variable_labels(mtcars,
                               mpg = "Miles/(US) gallon",
                               cyl = "Number of cylinders",
                               disp = "Displacement (cu.in.)",
                               hp = "Gross horsepower",
                               drat = "Rear axle ratio",
                               wt = "Weight (1000 lbs)",
                               qsec = "1/4 mile time",
                               vs = "Engine",
                               vs = c("V-engine" = 0,
                                      "Straight engine" = 1),
                               am = "Transmission",
                               am = c("Automatic" = 0,
                                      "Manual"=1),
                               gear = "Number of forward gears",
                               carb = "Number of carburetors"
)

#   ____________________________________________________________________________
#   wave 3                                                                  ####

# wv3_variables <- paste(c("V"), c(2, 4:10, 12:41, 47:55, "56_01", 57:60, 65:66,
#                                    86, 89, 92:96, 98:123, 124:132, 135:148,
#                                    151:152, 154:171, 179, 182, 192:206, 208, 
#                                    210:217, 226, 227, 228), sep="")

## 56_01 too
# n = 1542 (US)
wvs_w3 <- readRDS("./data/WVS/WV3 - F00008205-WV3_Data_R_v20180912/F00008205-WV3_Data_R_v20180912.rds") %>% 
  filter(V2 == 840) %>%                                      # filter for USA
  # select(all_of(wv3_variables)) %>% 
  age_range(., "V216")     # V216


#   ____________________________________________________________________________
#   wave 4                                                                  ####

# wv4_variables <- paste(c("V"), c(2, 4:34, 37:67, 68:76, "77_01", 78, 79, 83, 98:100,
#                                    103, 106, 109:145, 147:159, 161:163, 164:175,
#                                    186, 200:213, 216:218, 220, 223, 225, 237, 
#                                    "237B"), sep="")

# n = 1200 (US)
wvs_w4 <- read_dta("./data/WVS/WV4 - F00011152-WV4_Data_R_v20201117/WV4_Data_stata_v20201117.dta") %>% 
  filter(V2 == 840) %>%                                      # filter for USA
  # select(all_of(wv4_variables)) %>% 
  age_range(., "V225")

#   ____________________________________________________________________________
#   wave 5                                                                  ####


# wvs5_variables <- paste(c("V"), c(1, 2, 4:44, 46, 47, 51:55, 57:74, 76:103, 
#                                    114:145, "146_05", 147:164, 166:169, 177, 185, 194:211, 223:233,
#                                    235, 237, 238, 252, 256), sep="")

# n = 1249 (US)
wvs_w5 <- readRDS("./data/WVS/WV5 - F00007944-WV5_Data_R_v20180912/F00007944-WV5_Data_R_v20180912.rds") %>% 
  filter(V2 == 840)  %>%                                       # filter for USA
  # select(all_of(wvs5_variables)) %>% 
  age_range(., "V237")

#   ____________________________________________________________________________
#   wave 6                                                                  ####

# wvs6_variables <- paste(c("V"), c(2, 4:10, 12:57, 60:80, 84:124, "125_05", 
#                                    126:142, 144, 157:160, 170:180, 192:214,
#                                    216:224, 225:228, 229, 238, 240, 242, 248, 
#                                    254), sep="")

# n = 2232 (US)

wvs_w6 <- read_dta("./data/WVS/WV6 - F00011103-WV6_Data_R_v20201117/F00011106-WV6_Data_stata_v20201117/WV6_Data_stata_v20201117.dta") %>% 
  filter(V2 == 840) %>%                                       # filter for USA
  # select(all_of(wvs6_variables)) %>% 
  age_range(., "V242")

#   ____________________________________________________________________________
#   wave 7 time series                                                      ####

# wvs7_variables <- paste(c("Q"), c(1:34, 36:46, 48:50, 56:89, 94:110, 113:120, 
#                                    131:141, 149:163, 177:260, 262, 273, 290), 
#                          sep="")

# n = 2596 (US)
wvs_w7 <- read_dta("./data/WVS/WV7 - F00011356-WVS_Cross-National_Wave_7_csv_v6_0/F00010734-WVS_Cross-National_Wave_7_stata_v6_0/WVS_Cross-National_Wave_7_stata_v6_0.dta") %>% 
  filter(B_COUNTRY_ALPHA == "USA") %>%                                       # filter for USA
  # select(all_of(wvs7_variables)) %>% 
  age_range(., "Q262")

#   ____________________________________________________________________________
#   save variables to excel sheet                                           ####

all_waves <- list(wvs_w1, wvs_w2, wvs_w3, wvs_w4, wvs_w5, wvs_w6, wvs_w7) 

i = 1
for(w in all_waves) {
  
  v <- as.data.frame(look_for(w)) %>%
    select(pos, variable, label, missing) %>%
    mutate(label = str_replace_all(label, "[^[:print:]]", ""))  # remove illegal xml characters

  assign(paste("vars_", i, sep = ""), v)
  i = i + 1
  print(i)
}

all_vars <- list(vars_1, vars_2, vars_3, vars_4, vars_5, vars_6, vars_7)

wv_n <- 1
wb <- createWorkbook()
for (v in all_vars) {
  sheet_name = paste("wave_", wv_n)
  addWorksheet(wb, sheet_name)
  writeData(wb, sheet_name, assign(paste("wave_w", wv_n, sep=""), v))
  wv_n <- wv_n + 1
}

# saveWorkbook(wb, './data/WVS/wvs_variables_all.xlsx')



#   ____________________________________________________________________________
#   time series data

wvs_trend <- read_dta("./data/WVS/Time Series - 1981-2022 - F00011932-WVS_Time_Series_1981-2022_Rdata_v5_0/F00011930-WVS_Time_Series_1981-2022_Stata_v5_0/WVS_Time_Series_1981-2022_stata_v5_0.dta")
