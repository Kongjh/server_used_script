#!bin/bash
#From data get barcodes,and check barcode
#Kjh 20190110
#修改3个地方， barcode，name，grepbarcode
#思路：挑出序列，每个barcode单独成一个文件，相当于重复，切出 barcode+variants 拼在一起，根据设计的barcode组合 挑出真正的variants，再duplicate一下
#$1
#$2

#######一共需要修改  name;barcode.txt;

#name="rna"
#name="dna"
namelist=("dna" "rna")
filelist=("/Dell/Dell4/kongjh/kozak/library_exper/seq/total-DNA/DNA-total-FACS_L8_A025.R1.adapter.fastq" "/Dell/Dell4/kongjh/kozak/library_exper/seq/total-RNA/RNA-total-FACS_L2_A027.R1.adapter.fastq")

for i in `seq 0 1`
do
	name=${namelist[i]}
	file=${filelist[i]}
	work="/Dell/Dell4/kongjh/kozak/library_exper/check_barcode/"
	cd $work
	mkdir $name
	cd ${work}${name}/
#temp1="temp_first_${name}"
	first="fastq_${name}"
	temp2="bar_5_${name}"
	temp3="bar_3_${name}"
	temp5="bar_5_3_${name}"
	num_5_3_bar="bar_num_5_3_${name}.csv"
#temp4="temp_variants_${name}"
######get sequence  
#$1 指第一个参数，我改用直接在bash里用变量代表了  #del 偶数行 #因为 grep后会多出一行 -------，所以需要删除这行
	grep -v '^[@+]' ${file} | sed '1~2!d' > $first
	head -8 $file $first
	wc -l $file $first
#######to check barcode, should count barcodes, according the designed structure 
#barcode == 6 base; get 5' or 3' bar 根据位置信息选择
	cat $first | cut -c 13-18 > $temp2
	cat $first | cut -c 88-93 > $temp3
	paste -d "\t" $temp2 $temp3 > $temp5
#paste -d: $temp2 $temp3 > $temp5
#paste -d ":" $temp2 $temp3 > $temp5
	cat $temp5 | sort | uniq -c | sort -k1 -nr > $num_5_3_bar
	head -8  $temp2 $temp3 $temp5 $num_5_3_bar
	wc -l $temp2 $temp3 $temp5 $num_5_3_bar
done

