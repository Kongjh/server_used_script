#!/bin/bash

!!!! 修改： csv 变成 txt
把 最后文件名1_ribo 这些，改成无就好

namelist=(`cat /Dell/Dell4/kongjh/mRNA_looping_2/eIF1/namelist.txt`)
filelist=(`cat /Dell/Dell4/kongjh/mRNA_looping_2/eIF1/filelist.txt`)

for i in `seq 0 5`
do
    f="/Dell/Dell4/kongjh/mRNA_looping_2/"
    dirname="eIF1"
	cd ${f}${dirname}/
	t=${f}${dirname}/temp/

	name=${namelist[i]}
    f1=${filelist[i]} 
    mkdir ${name}
    cd ${name}

	ftitle=${f}${dirname}/${name}/	
	adapter="TGGAATTCTCGGGTGCCAAG"
	#time cutadapt -u 3 -a ${adapter} --discard-untrimmed -m 18 -M 32 -o ${ftitle}cut_${name}.fastq ${f1} > report_cutadapt_${name}.txt
	if [ ${i} \< 3 ];then
		# ribo-seq
    	time cutadapt -u 3 -a ${adapter} --discard-untrimmed -m 18 -M 32 -o ${ftitle}cut_${name}.fastq ${f1} > report_cutadapt_${name}.txt
	else
		# mRNA seq
		#time cutadapt -u 3 -a ${adapter} --discard-untrimmed -m 20 -M 40 -o ${ftitle}cut_${name}.fastq ${f1} > report_cutadapt_${name}.txt
		break
	fi

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
