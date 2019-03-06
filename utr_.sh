#!/bin/bash

f="/Dell/Dell4/kongjh/kozak_40s_ver2/"
t="/Dell/Dell4/kongjh/kozak_40s_ver2/temp/"
#name="ssu"
#name="rs"
name="utr"
#name="syors"
#name="syossu"
#name=${f1%_*}

#adapter="NBA{20}TGG"
adapter="AAAAAAAAAAAAAAAAAAAATGG"
#adapter="NBAAAAAAAAAAAAAAAAAAAA"

f1="/Dell/Dell4/kongjh/kozak_40s/wt_ssu_fraction.fastq"
#f1="/Dell/Dell4/kongjh/kozak_40s/wt_rs_fraction.fastq"
#f1="/Dell/Dell4/kongjh/kozak_40s/syo_ssu_fraction.fastq"
#f1="/Dell/Dell4/kongjh/kozak_40s/mrna_fraction.fastq"

cd ${f}
mkdir ${name}
ftitle=${f}${name}/
cd ${ftitle}

time cutadapt -a ${adapter} --discard-untrimmed -m 10 -o ${ftitle}cut_${name}.fastq ${f1} > report-cutadapt-${name}.txt
#time bowtie2-build -f /Dell/Dell4/kongjh/ribo-seq/test/index/rna_coding.fasta rna 
cd /Dell/Dell4/kongjh/gene-reference/SGD/index/
time bowtie2 --end-to-end -p 8 -x rna -U ${ftitle}cut_${name}.fastq --un ${ftitle}trimmed-one_${name}.fastq -S ${t}one_${name}.sam 
cd /Dell/Dell4/kongjh/gene-reference/ensemble/index/
time bowtie2 --end-to-end -p 8 -x ncrna -U ${ftitle}trimmed-one_${name}.fastq --un ${ftitle}trimmed-two_${name}.fastq -S ${t}two_${name}.sam
time bowtie2 --end-to-end -p 8 -x dna -U ${ftitle}trimmed-two_${name}.fastq --un ${t}unmap-${name}.fastq -S ${ftitle}mapped-${name}.sam

cd ${ftitle}
#time htseq-count --additional-attr=gene_name ${ftitle}mapped-${name}.sam  /Dell/Dell4/kongjh/gene-reference/ensemble/anotation/Saccharomyces_cerevisiae.R64-1-1.94.gtf -o ${ftitle}addgene-mapped-${name}.sam > report-count-${name}.txt 
time htseq-count --type=five_prime_UTR --additional-attr=ID -i ID ${ftitle}mapped-${name}.sam  /Dell/Dell4/kongjh/gene-reference/nochrNagalakshmi_2008_5UTRs_V64.gff3 -o ${ftitle}addutr-mapped-${name}.sam > report-count-${name}.txt

samtools view -T /Dell/Dell4/kongjh/gene-reference/ensemble/index/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.fa -h ${ftitle}addutr-mapped-${name}.sam > ${ftitle}header-addutr-mapped-${name}.sam
samtools view -F 4 -S ${ftitle}header-addutr-mapped-${name}.sam > ${ftitle}all-0-16-mapped-${name}.sam
awk -F "\t" '{print $1,$10,$3,$NF,$4,$2,$6}' OFS="\t" ${ftitle}all-0-16-mapped-${name}.sam > ${ftitle}${name}.csv

# 转变为 bam 用于提取 cigar
samtools view -T /Dell/Dell4/kongjh/gene-reference/ensemble/index/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.fa -h ${ftitle}all-0-16-mapped-${name}.sam > ${ftitle}all-header-0-16-mapped-${name}.sam
samtools view -b -S ${ftitle}all-header-0-16-mapped-${name}.sam > ${ftitle}all-0-16-mapped-${name}.bam

#paste -d "\t" Ho-1-28.csv Ho-1-28-length.csv > Ho-1-28-final.csv
#samtools flagstat mapped-ssu.sam
#也是check 是否有其他 flag 以及 flag数目与提取的对不对
#awk -F '\t' '{print $2}' al-mapped-ssu.sam | sort | uniq -c > hhh.txt
