# -*- coding: utf-8 -*-
"""
Created on Tue Oct  9 14:29:03 2018

@author: Administrator
"""
### 定义 反向互补函数
def rev(seq):
	ntComplement = {'A':'T', 'C':'G', 'T':'A', 'G':'C'}
	re_seq = list(seq[::-1])
	for i in range(1,len(re_seq)+1) :
		re_seq[i -1] = ntComplement[re_seq[i -1]]
	reseq = "".join(re_seq)
	return reseq
#a = "AGGGGTTTAGTTTCAGCTCTTAGATG"
#b = rev(a)
#b
#a="tggaattctcgggtgccaaggaactccagtc"
#a.upper()
###################################################################
########          ribo-seq mrna-seq 
####### 把比对的结果  （length 从R 那里获得 再 linux 中拼接） 之后再提取出来 格式化 进入R
def getOrignfile(file1,file2):
	import csv
	from itertools import islice
	with open (file2,'w',newline = '') as f2:
		f2 = csv.writer(f2,delimiter = "\t")
		f2.writerow(["read_id","chr","gene_id", "map_position","polar","length"])
		with open (file1, 'r') as f1:
			f1 = csv.reader(f1, delimiter = '\t')          
			for i in f1:
#                        print(i)
#                        break
#['HWI-7001446:609:C8A38ANXX:4:1101:2041:2236', 'TTCACCTTAGCGGGTGGTTTGAAAGAGGA','V', 'XF:Z:YEL065W', '28560', '0', '29M', '29']
				ii = i[3].split(":")
#                        if ii[2][0] == "Y":  # 只取酵母基因，去除线粒体的
#                              iii = ii[2].split("_") # 这一句是提取 utr用来 删除结尾 utr的  YLR325C_5UTR , 同时我也修改了 writerown 那里的 序号
                        # 决定取所有的基因，包括线粒体等，到了R 再进行筛选，！！！！！注意有 too low quality 这些
				f2.writerow([i[0],i[2],ii[2],i[4],i[5],i[7]])
#                              f2.writerow([i[0],i[2],iii[0],i[4],i[5],i[7]])
#                        else:
#      #                        x = x+1
#                              continue
# 针对 3次重复的
# i=1
# file1list = ["G:\\mrna_looped\\Hh_1_mrna_final.csv","G:\\mrna_looped\\Hh_2_mrna_final.csv","G:\\mrna_looped\\Hh_3_mrna_final.csv","G:\\mrna_looped\\Hh_1_ribo_final.csv","G:\\mrna_looped\\Hh_2_ribo_final.csv","G:\\mrna_looped\\Hh_3_ribo_final.csv"]
# file2list = ["G:\\mrna_looped\\new_Hh_1_mrna_final.txt","G:\\mrna_looped\\new_Hh_2_mrna_final.txt","G:\\mrna_looped\\new_Hh_3_mrna_final.txt","G:\\mrna_looped\\new_Hh_1_ribo_final.txt","G:\\mrna_looped\\new_Hh_2_ribo_final.txt","G:\\mrna_looped\\new_Hh_3_ribo_final.txt"]
# for file1,file2 in zip(file1list,file2list):
#       getOrignfile(file1,file2)
#       # print(i) # 信号指示
#       # i = i+1

# 针对 1次重复的
# i=1
# file1list = ["/Dell/Dell4/kongjh/mrna_looped/FS/FS_1_ribo/FS_1_ribo_final.csv","/Dell/Dell4/kongjh/mrna_looped/FS/FS_2_ribo/FS_2_ribo_final.csv","/Dell/Dell4/kongjh/mrna_looped/FS/FS_3_ribo/FS_3_ribo_final.csv","/Dell/Dell4/kongjh/mrna_looped/FS/FS_1_mrna/FS_1_mrna_final.csv","/Dell/Dell4/kongjh/mrna_looped/FS/FS_2_mrna/FS_2_mrna_final.csv","/Dell/Dell4/kongjh/mrna_looped/FS/FS_3_mrna/FS_3_mrna_final.csv"]
# file2list = ["/Dell/Dell4/kongjh/tmp_0312/new_FS_1_ribo_final.csv","/Dell/Dell4/kongjh/tmp_0312/new_FS_2_ribo_final.csv","/Dell/Dell4/kongjh/tmp_0312/new_FS_3_ribo_final.csv","/Dell/Dell4/kongjh/tmp_0312/new_FS_1_mrna_final.csv","/Dell/Dell4/kongjh/tmp_0312/new_FS_2_mrna_final.csv","/Dell/Dell4/kongjh/tmp_0312/new_FS_3_mrna_final.csv"]
# for file1,file2 in zip(file1list,file2list):
#       getOrignfile(file1,file2)
#       # print(i)
#       # i = i+1

# ssu
#file1='/Dell/Dell4/kongjh/kozak_ssu/ssu/ssu_final.csv'
#file2='/Dell/Dell4/kongjh/rstudio/leaky_version/ssu_40s/tmp1_40s_ssu.txt'
#getOrignfile(file1,file2)
# rs
#file1='/Dell/Dell4/kongjh/kozak_ssu/ssu/ssu_final.csv'
#file2='/Dell/Dell4/kongjh/rstudio/leaky_version/ssu_40s/tmp1_40s_ssu.txt'
#getOrignfile(file1,file2)
# mRNA
# file1='/Dell/Dell4/kongjh/kozak_ssu/mrna/mrna_final.csv'
# file2='/Dell/Dell4/kongjh/rstudio/leaky_version/ssu_40s/tmp1_mrna_ssu.txt'
# getOrignfile(file1,file2)


# 针对 3次重复的
# 需要自己先创建文件夹
ftitle_1 = "/Dell/Dell4/kongjh/mRNA_looping_2/"
ftitle_2 = ["eIF1","eIF1A","eIF4A","eIF4B","eIF5","eIF5B"]
#ftitle_2 = ["wt","ho","OE","FS","eIF4E","eIF4G1","CAF20","EAP1","PAB1"]
# 下面是bigrange
# ftitle_1 = "/Dell/Dell4/kongjh/mRNA_looping_2_bigrange/"
#ftitle_2 = ["eIF4B","eIF5","eIF5B"]
#ftitle_2 = ["FS"]
# ftitle_2 = ["FS3"]
#ftitle_3 = ["1_ribo","2_ribo","3_ribo"]
ftitle_3 = ["1_mrna","2_mrna","3_mrna"]
# ftitle_3 = ["1_ribo","2_ribo","3_ribo","1_mrna","2_mrna","3_mrna"]
ftitle_4 = "_final.txt"
outftitl_1 = "/Dell/Dell4/kongjh/rstudio/mRNA_looping/Factors/tmp/"
# outftitl_1 = "/Dell/Dell4/kongjh/rstudio/mRNA_looping/Factors_bigrange/tmp/"
# a=0 ; aa = 0
for a in range(0,6):# 1多少个factors
	for aa in range(0,3):#3  6  一共多少个样品
		file1 = ftitle_1+ftitle_2[a]+"/"+ftitle_3[aa]+"/"+ftitle_3[aa]+ftitle_4
		file2 = outftitl_1+ftitle_2[a]+"/"+"tmp1_"+ftitle_3[aa]+".txt"
		getOrignfile(file1,file2)
		print(ftitle_2[a],ftitle_3[aa])

##################################################################################### 
################# 算那个 distance start 和 stop 以及 p5 以及 p3  以及 提取 基因reads
## 从基因组提取每条染色体的序列 ,返回一个seq的字典 （用来提取 基因 reads）
import csv
from itertools import islice
fa_file = "/Dell/Dell4/kongjh/gene-reference/ensemble/index/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.fa"
with open(fa_file,"r") as f:
	sequence={} 
	f = csv.reader(f, delimiter = '\t') 
	for line in islice(f,0,None):
            # print(line)
            # break     
      # ['>XI dna:chromosome chromosome:R64-1-1:XI:1:666816:1 REF']       
		if line[0][0] == ">":
			chr_id=line[0].replace('>','').split(" ")[0] #提取 染色体 编号
			sequence[chr_id]=''
		else:
			sequence[chr_id] += line[0]#.replace('\n','')
# sequence['XI'][0:100]
# sequence['Mito'][0:100]               

####先把gene_id - position 对应起来 ## 把 gene_position 弄成 字典 star 和 stop
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# 这一步的 key 直接就决定了 哪些 gene 的 reads 不要 
import csv
from itertools import islice
file3 = "/Dell/Dell4/kongjh/rstudio/genomic_position.csv"
with open (file3, 'r') as f3:
	f3 = csv.reader(f3, delimiter = ',')  
	key = []
	value_start = []
	value_stop = []
	for i in islice(f3,1,None):
#            print(i)
#            break
#      ['IV', 'YDL248W', '1802', '+', '2951']
		key.append(i[1])
		value_start.append(int(i[2]))
		value_stop.append(int(i[4]))
	start_position = dict(zip(key,value_start))
	stop_position = dict(zip(key,value_stop))
#start_position['YDL238C']
#stop_position["YDL238C"]
# stop_position["Q0010"]    
################################################################
###################################################################
############## 计算 
def getFinalfile(file4,file5):
	import csv
	from itertools import islice
	with open(file5,'w',newline = '') as f5:
		f5 = csv.writer(f5,delimiter = '\t')
		f5.writerow(["read_id","chr","gene_id", "map_position","polar","length","p5", "p3","frame","gene_read","pp5","pp3"])
		with open (file4,'r',newline = '') as f4:
			f4 = csv.reader(f4, delimiter = '\t')  
			for i in islice(f4,1,None):
#                        print(i)
#                        break
#['HWI-7001446:609:C8A38ANXX:4:1101:2041:2236', 'V', 'YEL065W', '28560', '0', '29']
				if i[2] in key : ## 这一步就排除了  __no_feature	
#                              __ambiguous __too_low_aQual __not_aligned __alignment_not_unique	 这些，还包括一些 没有 orf length 的 gene
##                  # 这一步的 key 直接就决定了 哪些 gene 的 reads 不要  
					if i[4] == "0":
						p5 = int(i[3]) - start_position[i[2]]
						p3 = p5 + int(i[5]) - 1 
						gene_read = sequence[i[1]][int(i[3]) -1: int(i[3]) + int(i[5]) -1]
      #                              print(gene_read1[3,5])
      #                              break
#                                   frame 需要分 正负考虑 ，即考虑在 reads p5在ATG前面还是在 ATG 后面 是不一样的
						if p5 >= 0 :
							fra = p5%3
						else:
							fra = abs((abs(p5) +2)%3 -2) 
								# 下面是 stop 的
						pp5 = int(i[3]) - stop_position[i[2]]
						pp3 = pp5 + int(i[5]) - 1 
  #                              print(gene_read1[3,5])
  #                              break
						f5.writerow([i[0],i[1],i[2],i[3],i[4],i[5],p5,p3,fra,gene_read,pp5,pp3])
					elif i[4] == "16":
						p3 = start_position[i[2]] - int(i[3])
						p5 = p3 - int(i[5]) + 1
						gene_read = sequence[i[1]][int(i[3]) -1: int(i[3]) + int(i[5])-1]
						gene_read2 = rev(gene_read)
#                                   frame 需要分 正负考虑 
						if p5 >= 0 :
							fra = p5%3
						else:
							fra = abs((abs(p5) +2)%3 -2) 
								# 下面是 stop 的
						pp3 = stop_position[i[2]] - int(i[3])
						pp5 = pp3 - int(i[5]) + 1
						f5.writerow([i[0],i[1],i[2],i[3],i[4],i[5],p5,p3,fra,gene_read2,pp5,pp3])
  #                        else:
  #                              f5.writerow([i[0],i[1],i[2],i[3],i[4],i[5],i[6],"NA","NAA"])


# i = 1
# file4list = ["/Dell/Dell4/kongjh/tmp_0312/new_FS_1_ribo_final.csv","/Dell/Dell4/kongjh/tmp_0312/new_FS_2_ribo_final.csv","/Dell/Dell4/kongjh/tmp_0312/new_FS_3_ribo_final.csv","/Dell/Dell4/kongjh/tmp_0312/new_FS_1_mrna_final.csv","/Dell/Dell4/kongjh/tmp_0312/new_FS_2_mrna_final.csv","/Dell/Dell4/kongjh/tmp_0312/new_FS_3_mrna_final.csv"]
# file5list = ["/Dell/Dell4/kongjh/rstudio/mrna_looped/Factors/FS/last_FS_1_ribo_final.csv","/Dell/Dell4/kongjh/rstudio/mrna_looped/Factors/FS/last_FS_2_ribo_final.csv","/Dell/Dell4/kongjh/rstudio/mrna_looped/Factors/FS/last_FS_3_ribo_final.csv","/Dell/Dell4/kongjh/rstudio/mrna_looped/Factors/FS/last_FS_1_mrna_final.csv","/Dell/Dell4/kongjh/rstudio/mrna_looped/Factors/FS/last_FS_2_mrna_final.csv","/Dell/Dell4/kongjh/rstudio/mrna_looped/Factors/FS/last_FS_3_mrna_final.csv"]
# # 需要加个 sinagle 知道已经完成几个了！！！！！！！！
# for file4,file5 in zip(file4list,file5list):
#       getFinalfile(file4,file5)
#       # print(i)
#       # i = i+1

# ssu
#file4='/Dell/Dell4/kongjh/rstudio/leaky_version/ssu_40s/tmp1_40s_ssu.txt'
#file5='/Dell/Dell4/kongjh/rstudio/leaky_version/ssu_40s/final_40s_ssu.txt'
#getFinalfile(file4,file5)
# rs
#file4='/Dell/Dell4/kongjh/rstudio/leaky_version/ssu_40s/tmp1_40s_ssu.txt'
#file5='/Dell/Dell4/kongjh/rstudio/leaky_version/ssu_40s/final_40s_ssu.txt'
#getFinalfile(file4,file5)
# # mrna
# file4='/Dell/Dell4/kongjh/rstudio/leaky_version/ssu_40s/tmp1_mrna_ssu.txt'
# file5='/Dell/Dell4/kongjh/rstudio/leaky_version/ssu_40s/final_mrna_ssu.txt'
# getFinalfile(file4,file5)

# 针对 1次重复的
# i = 1
# file4list = ["G:\\new_HO_1_ribo_final.csv"]
# file5list = ["G:\\last_HO_1_ribo_final.csv"]
# # 需要加个 sinagle 知道已经完成几个了！！！！！！！！
# for file4,file5 in zip(file4list,file5list):
#       getFinalfile(file4,file5)
#       print(i)
#       i = i+1

# # 针对 3次重复的
# 先创建文件夹
outftitl_1 = "/Dell/Dell4/kongjh/rstudio/mRNA_looping/Factors/tmp/"
# outftitl_1 = "/Dell/Dell4/kongjh/rstudio/mRNA_looping/Factors_bigrange/tmp/"
ftitle_2 = ["eIF1","eIF1A","eIF4A","eIF4B","eIF5","eIF5B"]
#ftitle_2 = ["wt","ho","OE","FS","eIF4E","eIF4G1","CAF20","EAP1","PAB1"]
#ftitle_2 = ["eIF4B","eIF5","eIF5B"]
#ftitle_2 = ["FS"]
# ftitle_2 = ["FS3"]
#ftitle_3 = ["1_ribo","2_ribo","3_ribo"]
ftitle_3 = ["1_mrna","2_mrna","3_mrna"]
# ftitle_3 = ["1_ribo","2_ribo","3_ribo","1_mrna","2_mrna","3_mrna"]

lastftitle_1 = "/Dell/Dell4/kongjh/rstudio/mRNA_looping/Factors/"
# lastftitle_1 = "/Dell/Dell4/kongjh/rstudio/mRNA_looping/Factors_bigrange/"
# a=0 ; aa = 0
for a in range(0,6):# 1 多少个factors
	for aa in range(0,3): #3  6  一共多少个样品
		file4 = outftitl_1+ftitle_2[a]+"/"+"tmp1_"+ftitle_3[aa]+".txt"
		file5 = lastftitle_1+ftitle_2[a]+"/"+"last_"+ftitle_3[aa]+".txt"
		getFinalfile(file4,file5)
		print(ftitle_2[a],ftitle_3[aa])

#######################
# ssu analyse 比较重复序列 score 那里
# import csv
# from itertools import islice
# file00 = "G:\\40s\\score_reads.csv"
# file01 = "G:\\40s\\gene_position.csv"
# with open (file00,'r',newline = '') as f1:
#	f1 = csv.reader(f1,delimiter = ',')
# #      gene_position.writerow(["chr", "gene_id","start_codon", "W/c"])
# #      with open (file1, 'r') as gft:
# #            gftfile = csv.reader(gft, delimiter = '\t')          
#       for i in islice(f1,1,None):
#                   print(i)
#                   break




