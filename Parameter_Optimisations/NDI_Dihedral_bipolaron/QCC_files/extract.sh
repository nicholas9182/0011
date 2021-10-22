rm NDI.txt
for i in $(seq -175 5 180)
do
	a=$(grep "SCF Done:  E(RB3LYP)" NDI_$i.log | awk '{print $5}' | tail -1)
	echo "$i $a" >> NDI.txt
done
