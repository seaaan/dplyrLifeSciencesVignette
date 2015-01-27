library(dplyr)
# create columns
Sample <- data.frame(Sample = paste("Sample", c("A", "B", "C", "D")))
Treatment <- data.frame(Treatment = c("Drug X", "Drug Y"))
Concentration <- data.frame(Concentration = c(0, 1, 10, 100, 1000))
Replicate <- data.frame(Replicate = c(1, 2))

# create data frame with treatment conditions
expt <- merge(Sample, Treatment)
expt <- merge(expt, Concentration)
expt <- merge(expt, Replicate)

# clean up
rm(Sample, Treatment, Concentration, Replicate)

# arrange rows nicely
expt <- arrange(expt, Sample, Treatment, Concentration, Replicate)

# simulate data: want highest values in the untreated conditions, and then 
# decreasing values with each concentration of treatment
# (Concentration + 1) to avoid divide by zero
expt <- mutate(expt, 
   Data = sample(1:100, 80) * 1 / (Concentration + 1) )

# write the data to the current wd
write.csv(expt, "expt.csv", row.names = FALSE)
