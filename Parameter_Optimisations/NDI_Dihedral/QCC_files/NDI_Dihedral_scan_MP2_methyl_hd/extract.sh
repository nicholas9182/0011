rm NDI.txt
for i in $(seq -175 5 180)
do
	rm temp.txt
	grep "MP2=" NDI_$i.log >> temp.txt
	sed -i '' 's/=/      /g' temp.txt
	sed -i '' 's/NDI_/ /g' temp.txt
	sed -i '' 's/.log/ /g' temp.txt
	sed -i '' 's/\\RMSD/ /g' temp.txt
	b=$(awk '{print $4}' temp.txt)
	[ -z "$b" ] ||  echo $i $b >> NDI.txt 
done	
rm temp.txt
sed -i '' '/PG$/d' NDI.txt
