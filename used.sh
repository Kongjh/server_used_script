# 代码开头
#!/bin/bash

# 综合
du -h --max-depth=1 gittest/
cat flag.csv | sort | uniq -c | sort -k1 -nr > sort_flag.csv # 先 sort 一下在 去重统计数目，在从大到小排序
awk -F "\t" '{print $6}' OFS="\t" gal1_1_mrna.csv > flag.csv
grep -A17 "^>" orf_genomic_1000.fasta > temp1_A17.fasta
sed '/^--/'d temp1_A17.fasta > sed_temp1_A17.fasta
awk '!(NR%18)' sed_temp1_A17.fasta > awk17_sed.fasta
cat awk17_sed.fasta | cut -c 28-48 > cut_awk.csv
awk -F ":" '{print $1}' gene_infor.fasta > gene_list.csv
awk -F "," '{print $1}'  rest_of_gene_list.csv > SGDID_list.csv
paste -d ';' gene_list.csv cut_awk.csv SGDID_list.csv > vertified_ORF.csv

# 解压文件
gzip -cd xx.gz > xx.dd
#gzip -cd OE-1-ribo_L1_A012.R1.clean.fastq.gz > OE-1-ribo_L1_A012.R1.clean.fastq
bzip2 -kd exp1.bz2 # 保留了源文件 
tar -xzvf file.tar.gz # 解压tar.gz 
tar -xvf file.tar
gzip -d OE-3-ribo_L1_A024.R1.clean.fastq.gz &
unzip 8-2017.10.12.zip

# git
git add
git diff
git rm hhh license
git commit -m "delet"
git status
git log --pretty=oneline > log

git remote add origin https://github.com/Kongjh/gittest.git
git push -u origin master
git clone git://github.com/Kongjh/othertest.git

# others -1
tar -xvf Matlab\ 2016b\ Linux64\ Crack.rar # error!!!!!!! 出现乱码文件 tar解压 tar 不是 rar
ls -i
find -inum 275387 -delete
find -inum 275387 -exec mv {} hhh.txt \;
th-p hhh.txt/


head -2 $temp1 $first
wc -l $temp1 $first
nohup prefetch xxxxx &
nohup fastq-dump --split-3 /Dell/Dell4/kongjh/ncbi/public/sra/SRR014375.sra &
cat SRR014385.fastq > mRNA_1.fastq &
cat SRR0143* > fp_2.fastq &
paste -d "\t" Ho-1-28.csv Ho-1-28-length.csv > Ho-1-28-final.csv

# others -2
ps -aux | grep 'kongjh'

# 循环
for i in `seq 0 2`
do
    cat $second | grep -w "^${barcode_5[i]}" | grep -w "${barcode_3[i]}$" > ${third}${i}
    cat ${third}${i} | cut -c 8-28 > ${real_upf1}${i}.csv
    cat ${real_upf1}${i}.csv | sort | uniq -c | sort -k1 -nr > ${number_upf1}${i}.csv
done

# install myself python package path
python2.7 setup.py install --root=/home/kongjh/usr/
pip install --user pyBigWig RSeQC

###########
# awk e.g.
awk '!(NR%2)' dna.fastq > dna_seq.fastq
awk 'NR%2==0' dna.fastq | awk 'NR%2==1' > dna_seq.fastq
#$1 指第一个参数 需要使用完整路劲
awk 'NR%2==0' filename #删除奇数行
awk 'NR%2==1' filename #删除偶数行
awk -F "\t" '{print $1,$10,$3,$NF,$4,$2,$6}' OFS="\t" ${ftitle}all-0-16-mapped-${name}.sam > ${ftitle}${name}.csv

# grep e.g.
grep -v '^[@+]' $1 > $temp1

# sed e.g.
#del 偶数行
sed '1~2!d' $temp1 > $first
sed '1~2d' file #删除奇数行
sed '1~2!d' file #删除偶数行

##########
# samtools e.g.
samtools sort all-0-16-mapped-ssu.bam -o sort-all-0-16-mapped-ssu.bam
samtools index sort-all-0-16-mapped-ssu.bam

# for get wig file
#chmod 775 wigToBigWig
bash fetchChromSizes sacCer3 > sacCer3.chrom.sizes
python ~/.local/bin/bam2wig.py -s sacCer3.chrom.sizes -i sort-all-0-16-mapped-ssu.bam -o all-0-16-mapped-ssu.bw -u

# htseq e.g.
# htseq-count 5'utr 把 gff3中的 chr 替换成空了
time htseq-count --type=five_prime_UTR --additional-attr=ID -i ID mapped-Ho-1-28.sam  /Dell/Dell4/kongjh/gene-reference/nochrYassour_2009_UTR_boundaries_V64.gff3 -o add-utr-mapped-H0-1-28.sam > report-utr-count-H0-1-28.txt












