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
	nls(Energy~RB(C0,C1,C2,C3,C4,C5,Angle), 
		start=list(C0=0,C1=0,C2=0,C3=0,C4=0,C5=0), 
		data=D,
		weights=(1/(abs(Angle^2)+0.001)),
		#weights=( boltz_invert(Angle, Energy)^2  ),
		nls.control(maxiter=1000)) 
}

gaussian <- read.table("~/Dropbox/OBT/0013/thiophene_dihedral/inner.txt", header=FALSE) %>% 
	as_tibble() %>% 
	rename(Angle=V1, Energy=V2) %>%
	mutate(Energy= Energy*27211.4/10.36) %>%
	mutate(Energy = Energy - min(Energy)) %>%
	rename(Energy_w = Energy) %>% 
	dplyr::filter(Angle < 180) %>% print(n=50) 

MD_scan_off <- read.table("MD_scan_off.txt", header=FALSE) %>%
	rename(Angle=V1, Energy=V2) %>%
	mutate(Method="MD_potential_off") %>%
	mutate(Energy = Energy - min(Energy) ) %>%
	as_tibble() %>%
	rename(Energy_MD_off = Energy) %>%
	arrange(Angle) %>% 
	dplyr::filter(Angle < 180) %>% print()

MD_scan_on <- read.table("MD_scan_on.txt") %>%
	as_tibble() %>% 
	rename(Angle=V1, Energy=V2) %>%
	mutate(Method="MD_potential_on") %>%
	mutate(Energy = Energy - min(Energy) ) %>%
	rename(Energy_MD_on = Energy) %>% 
	arrange(Angle) %>%
	dplyr::filter(Angle < 180) 

MD_scan_off %>%
	mutate(Energy_w = gaussian$Energy_w) %>%
	mutate(Energy = Energy_w - Energy_MD_off ) %>%
	mutate(Energy = Energy - min(Energy)) %>%
	mutate(fit = predict(RB_fit(.))) %>% 
	ggplot(aes(x=Angle , y=Energy)) + 
		geom_point() + 
		geom_line(aes(y=fit)) +
		geom_line(aes(y=Energy_w), color="green") +
		geom_line(aes(y=Energy_MD_off), color="red") +
		theme_classic()
	ggsave("Difference.pdf")

MD_scan_off %>%
	dplyr::filter(Angle < 180) %>%
	mutate(Energy_w = gaussian$Energy_w) %>%
	mutate(Energy = Energy_w - Energy_MD_off ) %>%
	select(Angle, Energy) %>%	
	mutate(Energy = Energy - min(Energy)) %>%
	RB_fit(.)



	
