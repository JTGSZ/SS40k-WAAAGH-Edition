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
	//Safety so we don't leave them with a retarded cursor forever
	var/cursor_enabled = FALSE

	//DEFENSE STANCE VARS - SET THESE
	//Our ctrl click specials have blocking actions for defensive stance
	var/complex_defense = TRUE //If this has complex block aka parrying or other actions

	//Mostly a general direction
	var/defenseDIR //So someone doesn't become Neo from the matrix.
	//And covers all their directions at once.
	
	//A var that is both blocking and deflecting's CD
	var/active_defense_CD = FALSE //We will not be on both at the same time.
	
	/*
		Blocking
					*/
	/*
	Basically what blocking does is we will not allow this to fail below.
	A certain threshhold, The stat value will be in play in this, It will be a flat val.
	Then above the flat val if its in favor of the opponent, we enter probability.
	We will always block frontal.
	Small probability on the sides.
	*/
	//BLOCKING ACTION VARIABLES - DO NOT SET THESE
	var/blocking = FALSE //Are we currently blocking?
	var/forcesoak = 60 // The amount of force we compare to for the calculation.
	var/blocking_duration = 5 //How long we stay in a block
	
	/*
		Deflecting
					*/
	/*
	Basically what deflecting does is we will have a humble probability to straight up.
	Knock a weapon out of the opponents hand. 
	We will have a higher probability on side hits.
	Lower than sides on the frontal attack.
	*/
	//DEFLECTING ACTION VARIABLES - DO NOT SET THESE
	var/deflecting = FALSE
	var/deflectingprob = 50 //Probability
	var/deflecting_duration = 2 //How long we stay in a deflect

	//STANCE HOLDER - DO NOT SET THIS. Its basically just a string holder
	var/stance = "defensive"

	/*
		Parrying
					*/
	/*
	Basically what parrying does is we just negate the force, with a probability modifier.
	Frontal probability is normal
	Side probability is lesser.
	*/
	//Parrying Variables - DO NOT SET THESE
	var/parrying = FALSE //Are we currently parrying?
	var/parryprob = 110 //Probability
	var/parryduration = 5 //How long we stay in a parrying move
	
	//These are mostly active targeted actions on their own.
	//piercing strike - Adds "piercing" to the last_attacks string chain.
	var/piercing_blow = FALSE //Are we currently piercing?
	//Overcharge - For plasmaguns really
	var/overcharged = FALSE
	//Saw_Execution - For chain weapons really.
	var/saw_execution = FALSE

	//Our equipment controller and action holder.
	var/datum/attachment_system/ATCHSYS

//Return 1 if we pass, 0 if we do not pass. See: items.dm Line 349
/obj/item/weapon/item_action_slot_check(slot, mob/user)
	if(user.is_holding_item(src))
		return 1
	else
		return 0

//What occurs when a object is first spawned.
/obj/item/weapon/New() //We will grant the actions to each item individually, but store capability here.
	..()

//What occurs when a object is destroyed.
/obj/item/weapon/Destroy()
	..()

/*
	SAFETIES
				*/
//These are here mostly so you don't leave the user with something retarded.
//Also they are here so you don't have to think (or try) very hard too.
//Make sure to supercall.

//What occurs when a object is dropped.
/obj/item/weapon/dropped(mob/user)
	..()
	if(cursor_enabled)
		user.client.mouse_pointer_icon = initial(user.client.mouse_pointer_icon)
		cursor_enabled = FALSE
		if(piercing_blow)
			piercing_blow = FALSE
		if(saw_execution)
			saw_execution = FALSE

//What occurs when a object is thrown.
/obj/item/weapon/throw_impact(atom/hit_atom, mob/user)
	..()
	if(cursor_enabled)
		user.client.mouse_pointer_icon = initial(user.client.mouse_pointer_icon)
		cursor_enabled = FALSE
		if(piercing_blow)
			piercing_blow = FALSE
		if(saw_execution)
			saw_execution = FALSE

//What occurs when a object is unequipped/stripped
/obj/item/weapon/unequipped(mob/user)
	..()
	if(cursor_enabled)
		user.client.mouse_pointer_icon = initial(user.client.mouse_pointer_icon)
		cursor_enabled = FALSE
		if(piercing_blow)
			piercing_blow = FALSE
		if(saw_execution)
			saw_execution = FALSE

//Occurs before the attack
/obj/item/weapon/preattack(atom/target, mob/user, proximity_flag, click_parameters)
	..()

//Occurs after the attack
/obj/item/weapon/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	..()
	if(piercing_blow)
		piercing_blow = FALSE
		armor_penetration = initial(src.armor_penetration)

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
Our current words are the following. (Updated 3/20/2020 by JTGSZ)

	Method		    String		      Location of string append.		Mouse Cursor
|---------------|-----------------|-----------------------------------|-------------|
Grab Intent    -   grapple 			See: complexcombat.dm Line: 210
Disarm Intent  -   disarm			See: complexcombat.dm Line: 213
Help Intent    -   knockback		See: complexcombat.dm Line: 216
Hurt Intent    -   hurt				See: complexcombat.dm Line: 219
Charge action  -   charge			See: complexcombat.dm Line: 284
Parry action   -   parry			See: complexcombat.dm Line: 310		TRUE
Pierce action  -   pierce			See: complexcombat.dm Line: 434
Deflect action -   deflect          See: complexcombat.dm Line: 350
Block action   -   block            See: complexcombat.dm Line: 338
Saw action     -   saw              See: complexcombat.dm Line: 193		TRUE
Overcharge action - overcharge		See: complexcombat.dm Line: 406

*/
//See: complex_base_class.dm in AA
//See: item_attack.dm for the attack proc.
/obj/item/weapon/attack(mob/living/target as mob, mob/living/user as mob, def_zone, var/originator = null)
	if(ishuman(user) && ishuman(target))
		var/mob/living/carbon/human/H = user
		var/mob/living/carbon/human/T = target
		if(saw_execution == TRUE)
			user.visible_message("<span class='danger'> [user] begins sawing [target] to death!")
			if(do_after(user,src,40))
				H.word_combo_chain += "saw"
				for(var/datum/organ/external/E in T.organs) //TARGETS ORGANS
					if(do_after(user,src,5))
						E.droplimb(1)
						H.health += 10 //We get 10 health per limb sawed off.
				for(var/datum/organ/internal/I in H.organs) //A REWARD FOR SAWING UP PEOPLE IS HEALTH.
					if(I.damage)
						I.damage = max(0, I.damage - 5) //Heals a whooping 5 organ damage.
					I.status &= ~ORGAN_BROKEN //What do I owe you?
					I.status &= ~ORGAN_SPLINTED //Nothing, it's for free!
					I.status &= ~ORGAN_BLEEDING //FOR FREE?!
				H.client.mouse_pointer_icon = initial(H.client.mouse_pointer_icon)
				cursor_enabled = FALSE
		if(piercing_blow == TRUE)
			armor_penetration = 100 //Ending handled in afterattack
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
	..() //We supercall to make sure everythings handled properly.

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

	//Lets you self clear buffer anywhere in it.
	if(findtext(H.word_combo_chain, "disarmgrappleknockback")) //Disarm Grapple Knockback
		H.word_combo_chain = ""
		H.update_powerwords_hud()

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
	if(!active_defense_CD)
		return 0
	defenseDIR = get_dir(user, target) //EG we click north and now we have NORTH
	var/showndirection = "" //We do not need a living target, just any target for a direction.
	switch(defenseDIR)
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
	
	
	switch(stance)
		if("defensive")
			user.visible_message("<span class='danger'> [user] prepares to parry blows from the [showndirection].</span>", "<span class='danger'> You prepare to parry blows from the [showndirection].</span>")
			parrying = TRUE
			spawn(parryduration*10) 
				active_defense_CD = FALSE //Cooldown is off
			spawn(parryduration*5)
				parrying = FALSE //And we should stop parrying in half the time
			user.click_delayer.setDelay(2)
			if(ishuman(user))
				var/mob/living/carbon/human/H = user
				H.word_combo_chain += "parry"
				H.update_powerwords_hud()
		if("blocking")
			user.visible_message("<span class='danger'> [user] Holds fast, ready to block blows from the [showndirection].</span>", "<span class='danger'> You prepare to block blows from the [showndirection].</span>")
			blocking = TRUE
			spawn(blocking_duration * 10)
				active_defense_CD = FALSE
			spawn(blocking_duration * 5)
				blocking = FALSE
			user.click_delayer.setDelay(2)
			if(ishuman(user))
				var/mob/living/carbon/human/H = user
				H.word_combo_chain += "block"
				H.update_powerwords_hud()
		if("deflective")
			user.visible_message("<span class='danger'> [user] prepares to deflect swings from the [showndirection].</span>", "<span class='danger'> You watch for openings to deflect to the [showndirection].</span>")
			deflecting = TRUE
			spawn(deflecting_duration * 10)
				active_defense_CD = FALSE
			spawn(deflecting_duration * 5)
				deflecting = FALSE
			user.click_delayer.setDelay(2)
			if(ishuman(user))
				var/mob/living/carbon/human/H = user
				H.word_combo_chain += "deflect"
				H.update_powerwords_hud()

	active_defense_CD = TRUE //We enter cooldown after this.

//Params - I is the object that hits us, param 2 is the person attacking, param 3 is the person who is parrying aka us.
//Obv our object is src
//user.dir target.dir //See: Combat.dm Line: 47 for where we are located.
//Order of precedence, Block, Parry, Deflect. In the scenario someone does all of them at once.
/obj/item/weapon/proc/handle_complex_defense(var/obj/item/I, var/mob/living/attacker, var/mob/living/defender, var/probmod = 0)
	var/assaultDIR = get_dir(defender,attacker) //The direction we are being attacked from

	if(deflecting)
		if(defenseDIR == assaultDIR) //If person assaulting us is the same direction we picked
			return
		if((assaultDIR == turn(defenseDIR,90)) || (assaultDIR == turn(defenseDIR,-90))) //If we are being attacked directly on the sides of the dir we picked
			return
	if(blocking)
		if(defenseDIR == assaultDIR)
			return
		if((assaultDIR == turn(defenseDIR,90)) || (assaultDIR == turn(defenseDIR,-90)))
			return
	//---PARRYING IS LAST IN THIS CHAIN.
	if(parrying) //ARE we parrying? Now we need to get some direction calculations
		if(src.force >= 10 && !defender.lying) //If force is less than this level, that probably means it is some kind of inactive blade, and can't be used to parry.
			if(defenseDIR == assaultDIR) //If the person assaulting us is the same direction we picked.
				if(prob((parryprob - I.force)+probmod)) //Not the most elegant solution but I don't want to have to track multiple different variables scattered around objects.
					attacker.visible_message("<span class ='danger'>[defender] has parried [attacker]'s attack!</span>")
					return TRUE //If we are attacked from the direction we parry
				else
					to_chat(defender, "<span class = 'danger'> You fail to parry the [I]!</span>")
					return FALSE
			if((assaultDIR == turn(defenseDIR,90)) || (assaultDIR == turn(defenseDIR,-90)))
				if(prob((parryprob - I.force)+probmod)/6) //If we are attacked from a side
					attacker.visible_message("<span class ='danger'>[defender] has parried [attacker]'s side attack!</span>")
					return TRUE
				else
					to_chat(defender, "<span class = 'danger'> You fail to parry the [I]!</span>")
					return FALSE
		else
			to_chat(defender, "<span class = 'danger'> You fail to parry the [I]!</span>")
			return FALSE
	return FALSE //basically if it returns true to the segment in human_defense.dm Line 211 we do stuff here.
	//Instead of over there
/*
	BASIC STANCE SWAP PROC
							*/
/obj/item/weapon/proc/aggr_def_switch_stance(var/mob/living/user)
	if(stance == "aggressive")
		stance = "defensive"
	else
		stance = "aggressive"
	user.visible_message("<span class='notice'> [user] falls into [stance] stance.</span>")

//Technically you can have both on one item, since the else
//Will bring it into that one, and then if they hit it again you get the first
//So the stances will just be ordered based on importance
//And partially balanced in this manner because you have the movement through them.
//But the action button icons have to match this.
/*
	SHIELD STANCE SWAP PROC
							*/
/obj/item/weapon/proc/defl_bloc_switch_stance(var/mob/living/user)
	if(stance == "blocking")
		stance = "deflective"
	else
		stance = "blocking"
	user.visible_message("<span class='notice'> [user] falls into [stance] stance.</span>")

/*
	OVERCHARGE PROC HOLDER
							*/
//Define per weapon.
/obj/item/weapon/proc/overcharge(var/mob/living/carbon/human/user)
	if(overcharged)
		overcharged = FALSE
		user.visible_message("<span class='notice'> [user] stops supercharging their [src].</span>")
	else
		overcharged = TRUE
		user.word_combo_chain += "overcharge"
		user.update_powerwords_hud()
		user.visible_message("<span class='notice'> [user] begins supercharging their [src].</span>")
	return

/*
	SAWING PROC HOLDER
						*/
/obj/item/weapon/proc/saw_execution(var/mob/living/carbon/human/user)
	user.visible_message("<span class='danger'> [user] gets ready to rev it up!")
	user.client.mouse_pointer_icon = file("z40k_shit/icons/mouse_pointers/sawing_action.dmi")
	cursor_enabled = TRUE
	saw_execution = TRUE
	if(saw_execution)
		user.visible_message("<span class='danger'> [user] stops getting ready to rev it up!")
		user.client.mouse_pointer_icon = initial(user.client.mouse_pointer_icon)
		cursor_enabled = FALSE
		saw_execution = FALSE

/*
	PIERCING BLOW PROC HOLDER
								*/
/obj/item/weapon/proc/piercing_blow(var/mob/living/carbon/human/user)
	user.visible_message("<span class='danger'> [user] prepares to deliver a piercing blow.</span>")
	if(do_after(user,src,20))
		user.client.mouse_pointer_icon = file("z40k_shit/icons/mouse_pointers/piercing_blow.dmi")
		cursor_enabled = TRUE
		piercing_blow = TRUE
		user.word_combo_chain += "pierce"
		user.update_powerwords_hud()
	if(piercing_blow)
		user.visible_message("<span class='danger'> [user] stops preparing to deliver a piercing blow.</span>")
		user.client.mouse_pointer_icon = initial(user.client.mouse_pointer_icon)
		cursor_enabled = FALSE
		piercing_blow = FALSE

/*
	HANDLE CTRL CLICK
						*/
//Actually handled at the mob level. Located in complexcombat.dm Line: 404
//Built so you can slot in stuff other than the given charging/parrying into each item you want.
/obj/item/weapon/proc/handle_ctrlclick(var/mob/living/user, var/atom/target)
	switch(stance)
		if("defensive")
			handle_defensive_ctrlclick(user, target)
		if("aggressive")
			handle_aggressive_ctrlclick(user, target)
		if("deflective")
			handle_defensive_ctrlclick(user, target)
		if("blocking")
			handle_defensive_ctrlclick(user, target)

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