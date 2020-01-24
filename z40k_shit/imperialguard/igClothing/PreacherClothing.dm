
/obj/item/clothing/suit/armor/iguard/preacherrobe
	name = "preacher robe"
	desc = "An armored coat reinforced with ceramic plates and pauldrons to provide additional protection whilst still offering maximum mobility and flexibility. Issued only to the imperium's finest."
	icon_state = "preacher_robe" //Check: Its there
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS
	heat_conductivity = SPACESUIT_HEAT_CONDUCTIVITY
	armor = list(melee = 65, bullet = 50, laser = 50,energy = 25, bomb = 50, bio = 100, rad = 50)
	var/is_hooded = 0
	var/nohood = 0
	var/obj/item/clothing/head/iguard/preacherhood/hood
	actions_types = list(/datum/action/item_action/toggle_hood)

/obj/item/clothing/suit/armor/iguard/preacherrobe/New()
	if(!nohood)
		hood = new(src)
	else
		actions_types = null

	..()

/obj/item/clothing/head/iguard/preacherhood
	name = "robe hood"
	desc = "A hood attached to a heavy robe."
	icon_state = "phood"
	body_parts_covered = HIDEHEADHAIR
	heat_conductivity = SNOWGEAR_HEAT_CONDUCTIVITY
	var/obj/item/clothing/suit/armor/iguard/preacherrobe/robe

/obj/item/clothing/head/iguard/preacherhood/New(var/obj/item/clothing/suit/armor/iguard/preacherrobe/wc)
	..()
	if(istype(wc))
		robe = wc
	else if(!robe)
		qdel(src)



/obj/item/clothing/suit/storage/wintercoat
