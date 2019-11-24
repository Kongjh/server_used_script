#!/bin/bash

factorlist=(`cat /Dell/Dell4/kongjh/mRNA_looping_2/factor_list.txt`) #eIF1
for i in `seq 0 5`
do
	f="/Dell/Dell4/kongjh/mRNA_looping_2/"
    dirname=${factorlist[i]} 
    cd ${f}${dirname}/
	
	namelist=(`cat namelist.txt`) # 1_ribo
	
	for ii in `seq 0 2`
	do
		name=${namelist[ii]}
		cd ${f}${dirname}/${name}/
		paste -d "\t" ${name}.csv length_${name}.txt > ${name}_final.txt
		echo "${ii} sucessfull"
	done
done
