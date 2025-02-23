### file description ###########################################################
##                                                                            ##
## This file processes the world values survey data                           ##
##                                                                            ##
##      Data included:                                                        ##
##        wvs wave 1, 3, 4, 5, 6, 7                                           ## 
##        https://www.worldvaluessurvey.org/                                  ##    
##                                                                            ##
##      Output | Last Save:                                                   ##
##                                                                            ##
##                                                                            ##
## ########################################################################## ## 

#   ____________________________________________________________________________
#   load libraries                                                          ####

library(openxlsx)
# data("mtcars")
source("./code/prelims.r")

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
#   wave 2 - create fake data because wave 2 has no questions of interest   ####

# wvs_w2 <- set_variable_labels(mtcars,
#                                mpg = "Miles/(US) gallon",
#                                cyl = "Number of cylinders",
#                                disp = "Displacement (cu.in.)",
#                                hp = "Gross horsepower",
#                                drat = "Rear axle ratio",
#                                wt = "Weight (1000 lbs)",
#                                qsec = "1/4 mile time",
#                                vs = "Engine",
#                                vs = c("V-engine" = 0,
#                                       "Straight engine" = 1),
#                                am = "Transmission",
#                                am = c("Automatic" = 0,
#                                       "Manual"=1),
#                                gear = "Number of forward gears",
#                                carb = "Number of carburetors"
# )

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

all_waves <- list(wvs_w1, wvs_w3, wvs_w4, wvs_w5, wvs_w6, wvs_w7) 
# wvs_w2 needs to be added to the list if you're going to print the waves to their own sheets. 
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

##  ............................................................................
##  define trend variables                                                  ####

trend_variables <- c('A001', # waves 3-7 | important in life: family 
                     'A002', # waves 3-7 | important in life: friends 
                     'A003', # waves 3-7 | important in life: leisure time 
                     'A004', # waves 3-7 | important in life: politics 
                     'A005', # waves 3-7 | important in life: work 
                     'A006', # waves 3-7 | important in life: religion 
                     'A008', # waves 3-7 | feeling of happiness 
                     'A029', # waves 3-7 | important child qualities: independence 
                     'A030', # waves 3-7 | important child qualities: hard work
                     'A032', # waves 3-7 | important child qualities: feeling of responsibility
                     'A034', # waves 3-7 | important child qualities: imagination
                     'A035', # waves 3-7 | important child qualities: tolerance & respect for other people
                     'A038', # waves 3-7 | important child qualities: thrift saving money & things
                     'A039', # waves 3-7 | important child qualities: determination perseverance 
                     'A040', # waves 3-7 | important child qualities: religious faith
                     'A041', # waves 3-7 | important child qualities: unselfishness
                     'A042', # waves 3-7 | important child qualities: obedience
                     'A124_02', # waves 3-7 | neighbors: different races
                     'A124_03', # waves 3-7 | neighbors: heavy drinkers
                     'A124_06', # waves 3-7 | neighbors: immigrants
                     'A124_07', # waves 3-7 | neighbors: people with AIDS
                     'A124_08', # waves 3-7 | neighbors: drug addicts
                     'A124_09', # waves 3-7 | neighbors: homosexuals
                     'A124_12', # waves 5-7 | neighbors: different religion
                     'A165', # waves 3-7 | most people can be trusted
                     'A170', # waves 3, 4, 6-7 | satisfaction with your life | wave 5 - V23
                     'A173', # waves 3, 4, 6-7 | how much freedom of choice and control - V22
                     'C001', # waves 3, 4, 6-7 | jobs scarce: men more right | wave 5 - V46 
                     'C002', # waves 3, 4, 6-7 | jobs scares: citizens not immigrants | wave 5 - V45 
                     'COUNTRY_ALPHA', # waves 3-7 | country code USA
                     'COW_ALPHA', # waves 3-7 | country code USA
                     'COW_NUM', # waves 3-7 | country code 2
                     'D054', # waves 3, 4, 6-7 | main life goal make parents proud | wave 5 - V64
                     'D057', # waves 3, 4, 6-7 | being a housewife is just as fulfilling | wave 5 - V60 
                     'D059', # waves 3, 4, 6-7 | men make better political leaders than women | wave 5 - V61 
                     'D060', # waves 3, 4, 6-7 | university is more important for boy than girl | wave 5 - V62
                     'E001', # waves 3, 4, 6-7 | aims of country: 1 | wave 5 - V69
                     'E002', # waves 3, 4, 6-7 | aims of country: 2 | wave 5 - V70
                     'E003', # waves 3, 4, 6-7 | aims of respondent: 1 | wave 5 - V71
                     'E004', # waves 3, 4, 6-7 | aims of respondent: 2 | wave 5 - V72
                     'E016', # waves 3, 4, 6-7 | future changes: more tech | wave 5 - V77 
                     'E018', # waves 3-7 | future changes: greater respect for authority
                     'E023', # waves 3, 4, 6-7 | interest in politics | wave 5 - V95
                     'E025', # waves 3-7 | political interest: sign a petition
                     'E026', # waves 3, 4, 6-7 | political interest: joining in boycotts | wave 5 - V97
                     'E027', # waves 3, 4, 6-7 | political interest: attending lawful demonstration | wave 5 - V98
                     'E033', # waves 3, 4, 6-7 | ideology - self placement | wave 5 - V114
                     'E035', # waves 3, 4, 6-7 | income inequality | wave 5 - V116
                     'E069_01', # waves 3, 4, 6-7 | confidence: churches | wave 5 - V131
                     'E069_04', # waves 3, 4, 6-7 | confidence: the press | wave 5 - V133
                     'E069_05', # waves 3, 4, 6-7 | confidence: labor unions | wave 5 - V135
                     'E069_06', # waves 3, 4, 6-7 | confidence: the police | wave 5 - V136
                     'E069_07', # waves 3, 4, 6-7 | confidence: parliament | wave 5 - V140
                     'E069_08', # waves 3, 4, 6-7 | confidence: civil services | wave 5 - V141
                     'E069_10', # waves 3, 4, 6-7 | confidence: television | wave 5 - V134
                     'E069_11', # waves 3, 4, 6-7 | confidence: government | wave 5 - V138
                     'E069_12', # waves 3, 4, 6-7 | confidence: political parties | wave 5 - V139
                     'E069_13', # waves 3, 4, 6-7 | confidence: major companies | wave 5 - V140
                     'E069_14', # waves 3, 4, 6-7 | confidence: environmental protection agency | wave 5 - V143
                     'E069_15', # waves 3, 4, 6-7 | confidence: women's movement | wave 5 - V144
                     'E069_20', # waves 3, 4, 6-7 | confidence: United Nations | wave 5 - V147
                     'E114', # waves 3, 4, 6-7 | political system: having a strong leader  | wave 5 - V148
                     'E115', # waves 3, 4, 6-7 | political system: having experts make decisions | wave 5 - V149 
                     'E116', # waves 3, 4, 6-7 | political system: having the army rule | wave 5 - V150
                     'E117', # waves 3, 4, 6-7 | political system: having a democracy | wave 5 - V151
                     'E124', # waves 3, 4, 6-7 | respect for individual human rights nowadays | wave 5 - V164 
                     'F034', # waves 3, 4, 6-7 | religious person | wave 5 - V187
                     'F114A', # waves 3, 4, 6-7 | justifiable: claiming government benefits | wave 5 - V198
                     'F115', # waves 3, 4, 6-7 | justifiable: avoiding fare on public transport | wave 5 - V199
                     'F116', # waves 3, 4, 6-7 | justifiable: cheating on taxes | wave 5 - V200
                     'F117', # waves 3, 4, 6-7 | justifiable: someone accepting a bribe | wave 5 - V201 
                     'F118', # waves 3, 4, 6-7 | justifiable: homosexuality | wave 5 - V202
                     'F119', # waves 3, 4, 6-7 | justifiable: prostitution | wave 5 - V203
                     'F120', # waves 3, 4, 6-7 | justifiable: abortion | wave 5 - V204
                     'F121', # waves 3, 4, 6-7 | justifiable: divorce | wave 5 - V205
                     'F122', # waves 3, 4, 6-7 | justifiable: euthanasia | wave 5 - V206
                     'F123', # waves 3, 4, 6-7 | justifiable: suicide | wave 5 - V207
                     'G006', # waves 3, 4, 6-7 | how proud of nationality | wave 5 - V209
                     'S002VS', # waves 3-7 | chronology of EVS-WVS waves
                     'S003', # waves 3-7 | ISO 3166-1 numeric country code
                     'S024', # waves 3-7 | country - wave
                     'S025', # waves 3-7 | county - year
                     'X001', # waves 3-7 | sex
                     'X002', # waves 3-7 | year of birth
                     'X003', # waves 3-7 | age
                     'X007', # waves 3-7 | marital status
                     'X011', # waves 3-7 | how many children do you have
                     'X025CSWVS', # waves 3-7 |  education (country specific)
                     'X026', # waves 3, 4, 6-7 | do you live with your parents | wave 5 - V240
                     'X028', # waves 3-7 | employment status
                     'X045', # waves 3, 4, 6-7 | social class (subjective) | wave 5 - V252
                     'X047_WVS' # waves 3, 4, 6-7 | scale of incomes | wave 5 - V253
                     )

##  ........................................................................####
##  load wvs trend data                                                     ####

wvs_trend <- read_dta("./data/WVS/Time Series - 1981-2022 - F00011932-WVS_Time_Series_1981-2022_Rdata_v5_0/F00011930-WVS_Time_Series_1981-2022_Stata_v5_0/WVS_Time_Series_1981-2022_stata_v5_0.dta") %>% 
  filter(COW_ALPHA == "USA") %>% 
  select(all_of(trend_variables))

##  ........................................................................#### 
##  find variables that are not asked in any panel                          ####

## people of different religion not asked in first two waves
## var = a124_12
not_asked <- wvs_trend %>%
  group_by(S024) %>%
  summarise(across(everything(), ~ any(. == -5))) %>% 
  filter_all(any_vars(. %in% TRUE))













