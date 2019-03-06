#! /bin/python
#this is a way, based on the regex regular; but i do not use this way, i use th other way to get the variants:base on location(see shell file)
import csv
import re
inputfile="/Dell/Dell4/kongjh/tesss/dna_seq.fastq"
outfile = "/Dell/Dell4/kongjh/tesss/dna_var.csv"
bar_5=["ATCACG","CGATGT","TTAGGC","TGACCA","ACAGTG","GCCAAT"]
bar_3=["ATCACG","CGATGT","TTAGGC","TGACCA","ACAGTG","GCCAAT"]
wt=[]
for i in range(1,7):
#      print(i) # 1,2,3,4,5,6     
      with open(inputfile) as temp:
            for line in temp:
#                  print(line)
#                  break
#      break
                  str = re.compile(r''+bar_5[i-1]+'CCTCTATACTTTAACGTCAAGG[AGCT]{13}ATG[AGCT]{5}TCGACGGATCCCCGGGTTAATTAACA'+bar_3[i-1]+'')
                  variants = re.findall(str,line)
                  #判断是否为空 
                  if len(variants) != 0:
                        wt.append(variants[0])
print("wt length = " + len(wt))
#print("wt length = ", len(wt))
with open (outfile,'w',newline = '') as f:
            var = csv.writer(f,delimiter = ',')
            for i in wt:
                  var.writerow([i])
print("var length = " + len(var))


