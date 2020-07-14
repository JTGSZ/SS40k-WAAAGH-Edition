//Here ends the end of the active path. We can do more with this but from this point on the danger going mad should be EXETREME.
/spell/slaanesh
	panel = "Slaanesh"
	override_base = "cult" //The area behind tied into the panel we are attached to
	override_icon = 'icons/obj/ghost_spells.dmi' //Basically points us to a different dmi.
	//overlay_icon_state = "spell"
	hud_state = "slaanesh" //name of the icon used in generating the spell hud object ontop of the base
	
/spell/slaanesh/celeb
	name = "Ascention"
	desc = "Become a Champion of Chaos."
	invocation = "MY SOUL FOR YOU!!"
	invocation_type = "none"
	school = "warp"
	panel = "Warp Magic"
	clothes_req = 0
	human_req = 1
	charge_max = 500
	range = -1
	include_user = 1

/obj/effect/proc_holder/spell/targeted/celeb/ascention/cast()				//we hijack the click!! Take this click to cuba!!!
	if(!usr) return
	if(!ishuman(usr)) return
	var/mob/living/carbon/human/U = usr
	new /mob/living/simple_animal/hostile/faithless/slaaneshchampion(U.loc)
	U.visible_message("<span class='notice'>[U] bends and twists into some kind of abomination!</span>", "<span class='notice'>Only your body is needed. Your soul serves me better in the warp.</span>")
	qdel(U)
	..()


/mob/living/simple_animal/hostile/faithless/slaaneshchampion
	name = "Daemonette"
	desc = "A creature of the warp!"
	icon_state = "daemonette"
	icon_living = "daemonette"
	icon_dead = "daemonette_dead"