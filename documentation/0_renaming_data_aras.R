    # Library 
    library(dplyr)
    
    # Load data frames 
    houseA <- read.csv('./data/rdata/houseA.csv')
    houseB <- read.csv('./data/rdata/houseB.csv')

    dim(houseA); dim(houseB)
    head(houseA); head(houseB)
    str(houseA); str(houseB)

    # Renaming the activities into the columns P1 and P2 of HouseA
    houseA <- mutate(houseA,P1=as.factor(X21))
    houseA <- mutate(houseA,P2=as.factor(X22))
    houseA.actnames <- c(
    "1"	= "Other",
    "2" = "	Going_Out",
    "3" =	"Preparing_Breakfast",
    "4" =	"Having_Breakfast",
    "5" =	"Preparing_Lunch",
    "6" =	"Having_Lunch",
    "7" =	"Preparing_Dinner",
    "8" =	"Having_Dinner",
    "9" =	"Washing_Dishes",
    "10" =	"Having_Snack",
    "11" =	"Sleeping",
    "12" =	"Watching_TV",
    "13" =	"Studying",
    "14" =	"Having_Shower",
    "15" =	"Toileting",
    "16" =	"Napping",
    "17" =	"Using_Internet",
    "18" =	"Reading_Book",
    "19" =	"Laundry",
    "20" =	"Shaving",
    "21" =	"Brushing_Teeth",
    "22" =	"Talking_on_the_Phone",
    "23" =	"Listening_to_Music",
    "24" =	"Cleaning",
    "25" =	"Having_Conversation",
    "26" =	"Having_Guest",
    "27" =	"Changing_Clothes")

    houseA$P1 <- revalue(houseA$P1, houseA.actnames)
    houseA$P2 <- revalue(houseA$P2, houseA.actnames)

    # Renaming the columns names 
    names(houseA) <- c(
    'Ph1',
    'Ph2',
    'Ir1',
    'Fo1',
    'Fo2',
    'Di3',
    'Di4',
    'Ph3',
    'Ph4',
    'Ph5',
    'Ph6',
    'Co1',
    'Co2',
    'Co3',
    'So1',
    'So2',
    'Di1',
    'Di2',
    'Te1',
    'Fo3',
    'X21',
    'X22',
    'P1',
    'P2')

    # Renaming the activities into the columns P1 and P2 of HouseB
    houseB <- mutate(houseB,P1=as.factor(X21))
    houseB <- mutate(houseB,P2=as.factor(X22))
    houseB.actnames <- c(
    "1" =	"Other",
    "2" =	"Going Out",
    "3" =	"Preparing Breakfast",
    "4" =	"Having Breakfast",
    "5" =	"Preparing Lunch",
    "6" =	"Having Lunch",
    "7" =	"Preparing Dinner",
    "8" =	"Having Dinner",
    "9" =	"Washing Dishes",
    "10" =	"Having Snack",
    "11" =	"Sleeping",
    "12" =	"Watching TV",
    "13" =	"Studying",
    "14" =	"Having Shower",
    "15" =	"Toileting",
    "16" =	"Napping",
    "17" =	"Using Internet",
    "18" =	"Reading Book",
    "19" =	"Laundry",
    "20" =	"Shaving",
    "21" =	"Brushing Teeth",
    "22" =	"Talking on the Phone",
    "23" =	"Listening to Music",
    "24" =	"Cleaning",
    "25" =	"Having Conversation",
    "26" =	"Having Guest",
    "27" =	"Changing Clothes")

    houseB$P1 <- revalue(houseB$P1, houseB.actnames)
    houseB$P2 <- revalue(houseB$P2, houseB.actnames)

    #
    names(houseB) <- c(
    'co1',
    'co2',
    'co3',
    'co4',
    'co5',
    'co6',
    'di2',
    'fo1',
    'fo2',
    'fo3',
    'ph1',
    'ph2',
    'pr1',
    'pr2',
    'pr3',
    'pr4',
    'pr5',
    'so1',
    'so2',
    'so3',
    'X21',
    'X22',
    'P1',
    'P2')

    # Save data frames
    write.csv(houseA, file='./data/rdata/houseA_.csv', row.names=TRUE)
    write.csv(houseB, file='./data/rdata/houseB_.csv', row.names=TRUE)
    