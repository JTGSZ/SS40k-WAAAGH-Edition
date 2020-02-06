//Within is all of the ork equipment, I figured it'd be easier to just pool it here.
//Since after-all we can do whatever we wish ya know? If its that bad it can be moved later.
//The mob icon path for orks is located in 40kSpecies.dm. Mob being what appears when it is worn
// -Love JTGSZ

//Heres all of the parents.
/obj/item/clothing/gloves/ork //Parent of the children afterwards, inherits from these paths.
	icon = 'z40k_shit/icons/obj/orks/orkarmorandclothesOBJ.dmi' //Object Icon Path, what appears when dropped.
	species_restricted = list("Ork", "Ork Nob") //Only orks can wear ork stuff for now at least.
	species_fit = list("Ork", "Ork Nob") //We insure it checks to fit for the species icon.
/obj/item/clothing/head/ork
	icon = 'z40k_shit/icons/obj/orks/orkarmorandclothesOBJ.dmi'
	species_restricted = list("Ork", "Ork Nob")
	species_fit = list("Ork", "Ork Nob") 
/obj/item/clothing/suit/armor/ork
	icon = 'z40k_shit/icons/obj/orks/orkarmorandclothesOBJ.dmi'
	species_restricted = list("Ork", "Ork Nob")
	species_fit = list("Ork", "Ork Nob") 
/obj/item/clothing/shoes/ork
	icon = 'z40k_shit/icons/obj/orks/orkarmorandclothesOBJ.dmi'
	species_restricted = list("Ork", "Ork Nob", "Ork Warboss")
	species_fit = list("Ork", "Ork Nob", "Ork Warboss") 
/obj/item/clothing/under/ork
	icon = 'z40k_shit/icons/obj/orks/orkarmorandclothesOBJ.dmi'
	species_restricted = list("Ork", "Ork Nob")
	species_fit = list("Ork", "Ork Nob") 
/obj/item/weapon/storage/belt/ork
	icon = 'z40k_shit/icons/obj/orks/orkarmorandclothesOBJ.dmi'
	species_fit = list("Ork", "Ork Nob", "Ork Warboss") 
/obj/item/weapon/storage/backpack/ork
	icon = 'z40k_shit/icons/obj/orks/orkarmorandclothesOBJ.dmi'
	species_fit = list("Ork", "Ork Nob", "Ork Warboss") 


