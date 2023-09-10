# GradientForests
Scripts to prepare input for GF using WGS VCFs, pool-seq SNP tables, capture VCFs or population allelic frequencies files. It selects 10k random SNPs without missing data.


For pop freq files it first selects SNPs with max 10% missing data. Then it selects 10,000 random SNPs out of those. Finally, in the selected 10k SNPs missing frequencies are given the median frequency for that SNPs. This is to avoid selecting only SNP without missing data, which may be limiting in some cases.


GF.R: script to run GF in R once the input is ready.
