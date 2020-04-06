/spell/aoe_turf/warp_speed	//Raaagh
	name = "Warp Speed"
	abbreviation = "WSPD"
	desc = "Blessing - Makes you move faster."
	hud_state = "racial_waagh"
	user_type = USER_TYPE_PSYKER
	spell_flags = INCLUDEUSER
	specialization = BIOMANCY
	charge_type = Sp_RECHARGE
	charge_max = 100
	invocation_type = SpI_NONE
	range = 1
	still_recharging_msg = "<span class='notice'>You ain't ready yet idiot..</span>"

/spell/aoe_turf/warp_speed/cast(list/targets, mob/user)
	for(var/mob/living/L in targets)
		to_chat(L, "<span class='sinister'>Warp Energy courses through you, allowing you to move inhumanly fast.</span>")
		L.attribute_agility += 15
		L.movement_speed_modifier += 1.0
		L.warp_speed = TRUE
		L.vis_contents += new /obj/effect/overlay/weak_green_circle(L,10)
		spawn(12 SECONDS)
			to_chat(L, "<span class='sinister'>Warp energy fading, your speed returns to normal.</span>")
			L.warp_speed = FALSE
			L.attribute_agility -= 15
			L.movement_speed_modifier -= 1.0
			
/spell/aoe_turf/warp_speed/choose_targets(var/mob/user = usr)
	return list(user)