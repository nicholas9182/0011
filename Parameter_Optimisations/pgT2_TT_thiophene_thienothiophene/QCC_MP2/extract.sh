rm pg2T_TT.txt
for i in $(seq -175 5 180)
do
	a=$(grep "SCF Done:  E(RHF)" pgT2_TT_$i.log | awk '{print $5}' | tail -1)
	echo "$i $a" >> pg2T_TT.txt
done
