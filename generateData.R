library(dplyr)
# create columns
Sample <- data.frame(Sample = c("A", "B", "C", "D"))
Treatment <- data.frame(Treatment = c("DrugX", "DrugY"))
Concentration <- data.frame(Concentration = c(1, 10, 100, 1000))
Replicate <- data.frame(Replicate = c(1, 2))

# create data frame with treatment conditions
rx <- merge(Sample, Treatment)
rx <- merge(rx, Concentration)
rx <- merge(rx, Replicate)

# create data frame with untreated conditions and bind to rx
Sample %>% 
   mutate(Treatment = c("None"), Concentration = c(0)) %>%
      merge(Replicate) %>%
         bind_rows(rx) -> expt

# clean up
rm(Sample, Treatment, Concentration, Replicate, rx)

# arrange rows nicely
expt <- arrange(expt, Sample, Treatment, Concentration, Replicate)

# simulate data: want highest values in the untreated conditions, and then 
# decreasing values with each concentration of treatment
# (Concentration + 1) to avoid divide by zero
expt <- mutate(expt, 
   Data = sample(1:100, 72) * 1 / (Concentration + 1) )

# write the data to the current wd
write.csv(expt, "expt.csv", row.names = FALSE)