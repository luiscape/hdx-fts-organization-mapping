

library(ggplot2)

# Loading manually edited dataset
data <- read.csv('data/correct_codes.csv')

# Calculating the rate of success. 
rate <- (nrow(data[!is.na(data$fts_id),]) / nrow(data)) * 100; rate

# Separating only the odd ones
odd <-data[is.na(data$fts_id),]

ggplot(odd) + theme_bw() +
  geom_bar(aes(hunch, fill = hunch), stat = 'bin')