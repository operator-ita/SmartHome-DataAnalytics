# Houses

    # Load data frames 
    houseA <- read.csv('./data/rdata/houseA.csv')
    houseB <- read.csv('./data/rdata/houseB.csv')
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


    letters <- c(1,5)
    replace(letters, c(1, 5, 9, 15, 21),  c("A", "E", "I", "O", "U"))

# Pie Charts
    # Loading and cleaning the frequency tables
    freq_table_HA_R1 <- read.csv('./data/rdata/Freq_houseA_P1.csv')
    freq_table_HA_R1[1,2] <- "Going_Out"
    freq_table_HA_R1[2,2] <- "Missing_Activity"
    names(freq_table_HA_R1)[2] <- "Activity"
    
    freq_table_HA_R2 <- read.csv('./data/rdata/Freq_houseA_P2.csv')
    freq_table_HA_R2[1,2] <- "Going_Out"
    freq_table_HA_R2[2,2] <- "Missing_Activity"
    names(freq_table_HA_R2)[2] <- "Activity"
    
    freq_table_HB_R1 <- read.csv('./data/rdata/Freq_houseB_P1.csv')
    freq_table_HB_R1[1,2] <- "Missing Activity"
    names(freq_table_HB_R1)[2] <- "Activity"
    
    freq_table_HB_R2 <- read.csv('./data/rdata/Freq_houseB_P2.csv')
    freq_table_HB_R2[1,2] <- "Missing Activity"
    names(freq_table_HB_R2)[2] <- "Activity"
    
    # Creation of charts
        library(ggplot2)
        
        # Sorting Frequencies
        freq_table_HA_R1[order(freq_table_HA_R1$Freq, decreasing = TRUE),]    
        freq_table_HA_R2[order(freq_table_HA_R2$Freq, decreasing = TRUE),]
        freq_table_HB_R1[order(freq_table_HB_R1$Freq, decreasing = TRUE),]
        freq_table_HB_R2[order(freq_table_HB_R2$Freq, decreasing = TRUE),]
        
        # Creation of bar charts
        library(scales)
        
        bar_HA_R1 <- ggplot(data = freq_table_HA_R1, aes(x = reorder(Activity, Freq), y = Freq)) +
            geom_col(aes(fill = Activity) , show.legend = FALSE) +
            ggtitle(paste("Time spent on each activity by resident 1 in house A")) +
            coord_flip() +
            geom_label(aes(label = percent(Freq/sum(Freq), accuracy =  0.001),
                           y = -150, fill = Activity),
                       show.legend = FALSE,
                       size = 3.5, label.padding = unit(0.1, "lines")) +
            expand_limits(y = -150)+
            labs(x = "Activity", y = "Seconds")
        
        bar_HA_R2 <- ggplot(data = freq_table_HA_R2, aes(x = reorder(Activity, Freq), y = Freq)) +
            geom_col(aes(fill = Activity) , show.legend = FALSE) +
            ggtitle(paste("Time spent on each activity by resident 2 in house A")) +
            coord_flip() +
            geom_label(aes(label = percent(Freq/sum(Freq), accuracy =  0.001),
                           y = -150, fill = Activity),
                       show.legend = FALSE,
                       size = 3.5, label.padding = unit(0.1, "lines")) +
            expand_limits(y = -150)+
            labs(x = "Activity", y = "Seconds")
        
        bar_HB_R1 <- ggplot(data = freq_table_HB_R1, aes(x = reorder(Activity, Freq), y = Freq)) +
            geom_col(aes(fill = Activity) , show.legend = FALSE) +
            ggtitle(paste("Time spent on each activity by resident 1 in house B")) +
            coord_flip() +
            geom_label(aes(label = percent(Freq/sum(Freq), accuracy =  0.001),
                           y = -150, fill = Activity),
                       show.legend = FALSE,
                       size = 3.5, label.padding = unit(0.1, "lines")) +
            expand_limits(y = -150)+
            labs(x = "Activity", y = "Seconds")
        
        bar_HB_R2 <- ggplot(data = freq_table_HB_R2, aes(x = reorder(Activity, Freq), y = Freq)) +
            geom_col(aes(fill = Activity) , show.legend = FALSE) +
            ggtitle(paste("Time spent on each activity by resident 2 in house B")) +
            coord_flip() +
            geom_label(aes(label = percent(Freq/sum(Freq), accuracy =  0.001),
                           y = -150, fill = Activity),
                       show.legend = FALSE,
                       size = 3.5, label.padding = unit(0.1, "lines")) +
            expand_limits(y = -150)+
            labs(x = "Activity", y = "Seconds")
        