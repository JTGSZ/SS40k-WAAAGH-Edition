/obj/item/weapon/ork/burnapack
	name = "Burna Pack"
	desc = "Let forth your burning spirit in a gout of flames."
	icon = 'icons/obj/orkstuff/orkarmorandclothesOBJ.dmi'
	icon_state = "orkburnapack"
	item_state = "orkburnapack"
	slot_flags = SLOT_BACK
	w_class = W_CLASS_LARGE
	var/obj/item/weapon/gun/flamernozzle/mynozzle // The specific gun end tied to this pack
	var/heldorholstered = 0 //Is the nozzle on it or off of it
	var/max_fuel = 1500 //The max amount of fuel this can hold
	var/start_fueled = 1 // Do we start fueled

/obj/item/weapon/ork/burnapack/New()
	. = ..()
	mynozzle = new(src)
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

	if (!can_use_verbs(usr))
		return

	detach_nozzle()

/obj/item/weapon/ork/burnapack/examine(mob/user)
	..()
	to_chat(user, "<span class='info'> Has [max_fuel] unit\s of fuel remaining.</span>")

/obj/item/weapon/ork/burnapack/update_icon()
	if(heldorholstered)
		icon_state = "orkburnapack"
	else
		icon_state = ""

/obj/item/weapon/ork/burnapack/afterattack(obj/O as obj, mob/user as mob, proximity)
	if(!proximity)
		return
	if (istype(O, /obj/structure/reagent_dispensers/fueltank) && get_dist(src,O) <= 1)
		O.reagents.trans_to(src, max_fuel)
		to_chat(user, "<span class='notice'> Pack refueled</span>")
		playsound(src, 'sound/effects/refill.ogg', 50, 1, -6)
		return

/obj/item/weapon/ork/burnapack/attackby(obj/item/W, mob/user)
	if(istype(W, /obj/item/weapon/gun/flamernozzle/))
		attach_nozzle(mynozzle)
		return

/obj/item/weapon/ork/burnapack/proc/attach_nozzle(var/mob/user)
	if(!mynozzle)
		mynozzle = new(src)
	mynozzle.forceMove(src)
	heldorholstered = 0
	if(user)
		to_chat(user, "<span class='notice'> You loop [mynozzle.name] to a hook on the [name].</span>")
	update_icon()
	user.update_inv_back()

/obj/item/weapon/ork/burnapack/proc/detach_nozzle(var/mob/user)
	if(!mynozzle)
		to_chat(user, "Your pack seems to have no nozzle, FUCK.")
		return
	user.put_in_hands(mynozzle)
	heldorholstered = 1
	if(user)
		to_chat(user,"<span class='notice'> You unloop [mynozzle.name] off the hook on the [name].</span>")
	update_icon()
	user.update_inv_back()

/obj/item/weapon/gun/flamernozzle
	name = "Burna Pack Nozzle"
	desc = "The shooty end of a flamethrower"
	icon = 'icons/obj/flamethrower.dmi'
	icon_state = "flamethrowerbase"
	item_state = "flamethrower_0"
	var/obj/item/weapon/ork/burnapack/my_pack
	var/currently_lit = 0

/obj/item/weapon/gun/flamernozzle/New()
	if(istype(loc, /obj/item/weapon/ork/burnapack))
		my_pack = loc

/obj/item/weapon/gun/flamernozzle/dropped(mob/user)
	if(my_pack)
		my_pack.attach_nozzle(user)
	else
		qdel(src)

/obj/item/weapon/gun/flamernozzle/verb/light_flame() //pulls the nozzle off the chempack
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