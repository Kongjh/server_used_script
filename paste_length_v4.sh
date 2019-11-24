#!/bin/bash
# eIF1
#factorlist=(`cat /Dell/Dell4/kongjh/mRNA_looping_2/factorlist.txt`)
factorlist=(`cat /Dell/Dell4/kongjh/mRNA_looping_2/factor_list_eIF_new.txt`)
# 多少 fators
for i in `seq 0 5`
do
	f="/Dell/Dell4/kongjh/mRNA_looping_2/"
    # 1_ribo
	namelist=(`cat ${f}namelist.txt`)
	dirname=${factorlist[i]} 
    cd ${f}${dirname}/
	# 多少重复， ribo 或者 mrna
	for ii in `seq 0 5`
	do
	# 判断做 ribo 还是 mRNA；还是都做
		if [ ${ii} \< 3];then
		# ribo
			#name=${namelist[ii]}
			#cd ${f}${dirname}/${name}/
			#paste -d "\t" ${name}.txt length_${name}.txt > ${name}_final.txt
			#echo "${dirname} ${name} sucessfull"
			continue
		else
		# mRNA
			name=${namelist[ii]}
            cd ${f}${dirname}/${name}/
            paste -d "\t" ${name}.txt length_${name}.txt > ${name}_final.txt
            echo "${dirname} ${name} sucessfull"
		fi
	done
done
