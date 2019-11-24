# 代码开头
#!/bin/bash

which # 查看命令等的位置 path 等

# 关于系统
which cutadapt # 查找该命令来自哪条路径
pip3 install --user HTSeq # --prefix

# 跑 bash R python 脚本
nohup time bash xxx.sh
nohup time python xxx.py
nohup time Rscript xxx.r

# 综合
du -h --max-depth=1 gittest/
cat flag.csv | sort | uniq -c | sort -k1 -nr > sort_flag.csv # 先 sort 一下在 去重统计数目，在从大到小排序
awk -F "\t" '{print $6}' OFS="\t" gal1_1_mrna.csv > flag.csv
grep -A17 "^>" orf_genomic_1000.fasta > temp1_A17.fasta
sed '/^--/'d temp1_A17.fasta > sed_temp1_A17.fasta # 删除 -- 开头的行
awk '!(NR%18)' sed_temp1_A17.fasta > awk17_sed.fasta
cat awk17_sed.fasta | cut -c 28-48 > cut_awk.csv
awk -F ":" '{print $1}' gene_infor.fasta > gene_list.csv
awk -F "," '{print $1}'  rest_of_gene_list.csv > SGDID_list.csv
paste -d ';' gene_list.csv cut_awk.csv SGDID_list.csv > vertified_ORF.csv
wget -c https:/ &
grep 'eIF\|overall' run.out > grep.out # “或”匹配，如果是“和“的话就两个 grep
sort -nr -k2 report-count-1_ribo.txt > t.txt # 参考 endnote 那里 

cat no.fa | sed '/^$/d' > no2.fa # 删除空行
ls `pwd`/*/* > full_path.txt #获得文件路径


# 解压文件
#gzip -cd xx.gz > xx.dd #直接用 d 参数 不用重定向
#gzip -cd OE-1-ribo_L1_A012.R1.clean.fastq.gz > OE-1-ribo_L1_A012.R1.clean.fastq
bzip2 -kd exp1.bz2 # 保留了源文件 
tar -xvf samtools-1.9.tar.bz2
tar -xzvf file.tar.gz # 解压tar.gz .tgz .tar.gz  
tar -xvf file.tar
gzip -d OE-3-ribo_L1_A024.R1.clean.fastq.gz &
unzip 8-2017.10.12.zip

# git
git init
git config user.email "akjh2017@genetics.ac.cn"
git config user.name "Kongjh"
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
wc -l file file2 xxx 
find -inum 275387 -delete
find -inum 275387 -exec mv {} hhh.txt \;
th-p hhh.txt/
fc-cache -f -v
fc-list

head -2 $temp1 $first
wc -l $temp1 $first
nohup prefetch xxxxx &
nohup fastq-dump --split-3 /Dell/Dell4/kongjh/ncbi/public/sra/SRR014375.sra &
cat SRR014385.fastq > mRNA_1.fastq &
cat SRR0143* > fp_2.fastq &

paste -d "\t" Ho-1-28.csv Ho-1-28-length.csv > Ho-1-28-final.csv

# others -2
ps -aux | grep 'kongjh'

# 命令 流程控制
# 并行执行完这三个脚本之后,输出helloworld。
sh a.sh &
sh b.sh & 
sh c.sh &
wait 
echo "helloworld"
# 
sleep


# install myself python package path
python2.7 setup.py install --root=/home/kongjh/usr/
pip install --user pyBigWig RSeQC

###########################
# paste
paste -d "\t" Ho-1-28.csv Ho-1-28-length.csv > Ho-1-28-final.csv
# 默认按列拼接
-s # 是按行拼接

# uniq
# 通常和sort 连用，sort 之后uniq 


# awk e.g.
awk '!(NR%2)' dna.fastq > dna_seq.fastq
awk 'NR%2==0' dna.fastq | awk 'NR%2==1' > dna_seq.fastq
#$1 指第一个参数 需要使用完整路劲
awk 'NR%2==0' filename #获得偶数行
awk 'NR%2==1' filename #删除偶数行
awk -F "\t" '{print $1,$10,$3,$NF,$4,$2,$6}' OFS="\t" ${ftitle}all-0-16-mapped-${name}.sam > ${ftitle}${name}.csv
awk -F "|" '{print $7}' human_kozak_seq.txt > test.txt
awk -F "\t" '{print $1}' test.txt | sort | uniq -c > tf_id_kind.txt

# cut # 字符串 从 1开始计数 
cut -f 2 mouse_biomart_transcript_crcm38p6_up20nt.txt | cut -c 7-27 > mouse_kozak_tmp.txt & # 选取第二列，再截取 7-27 
# grep e.g.
grep -v '^[@+]' $1 > $temp1 # v是相反，排除 @或者+开头的行


# sed e.g.
#del 偶数行
sed '1~2!d' $temp1 > $first
sed '1~2d' file #删除奇数行
sed '1~2!d' file #删除偶数行
awk -F " " '{print $1}' orf_coding.txt | sed 's/"//g' > h.txt # awk打印第一列，但是含有"，再用 sed删除每行的"
##########
# samtools e.g.
#installed
cd samtools-1.x    # and similarly for bcftools and htslib
./configure --prefix=/where/to/install
make
make install
export PATH=/where/to/install/bin:$PATH    # for sh or bash users

#samtools_0.1.18 sort
#samtools_0.1.18 sort all-0-16-mapped-1_mrna.bam all-0-16-mapped-1_mrna.sort

#sort 之后 才能 insex
# -@ 8 是用 8 个核
samtools sort -@ 8 all-0-16-mapped-mrna.bam -O BAM -o sort.bam
samtools index -@ 8 sort.bam
# depth 没有 @ 参数
samtools depth -a -b ${f}${dirname}/mrna/tmp.bed ${f}${dirname}/mrna/sort.bam > ${f}${dirname}/mrna/coverage/${geneid[i]}.txt

samtools sort all-0-16-mapped-mrna.bam -O BAM -o sort.bam
samtools index sort.bam

samtools sort all-0-16-mapped-ssu.bam -o sort-all-0-16-mapped-ssu.bam
samtools index sort-all-0-16-mapped-ssu.bam
samtools depth mouse.sorted.bam > mouse.sorted.bam.depth.txt

# for get wig file
#chmod 775 wigToBigWig
bash fetchChromSizes sacCer3 > sacCer3.chrom.sizes
python ~/.local/bin/bam2wig.py -s sacCer3.chrom.sizes -i sort-all-0-16-mapped-ssu.bam -o all-0-16-mapped-ssu.bw -u

# htseq e.g.
# htseq-count 5'utr 把 gff3中的 chr 替换成空了
time htseq-count --type=five_prime_UTR --additional-attr=ID -i ID mapped-Ho-1-28.sam  /Dell/Dell4/kongjh/gene-reference/nochrYassour_2009_UTR_boundaries_V64.gff3 -o add-utr-mapped-H0-1-28.sam > report-utr-count-H0-1-28.txt

# fastqc
fastqc --help
fastqc Fusion-1ribo_L7_A004.R1.clean.fastq -o fastqc_dir/

# macs2
# 再 2.7 python 下进行
# 在 used script 那里

# md5sum 
man md5sum
md5sum -c md5.txt # md5文件内容和文件在同一文件夹下，会自动检测 # 注意事项如下
md5sum lnmp1.3-full.tar.gz > md5-hash.txt # 获得保存某一文件的md5
# 注意事项：在已知hash数值情况下对文件进行校验的时候要注意，一定要让系统能够找到要校验的文件。否则就没法进行校验了。具体的使用说明，可以通过md5(sha1)sum --help来查看

# 批量获得文件夹的绝对路径
ls `pwd`/* #`xx`这里就先输出了路径。
ls /xxx/rrrr/dddd/xxxx/* #跟上面的一样效果
ls -R # 递归应该是这个
ls xxx/*  #一般是这个
echo `pwd`

# test 测试bash 脚本 和 语法 以及走过的坑
# 循环
for i in `seq 0 2`
do
    cat $second | grep -w "^${barcode_5[i]}" | grep -w "${barcode_3[i]}$" > ${third}${i}
    cat ${third}${i} | cut -c 8-28 > ${real_upf1}${i}.csv
    cat ${real_upf1}${i}.csv | sort | uniq -c | sort -k1 -nr > ${number_upf1}${i}.csv
done

# if 语句
a=10
b=20
if [ $a == $b ]# 注意 < > 要加转义符号 即 if [ $i \> 3 ]
then
    echo "a is equal to b"
else
    echo "a is not equal to b"
fi

# 变量知识，详见 endnote
a="aa"
# 错误，单引号只能是纯字符
fi='/Dell/Dell4/kongjh/mRNA_looping_2/${a}/filelist.txt'
# 正确，双引号内可以有变量
fi="/Dell/Dell4/kongjh/mRNA_looping_2/${a}/filelist.txt"
# 正确，同上
fi=/Dell/Dell4/kongjh/mRNA_looping_2/${a}/filelist.txt
echo ${fi}

filelist=(`cat ${fi}`)
for i in `seq 0 1`
do
    echo ${filelist[i]}
done

#一行一行 读取文件
#!/bin/bash
#reading data from a file
count=1
cat test1 | while read line
do
        echo "Line $count: $line"
        count=$[ $count + 1 ]
done
echo finished processing the file

# 注意事项！
# 注释与代码不能在同一行



