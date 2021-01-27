# Houses

    # Set the working directory 
    setwd(paste(getwd(),"data/rdata", sep='/'))

    # Load data frames 
    houseA <- read.csv('houseA.csv')
    houseB <- read.csv('houseB.csv')
    #colnames(houseA) <- c(1:22) ; colnames(houseA) <- c(1:22)
    dim(houseA); dim(houseB)
    head(houseA); head(houseB)


    
    # Describing data ... 
    # TODO 
    length(house.a)
    house.a    
    str(mtcars)
    summary(mtcars)
    head(mtcars, n=10L)
    View(mtcars)
