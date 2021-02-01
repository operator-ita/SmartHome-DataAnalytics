# LDR

    # Libraries 
    library(ggplot2)
    library(dplyr)
    
    # Load data 
    getwd()
    ldr <- read.csv('./data/rdata/ldrF.csv')

    # Check data 
    str(ldr); 
    head(ldr, n=15)
    summary(ldr)
    
    # Scatter Plot
    ldr %>% ggplot() + aes(x = Luxes, y  = R, colour=Exp) + geom_point() +  ggtitle('Light dependancy') + ylab('Resistence [KOhms]') + xlab('Luxes') + theme_light() 
    ggsave("ldr_scatter_1.png")
    # facet_wrap('Exp')


    # ZScore 
    zscore <- function(vec) { 
        temp <- (vec-mean(vec)) / sd(vec)
        return(temp)
    }

    # Cleaning data using Zscore
    summary(ldr) # Min distance of 10cm to max distance 95cm by 5cm increment
    
    zd <- seq(10,95,5)
    zlux <- c()
    zdis <- c()
    for (distancia in zd) {  
        temp <- ldr [ ldr$d == distancia , ]
        temp <- temp$Luxes
        z <- zscore(temp)
        zlux <- append(zlux, z)
        zdis <- append(zdis, distancia) 
    }


    b <- reshape(zlux, length(zd)) 
    
    a <- matrix(zlux, nrow = length(zd), ncol = 6)
    dim(a)
    a[ ,2 ]
    
    Reshape(a, 1, length(zd))
