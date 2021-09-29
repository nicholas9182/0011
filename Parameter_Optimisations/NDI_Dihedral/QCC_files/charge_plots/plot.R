read.table("charges.txt") %>% as_tibble() %>% 
	rename(AtomName=V1, Element=V2, Charge=V3, x=V4, y=V5, z=V6) %>%
	mutate(radius = if_else(Element=="H", 0.54, NaN) ) %>%
	mutate(radius = if_else(Element=="N", 1.50, radius) ) %>%
	mutate(radius = if_else(Element=="C", 1.7, radius) ) %>%
	mutate(radius = if_else(Element=="O", 1.52, radius) ) %>%
	mutate(radius = if_else(Element=="S", 1.84, radius) ) %>%
       	ggplot(aes(x=x,y=y,color=Charge, size=radius)) +
		geom_point() +
		scale_color_gradient2(
				      low="blue",
				      mid="lightgreen",
				      high="red",
				      limits=c(-0.65,0.65)
			      ) +
		scale_radius(limits=c(0,2.25), range=c(0,12)) +
		coord_fixed() +
		stripped(Base=20) +
		xlim(-9,9) +
		ylim(-9,9) +
		guides(size=FALSE) +
		geom_text(aes(label=Element), color="white", size=3)
	ggsave("charges.png")

read.table("charges2.txt") %>% as_tibble() %>% 
	rename(AtomName=V1, Element=V2, Charge=V3, x=V4, y=V5, z=V6) %>%
	mutate(radius = if_else(Element=="H", 0.54, NaN) ) %>%
	mutate(radius = if_else(Element=="N", 1.50, radius) ) %>%
	mutate(radius = if_else(Element=="C", 1.7, radius) ) %>%
	mutate(radius = if_else(Element=="O", 1.52, radius) ) %>%
	mutate(radius = if_else(Element=="S", 1.84, radius) ) %>%
       	ggplot(aes(x=x,y=y,color=Charge, size=radius)) +
		geom_point() +
		scale_color_gradient2(
				      low="blue",
				      mid="lightgreen",
				      high="red",
				      limits=c(-0.65,0.65)
			      ) +
		scale_radius(limits=c(0,2.25), range=c(0,18)) +
		coord_fixed() +
		stripped(Base=20) +
		xlim(-6,6) +
		ylim(4,13) +
		guides(size=FALSE) +
		geom_text(aes(label=Element), color="white", size=3)
	ggsave("charges_bithiophene.png")
