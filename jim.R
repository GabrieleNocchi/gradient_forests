LS <- readRDS("pop_allele_frqs.rds")
LS.df = as.data.frame(do.call(rbind, LS))

library(reshape2)

df <- LS.df[,-3]

df_reshaped <- dcast(df, pop ~ chr + bp, value.var = "alt_freq")

# Rename the first column to "ID"
colnames(df_reshaped)[1] <- "ID"



# Get the column names of the data frame (excluding the first column)
cols <- colnames(df_reshaped)[-1]

# Sample 10000 column names without replacement
sampled_cols <- sample(cols, 10000, replace = FALSE)

# Subset the data frame with the sampled columns
sampled_df <- df_reshaped[, c("ID", sampled_cols)]

write.table(sampled_df, file ="snp.forR", row.names = F, quote =F, sep ="\t")