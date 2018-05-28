require(rcicr)
require(dplyr)
require(tidyr)
require(stringr)

rawData <- read.csv("study1a_data_0322017.csv")

cleanData <- rawData %>%
  filter(Finished == 1, SubjectType == "real") %>%
  select(ResponseId, age, sex, t00001:t00300) %>%
  gather(Trial, Choice, t00001:t00300) %>%
  arrange(ResponseId, Trial)

cleanData <- separate(cleanData, Trial, c("TrialMarker", "TrialCode"), "t") %>% 
  select(-TrialMarker)

cleanData$TrialCode <- as.integer(cleanData$TrialCode)

cleanData$ChoiceCode <- 999
cleanData$ChoiceCode[cleanData$Choice==1] <- -1
cleanData$ChoiceCode[cleanData$Choice==2] <- 1

baseImg <- "base"
rData <- "rcic_seed_1_time_Feb_10_2017_14_49.Rdata"

# Create overall CI and anti-CI across all subjects and responses:

ci <- generateCI2IFC(cleanData$TrialCode,
                     cleanData$ChoiceCode,
                     baseImg,
                     rData,
                     targetpath = "./ci")

antici <- generateCI2IFC(cleanData$TrialCode,
                         cleanData$ChoiceCode,
                         baseImg,
                         rData,
                         targetpath = "./ci",
                         antiCI = TRUE)



