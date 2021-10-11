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

}

#make_and_em gly14_T.pdb gly14_T g14T
#make_and_em met14_T.pdb met14_T m14T
#make_and_em eth14_T.pdb eth14_T e14T
#make_and_em pro14_T.pdb pro14_T p14T
#make_and_em but14_T.pdb but14_T b14T
#make_and_em pen14_T.pdb pen14_T p14T
#make_and_em hex14_T.pdb hex14_T h14T
#
#make_and_em gly14_TT.pdb gly14_TT g14TT
#make_and_em met14_TT.pdb met14_TT m14TT
#make_and_em eth14_TT.pdb eth14_TT e14TT
#make_and_em pro14_TT.pdb pro14_TT p14TT
#make_and_em but14_TT.pdb but14_TT b14TT
#make_and_em pen14_TT.pdb pen14_TT p14TT
make_and_em hex14_TT.pdb hex14_TT h14TT

#make_and_em gly14_T_inverted.pdb gly14_T_inverted g14T
#make_and_em met14_T_inverted.pdb met14_T_inverted m14T
#make_and_em eth14_T_inverted.pdb eth14_T_inverted e14T
#make_and_em pro14_T_inverted.pdb pro14_T_inverted p14T
#make_and_em but14_T_inverted.pdb but14_T_inverted b14T
#make_and_em pen14_T_inverted.pdb pen14_T_inverted p14T
#make_and_em hex14_T_inverted.pdb hex14_T_inverted h14T
#make_and_em hep14_T_inverted.pdb hep14_T_inverted h14T

#make_and_em gly14_TT_inverted.pdb gly14_TT_inverted g14TT
#make_and_em met14_TT_inverted.pdb met14_TT_inverted m14TT
#make_and_em eth14_TT_inverted.pdb eth14_TT_inverted e14TT
#make_and_em pro14_TT_inverted.pdb pro14_TT_inverted p14TT
#make_and_em but14_TT_inverted.pdb but14_TT_inverted b14TT
#make_and_em pen14_TT_inverted.pdb pen14_TT_inverted p14TT
#make_and_em hex14_TT_inverted.pdb hex14_TT_inverted h14TT
#make_and_em hep14_TT_inverted.pdb hep14_TT_inverted h14TT








