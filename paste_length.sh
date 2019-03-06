#!/bin/bash

## 修改 2个参数，文件夹
namelist=(`cat /Dell/Dell4/kongjh/mrna_looped/HD/namelist.txt`)

for i in `seq 0 1`
do
    f="/Dell/Dell4/kongjh/mrna_looped/HD/"
    name=${namelist[i]}
    ftitle=${f}${name}/
    cd ${ftitle}
	paste -d "\t" ${name}.csv ${name}-length.csv > ${name}_final.csv
	echo $i
done
