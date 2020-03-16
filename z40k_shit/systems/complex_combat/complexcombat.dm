//Within is all the beginning paths and some semblance of complex combat.
/*Other Areas of note:
//Inertial Speed is handled in /mob/living/carbon/human/Life() and
								/mob/living/carbon/human/base_movement_tally()

the variables in human_defines.dm starting at line 18
	var/word_combo_chain //The holder for the attack chain system appends.
	var/clear_counter = 0 //The counter that dictates when it clears.

Basically clears out the last_attacks string holder after 6 ticks.
Its the process loop for the word combo chain system on the mob.
	SEE: human life.dm. Line 141

*/
/obj/item/weapon
	//We have ctrl click specials
	//COMPLEX CLICK SWITCH - SET THIS
	var/complex_click = TRUE   //If control+click can be used for moves.
	
	//BLOCK VARS - SET THESE
	//Our ctrl click specials have blocking actions for defensive stance
	var/complex_block = TRUE //If this has complex block aka parrying or other actions
	var/can_parry = TRUE //Are we capable of parrying?

	//STANCE HOLDER - DO NOT SET THIS. Its basically just a string holder
	var/stance = "defensive"
	//Parrying Variables - DO NOT SET THESE
	var/parryingCD = FALSE //Are we currently on CD from parrying?
	var/parrying = FALSE //Are we currently parrying?
	var/parryingDIR //The direction we are parrying, for dir comparisons.
	var/parryprob = 110 //Probability
	var/parryduration = 5 //How long we stay in a parrying move
	
	//piercing strike - Adds "piercing" to the last_attacks string chain.
	var/can_piercing = FALSE //Can we ready a piercing attack with this?

	//Our equipment controller and action holder.
	var/datum/attachment_system/ATCHSYS

//Return 1 if we pass, 0 if we do not pass. See: items.dm Line 349
/obj/item/weapon/item_action_slot_check(slot, mob/user)
	if(user.is_holding_item(src))
		return 1
	else
		return 0


/obj/item/weapon/New()
	var/REEE = /datum/action/item_action/warhams/basic_swap_stance
	actions_types += REEE
	
	processing_objects.Add(src) //this is probably a poor idea.
	//considering i don't know what all is in weapons that processes currently, o fuckin well.
	..()

/obj/item/weapon/Destroy()
	..()

/*
	STRING APPENDER
					*/
/*
Basically the plan is to like.
A. Create a basic appender in /obj/item/weapon/attack that everything will supercall into.
B. Make a proc call later in this that children can overwrite.
C. Then when the object they are using calls attack, it runs this and then runs the overwritten thing.
Doing a special attack at the end of the proc chain based on whats in the last_attacks string holder.
------------------Design Decisions---------------------
Stance actions will add to the string holder.
A specific string will be a universal buffer clear
---------
Todo:
And, I need a way to control force, effects on segments of the body.
Along with that I need a way to handle armor piercing and such too.

*/
/*
Our current words are the following.

	Method		    String		      Location of string append.
|---------------|-----------------|-----------------------------------|
Grab Intent    -   grapple 			See: complexcombat.dm Line: 101
Disarm Intent  -   disarm			See: complexcombat.dm Line: 103
Help Intent    -   knockback		See: complexcombat.dm Line: 107
Hurt Intent    -   hurt				See: complexcombat.dm Line: 109
Charge action  -   charge			See: complexcombat.dm Line: 205
Parry action   -   parry			See: complexcombat.dm Line: 245

*/
//See: complex_base_class.dm in AA
//See: item_attack.dm for the attack proc.
/obj/item/weapon/attack(mob/living/target as mob, mob/living/user as mob, def_zone, var/originator = null)
	if(ishuman(user) && ishuman(target))
		var/mob/living/carbon/human/H = user
		var/mob/living/carbon/human/T = target
		if(H.inertial_speed != null && H.a_intent == "harm")
			if(H.inertial_speed >= 5 && H.dir == T.dir && !T.lying)
				add_logs(user, target, "backstabbed")
				user.visible_message("<span class='danger'>[H] stabs [T] in the back with the [src.name]!</span>")
				H.inertial_speed = null
				T.Paralyse(5)
				step_away(T,H,10)
				step_away(T,H,10)
		if(H.a_intent == I_GRAB)
			H.word_combo_chain += "grapple"
			H.clear_counter = 0
		if(H.a_intent == I_DISARM)
			H.word_combo_chain += "disarm"
			H.clear_counter = 0
		if(H.a_intent == I_HELP)
			H.word_combo_chain += "knockback"
			H.clear_counter = 0
		if(H.a_intent == I_HURT)
			H.word_combo_chain += "hurt"
			H.clear_counter = 0
		
		interpret_powerwords(target, user, def_zone, originator) //We interpret the words in the word combo chain var here
		H.update_powerwords_hud() //We update the humans powerwords hud
	..()

//We bring all the given stuff into this proc too. 
//Everything after this better supercall if they overwrite this proc.
//Basically theres going to be two types of lastattack finding methods.
//String equality and findtexts.
//The first means they need to be precise, the latter means they just need to do it.
/obj/item/weapon/proc/interpret_powerwords(mob/living/target as mob, mob/living/user as mob, def_zone, var/originator = null)
	var/mob/living/carbon/human/H = user
	var/mob/living/carbon/human/T = target
	//Universal Buffer Clears
	switch(H.word_combo_chain)
		if("chargegrappledisarmgrapple") //Charge Grapple Disarm Grapple
			T.word_combo_chain = ""
			T.update_powerwords_hud()
		if("parrydisarm") //Parry Disarm
			T.word_combo_chain = ""
			T.update_powerwords_hud()
		if("grappledisarm") //Grapple Disarm
			T.word_combo_chain = ""
			T.update_powerwords_hud()

	if(findtext(H.word_combo_chain, "disarmgrappleknockback"))) //Disarm Grapple Knockback
		H.word_combo_chain = ""
		H.update_powerwords_hud()

	return 1

/*
	BASIC ACTIONS
				*/

//STANCE SWAP - BASIC
/datum/action/item_action/warhams/basic_swap_stance
	name = "Swap Stance"
	background_icon_state = "bg_defensive"
	button_icon_state = "defensive_1"
	var/defensive_or_not = FALSE

/datum/action/item_action/warhams/basic_swap_stance/Trigger()
	var/obj/item/weapon/S = target
	S.switch_stance(owner)

	if(S.stance == "aggressive")
		background_icon_state = "bg_aggro"
		button_icon_state = "aggressive_1"
		UpdateButtonIcon()
	if(S.stance == "defensive")
		background_icon_state = "bg_defensive"
		button_icon_state = "defensive_1"
		UpdateButtonIcon()

//PIERCING BLOWS - BASIC
/obj/item/weapon/verb/switchpiercing()
	set name = "Piercing Blow"
	set desc = "Make the next blow armor piercing. Delivering an armor piercing blow takes more time than a regular one."
	set category = "Sword"

	//piercing = !piercing
//	if(piercing)
//		usr << "\red You prepare to deliver a piercing blow."
//	else
//		usr << "\red You are no longer prepared to deliver a piercing blow."

/*
	BASIC STANCE SWAP PROC
							*/
/obj/item/weapon/proc/switch_stance(var/mob/living/user)
	if(stance == "aggressive")
		stance = "defensive"
	else
		stance = "aggressive"
	usr.visible_message("<span class='notice'> [user] falls into [stance] stance.</span>")

//Built so you can slot in stuff other than the given charging/parrying into each item you want.
/obj/item/weapon/proc/handle_ctrlclick(var/mob/living/user, var/atom/target)
	if(stance == "defensive")
		handle_defensive_ctrlclick(user, target)
	else if(stance == "aggressive")
		handle_aggressive_ctrlclick(user, target)

/*
	AGGRESSIVE STANCE CTRLCLICK PARENT
										*/
//Basic charging
/obj/item/weapon/proc/handle_aggressive_ctrlclick(var/mob/living/user, var/mob/living/target)
	if(isliving(target)) //ITS GOTTA BE LIVING BUDDY, OR WE AIN'T GOIN NOWHERE
		if(!user.click_delayer.blocked())
			user.delayNextAttack(10)
			user.visible_message("<span class='danger'> [user] charges at [target]!</span>")
			step_towards(user,target)
			step_towards(user,target)
			spawn(2)
				step_towards(user,target)
			spawn(3) 
				step_towards(user,target)
			if(ishuman(user))
				var/mob/living/carbon/human/H = user
				H.inertial_speed += 6
				H.word_combo_chain += "charge"
				H.update_powerwords_hud()

/*
	DEFENSIVE STANCE CTRLCLICK PARENT
									*/
//Its just basic parrying
/obj/item/weapon/proc/handle_defensive_ctrlclick(var/mob/living/user, var/atom/target)
	parryingDIR = get_dir(user, target) //EG we click north and now we have NORTH
	var/showndirection = "" //We do not need a living target, just any target for a direction.
	switch(parryingDIR)
		if(1)
			showndirection = "North"
		if(2)
			showndirection = "South"
		if(4)
			showndirection = "East"
		if(5)
			showndirection = "Northeast"
		if(6)
			showndirection = "Southeast"
		if(8)
			showndirection = "West"
		if(9)
			showndirection = "Northwest"
		if(10)
			showndirection = "Southwest"
	
	if(can_parry) //Can we parry?
		if(!parryingCD) //Are we off CD
			to_chat(user,"<span class='danger'>You prepare to parry blows from the [showndirection].</span>")
			parryingCD = TRUE //Then we enter CD and prepare
			parrying = TRUE
			spawn(parryduration*10) 
				parryingCD = FALSE //Cooldown is off
			spawn(parryduration*5)
				parrying = FALSE //And we should stop parrying in half the time
			user.click_delayer.setDelay(2)
			if(ishuman(user))
				var/mob/living/carbon/human/H = user
				H.word_combo_chain += "parry"
				H.update_powerwords_hud()

//Params - I is the object that hits us, param 2 is the person attacking, param 3 is the person who is parrying aka us.
//Obv our object is src
//user.dir target.dir
/obj/item/weapon/proc/handle_block(var/obj/item/I, var/mob/living/user, var/mob/living/target, var/probmod = 0)
	if(can_parry) //Can we even parry?
		if(parrying) //ARE we parrying? Now we need to get some direction calculations
			var/assaultDIR = get_dir(target,user) //The direction we are being attacked from
			if(src.force >= 10 && !target.lying) //If force is less than this level, that probably means it is some kind of inactive blade, and can't be used to parry.
				if(parryingDIR == assaultDIR)
					if(prob((parryprob - I.force)+probmod)) //Not the most elegant solution but I don't want to have to track multiple different variables scattered around objects.
						user.visible_message("<span class ='danger'>[target] has parried [user]'s attack!</span>")
						return TRUE //If we are attacked from the direction we parry
					else
						to_chat(target, "<span class = 'danger'> You fail to parry the [I]!</span>")
						return FALSE
				if((assaultDIR == turn(parryingDIR,90)) || (assaultDIR == turn(parryingDIR,-90)))
					if(prob((parryprob - I.force)+probmod)/6) //If we are attacked from a side
						user.visible_message("<span class ='danger'>[target] has parried [user]'s side attack!</span>")
						return TRUE
					else
						to_chat(target, "<span class = 'danger'> You fail to parry the [I]!</span>")
						return FALSE
			else
				to_chat(target, "<span class = 'danger'> You fail to parry the [I]!</span>")
				return FALSE
	return FALSE //basically if it returns true to the segment in human_defense.dm Line 211 we do stuff here.
	//Instead of over there

//Mob Var holder/parent entry
/mob/living/carbon/human
	var/bumpattack_cooldown = 0 //Whether we are on bumpattack cooldown or not.
	var/offhand_cooldown = 0
	var/inertial_speed = null //This is a variable to track how fast a human has been moving recently.
	//Inertial Speed is handled in /mob/living/carbon/human/Life() and /mob/living/carbon/human/base_movement_tally()

//Complex Bump Attacks
/mob/living/carbon/human/to_bump(atom/movable/AM as mob|obj)
	if(isliving(AM))
		var/mob/living/carbon/human/H = AM
		if(!H.bumpattack_cooldown)
			var/obj/item/weapon/I = src.get_active_hand()
			if(istype(I, /obj/item/weapon))
				H.bumpattack_cooldown = 1
				spawn(10) 
					H.bumpattack_cooldown = 0
				I.attack(H, src)
				return 1
	..()

//Src is our guy, A is what we are clicking on, W is our object
//Complex Clicks
/mob/living/carbon/human/ClickOn(var/atom/A, params) //Some combat interface things.
	var/list/modifiers = params2list(params)
	if(modifiers["alt"]) //If you hit alt and click you can fire a gun in the offhand
		var/obj/item/weapon/W = src.get_inactive_hand()
		if(W && !istype(W, /obj/item/weapon/gun))
			if(!offhand_cooldown)
				offhand_cooldown = 1
				spawn(5) 
					offhand_cooldown = 0
				W.afterattack(A, src)
				return
	
	if(modifiers["ctrl"]) //Ctrl + Click does a complex click if it has one
		var/obj/item/weapon/W = src.get_active_hand()
		if(W && W.complex_click)
			W.handle_ctrlclick(src, A)
			return
	..()