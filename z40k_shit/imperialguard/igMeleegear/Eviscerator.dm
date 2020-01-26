
/*
 * Eviscerator
 */
/obj/item/projectile/fire_breath/eviscerator //The fire projectile we will use, cap it to 4 turfs.
	fire_blast_type = /obj/effect/fire_blast/no_spread
	max_range = 4

/obj/item/weapon/gun/eviscerator
	name = "Eviscerator"
	desc = "A oversized chainsword. This one has a exterminator attached to it too."
	slot_flags = SLOT_BACK
	icon = 'z40k_shit/icons/obj/ig/IGequipment.dmi'
	inhand_states = list("left_hand" = 'z40k_shit/icons/inhands/LEFTIES/64x64eviscerator.dmi', "right_hand" = 'z40k_shit/icons/inhands/RIGHTIES/64x64eviscerator.dmi')
	icon_state = "eviscerator_off" 
	item_state = "eviscerator_off"
	throwforce = 35
	force = 50
	armor_penetration = 100
	throw_speed = 5
	throw_range = 10
	sharpness = 50
	sharpness_flags = SHARP_TIP | SHARP_BLADE | CHOPWOOD | CUT_WALL | CUT_AIRLOCK //it's a really sharp blade m'kay
	w_class = W_CLASS_LARGE
	flags = FPRINT | TWOHANDABLE | MUSTTWOHAND
	hitsound = 'z40k_shit/sounds/chainsword_evishit.ogg'
	fire_sound = null
	var/revvin_on = FALSE //Are we currently on?
	var/idle_loop = 0 //Our holder for process() ticks and the idle sound firing
	var/max_fuel = 500 //The max amount of fuel this can hold
	var/start_fueled = TRUE // Do we start fueled
	var/firstrev = FALSE //To handle the first rev noise and not allow spam of it.

/obj/item/weapon/gun/eviscerator/New() //We need to get our own process loop started for sounds
	..()
	processing_objects.Add(src)
	
	create_reagents(max_fuel)
	
	if(start_fueled)
		reagents.add_reagent(FUEL, max_fuel)

/obj/item/weapon/gun/eviscerator/Destroy()
	processing_objects.Remove(src)
	..()

/obj/item/weapon/gun/eviscerator/process()
	if(revvin_on)
		idle_loop++
	
	if(idle_loop >= 2)
		idle_loop = 0
		playsound(src,'z40k_shit/sounds/Chainsword_Idle.wav',50)
		if(!firstrev)
			firstrev = TRUE

/obj/item/weapon/gun/eviscerator/examine(mob/user)
	..()
	to_chat(user, "<span class='info'> Has [max_fuel] unit\s of fuel remaining.</span>")

/obj/item/weapon/gun/eviscerator/afterattack(obj/O as obj, mob/user as mob, proximity)
	if(!proximity)
		return
	if(istype(O, /obj/structure/reagent_dispensers/fueltank) && get_dist(src,O) <= 1)
		O.reagents.trans_to(src, max_fuel)
		to_chat(user, "<span class='notice'> Pack refueled</span>")
		playsound(src, 'sound/effects/refill.ogg', 50, 1, -6)
		return

/obj/item/weapon/gun/eviscerator/IsShield()
	return 1

/obj/item/weapon/gun/eviscerator/attack_self(var/mob/user) //If we click this, we ignite it.
	if(revvin_on)
		revvin_on = FALSE
		update_icon()
		if(firstrev)
			firstrev = FALSE
			playsound(src,'z40k_shit/sounds/Chainsword_Idle.wav',50)
	else
		revvin_on = TRUE
		update_icon()
	..()

/obj/item/weapon/gun/eviscerator/unequipped(mob/user)
	if(revvin_on)
		revvin_on = FALSE
		update_icon()

/obj/item/weapon/gun/eviscerator/dropped(mob/user)
	if(revvin_on)
		src.unwield(user)
		revvin_on = FALSE
		update_icon()

/obj/item/weapon/gun/eviscerator/process_chambered()
	if(revvin_on)
		if(max_fuel > 0)
			max_fuel -= 50
			playsound(src, 'sound/weapons/flamethrower.ogg', 50, 1)
			in_chamber = new/obj/item/projectile/fire_breath/eviscerator(src)
			Fire(targloc, user, params, struggle)
			return 1
		


/obj/item/weapon/gun/eviscerator/update_icon()
	var/mob/living/carbon/human/H = loc

	if(istype(loc,/mob/living/carbon/human))
		if(revvin_on)
			icon_state = "eviscerator_on"
			item_state = "eviscerator_on"
			H.update_inv_hands()
		else
			icon_state = "eviscerator_off"
			item_state = "eviscerator_off"
			H.update_inv_hands()