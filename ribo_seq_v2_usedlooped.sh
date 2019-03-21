#!/bin/bash


#name="WT_1_ribo"
#name="WT_2_ribo"
#name="WT_1_mrna"
#name="WT_3_ribo"
#name="WT_2_mrna"
#name="WT_3_mrna"


#f1="/Dell/Dell4/kongjh/mrna_looped/OE/seq/OE-1-ribo_L1_A012.R1.clean.fastq"
#f1="/Dell/Dell4/kongjh/mrna_looped/OE/seq/OE-2-ribo_L1_A022.R1.clean.fastq"
#f1="/Dell/Dell4/kongjh/mrna_looped/OE/seq/OE-1-RNA_L1_A011.R1.clean.fastq"
#f1="/Dell/Dell4/kongjh/mrna_looped/OE/seq/OE-3-ribo_L1_A024.R1.clean.fastq"
#f1="/Dell/Dell4/kongjh/mrna_looped/OE/seq/OE-2-RNA_L1_A021.R1.clean.fastq"
#f1="/Dell/Dell4/kongjh/mrna_looped/OE/seq/OE-3-RNA_L1_A023.R1.clean.fastq"


### 需要改4 处 文件夹的位置
namelist=(`cat /Dell/Dell4/kongjh/mrna_looped/WT/namelist.txt`)
filelist=(`cat /Dell/Dell4/kongjh/mrna_looped/WT/filelist.txt`)

for i in `seq 0 5`
do
    f="/Dell/Dell4/kongjh/mrna_looped/WT/"
    t="/Dell/Dell4/kongjh/mrna_looped/WT/temp/"
    adapter="TGGAATTCTCGGGTGCCAAG" 
    name=${namelist[i]}
    f1=${filelist[i]}
 
    cd ${f}
    mkdir ${name}
    ftitle=${f}${name}/
    cd ${ftitle}

    time cutadapt -u 3 -a ${adapter} --discard-untrimmed -m 16 -o ${ftitle}cut_${name}.fastq ${f1} #  > report_cutadapt_${name}.txt # 八 cut 的 repo 也直接输出，方便看
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

done
#paste -d "\t" Ho-1-28.csv Ho-1-28-length.csv > Ho-1-28-final.csv

#samtools flagstat mapped-ssu.sam
#也是check 是否有其他 flag 以及 flag数目与提取的对不对
#awk -F '\t' '{print $2}' al-mapped-ssu.sam | sort | uniq -c > hhh.txt
