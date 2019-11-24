#!/bin/bash

f="/Dell/Dell4/kongjh/ribo-seq/"

t="/Dell/Dell4/kongjh/ribo-seq/temp/"

#name="Ho-1-28"
#name="Ho-1-T"
name="Ho-2-28"
#name="Ho-2-T"
#name=${f1%_*}

adapter="TGGAATTCTCGGGTGCCAAG"

#f1="/Dell/Dell4/kongjh/ribo-seq/seq/HO-1-T_L4_A001.R1.clean.fastq"
f1="/Dell/Dell4/kongjh/ribo-seq/seq/HO-2-28_L4_A006.R1.clean.fastq"

cd ${f}
mkdir ${name}
ftitle=${f}${name}/
cd ${ftitle}

time cutadapt -u 3 -a ${adapter} --discard-untrimmed -m 16 -o ${ftitle}cut_${name}.fastq ${f1} > report-cutadapt-${name}.txt
#time cutadapt -a ${adapter} --discard-untrimmed -m 16 -o ${ftitle}cut_${name}.fastq ${f1} > report-cutadapt-${name}.txt
#time bowtie2-build -f /Dell/Dell4/kongjh/ribo-seq/test/index/rna_coding.fasta rna 
cd /Dell/Dell4/kongjh/gene-reference/SGD/index/
time bowtie2 --end-to-end -p 8 -x rna -U ${ftitle}cut_${name}.fastq --un ${ftitle}trimmed-one_${name}.fastq -S ${t}one_${name}.sam 
cd /Dell/Dell4/kongjh/gene-reference/ensemble/index/
time bowtie2 --end-to-end -p 8 -x ncrna -U ${ftitle}trimmed-one_${name}.fastq --un ${ftitle}trimmed-two_${name}.fastq -S ${t}two_${name}.sam
time bowtie2 --end-to-end -p 8 -x dna -U ${ftitle}trimmed-two_${name}.fastq --un ${t}unmap-${name}.fastq -S ${ftitle}mapped-${name}.sam

cd ${ftitle}
time htseq-count --additional-attr=gene_name ${ftitle}mapped-${name}.sam  /Dell/Dell4/kongjh/gene-reference/ensemble/anotation/Saccharomyces_cerevisiae.R64-1-1.94.gtf -o ${ftitle}addgene-mapped-${name}.sam > report-count-${name}.txt 

samtools view -T /Dell/Dell4/kongjh/gene-reference/ensemble/index/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.fa -h ${ftitle}addgene-mapped-${name}.sam > ${ftitle}header-addgene-mapped-${name}.sam
samtools view -F 4 -S ${ftitle}header-addgene-mapped-${name}.sam > ${ftitle}all-0-16-mapped-${name}.sam
awk -F "\t" '{print $1,$10,$3,$NF,$4,$2,$6}' OFS="\t" ${ftitle}all-0-16-mapped-${name}.sam > ${ftitle}${name}.csv

# 转变为 bam 用于提取 cigar
samtools view -T /Dell/Dell4/kongjh/gene-reference/ensemble/index/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.fa -h ${ftitle}all-0-16-mapped-${name}.sam > ${ftitle}all-header-0-16-mapped-${name}.sam
samtools view -b -S ${ftitle}all-header-0-16-mapped-${name}.sam > ${ftitle}all-0-16-mapped-${name}.bam

#paste -d "\t" Ho-1-28.csv Ho-1-28-length.csv > Ho-1-28-final.csv

#samtools flagstat mapped-ssu.sam
#也是check 是否有其他 flag 以及 flag数目与提取的对不对
#awk -F '\t' '{print $2}' al-mapped-ssu.sam | sort | uniq -c > hhh.txt
