/obj/item/weapon/ork/burnapack
	name = "Burna Pack"
	desc = "Let forth your burning spirit in a gout of flames."
	icon = 'icons/obj/orkstuff/orkarmorandclothesOBJ.dmi'
	icon_state = "orkburnapack"
	item_state = "orkburnapack"
	slot_flags = SLOT_BACK
	w_class = W_CLASS_LARGE
	species_fit = list("Ork")
	var/nozzleout = FALSE //Is the nozzle on it or off of it
	var/max_fuel = 1500 //The max amount of fuel this can hold
	var/start_fueled = 1 // Do we start fueled

/obj/item/weapon/ork/burnapack/New()
	. = ..()

	new /obj/item/weapon/gun/flamernozzle(src) //Make me a nozzle cunt

	create_reagents(max_fuel)
	if(start_fueled)
		reagents.add_reagent(FUEL, max_fuel)

/obj/item/weapon/ork/burnapack/proc/can_use_verbs(mob/user)
	var/mob/living/carbon/human/M = user
	if (M.stat == DEAD)
		to_chat(user, "You can't do that while you're dead!")
		return 0
	else if (M.stat == UNCONSCIOUS)
		to_chat(user, "You must be conscious to do this!")
		return 0
	else if (M.handcuffed)
		to_chat(user, "You can't reach the controls while you're restrained!")
		return 0
	else if(!isork(user))
		to_chat(user,"What the hell am I looking at?")
		return 0
	else
		return 1

/obj/item/weapon/ork/burnapack/verb/remove_nozzle() //pulls the nozzle off the burnapack
	set name = "Remove Nozzle"
	set category = "Object"
	set src in usr

	var/mob/living/user = usr
	
	if(!can_use_verbs(user))
		return

	detach_nozzle(user)

/obj/item/weapon/ork/burnapack/examine(mob/user)
	..()
	to_chat(user, "<span class='info'> Has [max_fuel] unit\s of fuel remaining.</span>")

/obj/item/weapon/ork/burnapack/update_icon()
	if(nozzleout) //updates icon stating whether we have the nozzle on or off.
		icon_state = "orkburnapack_nozzleout"
	else
		icon_state = "orkburnapack_nozzlein"

/obj/item/weapon/ork/burnapack/attackby(var/obj/item/A, mob/user)
	if(istype(A, /obj/item/weapon/gun/flamernozzle))
		user.drop_item(A)
		nozzleout = FALSE

/obj/item/weapon/ork/burnapack/unequipped(mob/user)
	if(nozzleout)
		var/obj/item/weapon/gun/flamernozzle/FN = locate(/obj/item/weapon/gun/flamernozzle) in user.held_items
		if(FN)
			user.drop_item(FN)
			nozzleout = FALSE

/obj/item/weapon/ork/burnapack/afterattack(obj/O as obj, mob/user as mob, proximity)
	if(!proximity)
		return
	if(istype(O, /obj/structure/reagent_dispensers/fueltank) && get_dist(src,O) <= 1)
		O.reagents.trans_to(src, max_fuel)
		to_chat(user, "<span class='notice'> Pack refueled</span>")
		playsound(src, 'sound/effects/refill.ogg', 50, 1, -6)
		return

/obj/item/weapon/ork/burnapack/proc/detach_nozzle(mob/user)
	var/obj/item/weapon/gun/flamernozzle/FN = locate() in src.contents
	if(!FN)
		to_chat(user, "Your pack seems to have no nozzle on it, FUCK.")
		return
	else
		user.put_in_hands(FN)	
		nozzleout = TRUE
		to_chat(user,"<span class='notice'> You pull the nozzle off the pack.</span>")
		update_icon()

/obj/item/weapon/gun/flamernozzle
	name = "Burna Pack Nozzle"
	desc = "The shooty end of a flamethrower"
	icon = 'icons/obj/flamethrower.dmi'
	icon_state = "flamethrowerbase"
	item_state = "flamethrower_0"
	var/obj/item/weapon/ork/burnapack/my_pack
	var/currently_lit = 0
	throw_range = 0
	throw_speed = 1

/obj/item/weapon/gun/flamernozzle/New()
	if(istype(loc, /obj/item/weapon/ork/burnapack))
		my_pack = loc

/obj/item/weapon/gun/flamernozzle/dropped(mob/user) //If we drop this, we return to pack.
	if(my_pack)
		my_pack.nozzleout = FALSE
		src.forceMove(my_pack)
		my_pack.update_icon()
	else
		qdel(src)

/obj/item/weapon/gun/flamernozzle/throw_impact(atom/hit_atom, mob/user) //If we throw this, we return to pack.
	..()
	if(isturf(hit_atom))
		src.forceMove(my_pack)

	if(my_pack)
		my_pack.nozzleout = FALSE
		my_pack.update_icon()

/obj/item/weapon/gun/flamernozzle/attack_self(var/mob/user) //If we click this, we ignite it.
	if(!currently_lit)
		to_chat(user, "<span class='notice'> You ignite the nozzle end.")
		currently_lit = 1
	else
		currently_lit = 0
		to_chat(user, "<span class='notice'> You unignite the nozzle end.")
	..()

/obj/item/weapon/gun/flamernozzle/verb/light_flame() //we also have a verb to turn the igniter on
	set name = "Igniter Toggle"
	set desc = "Turns the igniter on, along with all that entails"
	set category = "Object"
	set src in usr

	if(!currently_lit)
		currently_lit = 1
	else
		currently_lit = 0

/obj/item/weapon/gun/flamernozzle/process_chambered()
	if(in_chamber)
		return 1
	if(currently_lit)
		if(my_pack.max_fuel > 0)
			my_pack.max_fuel-= 50
			in_chamber = new/obj/item/projectile/fire_breath/shuttle_exhaust(src)
			return 1
		else
			return
	return 0