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
	var/datum/mek_build/MB

/spell/aoe_turf/mekbuild/New()
	..()
	MB = new /datum/mek_build

/spell/aoe_turf/mekbuild/Destroy()
	qdel(MB)
	MB = null
	..()

/spell/aoe_turf/mekbuild/cast(var/list/targets, mob/user)
	MB.use(user)

/datum/mek_build
	var/temp = null
	var/next_desc_fire //CD so we can't have someone rapidfire flood with the mek desc
	var/list/possible_recipes = list(
		new/datum/mek_recipe/kustom_shoota
									)

/datum/mek_build/New()
	//for(var/type in typesof(/datum/mek_recipe))
	//	var/datum/mek_recipe/AM = new type
	//	src.possible_recipes += AM

/datum/mek_build/proc/use(mob/user)
	var/dat
	dat += {"<B>Mek Recipes</B><BR>
			<HR>
			<B>Build Object:</B><BR>
			<I>The number afterwards is what metal it requires to be built.</I><BR>"}
	for(var/datum/mek_recipe/recipe in src.possible_recipes)
		dat += "<A href='byond://?src=\ref[src];build=1;recipe=\ref[recipe]'>[recipe.title]</A> <A href='byond://?src=\ref[src];desc=1;recipe=\ref[recipe]'>[recipe.build_desc]</A><BR>"
	dat += "<HR>"
	if(src.temp)
		dat += "[src.temp]"
	var/datum/browser/popup = new(user, "mekbuilder", "Mek Build Menu")
	popup.set_content(dat)
	popup.open()

/datum/mek_build/Topic(href, href_list)
	..()

	var/mob/living/L = usr
	if(!istype(L))
		return

	if(href_list["build"])
		var/datum/mek_recipe/MR = locate(href_list["recipe"])
		if(consume_resources(L,MR))
			return 1

	if(href_list["desc"])
		if(world.time >= next_desc_fire) //only do this every 2 seconds.
			var/datum/mek_recipe/MR = locate(href_list["recipe"])
			if(find_desc(L,MR))
				return 1

	src.use(usr)

//We consume resources here, basically it calls a proc on the recipe datum.
//If the proc returns 0 it gives a error message.
/datum/mek_build/proc/consume_resources(mob/living/user, var/datum/mek_recipe/mek_recipe)
	mek_recipe.datum_begin_chaintest(user)

//Basically this just plugs in a desc if you click the mat value
/datum/mek_build/proc/find_desc(mob/living/user, var/datum/mek_recipe/mek_recipe)
	next_desc_fire = world.time + 0.5 SECONDS
	to_chat(user,"Item Description: [mek_recipe.obj_desc]")
	return 1

/*
	DATUM MEK RECIPES
						*/
//Basically these are the recipes you can build on the mek builder menu.
/datum/mek_recipe
	var/title = "ERROR" //Title of it on the mek build menu
	var/obj/result_type //What we will get
	var/time //How much time it takes to build
	var/build_desc //The building desc for how to make it.
	var/obj_desc //A description of the object
	var/obj/item/stack/sheet/sheet_type = /obj/item/stack/sheet/metal
	var/sheet_amount = 20
	var/list/other_objects = list()

//We can have custom building right here, you return 1 if they succeed and 0 if they fail.
/datum/mek_recipe/proc/datum_begin_chaintest(mob/living/user)
	var/condition_1 = FALSE //We are false
	var/custom_condition = FALSE
	var/failed = FALSE //Did we fail
	var/condition_requirements = other_objects.len // Amount of times we need to tick true to pass the custom condition
	var/condition_counter = 0
	var/list/jokes_on_you_cunt = list()
	var/list/we_takin_these = other_objects.Copy()
	var/list/actually_takin_these = list()

	var/obj/item/MO
	
	MO = user.get_active_hand()
	if(istype(MO, sheet_type))
		var/obj/item/stack/sheet/my_sheet = MO
		if(my_sheet.amount >= sheet_amount)
			to_chat(user,"ACTIVE HAND CHECK MET")
			condition_1 = TRUE
	if(we_takin_these.len)
		if(is_type_in_list(MO, other_objects))
			we_takin_these.Remove(MO)
			actually_takin_these += MO
			condition_counter++
			
	MO = user.get_inactive_hand()
	if(!condition_1)
		if(istype(MO, sheet_type))
			var/obj/item/stack/sheet/my_sheet = MO	
			if(my_sheet.amount >= sheet_amount)
				to_chat(user,"INACTIVE HAND CHECK MET")
				condition_1 = TRUE
	if(we_takin_these.len)
		if(is_type_in_list(MO, other_objects))
			we_takin_these.Remove(MO)
			actually_takin_these += MO
			condition_counter++

	if(!condition_1)
		for(sheet_type in range(1,user))
			if(sheet_type.amount >= sheet_amount)
				condition_1 = TRUE
				to_chat(user,"RANGE CHECK MET")
				break
	
	if(we_takin_these.len)
		for(var/obj/item/THEBOYS in range(1,user))
			if(we_takin_these.len)
				if(prob(5))
					jokes_on_you_cunt += THEBOYS
				else if(is_type_in_list(THEBOYS,we_takin_these))
					we_takin_these.Remove(MO)
					actually_takin_these += MO
					condition_counter++
	
	to_chat(user,"Condition_counter is [condition_counter]")
	if(condition_counter >= condition_requirements)
		custom_condition = TRUE

	if(condition_1 && custom_condition)
		to_chat(user,"Finding all the materials, You begin crafting the [title]")
		if(do_after(user, user, time))
			sheet_type.use(sheet_amount)
			for(var/obj/item/theniggas in actually_takin_these)
				if(do_after(user,user,10))
					qdel(theniggas)
				else
					failed = TRUE
					break
			
			for(var/obj/item/fucked in jokes_on_you_cunt)
				qdel(fucked)
				
			if(!failed)
				new result_type(user.loc)
				to_chat(user,"You finish crafting the [title]")
			else
				to_chat(user,"You failed to craft the [title]")
				return 0

	else
		to_chat(user,"<span class='warning'> You do not have enough material near you. </span>")
		return 0

/datum/mek_recipe/kustom_shoota
	title = "Kustom Shoota"
	result_type = /obj/item/weapon/gun/projectile/automatic/kustomshoota
	time = 20 SECONDS
	build_desc = "20 Metal Sheets, 1 Shoota"
	obj_desc = "A Kustom Shoota allows many guns to be attached to it."
	sheet_type = /obj/item/stack/sheet/metal
	sheet_amount = 20
	other_objects = list(/obj/item/weapon/gun/projectile/automatic/shoota)


