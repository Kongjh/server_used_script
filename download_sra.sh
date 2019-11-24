#! /bin/bash
cd /Dell/Dell4/kongjh/ncbi/public/sra/tasep/
#time prefetch SRR3458594
#time prefetch SRR3458595
time prefetch SRR948553  # 这里加路径。没加就是默认的路径
time prefetch SRR948551
wait
cd /Dell/Dell4/kongjh/tasep/
time fastq-dump --split-3 /Dell/Dell4/kongjh/ncbi/public/sra/SRR948553.sra -O /Dell/Dell4/kongjh/tasep/
time fastq-dump --split-3 /Dell/Dell4/kongjh/ncbi/public/sra/SRR948551.sra -O /Dell/Dell4/kongjh/tasep/
#wait
#echo -e "\a"


