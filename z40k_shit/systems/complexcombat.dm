//Within is all the beginning paths and some semblance of complex combat.


/* Generic Weapons
-Contains
Choppa
Chainsword
Psykerstaff
*/
/obj/item/weapon/complexweapon
	var/stance = "defensive"

/obj/item/weapon/complexweapon/verb/switchstance() //We toggle stances here.
	set name = "Toggle Melee Stance"
	set desc = "Switch between agressive and defensive stance."
	set category = "Sword"

	if(stance == "agressive")
		stance = "defensive"
	else
		stance = "agressive"
	usr.visible_message("<span class='notice'> [usr] falls into [stance] stance.</span>")

/* Shields
-Contains
IG Shield
Ork Shield
*/
/obj/item/weapon/shield/complexweapon
	var/stance = "defensive"

/obj/item/weapon/shield/complexweapon/verb/switchstance() //We toggle stances here.
	set name = "Toggle Shield Stance"
	set desc = "Switch between agressive and defensive stance."
	set category = "Shield"

	if(stance == "agressive")
		stance = "defensive"
	else
		stance = "agressive"
	usr.visible_message("<span class='notice'> [usr] falls into [stance] stance.</span>")

/*
	Guns - This ones real shit cause i don't want to redo all the guns
								*/

/* Hackjob Category
-Contains
Eviscerator
*/

/obj/item/weapon/gun/projectile/complexweapon
	complex_click = TRUE
	var/stance = "defensive"

/obj/item/weapon/gun/projectile/complexweapon/verb/switchstance() //We toggle stances here.
	set name = "Toggle Stance"
	set desc = "Switch between agressive and defensive stance."
	set category = "Sword"

	if(stance == "agressive")
		stance = "defensive"
	else
		stance = "agressive"
	usr.visible_message("<span class='notice'> [usr] falls into [stance] stance.</span>")

/obj/item/weapon/gun/projectile/complexweapon/handle_ctrlclick(var/mob/living/user, var/mob/living/target)
	if(stance == "defensive")
		..()
	else
		if(!user.click_delayer.blocked())
			user.delayNextAttack(10)
			user.visible_message("<span class='danger' [user] charges at [target]!</span>")
			step_towards(user,target)
			step_towards(user,target)
			spawn(2)
				step_towards(user,target)
			spawn(3) 
				step_towards(user,target)
			if(ishuman(user))
				var/mob/living/carbon/human/H = user
				H.inertial_speed += 6

/* Energy Guns
-Contains
Lasgun
*/						
/obj/item/weapon/gun/energy/complexweapon
	var/bayonet = FALSE //Do we have a bayonet on our gun?

/* Shotguns
-Contains
Shotta
*/
/obj/item/weapon/gun/projectile/shotgun/complexweapon

/* Automatics
-Contains
Slugga
KustomShoota
*/
/obj/item/weapon/gun/projectile/automatic/complexweapon

/* Generic Class
-Contains
Burnapack Flamernozzle
*/

/obj/item/weapon/gun/complexweapon
	var/bayonet = FALSE


/obj/item/weapon
	//We have ctrl click specials
	var/complex_click = FALSE   //If control+click can be used for moves.
	
	//Our ctrl click specials have blocking actions for defensive stance
	var/complex_block = FALSE   //If this has complex block aka parrying or other actions
	var/can_parry = FALSE //Are we capable of parrying?

	//Parrying Variables
	var/parryingCD = FALSE //Are we currently on CD from parrying?
	var/parrying = FALSE //Are we currently parrying?
	var/parryingDIR //The direction we are parrying, for dir comparisons.
	var/parryprob = 110 //Probability
	var/parryduration = 5 //How long we stay in a parrying move
	
	//Armor busters
	var/piercingpower = 0 //How much armor a piercing strike ignores on hit

//Params - I is the object that hits us, param 2 is the person attacking, param 3 is the person who is parrying aka us.
//Obv our object is src
//user.dir target.dir
/obj/item/weapon/proc/handle_block(var/obj/item/I, var/mob/living/user, var/mob/living/target, var/probmod = 0)
	if(can_parry)
		if(src.force >= 10) //If force is less than this level, that probably means it is some kind of inactive blade, and can't be used to parry.
			if(prob((parryprob - I.force)+probmod) && !target.lying) //Not the most elegant solution but I don't want to have to track multiple different variables scattered around objects.
				user.visible_message("<span class ='danger'>[target] has parried [user]'s attack!</span>")
				parryingDIR = FALSE
				return TRUE
			else
				to_chat(target, "<span class = 'danger'> You fail to block the [I]!</span>")
		else if(src.force >= 10 && prob((parryprob - I.force)+probmod)/2)
			user.visible_message("<span class ='danger'>[target] has parried [user]'s attack!</span>")
			return TRUE
		else if(src.force >= 10 && prob((parryprob - I.force)+probmod)/6)
			user.visible_message("<span class ='danger'>[target] has parried [user]'s attack!</span>")
			return TRUE
	return FALSE //basically if it returns true to the segment in human_defense.dm Line 211 we do stuff here.
	//Instead of over there

/obj/item/weapon/proc/handle_ctrlclick(var/mob/living/user, var/mob/living/target)
	parryingDIR = get_dir(user, target)
	if(can_parry) //Can we parry?
		if(!parryingCD) //Are we off CD
			to_chat(user,"<span class='danger'>You prepare to parry a blow from the [parryingDIR].</span>")
			parryingCD = TRUE //Then we enter CD and prepare
			parrying = TRUE
			spawn(parryduration*10) 
				parryingCD = FALSE
			user.click_delayer.setDelay(2)

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
			if(istype(I, /obj/item/weapon/complexweapon) || \
				istype(I, /obj/item/weapon/shield/complexweapon) || \
				istype(I, /obj/item/weapon/gun/projectile/complexweapon))
				H.bumpattack_cooldown = 1
				spawn(10) 
					H.bumpattack_cooldown = 0
				I.attack(H, src)
				return 1
			if(istype(I,/obj/item/weapon/gun/energy/complexweapon))
				var/obj/item/weapon/gun/energy/complexweapon/GUN = I
				if(GUN.bayonet)
					H.bumpattack_cooldown = 1
					spawn(10)
						H.bumpattack_cooldown = 0
					GUN.attack(H, src)
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
		if(isliving(A))
			var/mob/living/M = A
			var/obj/item/weapon/W = src.get_active_hand()
			if(W && W.complex_click)
				W.handle_ctrlclick(src, M)
				return
	..()