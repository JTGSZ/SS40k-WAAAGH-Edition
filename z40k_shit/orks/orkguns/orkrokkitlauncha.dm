/obj/item/weapon/gun/projectile/rocketlauncher/rokkitlauncha
	name = "rokkit launcha"
	desc = "Ranged explosions, science marches on."
	fire_sound = 'sound/weapons/rocket.ogg'
	icon = 'z40k_shit/icons/obj/orks/orkequipment.dmi'
	icon_state = "rokkit_launcha"
	item_state = "rokkit_launcha"
	inhand_states = list("left_hand" = 'z40k_shit/icons/inhands/LEFTIES/64x64rokkit_launcha_left.dmi', "right_hand" = 'z40k_shit/icons/inhands/RIGHTIES/64x64rokkit_launcha_right.dmi')
	max_shells = 1
	w_class = W_CLASS_LARGE
	starting_materials = list(MAT_IRON = 5000)
	w_type = RECYK_METAL
	force = 20
	recoil = 1 //The backblast isn't just decorative you know
	throw_speed = 4
	throw_range = 3
	fire_delay = 5
	flags = FPRINT
	siemens_coefficient = 1
	slot_flags = SLOT_BACK
	caliber = list(ORKROKKIT = 1)
	origin_tech = Tc_COMBAT + "=4;" + Tc_MATERIALS + "=2;" + Tc_SYNDICATE + "=2"
	ammo_type = "/obj/item/ammo_casing/rocket_rpg/rokkit"
	attack_verb = list("strikes", "hits", "bashes")
	gun_flags = 0

/obj/item/weapon/gun/projectile/rocketlauncher/isHandgun()
	return FALSE

/obj/item/weapon/gun/projectile/rocketlauncher/update_icon()
	if(!getAmmo())
		icon_state = "rokkit_launcha-e"
		item_state = "rokkit_launcha-e"
	else
		icon_state = "rokkit_launcha"
		item_state = "rokkit_launcha"

/obj/item/weapon/gun/projectile/rocketlauncher/rokkitlauncha/attack(mob/living/M as mob, mob/living/user as mob, def_zone)
	if(M == user && user.zone_sel.selecting == "mouth") //Are we trying to suicide by shooting our head off ?
		user.visible_message("<span class='warning'>[user] tries to fit \the [src] into \his mouth but quickly reconsiders it</span>", \
		"<span class='warning'>You try to fit \the [src] into your mouth. You feel silly and pull it out</span>")
		return // Nope
	..()

/obj/item/weapon/gun/projectile/rocketlauncher/rokkitlauncha/suicide_act(var/mob/user)
	if(!src.process_chambered()) //No rocket in the rocket launcher
		user.visible_message("<span class='danger'>[user] jams down \the [src]'s trigger before noticing it isn't loaded and starts bashing \his head in with it! It looks like \he's trying to commit suicide.</span>")
		return(SUICIDE_ACT_BRUTELOSS)
	else //Needed to get that shitty default suicide_act out of the way
		user.visible_message("<span class='danger'>[user] fiddles with \the [src]'s safeties and suddenly aims it at \his feet! It looks like \he's trying to commit suicide.</span>")
		spawn(10) //RUN YOU IDIOT, RUN
			explosion(src.loc, -1, 1, 4, 8)
			if(src) //Is the rocket launcher somehow still here ?
				qdel(src) //This never happened
			return(SUICIDE_ACT_BRUTELOSS)
	return

/obj/item/ammo_casing/rocket_rpg/rokkit
	name = "rokkit"
	desc = "Its a rocket missing the c, idiot."
	icon = 'z40k_shit/icons/obj/orks/orkbulletpilesandmags.dmi'
	icon_state = "rokkit"
	caliber = ORKROKKIT
	projectile_type = "/obj/item/projectile/rocket/rokkit"
	starting_materials = list(MAT_IRON = 15000)
	w_type = RECYK_METAL
	w_class = W_CLASS_MEDIUM // Rockets don't exactly fit in pockets and cardboard boxes last I heard, try your backpack
	shrapnel_amount = 4
	
/obj/item/ammo_casing/rocket_rpg/rokkit/update_icon()
	return

/obj/item/projectile/rocket/rokkit
	name = "rokkit"
	icon = 'z40k_shit/icons/obj/projectiles.dmi'
	icon_state = "rokkit"
	damage = 120
	stun = 10
	weaken = 10
	exdev 	= 1
	exheavy = 3
	exlight = 5
	exflash = 8
