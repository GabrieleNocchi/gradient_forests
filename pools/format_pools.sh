
awk 'BEGIN {print "ID"} { for (i=1; i<=NF; i++) if ($i ~ /FREQ/) print $i }' *.txt > ID

awk 'BEGIN { FS = "\t" }
NR == 1 {
    for (i = 1; i <= NF; i++) {
        if ($i ~ /FREQ/) {
            freq_cols[++num_freq_cols] = i
        }
    }
    next
}
{
    printf "%s_%s", $1, $2
    for (i = 1; i <= num_freq_cols; i++) {
        if ($(freq_cols[i]) == "") {
            $(freq_cols[i]) = "NA"
        } else if ($(freq_cols[i]) ~ /%/) {
            $(freq_cols[i]) = substr($(freq_cols[i]), 1, length($(freq_cols[i]))-1) / 100
        }
        printf "%s%s", OFS $(freq_cols[i]), (i == num_freq_cols ? ORS : FS)
    }
}' *.txt > reformatted.txt

grep -v NA reformatted.txt > r1
wc -l r1 > count.txt
shuf -n 10000 r1 > r2
rm r1
mv r2 reformatted.txt

Rscript create_GF_input.R 


rm ID
rm reformatted.txt
