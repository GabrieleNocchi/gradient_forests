LS <- readRDS("pop_allele_frqs.rds")
LS.df = as.data.frame(do.call(rbind, LS))

library(reshape2)

df <- LS.df[,-3]

df_reshaped <- dcast(df, pop ~ chr + bp, value.var = "alt_freq")

# Rename the first column to "ID"
colnames(df_reshaped)[1] <- "ID"

# select columns(SNP) with max 10% NA
df_reshaped <- df_reshaped[, colMeans(is.na(df_reshaped)) <= 0.1]



# Get the column names of the data frame (excluding the first column)
cols <- colnames(df_reshaped)[-1]

# Sample 10000 column names without replacement
sampled_cols <- sample(cols, 10000, replace = FALSE)

# Subset the data frame with the sampled columns
sampled_df <- df_reshaped[, c("ID", sampled_cols)]




# Impute the NA and give them the Median freq
library(zoo)
library(dplyr)
new <- sampled_df %>% select(-1) %>% na.aggregate(FUN = median, na.rm = FALSE)
ID <- sampled_df[,1]
new <- data.frame(ID, new, stringsAsFactors = FALSE)



write.table(new, file ="snp.forR", row.names = F, quote = F, sep ="\t")

