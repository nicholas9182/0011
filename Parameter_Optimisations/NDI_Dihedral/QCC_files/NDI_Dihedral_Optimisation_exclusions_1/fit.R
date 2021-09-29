library('pracma')


RB <- function(C0,C1,C2,C3,C4,C5,Angle){
	V <-    C0*cos(Angle*0.0174533)^0 + 
		-C1*cos(Angle*0.0174533)^1 + 
		C2*cos(Angle*0.0174533)^2 + 
		-C3*cos(Angle*0.0174533)^3 + 
		C4*cos(Angle*0.0174533)^4 + 
		-C5*cos(Angle*0.0174533)^5
	return(V)
}

RB_fit <- function(D) {
	nls(Difference~RB(C0,C1,C2,C3,C4,C5,Angle), 
		start=list(C0=0,C1=0,C2=0,C3=0,C4=0,C5=0), 
#		weights=(1/(abs(Angle)+0.001)),
#		weights=( boltz_invert_kjmol(Angle, Difference)  ),
		data=D
	) 
}

gaussian <- read.table("~/Dropbox/OBT/0060/NDI_Dihedral_scan_b3lyp_methyl_hd/NDI_modified.txt", header=FALSE) %>% 
	as_tibble() %>% 
	rename(Angle=V1, Energy=V2) %>%
	mutate(Energy= Energy*27211.4/10.36) %>%
	mutate(Energy = Energy - min(Energy)) %>%
	mutate(Method = "Gaussian") %>%
	dplyr::filter(Angle < 180) %>%
        group_by(Method) %>% 	
	nest() 

MD_scan_off <- read.table("MD_scan_off.txt", header=FALSE) %>%
	rename(Angle=V1, Energy=V2) %>%
	mutate(Method="MD_potential_off") %>%
	mutate(Energy = Energy - min(Energy) ) %>%
	as_tibble() %>%
	arrange(Angle) %>% 
	dplyr::filter(Angle < 180) %>% 
        group_by(Method) %>% 	
	nest()

MD_scan_on <- read.table("MD_scan_on.txt") %>%
	as_tibble() %>% 
	rename(Angle=V1, Energy=V2) %>%
	mutate(Method="MD_potential_on") %>%
	mutate(Energy = Energy - min(Energy) ) %>%
	arrange(Angle) %>%
	dplyr::filter(Angle < 180) %>% 
        group_by(Method) %>% 	
	nest() 

data <- rbind(gaussian, MD_scan_off) %>%
	unnest() %>% 
	spread(Method, Energy) %>% 
	drop_na() %>% 
	mutate(Difference = Gaussian - MD_potential_off) %>% print(n=200) %>%
	mutate(fit = predict(RB_fit(.))) %>%
	gather(Method, Energy, Gaussian:Difference) %>% print(n=200)

data %>%
	ggplot(aes(x=Angle , y=Energy, color=Method)) + 
		geom_point() +
	        geom_point(aes(y=fit), color="black") +	
	        geom_line(aes(y=fit), color="black") +	
		geom_line() +
		theme_classic()
	ggsave("Difference.pdf", width=12)

rbind(gaussian, MD_scan_off) %>%
	unnest() %>% 
	spread(Method, Energy) %>% 
	drop_na() %>% 
	mutate(Difference = Gaussian - MD_potential_off) %>%
	select(Angle, Difference) %>% 
	RB_fit(.)

