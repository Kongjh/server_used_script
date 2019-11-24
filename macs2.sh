# !/bin/bash
# macs2
# 再 2.7 python 下进行
conda env list
source activate xxxx
nohup macs2 callpeak -t mouse.sorted.bam -c mouse_ribo.sorted.bam -n mousecall -f BAM -s 50 --nomodel > call_peak.out &
nohup macs2 callpeak -t mouse.sorted.bam -n mousecall -f BAM -s 50 --nomodel > call_peak.out &
callpeak -t mouse.sorted.bam -n mousecall -f BAM -s 50 --nomodel --extsize 28

conda deactivate
