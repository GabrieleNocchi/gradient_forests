for FILE in *.vcf.gz
do

# MAF 0.05 filter to analyse structure

/data/programs/vcftools_0.1.13/bin/vcftools --gzvcf $FILE --max-missing 1 --maf 0.05 --minQ 30 --minGQ 20 --minDP 5 --max-alleles 2 --recode --recode-INFO-all

# Need to set SNPs IDs
/data/programs/bcftools-1.9/bcftools annotate --set-id +'%CHROM\_%POS\_%REF\_%FIRST_ALT' out.recode.vcf --threads 4 -Ov -o ID.vcf


### REMOVED LD PRUNING TO BE CONSISTENT WITH POOL SEQ
# LD pruning as highly linked SNPs can bias the structure analysis
# /data/programs/plink --vcf ID.vcf --allow-extra-chr --indep-pairphase 50 5 0.4 --double-id --out ./pruned

# make a VCF only with unlinked SNPs (LD r2 max 0.4)
# /data/programs/plink --vcf ID.vcf --allow-extra-chr --extract pruned.prune.in --double-id --recode vcf --out $FILE\_pruned

perl header.pl ID.vcf > header.txt
perl random_draws.pl ID.vcf > body.txt
wc -l body.txt > count.txt

# Often not enough to take 10,000 SNPs from capute dataset. CHECK COUNT.TXT before running GF for the capture datasets

#shuf -n 10000 body.txt > draws.txt

cat header.txt body.txt > 10k_SNPs.vcf


/data/programs/vcftools_0.1.13/bin/vcf-sort 10k_SNPs.vcf > sorted_10k_SNP.vcf

/data/programs/vcftools_0.1.13/bin/vcftools --vcf sorted_10k_SNP.vcf --012 --out snp


cut -f2- snp.012 | sed 's/-1/NA/g' >snp.temp
sed 's/\t/_/' snp.012.pos | tr '\n' '\t' | sed 's/[[:space:]]*$//' >header
paste <(echo "ID" | cat - snp.012.indv) <(echo "" | cat header - snp.temp) > $FILE\_10k_unlinked_snp.forR
rm header snp.temp



rm *log
rm *.vcf
rm header.txt
rm body.txt
rm draws.txt
rm snp*
done
