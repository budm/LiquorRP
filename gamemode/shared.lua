/*--------------------------------------------------------
Default teams. If you make a team above the citizen team, people will spawn with that team!
--------------------------------------------------------*/
TEAM_CITIZEN = AddExtraTeam("Citizen", {
	color = Color(0, 255, 0, 255),
	model = {
		"models/player/Group01/Female_01.mdl",
		"models/player/Group01/Female_02.mdl",
		"models/player/Group01/Female_03.mdl",
		"models/player/Group01/Female_04.mdl",
		"models/player/Group01/Female_06.mdl",
		"models/player/Group01/Female_07.mdl",
		"models/player/group01/male_01.mdl",
		"models/player/Group01/Male_02.mdl",
		"models/player/Group01/male_03.mdl",
		"models/player/Group01/Male_04.mdl",
		"models/player/Group01/Male_05.mdl",
		"models/player/Group01/Male_06.mdl",
		"models/player/Group01/Male_07.mdl",
		"models/player/Group01/Male_08.mdl",
		"models/player/Group01/Male_09.mdl"
	},
	description = [[The Citizen is the most basic level of society you can hold
		besides being a hobo.
		You have no specific role in city life.
		But a good bottle of booze always helps
		modivate people. go find some!]],
	weapons = {},
	command = "citizen",
	max = 0,
	salary = 45,
	admin = 0,
	vote = false,
	hasLicense = false
})

TEAM_POLICE = AddExtraTeam("Police", {
	color = Color(0, 0, 255, 255),
	model = {
		"models/JesseV92/player/cs-go/ct_gign.mdl",
		"models/JesseV92/player/cs-go/ct_gsg9.mdl",
		"models/JesseV92/player/cs-go/ct_sas.mdl"
	},
	description = [[The protector of every citizen that lives in the city .
		You have the power to arrest criminals and protect innocents.
		Hit them with your arrest baton to put them in jail
		Bash them with a stunstick and they might learn better than to disobey
		the law.
		The Battering Ram can break down the door of a criminal with a warrant
		for his/her arrest.
		The Battering Ram can also unfreeze frozen props(if enabled).
		Type /wanted <name> to alert the public to this criminal
		OR go to tab and warrant someone by clicking the warrant button]],
	weapons = {"arrest_stick", "unarrest_stick", "stunstick", "door_ram", "weaponchecker"},
	command = "cp",
	max = 12,
	salary = 65,
	admin = 0,
	vote = true,
	hasLicense = true
})

TEAM_GANG = AddExtraTeam("Bootlegger", {
	color = Color(75, 75, 75, 255),
	model = {
		"models/player/Group03/Female_01.mdl",
		"models/player/Group03/Female_02.mdl",
		"models/player/Group03/Female_03.mdl",
		"models/player/Group03/Female_04.mdl",
		"models/player/Group03/Female_06.mdl",
		"models/player/Group03/Female_07.mdl",
		"models/player/group03/male_01.mdl",
		"models/player/Group03/Male_02.mdl",
		"models/player/Group03/male_03.mdl",
		"models/player/Group03/Male_04.mdl",
		"models/player/Group03/Male_05.mdl",
		"models/player/Group03/Male_06.mdl",
		"models/player/Group03/Male_07.mdl",
		"models/player/Group03/Male_08.mdl",
		"models/player/Group03/Male_09.mdl"},
	description = [[The Bootlegger, is responsible for distributing bootleg Liquor
	  to Average Civilians With Hopes they will buy their liquor over legitimate liquor or beer
     The Moonshiner sets your agenda and you follow it or you might be punished.]],
	weapons = {},
	command = "bootlegger",
	max = 3,
	salary = 45,
	admin = 0,
	vote = false,
	hasLicense = false
})

TEAM_MOB = AddExtraTeam("Moonshiner", {
	color = Color(25, 25, 25, 255),
	model = "models/player/gman_high.mdl",
	description = [[The Moonshiner is the provider of all bootleg liquor in the city.
		With his power he coordinates the bootleggers and forms an efficent distribution
		Ring.
		He has the ability to brew bootleg Liquor]],
	weapons = {},
	command = "moonshiner",
	max = 1,
	salary = 60,
	admin = 0,
	vote = false,
	hasLicense = true
})

TEAM_GUN = AddExtraTeam("Bartender", {
	color = Color(255, 140, 0, 255),
	model = "models/player/monk.mdl",
	description = [[The go to man for beer in the town, he sells from or by the barrel
		However, make sure you aren't caught selling barrels to the public.
		/Buyshipment <name> to Buy a  weapon shipment
		/Buygunlab to Buy a gunlab that spawns P228 pistols]],
	weapons = {},
	command = "bartender",
	max = 2,
	salary = 45,
	admin = 0,
	vote = false,
	hasLicense = false
})

TEAM_MEDIC = AddExtraTeam("Medic", {
	color = Color(255, 0, 255, 255),
	model = "models/player/kleiner.mdl",
	description = [[With your medical knowledge,
		you heal players to proper
		health.
		Without a medic, people can not be healed.
		Left click with the Medical Kit to heal other players.
		Right click with the Medical Kit to heal yourself.]],
	weapons = {"med_kit"},
	command = "medic",
	max = 8,
	salary = 45,
	admin = 0,
	vote = false,
	hasLicense = false
})

TEAM_CHIEF = AddExtraTeam("Civil Protection Chief", {
	color = Color(20, 20, 255, 255),
	model = "models/JesseV92/player/cs-go/ct_urban.mdl",
	description = [[The Chief is the leader of the Civil Protection unit.
		Coordinate the police forces to bring law to the city
		Hit them with arrest baton to put them in jail
		Bash them with a stunstick and they might learn better than to
		disobey the law.
		The Battering Ram can break down the door of a criminal with a
		warrant for his/her arrest.
		Type /wanted <name> to alert the public to this criminal
		Type /jailpos to set the Jail Position]],
	weapons = {"arrest_stick", "unarrest_stick", "stunstick", "door_ram", "weaponchecker"},
	command = "chief",
	max = 1,
	salary = 75,
	admin = 0,
	vote = false,
	hasLicense = true,
	NeedToChangeFrom = TEAM_POLICE
})

TEAM_MAYOR = AddExtraTeam("Mayor", {
	color = Color(255, 0, 0, 255),
	model = "models/player/breen.mdl",
	description = [[The Mayor of the city creates laws to serve the greater good
	of the people.
	If you are the mayor you may create and accept warrants.
	Type /wanted <name>  to warrant a player
	Type /jailpos to set the Jail Position
	Type /lockdown initiate a lockdown of the city.
	Bars are a safe place when a lockdown is occuring.
	Everyone must be inside during a lockdown.
	The cops patrol the area
	/unlockdown to end a lockdown]],
	weapons = {},
	command = "mayor",
	max = 1,
	salary = 85,
	admin = 0,
	vote = true,
	hasLicense = false
})

TEAM_HOBO = AddExtraTeam("Poor Drunk", {
	color = Color(80, 45, 0, 255),
	model = "models/player/corpse1.mdl",
	description = [[The lowest member of society. All people see you laugh.
		You have no home.
		Beg for your liquor.
		Sing for everyone who passes to get money
		Make your own wooden home somewhere in a corner or
		outside someone else's door]],
	weapons = {"weapon_bugbait"},
	command = "drunk",
	max = 5,
	salary = 0,
	admin = 0,
	vote = false,
	hasLicense = false
})

TEAM_DRUGDEALER = AddExtraTeam("Drug Dealer", {
	color = Color(120, 120, 120, 255),
	model = "models/player/Group01/Male_08.mdl",
	description = [[The drug dealer can sell cannabis seeds, cocaine,
	shrooms, pills, and lsd.]],
	weapons = {},
	command = "drugdealer",
	max = 5,
	salary = 0,
	admin = 0,
	vote = false,
	hasLicense = false
})


//ADD CUSTOM TEAMS UNDER THIS LINE:









/*
--------------------------------------------------------
HOW TO MAKE A DOOR GROUP
--------------------------------------------------------
AddDoorGroup("NAME OF THE GROUP HERE, you see this when looking at a door", Team1, Team2, team3, team4, etc.)

WARNING: THE DOOR GROUPS HAVE TO BE UNDER THE TEAMS IN SHARED.LUA. IF THEY ARE NOT, IT MIGHT MUCK UP!


The default door groups, can also be used as examples:
*/
AddDoorGroup("Cops and Mayor only", TEAM_CHIEF, TEAM_POLICE, TEAM_MAYOR)
AddDoorGroup("Bartender only", TEAM_GUN)


/*
--------------------------------------------------------
HOW TO MAKE AN AGENDA
--------------------------------------------------------
AddAgenda(Title of the agenda, Manager (who edits it), Listeners (the ones who just see and follow the agenda))

WARNING: THE AGENDAS HAVE TO BE UNDER THE TEAMS IN SHARED.LUA. IF THEY ARE NOT, IT MIGHT MUCK UP!

The default agenda's, can also be used as examples:
*/
AddAgenda("Moonshiner's agenda", TEAM_MOB, {TEAM_GANG})
AddAgenda("Police agenda", TEAM_MAYOR, {TEAM_CHIEF, TEAM_POLICE})


--------------------------------------------------------
-- Misc stuff for LiquorRP
--------------------------------------------------------

// Card values
CARD_ACE = 1;
CARD_2 = 2;
CARD_3 = 3;
CARD_4 = 4;
CARD_5 = 5;
CARD_6 = 6;
CARD_7 = 7;
CARD_8 = 8;
CARD_9 = 9;
CARD_10 = 10;
CARD_JACK = 11;
CARD_QUEEN = 12;
CARD_KING = 13;

// Card types
CARD_DIAMOND = 13;
CARD_HEART = 14;
CARD_CLUB = 15;
CARD_SPADE = 16;

// Card counts
GM.CardValues = {};
GM.CardValues[CARD_ACE] = 11;
GM.CardValues[CARD_2] = 2;
GM.CardValues[CARD_3] = 3;
GM.CardValues[CARD_4] = 4;
GM.CardValues[CARD_5] = 5;
GM.CardValues[CARD_6] = 6;
GM.CardValues[CARD_7] = 7;
GM.CardValues[CARD_8] = 8;
GM.CardValues[CARD_9] = 9;
GM.CardValues[CARD_10] = 10;
GM.CardValues[CARD_JACK] = 10;
GM.CardValues[CARD_QUEEN] = 10;
GM.CardValues[CARD_KING] = 10;

// Weather
WEATHER_NORMAL = 1;
WEATHER_SUNNY = 2;
WEATHER_CLOUDY = 3;
WEATHER_CLOUDY_REC = 4;
//WEATHER_RAINY = 5;
//WEATHER_STORMY = 6;
//WEATHER_STORM = 6;
//WEATHER_STORMY_PRE = 7;
//WEATHER_STORMY_HEAVY = 8;
