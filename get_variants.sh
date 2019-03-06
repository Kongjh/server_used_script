#!bin/bash
#From sequence  get variants
#Kjh 20190110
#修改3个地方， barcode，name，grepbarcode
#思路：在前一步check了barcodes后，切出 barcode+variants 拼在一起，根据设计的barcode组合 挑出真正的variants，再duplicate一下
#$12

#######一共需要修改  name;barcode.txt;
## filelist 为原始序列，这里再稍稍重复 check barcode 那一步
namelist=("dna" "rna")
filelist=("/Dell/Dell4/kongjh/kozak/library_exper/seq/total-DNA/DNA-total-FACS_L8_A025.R1.adapter.fastq" "/Dell/Dell4/kongjh/kozak/library_exper/seq/total-RNA/RNA-total-FACS_L2_A027.R1.adapter.fastq")

#读取成为一个数组，进行遍历
for i in `seq 0 1`
do
	name=${namelist[i]}
    file=${filelist[i]}
    work="/Dell/Dell4/kongjh/kozak/library_exper/"
    cd $work
    mkdir $name
    cd ${work}${name}/
#temp1="temp_first_${name}"
    first="fastq_${name}"
    temp2="bar_5_${name}"
    temp3="bar_3_${name}"
	temp4="all_variants_${name}"
	second="all_bar_variants_${name}"
## barcode 先ho再upf1
	barcode_5=(`cat /Dell/Dell4/kongjh/kozak/library_exper/bar_list/bar_${name}_5list`)
	barcode_3=(`cat /Dell/Dell4/kongjh/kozak/library_exper/bar_list/bar_${name}_3list`)
#get sequence  
#$1 指第一个参数，我改用直接在bash里用变量代表了  #del 偶数行 #因为 grep后会多出一行 -------，所以需要删除这行
    grep -v '^[@+]' ${file} | sed '1~2!d' > $first
    head -6 $file $first
    wc -l $file $first
# according the designed structure，根据位置，切出 5‘barcode variants 3’barcode 
#barcode == 6 base,varians == 21 base (dna or rna) 并集
    cat $first | cut -c 13-18 > $temp2
	cat $first | cut -c 41-61 > $temp4
    cat $first | cut -c 88-93 > $temp3
    paste -d "\t" $temp2 $temp4 $temp3 > $second
	head -6 $first $second
	wc -l $first $second
#filter to 目的barcode seq
#third="wt_barcode_variants"
#fourth="upf1_barcode_variants"
	real_upf1="real_upf1_variants"
	real_ho="real_ho_variants"
	number_upf1="sortnum_upf1_variants"
	number_ho="sortnum_ho_variants"
############## ho
# 因为只有一次重复所以 i = 0,
	i=0
# 如果有多个重复，则如下使用 循环
#for i in `seq 0 2`
#do
	cat $second | grep -w "^${barcode_5[i]}" | grep -w "${barcode_3[i]}$" | cut -c 8-28 > ${real_ho}_${name}.csv
#之前为了逐步检查才这样， > ${third}${i} cat ${third}${i} | cut -c 8-28，如上，现在可以直接 管道符操作 
	cat ${real_ho}_${name}.csv | sort | uniq -c | sort -k1 -nr > ${number_ho}_${name}.csv
#done
############ upf1
	i=1
	cat $second | grep -w "^${barcode_5[i]}" | grep -w "${barcode_3[i]}$" | cut -c 8-28 > ${real_upf1}_${name}.csv
# > ${fourth}${i} cat ${fourth}${i} | cut -c 8-28 > ${real_upf1}${i}.csv
	cat ${real_upf1}_${name}.csv | sort | uniq -c | sort -k1 -nr > ${number_upf1}_${name}.csv
	head -2 ${real_ho}_${name}.csv ${real_upf1}_${name}.csv  
	wc -l real_* sortnum_* 
done
echo "check barcodes 那一步的barcodes数目 应该需要跟挑出来的 variants数目一致"
# ps check barcodes 那一步的barcodes数目 应该需要跟 跳出来的 variants数目一致

