
//Im doing this on roles because im feeling lazy.
//Nevermind
//Anyways See: onclick human.dm line 379 for our entry
//We basically have to call update_powerwords_hud on the mob when we need to update it.

//Location of the power words area thing. See: _defines.dm for the rest
#define ui_powerwords "CENTER-1.5,NORTH-1:10"

/datum/hud/proc/powerwords_hud()
	// Display our currently active words.
	powerwords_display = getFromPool(/obj/abstract/screen)
	powerwords_display.name = "POWER WORDS"
	powerwords_display.icon = 'z40k_shit/icons/slightly_black_rectangle.dmi'
	powerwords_display.icon_state = "dark128x42"
	powerwords_display.screen_loc = ui_powerwords

	mymob.client.screen += list(powerwords_display)

/mob/living/carbon/human/proc/update_powerwords_hud()
	if(hud_used)
		if(!hud_used.powerwords_display)
			hud_used.powerwords_hud()
			//hud_used.human_hud(hud_used.ui_style)
		
		var/conversion_string //Basically this is our conversion string, we now exist.
		conversion_string = word_combo_chain //Then we make it our word combo chain
		//Then we regex stuff
		if(findtext(conversion_string, "pierce")) //Basically we can get our colors on this way.
			conversion_string = replacetext(conversion_string, "pierce", "<font color='#FFFF00'>Pierce</font>") //This one is grab
		if(findtext(conversion_string, "disarm"))
			conversion_string = replacetext(conversion_string, "disarm", "<font color='#0000FF'>Disarm</font>") //This one is disarm
		if(findtext(conversion_string, "hamstring"))
			conversion_string = replacetext(conversion_string, "hamstring", "<font color='#00FF00'>Hamstring</font>") //This one is help
		if(findtext(conversion_string, "hurt"))
			conversion_string = replacetext(conversion_string, "hurt", "<font color='#FF0000'>Hurt</font>") //This one is hurt
		if(findtext(conversion_string, "charge"))
			conversion_string = replacetext(conversion_string, "charge", "<font color='#FF9933'><b>Charge!</b></font>") //This one is hurt
		if(findtext(conversion_string, "parry"))
			conversion_string = replacetext(conversion_string, "parry", "<font color='#EE82EE'><b>Parry!</b></font>") //This one is hurt

		hud_used.powerwords_display.maptext_width = 128
		hud_used.powerwords_display.maptext_height = 42
		hud_used.powerwords_display.maptext = "<div align='left' valign='top' style='position:relative; top:0px; left:6px'>\
				<br>\
				[conversion_string]<br>\
				</div>"
	return