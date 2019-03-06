#! /bin/bash
cd /Dell/Dell4/kongjh/ncbi/public/sra/
time prefetch SRR3458594
time prefetch SRR3458595
wait
cd /Dell/Dell4/kongjh/kozak_40s/
time fastq-dump --split-3 /Dell/Dell4/kongjh/ncbi/public/sra/SRR3458594.sra -O /Dell/Dell4/kongjh/kozak_40s/
time fastq-dump --split-3 /Dell/Dell4/kongjh/ncbi/public/sra/SRR3458595.sra -O /Dell/Dell4/kongjh/kozak_40s/
#wait
#echo -e "\a"


