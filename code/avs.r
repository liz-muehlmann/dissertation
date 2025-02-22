### file description ###########################################################
##                                                                            ##
## This file processes the world values survey data                           ##
##                                                                            ##
##      Data included:                                                        ##
##        avs wave                                                            ##
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
source("./code/prelims.r")

avs2010 <- read_sav("data/AVS/2010 - PRRI-2010-American-Values-Survey.sav")
avs2011 <- read_sav("data/AVS/2011 - PRRI-2011-American-Values-Survey.sav")
avs2012 <- read_sav("data/AVS/2012 - PRRI-2012-American-Values-Survey.sav")
avs2013 <- read_sav("data/AVS/2013 - PRRI-2013-American-Values-Survey.sav")
avs2014 <- read_sav("data/AVS/2014 - PRRI-2014-American-Values-Survey.sav")
avs2015 <- read_sav("data/AVS/2015 - PRRI-2015-American-Values-Survey.sav")
avs2016 <- read_sav("data/AVS/2016 - PRRI-2016-American-Values-Survey.sav")
avs2017 <- read_sav("data/AVS/2017 - PRRI-2017-American-Values-Survey.sav")
avs2018 <- read_dta("data/AVS/2018 - PRRI_American Values - 2018.dta")
avs2019 <- read_dta("data/AVS/2020 - PRRI 2020 American Values Survey.dta")
avs2020 <- read_dta("data/AVS/2021 - PRRI 2021 American Values Survey AVS 2021 Sept 30 2021.dta")
avs2021 <- read_dta("data/AVS/2022 - AVS 2022_Client Final Weighted.dta")
avs2022 <- read_dta("data/AVS/2023 - PRRI 2023 American Values Study_Client File 2023.dta")
avs2023 <- read_dta("data/AVS/2023 - PRRI 2023 American Values Study_Client File 2023.dta")

#   ____________________________________________________________________________
#   save variables to excel sheet                                           ####

all_waves <- list(avs2010, avs2011, avs2012, avs2013, avs2014, avs2015, avs2016,
                  avs2017, avs2018, avs2019, avs2020, avs2021, avs2021, avs2022,
                  avs2023) 

i = 1
for(w in all_waves) {
    
    v <- as.data.frame(look_for(w)) %>%
        select(pos, variable, label, missing) %>%
        mutate(label = str_replace_all(label, "[^[:print:]]", ""))  # remove illegal xml characters
    
    assign(paste("vars_", i, sep = ""), v)
    i = i + 1
}

all_vars <- list(vars_1, vars_2, vars_3, vars_4, vars_5, vars_6, vars_7, vars_8,
                 vars_9, vars_10, vars_11, vars_12, vars_13, vars_14, vars_15)

# wv_n <- 1
# wb <- createWorkbook()
# for (v in all_vars) {
#     sheet_name = paste("wave_", wv_n)
#     addWorksheet(wb, sheet_name)
#     writeData(wb, sheet_name, assign(paste("wave_w", wv_n, sep=""), v))
#     wv_n <- wv_n + 1
# }

# saveWorkbook(wb, './data/AVS/all_avs_waves.xlsx')


#   ____________________________________________________________________________
#   fuzzy matching question texts                                           ####

## define and label all waves
wave_labels <- c("vars_1" = 1,
                 "vars_2" = 2, 
                 "vars_3" = 3, 
                 "vars_4" = 4, 
                 "vars_5" = 5, 
                 "vars_6" = 6, 
                 "vars_7" = 7, 
                 "vars_8" = 8,
                 "vars_9" = 9, 
                 "vars_10" = 10, 
                 "vars_11" = 11, 
                 "vars_12" = 12, 
                 "vars_13" = 13, 
                 "vars_14" = 14, 
                 "vars_15" = 15)

## create empty list
matches <- list()

## iteratively compare each wave's questions
## loop through each later and set it as a comparison wave -1
for(ref in 1:(length(all_vars)-1)) {
    ## compare each layer to the comparison wave
    for(com in (ref + 1):length(all_vars)){
        
        ## get current comparison and reference waves
        wave_ref <- wave_labels[[paste0("vars_", ref)]]
        wave_com <- wave_labels[[paste0("vars_", com)]]
        
        ## fuzzy join reference wave and comparison wave 
        matched <- stringdist_join(
            all_vars[[ref]],
            all_vars[[com]],
            by = "label",
            mode = "left",
            method = "jw",
            max_dist = 0.2) %>% 
        filter(!is.na(pos.y)) %>%
        mutate(wave_ref = wave_ref,
               wave_com = wave_com) %>% 
        rename(pos_ref = pos.x,
               variable_ref = variable.x,
               question_ref = label.x,
               pos_com = pos.y,
               variable_com = variable.y,
               question_com = label.y)
        
        matches[[paste(ref, com, sep = "_")]] <- matched
    }
}

# all_matches <- bind_cols(matched)
all_matches <- do.call(rbind, matches) 

# write.csv(all_matches, "./data/AVS/all_waves.csv", row.names = FALSE)
