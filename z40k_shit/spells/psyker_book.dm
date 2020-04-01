
//See spellbook.dm for our parent.
/obj/item/weapon/spellbook/primaris_psyker
	name = "psyker book"
	desc = "A book of uhh... psyker stuff for psykers."
	icon = 'z40k_shit/icons/obj/ig/IGequipment.dmi'
	icon_state = "psykerbook"
	slot_flags = SLOT_BELT
	inhand_states = list("left_hand" = 'z40k_shit/icons/inhands/LEFTIES/IGequipment_left.dmi', "right_hand" = 'z40k_shit/icons/inhands/RIGHTIES/IGequipment_right.dmi')
	item_state = "psykerbook"
	throw_speed = 1
	throw_range = 5
	w_class = W_CLASS_TINY
	flags = FPRINT

	all_spells = list()
	var/list/biomancy_spells = list()
	var/list/pyromancy_spells = list()
	var/list/telekinesis_spells = list()
	var/list/telepathy_spells = list()

	var/current_spellpoints = 5

	op = 1

// called after an item is picked up (loc has already changed)


/obj/item/weapon/spellbook/primaris_psyker/New()
	..()

	//setup_spellbook()

/obj/item/weapon/spellbook/primaris_psyker/proc/use_psykpoints(amount, mob/living/user)
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

/obj/item/weapon/spellbook/primaris_psyker/setup_spellbook()

	for(var/psyker_spell in getAllPrimarisPsykerSpells())
		var/spell/S = new psyker_spell 
		all_spells += psyker_spell
		if(!S.holiday_required.len || (Holiday in S.holiday_required))
			switch(S.specialization)
				if(SSBIOMANCY)
					biomancy_spells +=	psyker_spell
				if(SSPYROMANCY)
					pyromancy_spells += psyker_spell
				if(SSTELEKINESIS)
					telekinesis_spells += psyker_spell
				if(SSTELEPATHY)
					telepathy_spells += psyker_spell

//Menu
#define buy_href_link(obj, price, txt) ((price > current_spellpoints) ? "Price: [price] point\s" : "<a href='?src=\ref[src];spell=[obj];buy=1'>[txt]</a>")
#define book_background_color "#F1F1D4"
#define book_window_size "550x600"

/obj/item/weapon/spellbook/primaris_psyker/attack_self(var/mob/living/user)
	if(!user)
		return

	get_spellpoints(user)

	if(user.is_blind())
		to_chat(user, "<span class='info'>You open \the [src] and run your fingers across the parchment. Suddenly, the pages coalesce in your mind!</span>")

	user.set_machine(src)

	var/dat
	dat += "<head><title>Psyker Book ([current_spellpoints] REMAINING)</title></head><body style=\"background-color:[book_background_color]\">"
	dat += "<h1>A Psykers Catalogue Of Spells</h1><br>"
	dat += "<h2>[current_spellpoints] point\s remaining (<a href='?src=\ref[src];refund=1'>Get a refund</a>)</h2><br>"
	dat += "<em>This book contains a list of many useful things that you'll need in your journey.</em><br>"
	dat += "<span style=\"color:blue\"><strong>KNOWN SPELLS:</strong></span><br><br>"

	var/list/known_spells = all_spells.Copy() //Spells the user knows.
	var/list/shown_biomancy_spells = biomancy_spells.Copy() //These are total lists of what spells we have avail.
	var/list/shown_pyromancy_spells = pyromancy_spells.Copy()
	var/list/shown_telekinesis_spells = telekinesis_spells.Copy()
	var/list/shown_telepathy_spells = telepathy_spells.Copy()

	//Draw known spells first
	for(var/spell/spell in user.spell_list)
		if(known_spells.Find(spell.type)) //User knows a spell from the book
			known_spells.Remove(spell.type)

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

				upgrade_data += "<a href='?src=\ref[src];spell=\ref[spell];upgrade_type=[upgrade];upgrade_info=1'>[upgrade]</a>: [lvl]/[max] (<a href='?src=\ref[src];spell=\ref[spell];upgrade_type=[upgrade];upgrade=1'>upgrade ([spell.get_upgrade_price(upgrade)] points)</a>)"

			if(upgrade_data)
				dat += "[upgrade_data]<br><br>"
			dat+= "<br>"

//FORMATTING
//<b>Fireball</b> - 10 seconds (buy for 1 spell point)
//<i>(Description)</i>
//Requires robes to cast

	if(BIOMANCY in user.spelltree_unlocked_list)
		dat += "<span style=\"color:green\"><strong>BIOMANCY SPELLS:</strong></span><br><br>"
		for(var/spell_path in shown_biomancy_spells)
			dat += build_description(user, spell_path)
	else
		dat += "<span style=\"color:green\"><strong>UNLOCK BIOMANCY</strong></span><br>"
		dat += "<span style=\"color:green\"><a href='?src=\ref[src];unlock=1;unlock_tree=biomancy'>Unlock Tree</a></span><br><br>"

	if(PYROMANCY in user.spelltree_unlocked_list)
		dat += "<span style=\"color:red\"><strong>PYROMANCY SPELLS:</strong></span><br><br>"
		for(var/spell_path in shown_pyromancy_spells)
			dat += build_description(user, spell_path)
	else
		dat += "<span style=\"color:red\"><strong>UNLOCK PYROMANCY:</strong></span><br>"
		dat += "<span style=\"color:red\"><a href='?src=\ref[src];unlock=1;unlock_tree=pyromancy'>Unlock Tree</a></span><br><br>"

	if(TELEKINESIS in user.spelltree_unlocked_list)
		dat += "<span style=\"color:blue\"><strong>TELEKINESIS SPELLS:</strong></span><br><br>"
		for(var/spell_path in shown_telekinesis_spells)
			dat += build_description(user, spell_path)
	else
		dat += "<span style=\"color:blue\"><strong>UNLOCK TELEKINESIS:</strong></span><br>"
		dat += "<span style=\"color:blue\"><a href='?src=\ref[src];unlock=1;unlock_tree=telekinesis'>Unlock Tree</a></span><br><br>"

	if(TELEPATHY in user.spelltree_unlocked_list)
		dat += "<span style=\"color:purple\"><strong>TELEPATHY SPELLS:</strong></span><br><br>"
		for(var/spell_path in shown_telepathy_spells)
			dat += build_description(user, spell_path)
	else
		dat += "<span style=\"color:purple\"><strong>UNLOCK TELEPATHY</strong></span><br>"
		dat += "<span style=\"color:purple\"><a href='?src=\ref[src];unlock=1;unlock_tree=telepathy'>Unlock Tree</a></span><br><br>"

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
	to_chat(user, "<span class='notice'> There are no refunds retard. </span>")
	return

/obj/item/weapon/spellbook/primaris_psyker/Topic(href, href_list)
	if(..())
		return

	var/mob/living/L = usr
	if(!istype(L))
		return

	get_spellpoints(L)

	if(href_list["unlock"])
		if(use_psykpoints(1,L))
			switch(href_list["unlock_tree"])
				if(BIOMANCY)
					L.spelltree_unlocked_list += BIOMANCY
				if(PYROMANCY)
					L.spelltree_unlocked_list += PYROMANCY
				if(TELEKINESIS)
					L.spelltree_unlocked_list += TELEKINESIS
				if(TELEPATHY)
					L.spelltree_unlocked_list += TELEPATHY
			attack_self(usr)

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
				if(use_psykpoints(initial(S.price),L))
					var/spell/added = new buy_type
					added.refund_price = added.price
					add_spell(added, L)
					to_chat(usr, "<span class='info'>You have learned [added.name].</span>")

		attack_self(usr)

	if(href_list["upgrade"])
		var/upgrade_type = href_list["upgrade_type"]
		var/spell/spell = locate(href_list["spell"])

		if(istype(spell) && spell.can_improve(upgrade_type))
			var/price = spell.get_upgrade_price(upgrade_type)
			if(use_psykpoints(price,L))
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
