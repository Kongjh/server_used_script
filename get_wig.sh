#201811
#!/bin/bash

# 转为 bw
samtools sort all-0-16-mapped-ssu.bam -o sort-all-0-16-mapped-ssu.bam
samtools index sort-all-0-16-mapped-ssu.bam
bash fetchChromSizes sacCer3 > sacCer3.chrom.sizes
#pip install --user pyBigWig RSeQC
python ~/.local/bin/bam2wig.py -s sacCer3.chrom.sizes -i sort-all-0-16-mapped-ssu.bam -o all-0-16-mapped-ssu.bw -u
chmod 775 wigToBigWig

# 如果文件不是很大 可以直接用 bam 文件看
samtools view -h file.bam > file.sam
samtools view -b -S file.sam > file.bam
# 排序
samtools sort file.bam -o file.sorted.bam
# 建索引
samtools index file.sorted.bam

# 如果还是很大 或者转为 tdf 文件，使用 IGV tools

