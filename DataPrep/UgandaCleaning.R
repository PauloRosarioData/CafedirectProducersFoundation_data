#Note: first set working directory to the cloned Github repo

# Load the mapping table of new to old column names and make into a vector
ColumnNameData <- read.csv("NewColumnNameMapping.csv")
ColumnNameMap <- ColumnNameData$NewColName
names(ColumnNameMap) <- ColumnNameData$OldColName
#Make proposed names syntactically valid for R
ColumnNameMap <- make.names(ColumnNameMap, unique=TRUE)
#Load in data using new column names
Uganda <- read.csv("-1 Uganda Coffee Farmers Survey KMM edits 8  Feb (1) - Sheet1.csv",
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
Uganda$Q3.CoopSociety <- sapply(Uganda$Q3.CoopSociety, properCase)
Uganda$Q4.Village <- sapply(Uganda$Q4.Village, properCase)
Uganda$Q7.ProducerOrg <- sapply(Uganda$Q7.ProducerOrg, properCase)

#For free text 'earnings' and 'cost' fields, extract only numeric digits
#and convert them to integers or numbers
library(stringr)
#To-do: modify this to use regular expressions, so that the word "million" or "m" converts to 000000
#Uganda$Q38.CashCropEarnings <- as.integer(gsub("[^0-9]", "", Uganda$Q38.CashCropEarnings))

#To-do: modify this regex to interpret the commas better
#Uganda$Q39.CashCropPx <- as.numeric(str_extract(Uganda$Q39.CashCropPx, "\\d{1,}\\.?(\\d{1,})?"))

#No processing on Q40 for Uganda given different units specified
#Uganda$Q40.CostOfProduction <- as.integer(gsub("[^0-9]", "", Uganda$Q40.CostOfProduction))

#To-do: modify this to use regular expressions, so that the word "million" or "m" converts to 000000
#Uganda$Q61.CropEarning <- as.integer(gsub("[^0-9]", "", Uganda$Q61.CropEarning))

#No processing on Q63 for Uganda given different units specified
#Uganda$Q63.ProductionCost <- as.integer(gsub("[^0-9]", "", Uganda$Q63.ProductionCost))

#To-do: modify this to use regular expressions, so that the word "million" or "m" converts to 000000
#Uganda$Q69.AmountEarnedCattle <- as.integer(gsub("[^0-9]", "", Uganda$Q69.AmountEarnedCattle))

#No adjustment to Q70 for Uganda since some fields contain volume of milk sold
#Same here, but first replacing 'None' with 0. To-do: make this cleaner with regex!
#Uganda$Q70.NumberCattleSold <- gsub("None", 0, Uganda$Q70.NumberCattleSold)
#Uganda$Q70.NumberCattleSold <- gsub("none", 0, Uganda$Q70.NumberCattleSold)
#Uganda$Q70.NumberCattleSold <- gsub("NONE", 0, Uganda$Q70.NumberCattleSold)
#Uganda$Q70.NumberCattleSold <- as.integer(gsub("[^0-9]", "", Uganda$Q70.NumberCattleSold))

#No adjustment to Q71 for Uganda since some fields contain price for milk sold
#Uganda$Q71.PxPerCattle <- as.integer(gsub("[^0-9]", "", Uganda$Q71.PxPerCattle))

#To-do: modify this to use regular expressions, so that the word "million" or "m" converts to 000000
#Uganda$Q72.TotalEarningCattle <- as.integer(gsub("[^0-9]", "", Uganda$Q72.TotalEarningCattle))

Uganda$Q73.AmountEarnedGoats <- as.integer(gsub("[^0-9]", "", Uganda$Q73.AmountEarnedGoats))

#Strip out ingtegers, but first replacing 'None' with 0. To-do: make this cleaner with regex!
Uganda$Q74.NumberGoatsSold <- gsub("None", 0, Uganda$Q74.NumberGoatsSold)
Uganda$Q74.NumberGoatsSold <- gsub("none", 0, Uganda$Q74.NumberGoatsSold)
Uganda$Q74.NumberGoatsSold <- gsub("NONE", 0, Uganda$Q74.NumberGoatsSold)
Uganda$Q74.NumberGoatsSold <- as.integer(gsub("[^0-9]", "", Uganda$Q74.NumberGoatsSold))

Uganda$Q75.PxPerGoat <- as.integer(gsub("[^0-9]", "", Uganda$Q75.PxPerGoat))
Uganda$Q76.TotalEarningGoats <- as.integer(gsub("[^0-9]", "", Uganda$Q76.TotalEarningGoats))
Uganda$Q77.AmountEarnedPigs <- as.integer(gsub("[^0-9]", "", Uganda$Q77.AmountEarnedPigs))
Uganda$Q80.TotalEarningPigs <- as.integer(gsub("[^0-9]", "", Uganda$Q80.TotalEarningPigs))

Uganda$Q81.AmountEarnedChickens <- as.integer(gsub("[^0-9]", "", Uganda$Q81.AmountEarnedChickens))

#Same here, but first replacing 'None' with 0. To-do: make this cleaner with regex!

Uganda$Q82.NumberChickensSold <- gsub("None", 0, Uganda$Q82.NumberChickensSold)
Uganda$Q82.NumberChickensSold <- gsub("none", 0, Uganda$Q82.NumberChickensSold)
Uganda$Q82.NumberChickensSold <- as.integer(gsub("[^0-9]", "", Uganda$Q82.NumberChickensSold))
Uganda$Q84.TotalEarningsChickens <- as.integer(gsub("[^0-9]", "", Uganda$Q84.TotalEarningsChickens))
Uganda$Q113.CostOfChange <- as.integer(gsub("[^0-9]", "", Uganda$Q113.CostOfChange))
Uganda$Q118.CostStarting <- as.integer(gsub("[^0-9]", "", Uganda$Q118.CostStarting))


#Write final file to csv format
write.csv(Uganda, "UgandaClean.csv")