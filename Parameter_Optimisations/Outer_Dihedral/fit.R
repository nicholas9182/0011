
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
		start=list(C0=0,C1=300,C2=-30,C3=0,C4=10,C5=10), 
		data=D,
		weights=abs((1/(Angle+0.0001))),
		nls.control(maxiter=1000)) 
}

gaussian <- read.table("b3lyp_no_methyl_two_mon_corrected.txt", header=TRUE) %>% as_tibble() %>% 
	rename(Energy_w = Energy) %>% print(n=50) 

MD_scan_off <- read.table("MD_scan_off_corrected.txt", header=TRUE) %>%
	as_tibble() %>%
	rename(Energy_MD_off = Energy) %>%
	arrange(Angle) %>% print()

MD_scan_on <- read.table("MD_scan_on.txt") %>%
	as_tibble() %>% 
	rename(Angle=V1, Energy=V2) %>%
	mutate(Method="MD_potential_on") %>%
	mutate(Energy = Energy - min(Energy)) %>%
	rename(Energy_MD_on = Energy) %>% 
	arrange(Angle) 

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
	mutate(Energy_w = gaussian$Energy_w) %>%
	mutate(Energy = Energy_w - Energy_MD_off ) %>%
	select(Angle, Energy) %>%	
	mutate(Energy = Energy - min(Energy)) %>%
	RB_fit(.)



	
