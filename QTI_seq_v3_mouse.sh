#!/bin/bash

### 需要改4 处 文件夹的位置
file="/Dell/Dell4/kongjh/kozak_QTI/mouse_MEF/seq/SRR1630814.fastq"
#t="/Dell/Dell4/kongjh/mrna_looped/WT/temp/"
name='mouse'

#cd ${f}
#mkdir ${name}
#ftitle=${f}${name}/
#cd ${ftitle}

#time cutadapt -u 3 -a ${adapter} --discard-untrimmed -m 16 -o ${ftitle}cut_${name}.fastq ${f1} #  > report_cutadapt_${name}.txt # 八 cut 的 repo 也直接输出，方便看
#time cutadapt -a ${adapter} --discard-untrimmed -m 16 -o ${ftitle}cut_${name}.fastq ${f1} > report-cutadapt-${name}.txt
#time bowtie2-build -f /Dell/Dell4/kongjh/ribo-seq/test/index/rna_coding.fasta rna 

# 自己去 ensembl biomart下载 转录组数据，建index 比对
# index 已经完成
# build index 并进入该文件夹
#time bowtie2-build -f /Dell/Dell4/kongjh/gene-reference/ensemble/mouse_tf/mouse_96_biomart_transcript.fa mouse

# 使用 tophat 比对
#cd /Dell/Dell4/kongjh/kozak_QTI/mouse_MEF
# 直接用我自定义的index 就不用 transcriptomexxxxx
#time tophat2 -p 16 --no-convert-bam --transcriptome-index=/Dell/Dell4/kongjh/gene-reference/ensemble/mouse/gfp /Dell/Dell4/kongjh/gene-reference/ensemble/mouse/dna ${file}
#time tophat2 -p 16 --no-convert-bam /Dell/Dell4/kongjh/gene-reference/ensemble/mouse_tf/mouse ${file}
cd /Dell/Dell4/kongjh/gene-reference/ensemble/mouse
time bowtie2 --end-to-end -p 16 -x mouse -U ${file} --un /Dell/Dell4/kongjh/kozak_QTI/mouse_MEF/unmap-${name}.fastq -S /Dell/Dell4/kongjh/kozak_QTI/mouse_MEF/mapped-${name}.sam
#time htseq-count --additional-attr=gene_name /Dell/Dell4/kongjh/kozak_QTI/mouse_MEF/tophat_out/accepted_hits.sam  /Dell/Dell4/kongjh/gene-reference/gencode/mouse/gencode.vM21.annotation.gtf -o addgene-mapped_v1.sam > report-count-${name}.txt 
#time htseq-count --additional-attr=gene_name /Dell/Dell4/kongjh/kozak_QTI/mouse_MEF/tophat_out/accepted_hits.sam  /Dell/Dell4/kongjh/gene-reference/ensemble/mouse/Mus_musculus.GRCm38.96.gtf -o addgene-mapped_v1.sam > report-count-${name}.txt

#samtools view -T /Dell/Dell4/kongjh/gene-reference/ensemble/mouse/Mus_musculus.GRCm38.dna.toplevel.fa -h addgene-mapped_v1.sam > header-addgene-mapped_v1.sam
#samtools view -F 4 -S header-addgene-mapped_v1.sam > all-0-16-mapped_v2.sam
cd /Dell/Dell4/kongjh/kozak_QTI/mouse_MEF/
samtools view -F 4 -S mapped-${name}.sam > all-0-16-mapped_v2.sam
awk -F "\t" '{print $1,$10,$3,$NF,$4,$2,$6}' OFS="\t" all-0-16-mapped_v2.sam > ${name}.csv

# 转变为 bam 用于提取 cigar
#samtools view -T /Dell/Dell4/kongjh/gene-reference/ensemble/mouse/Mus_musculus.GRCm38.dna.toplevel.fa -h all-0-16-mapped_v2.sam > all-header-0-16-mapped_v2.sam
#samtools view -T /Dell/Dell4/kongjh/gene-reference/ensemble/mouse_tf/mouse_96_biomart_transcript.fa -h all-0-16-mapped_v2.sam > all-header-0-16-mapped_v2.sam
samtools view -T /Dell/Dell4/kongjh/gene-reference/ensemble/mouse/mouse_biomart_transcript_crcm38p6_up20nt.fa -h all-0-16-mapped_v2.sam > all-header-0-16-mapped_v2.sam
samtools view -b -S all-header-0-16-mapped_v2.sam > all-0-16-mapped_v2.bam


#samtools flagstat mapped-ssu.sam
#也是check 是否有其他 flag 以及 flag数目与提取的对不对
#awk -F '\t' '{print $2}' al-mapped-ssu.sam | sort | uniq -c > hhh.txt


