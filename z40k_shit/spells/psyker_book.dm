
//See spellbook.dm for our parent.
/obj/item/weapon/spellbook/primaris_psyker
	name = "psyker book"
	desc = "A book of uhh... psyker stuff for psykers."
	icon = 'icons/obj/library.dmi'
	icon_state = "spellbook"
	inhand_states = list("left_hand" = 'icons/mob/in-hand/left/books.dmi', "right_hand" = 'icons/mob/in-hand/right/books.dmi')
	item_state = "book"
	throw_speed = 1
	throw_range = 5
	w_class = W_CLASS_TINY
	flags = FPRINT

	all_spells = list()
	offensive_spells = list()
	defensive_spells = list()
	utility_spells = list()
	misc_spells = list()

	//Unlike the list above, the available_artifacts list builds itself from all subtypes of /datum/spellbook_artifact
	//available_artifacts = list()

	//available_potions = list() //No potions.

	var/current_spellpoints = 5

	op = 1

// called after an item is picked up (loc has already changed)


/obj/item/weapon/spellbook/primaris_psyker/New()
	..()

	setup_spellbook()

/obj/item/weapon/spellbook/primaris_psyker/use(amount, mob/living/user)
	if(!user)
		return 0

	to_chat(user,"ITS HITTIN BUDDY.")
	get_spellpoints(user)
	
	if(user.psyker_points >= amount)
		user.psyker_points -= amount
		current_spellpoints = user.psyker_points
		to_chat(user,"We have subtracted [amount] from [user.psyker_points]")
	
		return 1

/obj/item/weapon/spellbook/primaris_psyker/pickup(mob/user)
	..()
	get_spellpoints(user)

/obj/item/weapon/spellbook/primaris_psyker/proc/get_spellpoints(mob/living/user)
	current_spellpoints = user.psyker_points
	to_chat(user, "We currently have [current_spellpoints]")

/obj/item/weapon/spellbook/setup_spellbook()

	//for(var/psyker_spell in getAllPrimarisPsykerSpells())
	for(var/psyker_spell in getAllWizSpells())
		var/spell/S = new psyker_spell 
		all_spells += psyker_spell
		if(!S.holiday_required.len || (Holiday in S.holiday_required))
			switch(S.specialization)
				if(SSOFFENSIVE)
					offensive_spells +=	psyker_spell
				if(SSDEFENSIVE)
					defensive_spells += psyker_spell
				if(SSUTILITY)
					utility_spells += psyker_spell
				else
					misc_spells += psyker_spell


//Menu
#define buy_href_link(obj, price, txt) ((price > current_spellpoints) ? "Price: [price] point\s" : "<a href='?src=\ref[src];spell=[obj];buy=1'>[txt]</a>")
#define book_background_color "#F1F1D4"
#define book_window_size "550x600"

/obj/item/weapon/spellbook/primaris_psyker/attack_self(var/mob/user)
	if(!user)
		return

	get_spellpoints(user)

	if(user.is_blind())
		to_chat(user, "<span class='info'>You open \the [src] and run your fingers across the parchment. Suddenly, the pages coalesce in your mind!</span>")

	user.set_machine(src)

	var/dat
	dat += "<head><title>Psyker Book ([current_spellpoints] REMAINING)</title></head><body style=\"background-color:[book_background_color]\">"
	dat += "<h1>A Psykers Catalogue Of Spells And Artifacts</h1><br>"
	dat += "<h2>[current_spellpoints] point\s remaining (<a href='?src=\ref[src];refund=1'>Get a refund</a>)</h2><br>"
	dat += "<em>This book contains a list of many useful things that you'll need in your journey.</em><br>"
	dat += "<span style=\"color:blue\"><strong>KNOWN SPELLS:</strong></span><br><br>"

	var/list/shown_spells = all_spells.Copy()
	var/list/shown_offensive_spells = offensive_spells.Copy()
	var/list/shown_defensive_spells = defensive_spells.Copy()
	var/list/shown_utility_spells = utility_spells.Copy()
	var/list/shown_misc_spells = misc_spells.Copy()

	//Draw known spells first
	for(var/spell/spell in user.spell_list)
		if(shown_spells.Find(spell.type)) //User knows a spell from the book
			shown_spells.Remove(spell.type)

			//FORMATTING

			//<b>Fireball</b> - 10 seconds<br>
			//Requires robes to cast
			//speed: 1/5 (upgrade) | power: 0/1 (upgrade)

			var/spell_name = spell.name
			var/spell_cooldown = get_spell_cooldown_string(spell.charge_max, spell.charge_type)

			dat += "<strong>[spell_name]</strong>[spell_cooldown]<br>"

			//Get spell properties
			var/list/properties = get_spell_properties(spell.spell_flags, user)
			var/property_data
			for(var/P in properties)
				property_data += "[P] "

			if(property_data)
				dat += "<span style=\"color:blue\">[property_data]</span><br>"

			//Get the upgrades
			var/upgrade_data = ""

			for(var/upgrade in spell.spell_levels)
				var/lvl = spell.spell_levels[upgrade]
				var/max = spell.level_max[upgrade]

				//If maximum upgrade level is 0, skip
				if(!max)
					continue

				upgrade_data += "<a href='?src=\ref[src];spell=\ref[spell];upgrade_type=[upgrade];upgrade_info=1'>[upgrade]</a>: [lvl]/[max] (<a href='?src=\ref[src];spell=\ref[spell];upgrade_type=[upgrade];upgrade=1'>upgrade ([spell.get_upgrade_price(upgrade)] points)</a>)  "

			if(upgrade_data)
				dat += "[upgrade_data]<br><br>"
			dat+= "<br>"

//FORMATTING
//<b>Fireball</b> - 10 seconds (buy for 1 spell point)
//<i>(Description)</i>
//Requires robes to cast

	if(shown_offensive_spells.len)
		dat += "<span style=\"color:red\"><strong>OFFENSIVE SPELLS:</strong></span><br><br>"
		for(var/spell_path in shown_offensive_spells)
			dat += build_description(user, spell_path)

	if(shown_defensive_spells.len)
		dat += "<span style=\"color:blue\"><strong>DEFENSIVE SPELLS:</strong></span><br><br>"
		for(var/spell_path in shown_defensive_spells)
			dat += build_description(user, spell_path)

	if(shown_utility_spells.len)
		dat += "<span style=\"color:green\"><strong>UTILITY SPELLS:</strong></span><br><br>"
		for(var/spell_path in shown_utility_spells)
			dat += build_description(user, spell_path)

	if(shown_misc_spells.len)
		dat += "<span style=\"color:orange\"><strong>MISCELLANEOUS SPELLS:</strong></span><br><br>"
		for(var/spell_path in shown_misc_spells)
			dat += build_description(user, spell_path)

	dat += "<hr><span style=\"color:purple\"><strong>ARTIFACTS AND BUNDLES<sup>*</sup></strong></span><br><small>* Non-refundable</small><br><br>"

	for(var/datum/spellbook_artifact/A in available_artifacts)
		if(!A.can_buy(user))
			continue

		var/artifact_name = A.name
		var/artifact_desc = A.desc
		var/artifact_price = A.price

		//FORMATTING:
		//<b>Staff of Change</b> (buy for 1 point)
		//<i>(description)</i>

		dat += "<strong>[artifact_name]</strong> ([buy_href_link("\ref[A]", artifact_price, "buy for [artifact_price] point\s")])<br>"
		dat += "<em>[artifact_desc]</em><br><br>"

	dat += "</body>"

	user << browse(dat, "window=spellbook;size=[book_window_size]")
	onclose(user, "spellbook")

/obj/item/weapon/spellbook/primaris_psyker/build_description(var/mob/user, var/spell_path) //Building sounds more coderlike doesn't it
	var/dat
	var/spell/abstract_spell = spell_path
	var/spell_name = initial(abstract_spell.name)
	var/spell_cooldown = get_spell_cooldown_string(initial(abstract_spell.charge_max), initial(abstract_spell.charge_type))
	var/spell_price = get_spell_price(abstract_spell)
	dat += "<strong>[spell_name]</strong>[spell_cooldown] ([buy_href_link(spell_path, spell_price, "buy for [spell_price] point\s")])<br>"
	dat += "<em>[initial(abstract_spell.desc)]</em><br>"
	var/flags = initial(abstract_spell.spell_flags)
	var/list/properties = get_spell_properties(flags, user)
	var/property_data
	for(var/P in properties)
		property_data += "[P] "
	if(property_data)
		dat += "<span style=\"color:blue\">[property_data]</span><br>"
	dat += "<br>"
	return dat

/obj/item/weapon/spellbook/primaris_psyker/get_spell_properties(flags, mob/user)
	var/list/properties = list()

	if(flags & NEEDSCLOTHES)
		var/new_prop = "Requires wizard robes to cast."

		//If user has the robeless spell, strike the text out
		if(user)
			var/is_robeless = locate(/spell/passive/noclothes) in user.spell_list
			if(is_robeless)
				new_prop = "<s>[new_prop]</s>"

		properties.Add(new_prop)

	if(flags & STATALLOWED)
		properties.Add("Can be cast while unconscious.")

	return properties

/obj/item/weapon/spellbook/primaris_psyker/get_spell_cooldown_string(charges, charge_type)
	if(charges == 0)
		return

	switch(charge_type)
		if(Sp_CHARGES)
			return " - [charges] charge\s"
		if(Sp_RECHARGE)
			return " - cooldown: [(charges/10)]s"

/obj/item/weapon/spellbook/primaris_psyker/get_spell_price(spell/spell_type)
	if(ispath(spell_type, /spell))
		return initial(spell_type.price)
	else if(istype(spell_type))
		return spell_type.price
	else
		return 0

/obj/item/weapon/spellbook/primaris_psyker/refund(mob/user)
	to_chat(user, "<span class='notice'> There are no refunds. </span>")
	return

/obj/item/weapon/spellbook/primaris_psyker/Topic(href, href_list)
	if(..())
		return

	var/mob/living/L = usr
	if(!istype(L))
		return

	get_spellpoints(L)

	if(href_list["refund"])
		refund(usr)

		attack_self(usr)

	if(href_list["buy"])
		var/buy_type = text2path(href_list["spell"])

		if(ispath(buy_type, /spell)) //Passed a spell typepath
			if(locate(buy_type) in usr.spell_list)
				to_chat(usr, "<span class='notice'>You already know that spell. Perhaps you'd like to upgrade it instead?</span>")

			else if(buy_type in all_spells)
				var/spell/S = buy_type
				if(use(initial(S.price),L))
					var/spell/added = new buy_type
					added.refund_price = added.price
					add_spell(added, L)
					to_chat(usr, "<span class='info'>You have learned [added.name].</span>")

		else //Passed an artifact reference
			var/datum/spellbook_artifact/SA = locate(href_list["spell"])

			if(istype(SA) && (SA in available_artifacts))
				if(SA.can_buy(usr) && use(SA.price,L))
					SA.purchased(usr)
					if(SA.one_use)
						available_artifacts.Remove(SA)

		attack_self(usr)

	if(href_list["upgrade"])
		var/upgrade_type = href_list["upgrade_type"]
		var/spell/spell = locate(href_list["spell"])

		if(istype(spell) && spell.can_improve(upgrade_type))
			var/price = spell.get_upgrade_price(upgrade_type)
			if(use(price,L))
				spell.refund_price += price
				var/temp = spell.apply_upgrade(upgrade_type)

				if(temp)
					to_chat(usr, "<span class='info'>[temp]</span>")

		attack_self(usr)

	if(href_list["upgrade_info"])
		var/upgrade_type = href_list["upgrade_type"]
		var/spell/spell = locate(href_list["spell"])

		if(istype(spell))
			var/info = spell.get_upgrade_info(upgrade_type, spell.spell_levels[upgrade_type] + 1)
			if(info)
				to_chat(usr, "<span class='info'>[info]</span>")
			else
				to_chat(usr, "<span class='notice'>\The [src] doesn't contain any information about this.</span>")

#undef buy_href_link
#undef book_background_color
#undef book_window_size
