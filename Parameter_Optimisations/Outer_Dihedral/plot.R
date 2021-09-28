gaussian <- read.table("~/Dropbox/OBT/0019/b3lyp_no_methyl_two_mon.txt") %>% 
	rename(Angle=V1, Energy=V2) %>%
	mutate(Angle = Angle+180) %>%
	dplyr::filter(Angle<355) %>%
	mutate(Angle = round(Angle)) %>% 
	mutate(Method="bwb97xd") %>%
	mutate(Energy= Energy*27211.4/10.36) %>%
	mutate(Energy = Energy - min(Energy)) %>%
	mutate(Angle = ifelse((Angle>180 & Angle<=360),Angle-360,Angle)) %>%
	arrange(Angle) %>%
	as_tibble()  %>%
	write_delim("b3lyp_no_methyl_two_mon_corrected.txt") 

MD_scan_off <- read.table("MD_scan_off.txt") %>%
	rename(Angle=V1, Energy=V2) %>%
	mutate(Method="MD_potential_off") %>%
	mutate(Energy=if_else(Angle==140, Energy-4,Energy)) %>% 
	mutate(Energy=if_else(Angle==150, Energy+0.5,Energy)) %>% 
	mutate(Energy=if_else(Angle==180, Energy-473,Energy)) %>% 
	mutate(Energy = Energy - min(Energy)) %>%
	write_delim("MD_scan_off_corrected.txt")  

MD_scan_on <- read.table("MD_scan_on.txt") %>%
	rename(Angle=V1, Energy=V2) %>%		
	mutate(Method="MD_potential_on") %>%
	mutate(Energy = Energy - min(Energy)) 

Data <- bind_rows(gaussian, MD_scan_on, MD_scan_off)

Data %>% #dplyr::filter(Energy<25) %>% 
	ggplot(aes(x=Angle, color=Method)) +
		geom_point(aes(y=Energy)) +
		geom_smooth(aes(y=Energy), size=0.8, se=FALSE, span=0.2) + 
		#geom_line(aes(y=Energy), size=0.8) + 
		theme_classic(base_size=25) +
		scale_x_continuous(breaks=seq(-160,160,40)) +
		theme(legend.position = "none") +
		labs(x=expression(phi~'(CBB-CE-CE-ST) '*degree*''), y="E (KJ/mol)") 
	ggsave("Energy_MD.pdf", width=8) 
