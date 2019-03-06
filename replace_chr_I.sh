#!/bin/bash

str=("chrI" "chrII" "chrIII" "chrIV" "chrV" "chrVI" "chrVII" "chrVIII" "chrIX" "chrX" "chrXI" "chrXII" "chrXIII" "chrXIV" "chrXV" "chrXVI")
num=("chr1" "chr2" "chr3" "chr4" "chr5" "chr6" "chr7" "chr8" "chr9" "chr10" "chr11" "chr12" "chr13" "chr14" "chr15" "chr16")

for i in `seq 0 15`
do
#   echo ${str[i]} ${num[i]}
#	echo ${str[$i]} ${num[$i]}
## < lock the word, \ for 转义
#    sed -i 's/\<'${str[$i]}'\>/'${num[$i]}'/g' /Dell/Dell4/kongjh/kozak_40s_ver2/numaddchrSaccharomyces_cerevisiae.R64-1-1.94.gtf
    sed -i 's/\<'${str[$i]}'\>/'${num[$i]}'/g' /Dell/Dell4/kongjh/kozak_40s_ver2/numaddchr-all-0-16-mapped-ssu.bw.wig
	sed -i 's/\<'${str[$i]}'\>/'${num[$i]}'/g' /Dell/Dell4/kongjh/kozak_40s_ver2/numaddchrsacCer3.chrom.sizes
#   sed 's/${str[i]}/${num[i]}/' /Dell/Dell4/kongjh/kozak_40s_ver2/num${i}addchrSaccharomyces_cerevisiae.R64-1-1.94.gtf > num${i+1}addchrSaccharomyces_cerevisiae.R64-1-1.94.gtf
done
echo -e "\a"

#    fin="num${i}addchrSaccharomyces_cerevisiae.R64-1-1.94.gtf"
#    ii=$[${i}+1]
#    fout="num${ii}addchrSaccharomyces_cerevisiae.R64-1-1.94.gtf"
#    sed 's/`echo ${str[i]}`/`echo ${num[i]}`/' /Dell/Dell4/kongjh/kozak_40s_ver2/${fin} > /Dell/Dell4/kongjh/kozak_40s_ver2/${fout}

