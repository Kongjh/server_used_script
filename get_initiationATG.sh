grep -A17 "^>" orf_genomic_1000.fasta > temp1_A17.fasta
sed '/^--/'d temp1_A17.fasta > sed_temp1_A17.fasta
awk '!(NR%18)' sed_temp1_A17.fasta > awk17_sed.fasta
cat awk17_sed.fasta | cut -c 28-48 > cut_awk.csv
awk -F ":" '{print $1}' gene_infor.fasta > gene_list.csv
awk -F ":" '{print $2}' gene_infor.fasta > rest_of_gene_list.csv
awk -F "," '{print $1}'  rest_of_gene_list.csv > SGDID_list.csv
paste -d ';' gene_list.csv cut_awk.csv SGDID_list.csv > vertified_ORF.csv
wc -l temp1_A17.fasta sed_temp1_A17.fasta awk17_sed.fasta cut_awk.csv gene_list.csv vertified_ORF.csv SGDID_list.csv rest_of_gene_list.csv
