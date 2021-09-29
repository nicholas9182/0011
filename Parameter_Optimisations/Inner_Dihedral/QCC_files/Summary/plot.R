b3lyp_no_methyl <- read.table("b3lyp_no_methyl.txt") %>%
	rename(Angle=V1, Energy=V2) %>%
	mutate(Angle = round(Angle)) %>%
	mutate(Functional="B3LYP") %>%
	mutate(Sidechain="Proton") %>%
	mutate(Energy= Energy*27211.4/10.36) %>%
	mutate(Energy = Energy - min(Energy)) %>%
	mutate(Angle = ifelse((Angle>180 & Angle<=360),Angle-360,Angle)) %>%
	arrange(Angle) %>%
	mutate(polymer="gT")

xb97xdp_no_methyl <- read.table("wb97xd_no_methyl.txt") %>%
	rename(Angle=V1, Energy=V2) %>%
	mutate(Angle = round(Angle)) %>%
	mutate(Functional="wb97xd") %>%
	mutate(Sidechain="Proton") %>%
	mutate(Energy= Energy*27211.4/10.36) %>%
	mutate(Energy = Energy - min(Energy)) %>%
	mutate(Angle = ifelse((Angle>180 & Angle<=360),Angle-360,Angle)) %>%
	arrange(Angle)%>%
	mutate(polymer="gT")

b3lyp_with_methyl <- read.table("b3lyp_with_methyl.txt") %>%
	rename(Angle=V1, Energy=V2) %>%
	mutate(Angle = round(Angle)) %>%
	mutate(Functional="B3LYP") %>%
	mutate(Sidechain="Methyl") %>%
	mutate(Energy= Energy*27211.4/10.36) %>%
	mutate(Energy = Energy - min(Energy)) %>%
	mutate(Angle = ifelse((Angle>180 & Angle<=360),Angle-360,Angle)) %>%
	arrange(Angle)%>%
	mutate(polymer="gT")

wb97xd_with_methyl <- read.table("wb97xd_with_methyl_indi.txt") %>%
	rename(Angle=V1, Energy=V2) %>%
	mutate(Angle = round(Angle)) %>%
	mutate(Functional="wb97xd") %>%
	mutate(Sidechain="Methyl") %>%
	mutate(Energy= Energy*27211.4/10.36) %>%
	mutate(Energy = Energy - min(Energy)) %>%
	mutate(Angle = ifelse((Angle>180 & Angle<=360),Angle-360,Angle)) %>%
	arrange(Angle)%>%
	mutate(polymer="gT")

 b3lyp_with_methyl_thiophene <- read.table("../Inner_scan_b3lyp_thiophene/inner.txt") %>%
	rename(Angle=V1, Energy=V2) %>%
	mutate(Functional="B3LYP") %>%
	mutate(Sidechain="Methyl") %>%
	mutate(Energy= Energy*27211.4/10.36) %>%
	mutate(Energy = Energy - min(Energy))%>%
	mutate(polymer="gT-T") 



 b3lyp_with_methyl_bithiophene <- read.table("../Inner_scan_b3lyp_bithiophene/inner.txt") %>%
	rename(Angle=V1, Energy=V2) %>%
	mutate(Functional="B3LYP") %>%
	mutate(Sidechain="Methyl") %>%
	mutate(Energy= Energy*27211.4/10.36) %>%
	mutate(Energy = Energy - min(Energy)) %>%
	mutate(polymer="gT-TT")

data <- bind_rows(b3lyp_no_methyl, xb97xdp_no_methyl, b3lyp_with_methyl, wb97xd_with_methyl) %>%
	dplyr::filter(Energy < 30) %>%
	ggplot(aes(x=Angle,y=Energy, color=Functional, shape=Sidechain, group=interaction(Functional,Sidechain))) +
		geom_point(size=3) +
		geom_line() +
		scale_x_continuous(breaks=seq(-160,160,40)) +
		labs(x="Angle , degrees", y="Energy , Kj/mol", subtitle="basis set - 6-311+g(d,p)")  
	ggsave("inner_dihedral_scans.pdf", width=10)


data <- bind_rows(b3lyp_with_methyl_thiophene, b3lyp_with_methyl_bithiophene, b3lyp_with_methyl) %>% as_tibble()  %>%
	ggplot(aes(x=Angle,y=Energy, color=polymer)) +
		geom_point(size=3) +
		geom_smooth(se=FALSE,span=0.25) +
		scale_x_continuous(breaks=seq(-160,160,40)) +
		labs(x="Angle , degrees", y="Energy , Kj/mol", subtitle="b3lyp/6-311+g(d,p)", color="")  
	ggsave("dihedral_scans_oligomers.pdf", width=10)

library('pracma')

normalise <- function(x,y, scale=1){
        Y <-scale*  y / trapz(x,y)
        return(Y)
}

data <- bind_rows(b3lyp_with_methyl) %>% 
	as_tibble() %>% 
	group_by(polymer) %>%
	mutate(p=exp((-Energy)/(2.478))) %>% 
	select(Angle, polymer, p) %>%  
	group_by(polymer) %>%
	mutate(p=normalise(Angle,p)) %>%
	ggplot(aes(x=Angle,y=p, color=polymer)) +
		geom_point(size=3) +
		geom_line() +
		scale_x_continuous(breaks=seq(-160,160,40)) +
		labs(x="Angle , degrees", y="P(E)", subtitle="b3lyp/6-311+g(d,p)", color="")  
	ggsave("dihedral_scans_oligomers_population.pdf", width=10)









