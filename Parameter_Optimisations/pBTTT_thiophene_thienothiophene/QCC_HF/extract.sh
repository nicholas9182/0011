rm pBTTT.txt
for i in $(seq -175 5 180)
do
	a=$(grep "SCF Done:  E(RHF)" pBTTT_$i.log | awk '{print $5}' | tail -1)
	echo "$i $a" >> pBTTT.txt
done
