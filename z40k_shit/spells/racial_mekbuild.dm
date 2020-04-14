/spell/aoe_turf/mekbuild //Raaagh
	name = "Mek Build"
	abbreviation = "WG"
	desc = "Lets ya build shit on da go."
	panel = "Racial Abilities"
	override_base = "racial"
	hud_state = "racial_waagh"
	spell_flags = INCLUDEUSER
	charge_type = Sp_RECHARGE
	charge_max = 10
	invocation_type = SpI_NONE
	still_recharging_msg = "<span class='notice'>You ain't ready yet idiot..</span>"
	var/datum/button_crafting/MB
	var/list/crafting_recipes = list(
				new/datum/crafting_recipes/kustom_shoota
				)

/spell/aoe_turf/mekbuild/New()
	..()
	MB = new /datum/button_crafting(recipes = crafting_recipes)

/spell/aoe_turf/mekbuild/Destroy()
	qdel(MB)
	MB = null
	..()

/spell/aoe_turf/mekbuild/cast(var/list/targets, mob/user)
	MB.use(user)

