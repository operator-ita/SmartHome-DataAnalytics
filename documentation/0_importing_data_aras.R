# Import libraries 
    suppressMessages(suppressWarnings(library(dplyr)))
    library(data.table)

# HOUSE A 

    ## Set working directory
    dir_houseA = paste(getwd(),"data/Aras/HouseA", sep='/')
    setwd(dir_houseA)

    ## Importamos los datos a R
    houseA.lista <- lapply(list.files(path=dir_houseA, pattern='^DAY'), read.csv, sep=' ') 
    length(houseA.lista)
    dim(houseA.lista[[1]])
    head(houseA.lista[[1]]); head(houseA.lista[[30]]);

    
    ## Joint list and create a data frame
    houseA <- rbindlist(lapply(houseA.lista, rbind, use.names=FALSE))
    houseA <- as.data.frame(houseA)
    colnames(houseA) <- c(1:22)
    
    dim(houseA)
    houseA[1, ]

    # Save dataframe 
    write.csv(houseA, file='houseA.csv', row.names=FALSE)
    
# HOUSE B 

    ## Set working directory
    dir_houseB = paste(getwd(),"data/Aras/HouseB", sep='/')
    setwd(dir_houseB)

    ## Importamos los datos a R
    houseB.lista <- lapply(list.files(path=dir_houseB, pattern='^DAY'), read.csv, sep=' ') 
    length(houseB.lista)
    dim(houseB.lista[[1]])
    head(houseB.lista[[1]]); head(houseB.lista[[30]]);

    
    ## Joint list and create a data frame
    houseB <- rbindlist(lapply(houseB.lista, rbind, use.names=FALSE))
    houseB <- as.data.frame(houseB)
    colnames(houseB) <- c(1:22)
    
    dim(houseB)
    houseB[1, ]

    # Save dataframe 
    write.csv(houseB, file='houseB.csv', row.names=FALSE)

