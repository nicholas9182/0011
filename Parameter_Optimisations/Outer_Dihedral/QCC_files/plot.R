

b3lyp_no_methyl_full <- read.table("b3lyp_no_methyl_two_mon.txt") %>%
	rename(Angle=V1, Energy=V2) %>%
	mutate(Angle = round(Angle)) %>%
	mutate(Functional="B3LYP") %>%
	mutate(Sidechain="Proton") %>%
	mutate(Monomers="Two Full") %>%
	mutate(Energy= Energy*27211.4/10.36) %>%
	mutate(Energy = Energy - min(Energy)) %>%
	mutate(Angle = Angle+180) %>%
	dplyr::filter(Angle<355) %>%
	mutate(Angle = ifelse((Angle>180 & Angle<=360),Angle-360,Angle)) %>%
	arrange(Angle)

xb97xdp_no_methyl_full <- read.table("wb97xd_no_methyl_two_mon.txt") %>%
	rename(Angle=V1, Energy=V2) %>%
	mutate(Angle = round(Angle)) %>%
	mutate(Functional="wb97xd") %>%
	mutate(Sidechain="Proton") %>%
	mutate(Monomers="Two Full") %>%
	mutate(Energy= Energy*27211.4/10.36) %>%
	mutate(Energy = Energy - min(Energy)) %>%
	dplyr::filter(Angle<355) %>%
	mutate(Angle = ifelse((Angle>180 & Angle<=360),Angle-360,Angle)) %>%
	arrange(Angle)

b3lyp_with_methyl_full <- read.table("b3lyp_with_methyl_two_mon.txt") %>%
	rename(Angle=V1, Energy=V2) %>%
	mutate(Angle = round(Angle)) %>%
	mutate(Functional="B3LYP") %>%
	mutate(Sidechain="Methyl") %>%
	mutate(Monomers="Two Full") %>%
	mutate(Energy= Energy*27211.4/10.36) %>%
	mutate(Energy = Energy - min(Energy)) %>%
	mutate(Angle = ifelse((Angle>180 & Angle<=360),Angle-360,Angle)) %>%
	arrange(Angle)

wb97xd_with_methyl_full <- read.table("wb97xd_with_methyl_two_mon.txt") %>%
	rename(Angle=V1, Energy=V2) %>%
	mutate(Angle = round(Angle)) %>%
	mutate(Functional="wb97xd") %>%
	mutate(Sidechain="Methyl") %>%
	mutate(Monomers="Two Full") %>%
	mutate(Energy= Energy*27211.4/10.36) %>%
	mutate(Energy = Energy - min(Energy)) %>%
	mutate(Angle = ifelse((Angle>180 & Angle<=360),Angle-360,Angle)) %>%
	arrange(Angle)


b3lyp_no_methyl_half <- read.table("b3lyp_no_methyl_two_half_mon.txt") %>%
	rename(Angle=V1, Energy=V2) %>%
	mutate(Angle = round(Angle)) %>%
	mutate(Angle = Angle+180) %>%
	mutate(Functional="B3LYP") %>%
	mutate(Monomers="Two Half") %>%
	mutate(Sidechain="Proton") %>%
	mutate(Energy= Energy*27211.4/10.36) %>%
	mutate(Energy = Energy - min(Energy)) %>%
	mutate(Angle = ifelse((Angle > 180),Angle-360,Angle)) %>%
	arrange(Angle)

wb97xdp_no_methyl_half <- read.table("wb97xd_no_methyl_two_half_mon_hd.txt") %>%
	rename(Angle=V1, Energy=V2) %>%
	mutate(Angle = round(Angle)) %>%
	mutate(Functional="wb97xd") %>%
	mutate(Monomers="Two Half") %>%
	mutate(Sidechain="Proton") %>%
	mutate(Energy= Energy*27211.4/10.36) %>%
	mutate(Energy = Energy - min(Energy)) %>%
	arrange(Angle)

MP2_no_methyl_half <- read.table("../0024/MP2_no_methyl.txt") %>%
	rename(Angle=V1, Energy=V2) %>%
	mutate(Angle = round(Angle)) %>%
	mutate(Functional="MP2") %>%
	mutate(Sidechain="Proton") %>%
	mutate(Monomers="Two Half") %>%
	mutate(Energy= Energy*27211.4/10.36) %>%
	mutate(Energy = Energy - min(Energy)) %>%
	arrange(Angle)


MP2_no_methyl_half <- read.table("../0024/MP2_methyl.txt") %>%
	rename(Angle=V1, Energy=V2) %>%
	mutate(Angle = round(Angle)) %>%
	mutate(Functional="MP2") %>%
	mutate(Sidechain="Proton") %>%
	mutate(Monomers="Two Half") %>%
	mutate(Energy= Energy*27211.4/10.36) %>%
	mutate(Energy = Energy - min(Energy)) %>%
	arrange(Angle)

b3lyp_with_methyl_half <- read.table("b3lyp_with_methyl_two_half_mon.txt") %>%
	rename(Angle=V1, Energy=V2) %>%
	mutate(Angle = round(Angle)) %>%
	mutate(Angle = Angle+180) %>%
	mutate(Functional="B3LYP") %>%
	mutate(Sidechain="Methyl") %>%
	mutate(Monomers="Two Half") %>%
	mutate(Energy= Energy*27211.4/10.36) %>%
	mutate(Energy = Energy - min(Energy)) %>%
	mutate(Angle = ifelse((Angle > 180),Angle-360,Angle)) %>%
	arrange(Angle)

wb97xd_with_methyl_half <- read.table("wb97xd_with_methyl_two_half_mon.txt") %>%
	rename(Angle=V1, Energy=V2) %>%
	mutate(Angle = round(Angle)) %>%
	mutate(Angle = Angle-180) %>%
	mutate(Functional="wb97xd") %>%
	mutate(Sidechain="Methyl") %>%
	mutate(Monomers="Two Half") %>%
	mutate(Energy= Energy*27211.4/10.36) %>%
	mutate(Energy = Energy - min(Energy)) %>%
	mutate(Angle = ifelse((Angle < -180),Angle+360,Angle)) %>%
	arrange(Angle)

data <- bind_rows(
	b3lyp_no_methyl_full, xb97xdp_no_methyl_full, b3lyp_with_methyl_full, wb97xd_with_methyl_full, b3lyp_no_methyl_half, wb97xdp_no_methyl_half, MP2_no_methyl_half, b3lyp_with_methyl_half, wb97xd_with_methyl_half
) %>% as_tibble()

data %>% dplyr::filter(Functional=="wb97xd") %>%
	ggplot(aes(x=Angle, y=Energy, color=Monomers, shape=Sidechain)) + 
		geom_point(size=2) +
		geom_smooth(se=FALSE,span=0.15, size=0.5) +
		labs(x=expression('CBB-CE-CE-ST ('*degree*')'), y="E (KJ/mol)", subtitle="wb97xd") +
		scale_x_continuous(breaks=seq(-160,160,40)) +
	ggsave("Structure_effect_wb97xd.pdf", width=10)

data %>% dplyr::filter(Functional=="B3LYP") %>%
	ggplot(aes(x=Angle, y=Energy, color=Monomers, shape=Sidechain)) + 
		geom_point(size=2) +
		geom_smooth(se=FALSE,span=0.15, size=0.5) +
		labs(x=expression('CBB-CE-CE-ST ('*degree*')'), y="E (KJ/mol)", subtitle="b3lyp") +
		scale_x_continuous(breaks=seq(-160,160,40)) +
	ggsave("Structure_effect_b3lyp.pdf", width=10)

data %>% dplyr::filter(Sidechain=="None") %>%
	dplyr::filter(Monomers=="Two Full" | Functional=="MP2") %>%
	ggplot(aes(x=Angle, y=Energy, color=Functional)) + 
		geom_point(size=2) +
		geom_smooth(se=FALSE,span=0.22, size=0.5) +
		labs(x=expression('CBB-CE-CE-ST ('*degree*')'), y="E (KJ/mol)") +
		scale_x_continuous(breaks=seq(-160,160,40)) +
	ggsave("Functional_effect.pdf", width=10)



