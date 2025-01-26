### file description ###########################################################
##                                                                            ##
## This file processes pew's american trends panel data                       ##
##                                                                            ##
##      Data included:                                                        ##
##        pew wave 1 -                                                        ## 
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

atp_wave5 <- read_sav("./data/Pew/American-Trends-Panel-Wave-5-Jul-14/W5_Jul14/ATP W5.sav") %>% 
    select(QKEY,                       # question key 
           Q1_W5,                      # life satisfaction
           Q1AA_W5,                    # social satisfaction
           Q1AB_W5,                    # family satisfaction
           Q2_W5,                      # community rating
           Q3_W5,                      # talk to neighbors
           Q4_W5,                      # time on internet
           Q5_W5,                      # internet use
           Q6_W5,                      # privacy concerns
           Q7_W5,                      # volunteered, last 12 months
           Q8_W5,                      # volunteered, since July 2024
           starts_with(c("Q9",         # engaged in different activities
                         "Q19",        # race discrimination
                         "FAVPOL",     # favorability of people
                         "Q24",        # feeling thermometer 
                         "Q31")),      # race combined
           Q10_W5,                     # community improvement
           Q11_W5,                     # trust in others
           Q18_W5,                     # walk in community at night
           Q21_W5,                     # God is the source of morals
           Q25_W5,                     # news interest       
           Q29_W5,                     # social class
           Q30_W5,                     # standard of living
           RELIG_W5,                   # religion identification
           PARTY_W5,                   # political party
           PARTYLN_W5,                 # party lean
           UPDATE_W5,                  # update or recently registered
           CONTACT1_W5,                # contacted about election
           SEARCH_W5,                  # search about election
           F_AGECAT_TYPOLOGY,          # age
           F_CREGION_FINAL,            # census region
           F_EDUCCAT_TYPOLOGY,         # education
           F_MARITAL_TYPOLOGY,         # marital status
           F_INCOME_TYPOLOGY) %>%      # income 
    rename(qkey = QKEY,
           life_satisfaction = Q1_W5,
           social_satisfaction = Q1AA_W5,
           family_satisfaction = Q1AB_W5,                    
           community_rating = Q2_W5,                      
           talk_to_neighbors = Q3_W5,                      
           time_on_internet = Q4_W5,                      
           internet_use = Q5_W5,                      
           internet_privacy = Q6_W5,                      
           volunteered_12mo = Q7_W5,                      
           volunteered_july = Q8_W5,                      
           vigorous_exercise = Q9A_W5,
           video_game = Q9B_W5,
           talk_someone = Q9C_W5,
           text_someone = Q9D_W5, 
           visit_someone = Q9E_W5,
           write_letter = Q9F_W5,
           social_media = Q9G_W5,
           read_paper = Q9H_W5,
           watch_news = Q9I_W5,
           listen_radio = Q9J_W5,
           community_organizing = Q10_W5,
           trust_others = Q11_W5,
           walk_night = Q18_W5,
           discrim_blacks = Q19A_W5,
           discrim_lgbtq = Q19B_W5,
           discrim_hispanics = Q19C_W5,
           discrim_women = Q19D_W5,
           fave_hClinton = FAVPOL_A_W5,
           fave_mObama = FAVPOL_B_W5,         # note = no c; per pew
           fave_gwBush = FAVPOL_D_W5,
           fave_mMcConnell = FAVPOL_E_W5,
           fave_hReid = FAVPOL_F_W5,
           fave_sPalin = FAVPOL_G_W5,
           god_morals = Q21_W5,
           therm_gop = Q24A_W5,
           therm_dem = Q24B_W5,
           therm_scotus = Q24C_W5,
           news_int = Q25_W5,
           social_class = Q29_W5,
           parent_compare = Q30_W5,
           race_white = Q31_COMBINED_1_W5,
           race_hispanic = Q31_COMBINED_2_W5,
           race_black = Q31_COMBINED_3_W5,
           race_asian = Q31_COMBINED_4_W5,
           race_amind = Q31_COMBINED_5_W5,
           race_nhapi = Q31_COMBINED_6_W5,
           race_other = Q31_COMBINED_7_W5,
           race_unknown = Q31_COMBINED_8_W5,
           race_refused = Q31_COMBINED_9_W5,
           religion = RELIG_W5,
           party = PARTY_W5,
           party_lean = PARTYLN_W5, 
           update_reg = UPDATE_W5,
           contact_election = CONTACT1_W5,
           search_election = SEARCH_W5,
           age_categories = F_AGECAT_TYPOLOGY,
           census_region = F_CREGION_FINAL,
           education = F_EDUCCAT_TYPOLOGY,         
           marital_status = F_MARITAL_TYPOLOGY,         
           income = F_INCOME_TYPOLOGY) 

#   ____________________________________________________________________________
#   age vs satisfaction                                                     ####

##  ............................................................................
##  age vs life satisfaction                                                ####

ageLife <- proc_freq(atp_wave5,
                     "age_categories", 
                     "life_satisfaction", 
                     include.table_percent = FALSE) %>% 
    labels() %>% 
    labelizor(labels = c("age_categories" = "Age Range",
                         "life_satisfaction" = "Generally, how would you say things are these days in your life? Would you say that you are…")) %>% 
    add_header_lines("Pew American Trends Panel Wave 5") %>% 
    center_header()

#### save file ####
ageLife %>% 
    save_as_docx(path = "./results/prop_tables/250126_atpw5_ageLife.docx")

##  ............................................................................
##  age vs social satisfaction                                              ####

ageSocial <- proc_freq(atp_wave5,
                     "age_categories", 
                     "social_satisfaction", 
                     include.table_percent = FALSE) %>% 
    labels() %>% 
    labelizor(labels = c("age_categories" = "Age Range",
                         "social_satisfaction" = "How satisfied are you with your social life?")) %>% 
    add_header_lines("Pew American Trends Panel Wave 5") %>% 
    center_header()

#### save file ####
ageSocial %>% 
    save_as_docx(path = "./results/prop_tables/250126_atpw5_ageSocial.docx")

##  ............................................................................
##  age vs family satisfaction                                              ####

ageFamily <- proc_freq(atp_wave5,
                       "age_categories", 
                       "family_satisfaction", 
                       include.table_percent = FALSE) %>% 
    labels() %>% 
    labelizor(labels = c("age_categories" = "Age Range",
                         "family_satisfaction" = "How satisfied are you with your family life?")) %>% 
    add_header_lines("Pew American Trends Panel Wave 5") %>% 
    center_header()

#### save file ####
ageFamily %>% 
    save_as_docx(path = "./results/prop_tables/250126_atpw5_ageFamily.docx")


#   ____________________________________________________________________________
#   age vs internet use                                                     ####

##  ............................................................................
##  age vs time on internet                                                 ####

ageIntTime <- proc_freq(atp_wave5,
                       "age_categories", 
                       "time_on_internet", 
                       include.table_percent = FALSE) %>% 
    labels() %>% 
    labelizor(labels = c("age_categories" = "Age Range",
                         "time_on_internet" = "How often did you USUALLY access the Internet over the last year?")) %>% 
    add_header_lines("Pew American Trends Panel Wave 5") %>% 
    center_header()

#### save file ####
ageIntTime %>% 
    save_as_docx(path = "./results/prop_tables/250126_atpw5_ageIntTime.docx")

##  ............................................................................
##  age vs internet use                                                     ####

ageIntUse <- proc_freq(atp_wave5,
                        "age_categories", 
                        "internet_use", 
                        include.table_percent = FALSE) %>% 
    labels() %>% 
    labelizor(labels = c("age_categories" = "Age Range",
                         "internet_use" = "Which of these best describes your Internet use:")) %>% 
    add_header_lines("Pew American Trends Panel Wave 5") %>% 
    center_header()

#### save file ####
ageIntUse %>% 
    save_as_docx(path = "./results/prop_tables/250126_atpw5_ageIntUse.docx")

##  ............................................................................
##  age vs internet privacy                                                 ####

ageIntPrivacy <- proc_freq(atp_wave5,
                       "age_categories", 
                       "internet_privacy", 
                       include.table_percent = FALSE) %>% 
    labels() %>% 
    labelizor(labels = c("age_categories" = "Age Range",
                         "internet_privacy" = "How much do you worry that computers and technology are being used to invade your privacy?")) %>% 
    add_header_lines("Pew American Trends Panel Wave 5") %>% 
    center_header()

#### save file ####
ageIntPrivacy %>% 
    save_as_docx(path = "./results/prop_tables/250126_atpw5_ageIntPrivacy.docx")


#   ____________________________________________________________________________
#   age vs behavior                                                         ####


##  ............................................................................
##  age vs video games                                                      ####

ageVideoGame <- proc_freq(atp_wave5,
                           "age_categories", 
                           "video_game", 
                           include.table_percent = FALSE) %>% 
    labels() %>% 
    labelizor(labels = c("age_categories" = "Age Range",
                         "video_game" = "Yesterday, did you play a video game?")) %>% 
    add_header_lines("Pew American Trends Panel Wave 5") %>% 
    center_header()

#### save file ####
ageVideoGame %>% 
    save_as_docx(path = "./results/prop_tables/250126_atpw5_ageVideoGame.docx")

##  ............................................................................
##  age vs talk to someone                                                  ####

ageTalk <- proc_freq(atp_wave5,
                     "age_categories", 
                     "talk_someone", 
                     include.table_percent = FALSE) %>% 
    labels() %>% 
    labelizor(labels = c("age_categories" = "Age Range",
                         "talk_someone" = "Yesterday, did you call a friend/relative just to talk?")) %>% 
    add_header_lines("Pew American Trends Panel Wave 5") %>% 
    center_header()

#### save file ####
ageTalk %>% 
    save_as_docx(path = "./results/prop_tables/250126_atpw5_ageTalk.docx")

##  ............................................................................
##  age vs text                                                             ####

ageText <- proc_freq(atp_wave5,
                     "age_categories", 
                     "text_someone", 
                     include.table_percent = FALSE) %>% 
    labels() %>% 
    labelizor(labels = c("age_categories" = "Age Range",
                         "text_someone" = "Yesterday, did you email/text a friend/relative just to talk?")) %>% 
    add_header_lines("Pew American Trends Panel Wave 5") %>% 
    center_header()

#### save file ####
ageText %>% 
    save_as_docx(path = "./results/prop_tables/250126_atpw5_ageText.docx")

##  ............................................................................
##  age vs visit                                                            ####

ageVisit <- proc_freq(atp_wave5,
                     "age_categories", 
                     "visit_someone", 
                     include.table_percent = FALSE) %>% 
    labels() %>% 
    labelizor(labels = c("age_categories" = "Age Range",
                         "visit_someone" = "Yesterday, did you visit with a friend/relative?")) %>% 
    add_header_lines("Pew American Trends Panel Wave 5") %>% 
    center_header()

#### save file ####
ageVisit %>% 
    save_as_docx(path = "./results/prop_tables/250126_atpw5_ageVisit.docx")

##  ............................................................................
##  age vs write                                                            ####

ageWrite <- proc_freq(atp_wave5,
                      "age_categories", 
                      "write_letter", 
                      include.table_percent = FALSE) %>% 
    labels() %>% 
    labelizor(labels = c("age_categories" = "Age Range",
                         "write_letter" = "Yesterday, did you write/receive a personal letter")) %>% 
    add_header_lines("Pew American Trends Panel Wave 5") %>% 
    center_header()

#### save file ####
ageWrite %>% 
    save_as_docx(path = "./results/prop_tables/250126_atpw5_ageWrite.docx")

##  ............................................................................
##  age vs social media                                                     ####

ageSMuse <- proc_freq(atp_wave5,
                      "age_categories", 
                      "social_media", 
                      include.table_percent = FALSE) %>% 
    labels() %>% 
    labelizor(labels = c("age_categories" = "Age Range",
                         "social_media" = "Yesterday, did you use social media?")) %>% 
    add_header_lines("Pew American Trends Panel Wave 5") %>% 
    center_header()

#### save file ####
ageSMuse %>% 
    save_as_docx(path = "./results/prop_tables/250126_atpw5_ageSMuse.docx")

##  ............................................................................
##  age vs daily newspaper                                                  ####

ageReadPaper <- proc_freq(atp_wave5,
                      "age_categories", 
                      "read_paper", 
                      include.table_percent = FALSE) %>% 
    labels() %>% 
    labelizor(labels = c("age_categories" = "Age Range",
                         "read_paper" = "Yesterday, did you get a chance to read a daily newspaper?")) %>% 
    add_header_lines("Pew American Trends Panel Wave 5") %>% 
    center_header()

#### save file ####
ageReadPaper %>% 
    save_as_docx(path = "./results/prop_tables/250126_atpw5_ageReadPaper.docx")

##  ............................................................................
##  age vs watched the news                                                 ####

ageWatchNews <- proc_freq(atp_wave5,
                          "age_categories", 
                          "watch_news", 
                          include.table_percent = FALSE) %>% 
    labels() %>% 
    labelizor(labels = c("age_categories" = "Age Range",
                         "watch_news" = "Yesterday, did you watch the news or a news program on TV?")) %>% 
    add_header_lines("Pew American Trends Panel Wave 5") %>% 
    center_header()

#### save file ####
ageWatchNews %>% 
    save_as_docx(path = "./results/prop_tables/250126_atpw5_ageWatchNews.docx")

##  ............................................................................
##  age vs listened to the radio                                            ####

ageListenRadio <- proc_freq(atp_wave5,
                          "age_categories", 
                          "listen_radio", 
                          include.table_percent = FALSE) %>% 
    labels() %>% 
    labelizor(labels = c("age_categories" = "Age Range",
                         "listen_radio" = "Yesterday, listen to any news on the radio?")) %>% 
    add_header_lines("Pew American Trends Panel Wave 5") %>% 
    center_header()

#### save file ####
ageListenRadio %>% 
    save_as_docx(path = "./results/prop_tables/250126_atpw5_ageListenRadio.docx")

#   ____________________________________________________________________________
#   age vs community organizing                                             ####




































