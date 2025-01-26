### file description ###########################################################
##                                                                            ##
## This file processes pew's national public opinion reference survey         ##
##                                                                            ##
##      Data included:                                                        ##
##        NPORS 2022                                                          ## 
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

npors22 <- read_sav("./data/NPORS/NPORS-2022-Data-Release/NPORS_2022_for_public_release.sav") %>% 
    select(RESPID, COMTYPE2, GOVSIZE1, VOL12_CPS, ROBWRK, RESPFUT, EMINUSE, 
           INTMOB, INTFREQ, HOME4NW2, BBHOME, starts_with("SMUSE"), GENDER, 
           BOOKS1, RADIO, DEVICE1a, SMART2, RELIMP, MARITAL, PARTY, RACECMB, 
           PARTYLN, EDUCATION, REG, VOTED2020, DISAMOD, INCOME, AGE, CREGION, 
           DIVISION) %>% 
    rename(respondent_id = RESPID,
           community_type = COMTYPE2,
           gov_size = GOVSIZE1,
           volunteered = VOL12_CPS,
           robot_work = ROBWRK,
           future_skills = RESPFUT,
           email_use = EMINUSE,
           mobile_internet = INTMOB,
           internet_frequency = INTFREQ,
           home_internet = HOME4NW2,
           home_int_service = BBHOME,
           facebook = SMUSE_a,
           youtube = SMUSE_b,
           twitter = SMUSE_c,
           instagram = SMUSE_d,
           snapchat = SMUSE_e,
           whatsapp = SMUSE_f,
           linkedin = SMUSE_g,
           pinterest = SMUSE_h,
           tiktok = SMUSE_i,
           gender = GENDER,
           read_books = BOOKS1,
           radio = RADIO,
           owns_cellphone = DEVICE1a,
           owns_smartphone = SMART2,
           religion_importance = RELIMP,
           marital_status = MARITAL,
           party = PARTY,
           race_combined = RACECMB,
           party_lean = PARTYLN,
           education = EDUCATION,
           reg_status = REG,
           voted2020 = VOTED2020,
           disabled = DISAMOD,
           income = INCOME,
           age = AGE,
           census_region = CREGION,
           division = DIVISION) %>% 
    mutate(age_range = case_when(age >= 18 & age <= 24 ~ "18-24",
                                 age >= 25 & age <= 34 ~ "25-34",
                                 age >= 35 & age <= 44 ~ "35-44",
                                 age >= 45 & age <= 54 ~ "45-54",
                                 age >= 55 & age <= 64 ~ "55-64",
                                 age >= 65 & age <= 74 ~ "65-74",
                                 age >= 75 & age <= 84 ~ "75-84",
                                 age >= 85 & age != 999 ~ "85+",
                                 age == 999 ~ NA))

#   ____________________________________________________________________________
#  age vs government size                                                   ####

ageGovSize <- proc_freq(npors22,
                       "age_range", 
                       "gov_size", 
                       include.table_percent = FALSE) %>% 
    labels() %>% 
    labelizor(labels = c("gov_size" = "If you had to choose, would you rather have...")) %>% 
    add_header_lines("Pew National Public Opinion Reference Survey 2022") %>% 
    center_header()

### . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . ..
### save table                                                              ####

ageGovSize %>% 
    save_as_docx(path = "./results/prop_tables/250125_npors22_ageGovSize.docx")


#   ____________________________________________________________________________
#  age vs email use                                                         ####

ageEmail <- proc_freq(npors22,
                        "age_range", 
                        "email_use", 
                        include.table_percent = FALSE) %>% 
    labels() %>% 
    labelizor(labels = c("email_use" = "Do you use the internet or email, at least occasionally?")) %>% 
    add_header_lines("Pew National Public Opinion Reference Survey 2022") %>% 
    center_header()

### . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . ..
### save table                                                              ####

ageGovSize %>% 
    save_as_docx(path = "./results/prop_tables/250125_npors22_ageGovSize.docx")
