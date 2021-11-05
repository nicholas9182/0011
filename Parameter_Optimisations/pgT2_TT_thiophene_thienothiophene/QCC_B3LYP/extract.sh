rm pBTTT.txt
for i in $(seq -175 5 180)
do
	a=$(grep "SCF Done:  E(RB3LYP)" pg2T_TT_$i.log | awk '{print $5}' | tail -1)
	echo "$i $a" >> pg2T_TT.txt
done
