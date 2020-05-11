var/const/ENGSEC			=(1<<0)

var/const/GENERAL			=(1<<0)
var/const/COMMISSAR			=(1<<1)
var/const/IGSERGEANT		=(1<<2)
var/const/INQUISITOR		=(1<<3)
var/const/IGWEPSPEC			=(1<<4)
var/const/IGTROOPER			=(1<<5)
var/const/AI				=(1<<6)
var/const/CYBORG			=(1<<7)
var/const/MOMMI				=(1<<8)
var/const/BASICORK 			=(1<<9)
var/const/PRIMARISPSYKER	=(1<<10)
var/const/ORKNOB			=(1<<11)
var/const/ORKWARBOSS		=(1<<12)
var/const/ORKTANKBUSTA		=(1<<13)
var/const/BASICMEK			=(1<<14)

var/const/MEDSCI			=(1<<1)
var/const/DOCTOR			=(1<<0)

var/const/CIVILIAN			=(1<<2)

var/const/BARTENDER			=(1<<1)
var/const/CHEF				=(1<<2)
var/const/JANITOR			=(1<<3)
var/const/MINER				=(1<<4)
var/const/PREACHER			=(1<<5)
var/const/CLOWN				=(1<<6)
var/const/MIME				=(1<<7)
var/const/ASSISTANT			=(1<<8)
var/const/TRADER			=(1<<9)

var/list/command_positions = list(
	"General",
	"Ork Warboss",
)

var/list/secondary_command = list(
	"Commissar",
	"Ork Nob"
)

var/list/engineering_positions = list(
)

var/list/medical_positions = list(
	"Medical Doctor",
)

var/list/science_positions = list()

var/list/civilian_positions = list(
	"Head of Personnel",
	"Bartender",
	"Chef",
	"Janitor",
	"Preacher",
	"Clown",
	"Mime",
	"Assistant"
)

var/list/cargo_positions = list(
)

var/list/security_positions = list(
	"Commissar",
	"Sergeant",
	"Inquisitor",
	"Trooper"
)

var/list/nonhuman_positions = list(
	"AI",
	"Cyborg",
	"pAI",
	"Mobile MMI"
)

var/list/misc_positions = list(
	"Trader",
)

var/list/all_jobs_txt = list(
	"General",
	"Commissar",
	"Medical Doctor",
	"Bartender",
	"Chef",
	"Janitor",
	"Preacher",
	"Clown",
	"Mime",
	"Assistant",
	"Sergeant",
	"Inquisitor",
	"Trooper",
)

var/list/departement_list = list(
	"Command",
	"Security",
	"Cargo",
	"Engineering",
	"Medical",
	"Science",
	"Civilian",
)

/proc/guest_jobbans(var/job)
	return ((job in command_positions) || (job in nonhuman_positions) || (job in security_positions))

/proc/get_job_datums()
	var/list/occupations = list()
	var/list/all_jobs = typesof(/datum/job)

	for(var/A in all_jobs)
		var/datum/job/job = new A()
		if(!job)
			continue
		occupations += job

	return occupations

/proc/get_alternate_titles(var/job)
	var/list/jobs = get_job_datums()
	var/list/titles = list()

	for(var/datum/job/J in jobs)
		if(!J)
			continue
		if(J.title == job)
			titles = J.alt_titles

	return titles
