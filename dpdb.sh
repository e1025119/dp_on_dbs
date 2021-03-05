#! /bin/bash
./initdb_cluster.sh
python convertCNF2Gr.py $1
IFS='.'
read -ra IN <<< $1
IFS=' '
inGR=$PWD/${IN[0]}.gr
cd ../project-cs-20
python main.py -comp -g $inGR
cd ../dp_on_dbs
cp "$PWD/../project-cs-20/tree_decompositions/${IN[0]}/best"/* ${IN[0]}.td
echo dpdb.py - old version, CNF only: done
printf "####################\n" >> output_dpdb.txt
printf "old version $1\n" >> output_dpdb.txt
printf "#------------------#\n" >> output_dpdb.txt
python dpdb.py -f $1 SharpSat 2>> output_dpdb.txt
printf "#------------------#\n" >> output_dpdb.txt
echo new_dpdb.py - new version, CNF \& TD: done
printf "####################\n" >> output_dpdb.txt
printf "new version $1\n" >> output_dpdb.txt
printf "#------------------#\n" >> output_dpdb.txt
python new_dpdb.py -cnf $1 -ptd ${IN[0]}.td SharpSat 2>> output_dpdb.txt
printf "#------------------#\n" >> output_dpdb.txt
rm ${IN[0]}.td
rm ${IN[0]}.gr
rm ${IN[0]}.bliss
