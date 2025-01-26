### file description ###########################################################
##                                                                            ##
## This file processes the bright line data sets sets                         ##
##                                                                            ##
##      Data included:                                                        ##
##        Civic Community                                                     ## 
##                                                                            ##
##      Output | Last Save:                                                   ##
##                                                                            ##
##                                                                            ##
## ########################################################################## ## 


#   ____________________________________________________________________________
#   load libraries and data                                                 ####

source("./code/analysis/analysis_prelims.r")

cc <- load(file = "./data/Civic Community/ICPSR_37023/ICPSR_37023-V1/ICPSR_37023/DS0003/37023-0003-Data.rda")
