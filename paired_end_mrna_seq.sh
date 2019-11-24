#!/bin/bash

namelist=(`cat /Dell/Dell4/kongjh/mrna_looped/mfs/namelist.txt`)
filelist=(`cat /Dell/Dell4/kongjh/mrna_looped/mfs/filelist.txt`) # 先放R1 再放R2 跟下面的 f1 和 f2 有关

for i in `seq 0 2`
do
    f="/Dell/Dell4/kongjh/mrna_looped/mfs/"
    t="/Dell/Dell4/kongjh/mrna_looped/mfs/temp/"
    name=${namelist[i]}
    f1=${filelist[i]}
    f2=${filelist[i+3]}

    cd ${f}
    mkdir ${name}
    ftitle=${f}${name}/
    cd ${ftitle}

    cd /Dell/Dell4/kongjh/gene-reference/ensemble/index/
    time bowtie2 --end-to-end -p 8 -x dna -1 ${f1} -2 ${f2} --un-conc ${t}unmap-${name}.fastq -S ${ftitle}mapped-${name}.sam
# 以下是 flag
	awk -F "\t" '{if (NR>19){print $2}}' OFS="\t" ${ftitle}mapped-${name}.sam > ${ftitle}flag-${name}.csv # 因为sam文件有表头，所以要先排除 NR 表示行号
	cat ${ftitle}flag-${name}.csv | sort | uniq -c | sort -k1 -nr # > ${ftitle}sort-flag-${name}.csv
#	cat ${ftitle}sort-flag-${name}.csv    
	cd ${ftitle}
	samtools flagstat ${ftitle}mapped-${name}.sam
# 先sort 再 count 更好
	samtools sort -n ${ftitle}mapped-${name}.sam -O SAM -o ${ftitle}sort-mapped-${name}.sam # -n 表示按照reads id来 sort
    time htseq-count --additional-attr=gene_name -r name -s no ${ftitle}sort-mapped-${name}.sam /Dell/Dell4/kongjh/gene-reference/ensemble/anotation/Saccharomyces_cerevisiae.R64-1-1.94.gtf -o ${ftitle}addgene-mapped-${name}.sam > report-count-${name}.txt
#time htseq-count --additional-attr=gene_name ${ftitle}mapped-${name}.sam  /Dell/Dell4/kongjh/gene-reference/ensemble/anotation/Saccharomyces_cerevisiae.R64-1-1.94.gtf -o ${ftitle}addgene-mapped-${name}.sam > report-count-${name}.txt 

done

