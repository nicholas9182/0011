source ~/.zshrc

make_and_em() {

        if [ -z "$*" ]
                then echo "Inputs - 1: pdb file , 2: itp name without extension , 3: resname in itp "
                return 1
        fi

	echo "DOING $1 $2 $3"

	gmx editconf -f pdb_files/$1 -o temp.gro -box 30 30 30 &> /dev/null && echo "made temp.gro" || return 1
	gmx pdb2gmx -f temp.gro -ff OBT &> /dev/null && echo "made pdb2gmx" || return 1
	top_itp topol.top $2 $3 &> /dev/null && echo "made itp" || return 1
	
	# make topol for test
	echo "#include \"OBT.ff/forcefield.itp\"" > test.top
	echo "#include \"$2.itp\"" >> test.top
	echo "" >> test.top
	echo "[ system ]" >> test.top
	echo "test" >> test.top
	echo "" >> test.top
	echo "[ molecules ]" >> test.top
	echo "$3           1" >> test.top

	gmx grompp -f EM.mdp -p test.top -c temp.gro -o test.tpr  &> /dev/null && echo "made tpr" || return 1
	gmx mdrun -s test.tpr -deffnm temp &> /dev/null && echo "made did EM run" || return 1
	gmx editconf -f temp.gro -o pdb_files/$1  &> /dev/null && echo "put back in pdb" || return 1
	mv $2.itp itp_files/  &> /dev/null  && echo "put back in itp" || return 1
	rm test* posre* conf.gro mdout* temp* topol.top

}

make_and_em gly12_TT.pdb gly12_TT g12TT
#make_and_em met12_TT.pdb met12_TT m12TT
#make_and_em eth12_TT.pdb eth12_TT e12TT
#make_and_em pro12_TT.pdb pro12_TT p12TT
#make_and_em but12_TT.pdb but12_TT b12TT
#make_and_em pen12_TT.pdb pen12_TT p12TT
#make_and_em hex12_TT.pdb hex12_TT h12TT
#
#make_and_em met12_TT_inverted.pdb met12_TT_inverted m12TT
#make_and_em eth12_TT_inverted.pdb eth12_TT_inverted e12TT
#make_and_em pro12_TT_inverted.pdb pro12_TT_inverted p12TT
#make_and_em but12_TT_inverted.pdb but12_TT_inverted b12TT
#make_and_em pen12_TT_inverted.pdb pen12_TT_inverted p12TT
#make_and_em hex12_TT_inverted.pdb hex12_TT_inverted h12TT
#make_and_em hep12_TT_inverted.pdb hep12_TT_inverted h12TT








