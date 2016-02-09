# Load the headers from the data file
#OriginalColName <- read.csv("Addressing the -1 for DataKind - KENYA SURVEY - KMM UPDATES 22 JAN-1.csv",
#                            header=FALSE, skip=1, nrows=1)
# Load the mapping table of new to old column names and make into a vector
ColumnNameData <- read.csv("NewColumnNameMapping.csv")
ColumnNameMap <- ColumnNameData$NewColName
names(ColumnNameMap) <- ColumnNameData$OldColName
#Make proposed names syntactically valid for R
ColumnNameMap <- make.names(ColumnNameMap, unique=TRUE)
#Load in data using new column names
Kenya <- read.csv("Addressing the -1 for DataKind - KENYA SURVEY - KMM UPDATES 22 JAN cleaned data - Sheet1.csv",
                 header = FALSE, stringsAsFactors = FALSE, skip = 2, col.names = ColumnNameMap)
#NewNames1314 <- Headings$Proposed.New.Name
#names(NewNames1314) <- Headings$R.Version.1314
#HSCIC1314 <- rename(HSCIC1314, NewNames1314)
                            
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
                            
library(stringr)
#Extract only numeric digits of three fields and convert them to integers or numbers
Kenya$Q38.CashCropEarnings <- as.integer(gsub("[^0-9]", "", Kenya$Q38.CashCropEarnings))
#Kenya$Q39.CashCropPx <- as.numeric(gsub("[^0-9.]", "", Kenya$Q39.CashCropPx))
Kenya$Q39.CashCropPx <- as.numeric(str_extract(Kenya$Q39.CashCropPx, "\\d{1,}\\.?(\\d{1,})?"))
Kenya$Q40.CostOfProduction <- as.integer(gsub("[^0-9]", "", Kenya$Q40.CostOfProduction))
Kenya$Q61.CropEarning <- as.integer(gsub("[^0-9]", "", Kenya$Q61.CropEarning))
Kenya$Q63.ProductionCost <- as.integer(gsub("[^0-9]", "", Kenya$Q63.ProductionCost))

