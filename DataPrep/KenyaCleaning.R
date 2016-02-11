#Note: first set working directory to the cloned Github repo

# Load the mapping table of new to old column names and make into a vector
ColumnNameData <- read.csv("NewColumnNameMapping.csv")
ColumnNameMap <- ColumnNameData$NewColName
names(ColumnNameMap) <- ColumnNameData$OldColName
#Make proposed names syntactically valid for R
ColumnNameMap <- make.names(ColumnNameMap, unique=TRUE)
#Load in data using new column names
Kenya <- read.csv("Addressing the -1 for DataKind - KENYA SURVEY - KMM UPDATES 22 JAN cleaned data - Sheet1.csv",
                 header = FALSE, stringsAsFactors = FALSE, skip = 2, col.names = ColumnNameMap)
#Remove column name dataframe
rm(ColumnNameData)
rm(ColumnNameMap)
                            
#Define function to make values into proper case
properCase <- function(x) {
  lower <- tolower(x)
  s <- strsplit(lower, " ")[[1]]
  paste(toupper(substring(s, 1,1)), substring(s, 2),
        sep="", collapse=" ")
}
                            
#Convert contents of three fields to proper case
Kenya$Q3.CoopSociety <- sapply(Kenya$Q3.CoopSociety, properCase)
Kenya$Q4.Village <- sapply(Kenya$Q4.Village, properCase)
Kenya$Q7.ProducerOrg <- sapply(Kenya$Q7.ProducerOrg, properCase)
                
#For free text 'earnings' and 'cost' fields, extract only numeric digits
#and convert them to integers or numbers
library(stringr)
Kenya$Q38.CashCropEarnings <- as.integer(gsub("[^0-9]", "", Kenya$Q38.CashCropEarnings))
Kenya$Q39.CashCropPx <- as.numeric(str_extract(Kenya$Q39.CashCropPx, "\\d{1,}\\.?(\\d{1,})?"))
Kenya$Q40.CostOfProduction <- as.integer(gsub("[^0-9]", "", Kenya$Q40.CostOfProduction))
Kenya$Q61.CropEarning <- as.integer(gsub("[^0-9]", "", Kenya$Q61.CropEarning))
Kenya$Q63.ProductionCost <- as.integer(gsub("[^0-9]", "", Kenya$Q63.ProductionCost))
Kenya$Q69.AmountEarnedCattle <- as.integer(gsub("[^0-9]", "", Kenya$Q69.AmountEarnedCattle))
#Same here, but first replacing 'None' with 0. To-do: make this cleaner with regex!
Kenya$Q70.NumberCattleSold <- gsub("None", 0, Kenya$Q70.NumberCattleSold)
Kenya$Q70.NumberCattleSold <- gsub("none", 0, Kenya$Q70.NumberCattleSold)
Kenya$Q70.NumberCattleSold <- gsub("NONE", 0, Kenya$Q70.NumberCattleSold)
Kenya$Q70.NumberCattleSold <- as.integer(gsub("[^0-9]", "", Kenya$Q70.NumberCattleSold))
Kenya$Q71.PxPerCattle <- as.integer(gsub("[^0-9]", "", Kenya$Q71.PxPerCattle))
Kenya$Q72.TotalEarningCattle <- as.integer(gsub("[^0-9]", "", Kenya$Q72.TotalEarningCattle))
Kenya$Q81.AmountEarnedChickens <- as.integer(gsub("[^0-9]", "", Kenya$Q81.AmountEarnedChickens))
#Same here, but first replacing 'None' with 0. To-do: make this cleaner with regex!
Kenya$Q82.NumberChickensSold <- gsub("None", 0, Kenya$Q82.NumberChickensSold)
Kenya$Q82.NumberChickensSold <- gsub("none", 0, Kenya$Q82.NumberChickensSold)
Kenya$Q82.NumberChickensSold <- as.integer(gsub("[^0-9]", "", Kenya$Q82.NumberChickensSold))