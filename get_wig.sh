#201811
#!/bin/bash

samtools sort all-0-16-mapped-ssu.bam -o sort-all-0-16-mapped-ssu.bam
samtools index sort-all-0-16-mapped-ssu.bam
bash fetchChromSizes sacCer3 > sacCer3.chrom.sizes
#pip install --user pyBigWig RSeQC
python ~/.local/bin/bam2wig.py -s sacCer3.chrom.sizes -i sort-all-0-16-mapped-ssu.bam -o all-0-16-mapped-ssu.bw -u
chmod 775 wigToBigWig

