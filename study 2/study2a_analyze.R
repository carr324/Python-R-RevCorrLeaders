require(rcicr)
require(dplyr)
require(tidyr)
require(stringr)

rawData <- read.csv("study2a_data_04202017.csv")

cleanData <- rawData %>%
  filter(DistributionChannel == "anonymous", dataUse == 3 | dataUse == 4) %>%
  select(EndDate, ResponseId, age, sex, dataUse, BFBM_1:WMWF_300) %>%
  gather(Trial, Choice, BFBM_1:WMWF_300) %>%
  separate(Trial, c("BaseImage", "TrialCode"), sep = "_") %>%
  arrange(ResponseId)

cleanData$ChoiceCode <- 999
cleanData$ChoiceCode[cleanData$Choice==1] <- -1
cleanData$ChoiceCode[cleanData$Choice==2] <- 1

cleanData <- filter(cleanData, ChoiceCode != 999) %>%
  arrange(BaseImage, ResponseId, TrialCode)

sbjSummary <- group_by(cleanData, ResponseId, EndDate, dataUse) %>%
  summarize(COUNT = n()) %>%
  arrange(EndDate, COUNT)

# Exclude sbj R_3EyUdCOyl7pSR8O (only 114/300 responses):
cleanData <- filter(cleanData, ResponseId != "R_3EyUdCOyl7pSR8O")

cleanData_bfbm <- filter(cleanData, BaseImage == "BFBM")
cleanData_bfwf <- filter(cleanData, BaseImage == "BFWF")
cleanData_wmbm <- filter(cleanData, BaseImage == "WMBM")
cleanData_wmwf <- filter(cleanData, BaseImage == "WMWF")

baseImg <- "base"

rData_bfbm <- "bfbm_seed_1_time_Apr_08_2017_16_20.Rdata"
rData_bfwf <- "bfwf_seed_1_time_Apr_08_2017_16_28.Rdata"
rData_wmbm <- "wmbm_seed_1_time_Apr_08_2017_16_36.Rdata"
rData_wmwf <- "wmwf_seed_1_time_Apr_08_2017_16_44.Rdata"

# Create overall selected CI across all subjects and responses:

ci_bfbm <- generateCI2IFC(cleanData_bfbm$TrialCode,
                          cleanData_bfbm$ChoiceCode,
                          baseImg,
                          rData_bfbm,
                          filename = "selected_bfbm.jpg",
                          targetpath = "./cis_selected")

ci_bfwf <- generateCI2IFC(cleanData_bfwf$TrialCode,
                          cleanData_bfwf$ChoiceCode,
                          baseImg,
                          rData_bfwf,
                          filename = "selected_bfwf.jpg",
                          targetpath = "./cis_selected")

ci_wmbm <- generateCI2IFC(cleanData_wmbm$TrialCode,
                          cleanData_wmbm$ChoiceCode,
                          baseImg,
                          rData_wmbm,
                          filename = "selected_wmbm.jpg",
                          targetpath = "./cis_selected")

ci_wmwf <- generateCI2IFC(cleanData_wmwf$TrialCode,
                          cleanData_wmwf$ChoiceCode,
                          baseImg,
                          rData_wmwf,
                          filename = "selected_wmwf.jpg",
                          targetpath = "./cis_selected")

# Generate overall anti CIs ...

antici_bfbm <- generateCI2IFC(cleanData_bfbm$TrialCode,
                              cleanData_bfbm$ChoiceCode,
                              baseImg,
                              rData_bfbm,
                              anti = TRUE,
                              filename = "unselected_bfbm.jpg",
                              targetpath = "./cis_unselected")

antici_bfwf <- generateCI2IFC(cleanData_bfwf$TrialCode,
                              cleanData_bfwf$ChoiceCode,
                              baseImg,
                              rData_bfwf,
                              anti = TRUE,
                              filename = "unselected_bfwf.jpg",
                              targetpath = "./cis_unselected")

antici_wmbm <- generateCI2IFC(cleanData_wmbm$TrialCode,
                              cleanData_wmbm$ChoiceCode,
                              baseImg,
                              rData_wmbm,
                              anti = TRUE,
                              filename = "unselected_wmbm.jpg",
                              targetpath = "./cis_unselected")

antici_wmwf <- generateCI2IFC(cleanData_wmwf$TrialCode,
                              cleanData_wmwf$ChoiceCode,
                              baseImg,
                              rData_wmwf,
                              anti = TRUE,
                              filename = "unselected_wmwf.jpg",
                              targetpath = "./cis_unselected")
