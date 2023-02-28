LS <- readRDS("pop_allele_frqs.rds")
LS.df = as.data.frame(do.call(rbind, LS))

library(reshape2)

df <- LS.df[,-3]

df_reshaped <- dcast(df, pop ~ chr + bp, value.var = "alt_freq")

# Rename the first column to "ID"
colnames(df_reshaped)[1] <- "ID"

df_reshaped <- df_reshaped[ , colSums(is.na(df_reshaped))==0]

# Get the column names of the data frame (excluding the first column)

write.table(df_reshaped, file ="snp.forR", row.names = F, quote =F, sep ="\t")
