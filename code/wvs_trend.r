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

library(openxlsx)
source("./code/prelims.r")

#   ____________________________________________________________________________
#   load data                                                               ####

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


#   ____________________________________________________________________________
#   load wvs trend data                                                     ####

wvs_trend <- read_dta("./data/WVS/Time Series - 1981-2022 - F00011932-WVS_Time_Series_1981-2022_Rdata_v5_0/F00011930-WVS_Time_Series_1981-2022_Stata_v5_0/WVS_Time_Series_1981-2022_stata_v5_0.dta") %>% 
  filter(COW_ALPHA == "USA") %>%                                # filter for USA
  select(all_of(trend_variables)) %>% 
  age_range(., "X003")


##  ........................................................................#### 
##  find variables that are not asked in a given wave                       ####

## 3 - A124_12 (Neighbors: Different Religions) | E124 (respect for individual human rights)
## 4 - A124_12 (Neighbors: Different Religions)
## 5 - X011 (Number of children)
## 6 - F119 (justifiable: prostitution) | F122 (justifiable: euthanasia)
## 7 - All questions asked
waves <- list(8403, 8404, 8405, 8406, 8407)
for (wave in waves){
  pr <- wvs_trend %>%
    filter(S024 == wave) %>% 
    select(where(~ all(.x == -4 | .x == -5,na.rm=TRUE)))
  assign(paste("wave_", wave, sep=""),pr)
}

## remove unnecessary wave data 
rm(wave_8403, wave_8404, wave_8405, wave_8406, wave_8407)

#   ____________________________________________________________________________
#   get all wave questions                                                  ####

## uncomment to save to workbook
wb <- createWorkbook()

for(w in waves) {
  d <- wvs_trend %>% 
    filter(S024 == w)
  v <- as.data.frame(look_for(d)) %>%
    select(pos, variable, label, missing) %>%
    mutate(label = str_replace_all(label, "[^[:print:]]", "")) # remove illegal xml characters
  
  # uncomment to save to workbook
  sheet_name = paste("wave", w, sep = "")
  addWorksheet(wb, sheet_name)
  writeData(wb, sheet_name, v)
  
  # uncomment to save to environment
  # assign(paste("vars_", w, sep = ""), v)
}

saveWorkbook(wb, './data/WVS/all_wvs_waves.xlsx')


#   ____________________________________________________________________________
#   cross tabs                                                              ####

