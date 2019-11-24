#!/bin/bash

## 修改 2个参数，文件夹
#namelist
#HD_1_ribo
#HD_2_ribo
#HD_3_ribo
#HD_1_mrna
#HD_2_mrna
#HD_3_mrna


namelist=(`cat /Dell/Dell4/kongjh/mrna_looped/HD/namelist.txt`)

for i in `seq 0 5`
do
    f="/Dell/Dell4/kongjh/mrna_looped/HD/"
    name=${namelist[i]}
    ftitle=${f}${name}/
    cd ${ftitle}
	paste -d "\t" ${name}.csv ${name}-length.csv > ${name}_final.csv
	echo $i
done
