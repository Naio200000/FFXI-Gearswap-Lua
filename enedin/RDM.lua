--[[

----------------
-- Properties --
----------------

Only job-specific properties are shown here. For the general list, more info, tips etc. visit my Gearswap page: https://enedin.be/gs/

AUTOMATIC
- When resting, changes to a hMP/MP hybrid set once you've capped MP in your full hMP set.
- Keeps on MP gear after using Convert, so you don't lose MP.
- Equips Uggalepih Pendant for nuking when your MP is low enough.

COMMANDS
- fightMode						Toggle mage/melee mode.
- meleeMode						Cycle melee sets.
- wpnxxx						Switch weapons. (xxx is the name of the weapon set, see sets.weapons.xxx)
- c3convert / c4convert			Cast post-Convert Cure 3 or 4 with more MP, so you don't lose MP.
- enfeebPot						Toggle enfeebling in potency/skill.
- nukeDmg						Toggle nuking in potency/skill.
- dispmp						Toggle showing spells' MP cost and other info.

-------------------------
-- Tips/Best practices --
-------------------------

- After Convert, use the c3convert/c4convert commands to cure yourself without losing MP.
- You can switch melee sets and weapons while in mage mode, but you'll only notice the change when switching to melee mode.

---------------------
-- About this file --
---------------------

CHANGELOG
- v2.3:		added throwing weapon/melee set
- v2.21:	adjusted Ugg. Pendant handling to be more accurate
- v2.2:		updated Obi and Ugg. Pendant handling
- v2.1:		improved message accuracy for Bind and Sleep
- v2.0:		base (core functionality)	

CREDITS
- Adapted this from Wren's GearSwap luas: https://supernovaffxi.fandom.com/wiki/Wren%27s_Gearswaps	

]]--

----------
-- Sets --
----------

function get_sets()

	-- Including this gives an easy way of defining cyclic/trigger/etc variables, makes handling self_commands easier.
	-- Motes also uses this, but this is completely independent from Motes
	include('Modes.lua')
	
	-- Idle sets
	
	sets.idle = { -- Movement, PDT, MDT, Refresh, HP, MP
	    main		= "Terra's Staff",
		sub			= "Reign Grip",
		range		= "Aureole",
		head		= "Dls. Chapeau +1",
		body		= "Dalmatica +1",
		hands		= "Zenith Mitts +1",
		legs		= "Blood Cuisses",
		feet		= "Zenith Pumps +1",
		neck		= "Orochi Nodowa +1",
		waist		= "Hierarch Belt",
		left_ear	= "Novia Earring",
		right_ear	= "Ethereal Earring",
		left_ring	= "Shadow Ring",
		right_ring	= "Defending Ring",
		back		= "Umbra Cape",
	}
	
	-- Magic sets
	
	sets.enfeebling_magic = {}
	sets.enfeebling_magic.int = { -- Skill (macc) > INT (pot)
	    main		= "Chatoyant Staff",
		sub			= "Bugard Strap +1",
		range		= "Aureole",
		head		= "Dls. Chapeau +1",
		body		= "Warlock's Tabard",
		hands		= "Bricta's Cuffs",
		legs		= "Nashira Seraweels",
		feet		= "Goliard Clogs",
		neck		= "Enfeebling Torque",
		waist		= "Witch Sash",
		left_ear	= "Incubus Earring +1",
		right_ear	= "Incubus Earring +1",
		left_ring	= "Galdr Ring",
		right_ring	= "Balrahn's Ring",
		back		= "Altruistic Cape",
	}
	sets.enfeebling_magic.intpotency = { -- INT (pot) > Skill (macc)
	    main		= "Alkalurops",
		sub			= "Bugard Strap +1",
		range		= "Aureole",
		head		= "Dls. Chapeau +1",
		body		= "Mahatma Hpl.",
		hands		= "Bricta's Cuffs",
		legs		= "Mahatma Slops",
		feet		= "Goliard Clogs",
		neck		= "Lmg. Medallion +1",
		waist		= "Witch Sash",
		left_ear	= "Omn. Earring",
		right_ear	= "Omn. Earring",
		left_ring	= "Galdr Ring",
		right_ring	= "Omniscient Ring",
		back		= "Prism Cape",
	}
	sets.enfeebling_magic.mnd = { -- Skill (macc) > MND (pot)
	    main		= "Chatoyant Staff",
		sub			= "Reign Grip",
		range		= "Aureole",
		head		= "Dls. Chapeau +1",
		body		= "Warlock's Tabard",
		hands		= "Bricta's Cuffs",
		legs		= "Nashira Seraweels",
		feet		= "Goliard Clogs",
		neck		= "Enfeebling Torque",
		waist		= "Witch Sash",
		left_ear	= "Incubus Earring +1",
		right_ear	= "Incubus Earring +1",
		left_ring	= "Celestial Ring",
		right_ring	= "Balrahn's Ring",
		back		= "Altruistic Cape",
	}
	sets.enfeebling_magic.mndpotency = { -- MND (pot) > Skill (macc)
	    main		= "Alkalurops",
		sub			= "Reign Grip",
		range		= "Aureole",
		head		= "Dls. Chapeau +1",
		body		= "Mahatma Hpl.",
		hands		= "Bricta's Cuffs",
		legs		= "Mahatma Slops",
		feet		= "Mahatma Pigaches",
		neck		= "Gnole Torque",
		waist		= "Witch Sash",
		left_ear	= "Celestial Earring",
		right_ear	= "Celestial Earring",
		left_ring	= "Celestial Ring",
		right_ring	= "Celestial Ring",
		back		= "Dew Silk Cape +1",
	}
	
	sets.enhancing_magic = { -- Skill (pot)
	    main		= "Chatoyant Staff",
		sub			= "Vivid Strap +1",
		range		= "Aureole",
		head		= "Wlk. Chapeau +1",
		body		= "Dls. Tabard +1",
		hands		= "Dls. Gloves +1",
		legs		= "Warlock's Tights",
		feet		= "Zenith Pumps +1",
		neck		= "Enhancing Torque",
		waist		= "Hierarch Belt",
		left_ear	= "Augment. Earring",
		right_ear	= "Loquac. Earring",
		left_ring	= "Serket Ring",
		right_ring	= "Ether Ring",
		back		= "Merciful Cape",
	}
	sets.enhancing_magic.stoneskin = { -- MND (pot), Fast Cast/MP when cap is reached
	-- With 272 (256+16merits) skill and 450 being SN cap, you need 123 MND on RDM to get cap	
		main		= "Alkalurops",
		sub			= "Reign Grip",
		range		= "Aureole",
		head		= "Wlk. Chapeau +1",
		body		= "Dls. Tabard +1",
		hands		= "Zenith Mitts +1",
		legs		= "Mahatma Slops",
		feet		= "Mahatma Pigaches",
		neck		= "Stone Gorget",
		waist		= "Pythia Sash +1",
		left_ear	= "Celestial Earring",
		right_ear	= "Loquac. Earring",
		left_ring	= "Celestial Ring",
		right_ring	= "Celestial Ring",
		back		= "Dew Silk Cape +1",
	}
	
	sets.healing_magic = { -- Cure Potency > 1MND = 3VIT = 5skill
	    main		= "Chatoyant Staff",
		sub			= "Reign Grip",
		range		= "Aureole",
		head		= "Maat's Cap",
		body		= "Mahatma Hpl.",
		hands		= "Dvt. Mitts +1",
		legs		= "Jet Seraweels",
		feet		= "Mahatma Pigaches",
		neck		= "Fylgja Torque +1",
		waist		= "Pythia Sash +1",
		left_ear	= "Roundel Earring",
		right_ear	= "Celestial Earring",
		left_ring	= "Celestial Ring",
		right_ring	= "Celestial Ring",
		back		= "Dew Silk Cape +1",
	}
	
	sets.healing_magic.convert = set_combine(sets.healing_magic,{ -- MP
		hands		= "Zenith Mitts +1",
		legs		= "Zenith Slacks +1",
		waist		= "Hierarch Belt",
		left_ring	= "Serket Ring",
	})
	
	sets.elemental_magic = { -- Magic Attack Bonus > INT > Skill
	    main		= "Chatoyant Staff",
		sub			= "Bugard Strap +1",
		range		= "Aureole",
		head		= "Wlk. Chapeau +1",
		body		= "Mahatma Hpl.",
		hands		= "Zenith Mitts +1",
		legs		= "Mahatma Slops",
		feet		= "Dls. Boots +1",
		neck		= "Lmg. Medallion +1",
		waist		= "Witch Sash",
		left_ear	= "Novio Earring",
		right_ear	= "Moldavite Earring",
		left_ring	= "Galdr Ring",
		right_ring	= "Omniscient Ring",
		back		= "Hecate's Cape",
	}
	sets.elemental_magic.skill = set_combine(sets.elemental_magic,{ -- Skill
	    hands		= "Genie Gages",
		legs		= "Dls. Tights +1",
		feet		= "Shrewd Pumps",
	})
	sets.elemental_magic.debuffs={ -- INT
		main		= "Chatoyant Staff",
		sub			= "Bugard Strap +1",
		ammo		= "Phtm. Tathlum",
		head		= "Maat's Cap",
		body		= "Mahatma Hpl.",
		hands		= "Mahatma Cuffs",
		legs		= "Mahatma Slops",
		feet		= "Goliard Clogs",
		neck		= "Lmg. Medallion +1",
		waist		= "Witch Sash",
		left_ear	= "Omn. Earring",
		right_ear	= "Omn. Earring",
		left_ring	= "Galdr Ring",
		right_ring	= "Omniscient Ring",
		back		= "Prism Cape",
	}
	
	sets.dark_magic = { -- Skill (pot/macc) > INT (macc)
	    main		="Chatoyant Staff",
		sub			="Dark Grip",
		range		="Aureole",
		head		="Nashira Turban",
		body		="Nashira Manteel",
		hands		="Blood Fng. Gnt.",
		legs		="Mahatma Slops",
		feet		="Goliard Clogs",
		neck		="Dark Torque",
		waist		="Witch Sash",
		left_ear	="Dark Earring",
		right_ear	="Incubus Earring +1",
		left_ring	="Galdr Ring",
		right_ring	="Balrahn's Ring",
		back		="Merciful Cape",
	}
	sets.dark_magic.stun = set_combine(sets.dark_magic,{ -- Fast Cast = Haste
		main		="Chatoyant Staff",
		sub			="Vivid Strap +1",
		head		="Wlk. Chapeau +1",
		body		="Dls. Tabard +1",
		hands		="Dusk Gloves +1",
		feet		="Dusk Ledelsens +1",
		waist		="Ninurta's Sash",
		right_ear	="Loquac. Earring",
	})
	
	sets.utsusemi = { -- Haste, Spell Interrupt Down
		main		= "Eremite's Wand",
		sub			= "Eremite's Wand",
		range		= "Aureole",
		head		= "Wlk. Chapeau +1",
		body		= "Dls. Tabard +1",
		hands		= "Dusk Gloves +1",
		legs		= "Nashira Seraweels",
		feet		= "Karasutengu",
		neck		= "Uggalepih Pendant",
		waist		= "Ninurta's Sash",
		left_ear	= "Astral Earring",
		right_ear	= "Loquac. Earring",
		left_ring	= "Serket Ring",
		right_ring	= "Defending Ring",
		back		= "Umbra Cape",
	}
	
	-- Fast Cast and Haste sets

	sets.precastfastcast = { -- Fast Cast (casting time)
		main		= "Terra's Staff",
		sub			= "Vivid Strap +1",
		range		= "Aureole",
		head		= "Wlk. Chapeau +1",
		body		= "Dls. Tabard +1",
		hands		= "Zenith Mitts +1",
		legs		= "Zenith Slacks +1",
		feet		= "Dls. Boots +1",
		neck		= "Uggalepih Pendant",
		waist		= "Hierarch Belt",
		left_ear	= "Astral Earring",
		right_ear	= "Loquac. Earring",
		left_ring	= "Serket Ring",
		right_ring	= "Defending Ring",
		back		= "Gigant Mantle",
	}
	
	sets.fastcasthaste = { -- Fast Caste = Haste (recast time)
		main		= "Terra's Staff",
		sub			= "Vivid Strap +1",
		range		= "Aureole",
	    head		= "Wlk. Chapeau +1",
		body		= "Dls. Tabard +1",
		hands		= "Dusk Gloves +1",
		legs		= "Nashira Seraweels",
		feet		= "Dusk Ledelsens +1",
		neck		= "Uggalepih Pendant",
		waist		= "Ninurta's Sash",
		left_ear	= "Astral Earring",
		right_ear	= "Loquac. Earring",
		left_ring	= "Serket Ring",
		right_ring	= "Ether Ring",
		back		= "Umbra Cape",
	}
	
	-- Other sets
	
	sets.resting = { -- hMP
	    main		="Imperial Wand",
		sub			="Legion Scutum",
		range		= "Aureole",
		head		="Mirror Tiara",
		body		="Mahatma Hpl.",
		hands		="Genie Gages",
		legs		="Hydra Brais",
		feet		="Goliard Clogs",
		neck		="Gnole Torque",
		waist		="Duelist's Belt",
		left_ear	="Relaxing Earring",
		right_ear	="Antivenom Earring",
		left_ring	="Celestial Ring",
		right_ring	="Celestial Ring",
		back		="Invigorating Cape",
	}
	
	sets.resting.mp = set_combine(sets.resting,{ -- MP
		head		= "Zenith Crown +1",
		hands		= "Zenith Mitts +1",
		legs		= "Zenith Slacks +1",
		left_ring	= "Serket Ring",
	})
	
	sets.matching_dayweather = {waist = "Hachirin-no-Obi"}
	sets.icestaff = {main = "Aquilo's Staff"}
	sets.darkgrip = {sub = 'Dark Grip'}
	
	-- Melee sets
	
	sets.melee = {}
	sets.melee.haste = { -- Haste, for fighting easy stuff
		head		="Walahra Turban",
		body		="Goliard Saio",
		hands		="Dusk Gloves +1",
		legs		="Nashira Seraweels",
		feet		="Dusk Ledelsens +1",
		neck		="Fortitude Torque",
		waist		="Ninurta's Sash",
		left_ear	="Suppanomimi",
		right_ear	="Brutal Earring",
		left_ring	="Rajas Ring",
		right_ring	="Flame Ring",
		back		="Cerb. Mantle +1",
	}
	sets.melee.hacc = { -- Haste, Accuracy, for fighting moderate stuff
	    head		="Walahra Turban",
		body		="Goliard Saio",
		hands		="Dusk Gloves +1",
		legs		="Hydra Brais",
		feet		="Dusk Ledelsens +1",
		neck		="Ancient Torque",
		waist		="Ninurta's Sash",
		left_ear	="Suppanomimi",
		right_ear	="Brutal Earring",
		left_ring	="Rajas Ring",
		right_ring	="Toreador's Ring",
		back		="Cuchulain's Mantle",
	}
	sets.melee.acc = { -- Accuracy, for fighting hard stuff
	    head		="Optical Hat",
		body		="Antares Harness",
		hands		="Hydra Gloves",
		legs		="Hydra Brais",
		feet		="Hydra Gaiters",
		neck		="Ancient Torque",
		waist		="Virtuoso Belt",
		left_ear	="Suppanomimi",
		right_ear	="Brutal Earring",
		left_ring	="Toreador's Ring",
		right_ring	="Toreador's Ring",
		back		="Cuchulain's Mantle",
	}
	sets.throwing = {
		range		= "Aureole",
		head		= "Optical Hat",
		neck		= "Peacock Amulet",
		left_ring	= "Dragon Ring +1",
		right_ring	= "Dragon Ring +1",
		back        = "Jaeger Mantle",
	}
	
	sets.weapons = {}
	sets.weapons.swsh = {
		main		="Excalibur",
		sub			="Genbu's Shield",
		range       = "",
        ammo        = "White Tathlum",
	}
	sets.weapons.dgsh = {
		main		="Mandau",
		sub			="Genbu's Shield",
		range       = "",
        ammo        = "White Tathlum",
	}
	sets.weapons.kcsh = {
		main		="Kraken Club",
		sub			="Genbu's Shield",
		range       = "",
        ammo        = "White Tathlum",
	}
	sets.weapons.swdg = {
		main		="Excalibur",
		sub			="Mandau",
		range       = "",
        ammo        = "White Tathlum",
	}
	sets.weapons.dgsw = {
		main		="Mandau",
		sub			="Excalibur",
		range       = "",
        ammo        = "White Tathlum",
	}
	sets.weapons.swkc = {
		main		="Excalibur",
		sub			="Kraken Club",
		range       = "",
        ammo        = "White Tathlum",
	}
	sets.weapons.dgkc = {
		main		="Mandau",
		sub			="Kraken Club",
		range       = "",
        ammo        = "White Tathlum",
	}
	
	sets.ws = {}
	sets.ws.haste = {}
	sets.ws.hacc = {}
	sets.ws.acc = {}
	
	sets.ws.haste.mercystroke = { -- 80%STR
	    head		= "Maat's Cap",
		body		= "Antares Harness",
		hands		= "Alkyoneus's Brc.",
		legs		= "Dusk Trousers +1",
		feet		= "Ogre Ledelsens +1",
		neck		= "Fotia Gorget",
		waist		= "Warwolf Belt",
		left_ear	= "Harmonius Earring",
		right_ear	= "Brutal Earring",
		left_ring	= "Rajas Ring",
		right_ring	= "Flame Ring",
		back		= "Cerb. Mantle +1",
	}
	sets.ws.hacc.mercystroke = set_combine(sets.ws.haste.mercystroke,{ -- with some acc
		feet		= "Hydra Gaiters",
	})
	sets.ws.acc.mercystroke = set_combine(sets.ws.hacc.mercystroke,{ -- with some more acc
		waist		= "Virtuoso Belt",
		right_ring	= "Toreador's Ring",
		back		= "Cuchulain's Mantle",
	})
	sets.ws.haste.evisceration = { -- 30% DEX
	    head		= "Maat's Cap",
		body		= "Antares Harness",
		hands		= "Alkyoneus's Brc.",
		legs		= "Dusk Trousers +1",
		feet		= "Ogre Ledelsens +1",
		neck		= "Fotia Gorget",
		waist		= "Warwolf Belt",
		left_ear	= "Pixie Earring",
		right_ear	= "Brutal Earring",
		left_ring	= "Rajas Ring",
		right_ring	= "Adroit Ring",
		back		= "Cerb. Mantle +1",
	}
	sets.ws.hacc.evisceration = set_combine(sets.ws.haste.evisceration,{ -- with some acc
		back		= "Cuchulain's Mantle",
		feet		= "Hydra Gaiters",
	})
	sets.ws.acc.evisceration = set_combine(sets.ws.hacc.evisceration,{ -- with some more acc
		waist		= "Virtuoso Belt",
		right_ring	= "Toreador's Ring",
	})
	sets.ws.haste.kor = { -- 40%STR, 40%MND (about the same for Death Blossom)
		head		= "Maat's Cap",
		body		= "Antares Harness",
		hands		= "Alkyoneus's Brc.",
		legs		= "Dusk Trousers +1",
		feet		= "Ogre Ledelsens +1",
		neck		= "Fotia Gorget",
		waist		= "Warwolf Belt",
		left_ear	= "Harmonius Earring",
		right_ear	= "Brutal Earring",
		left_ring	= "Rajas Ring",
		right_ring	= "Flame Ring",
		back		= "Cerb. Mantle +1",
	}
	sets.ws.hacc.kor = set_combine(sets.ws.haste.kor,{ -- with some acc
	})
	sets.ws.acc.kor = set_combine(sets.ws.hacc.kor,{ -- with some more acc
		waist		= "Virtuoso Belt",
		right_ring	= "Toreador's Ring",
		back		= "Cuchulain's Mantle",
	})
	sets.ws.haste.vorpalblade = { -- 60%STR
		head		= "Maat's Cap",
		body		= "Antares Harness",
		hands		= "Alkyoneus's Brc.",
		legs		= "Dusk Trousers +1",
		feet		= "Ogre Ledelsens +1",
		neck		= "Fotia Gorget",
		waist		= "Warwolf Belt",
		left_ear	= "Harmonius Earring",
		right_ear	= "Brutal Earring",
		left_ring	= "Rajas Ring",
		right_ring	= "Flame Ring",
		back		= "Cerb. Mantle +1",
	}
	sets.ws.hacc.vorpalblade = set_combine(sets.ws.haste.vorpalblade,{ -- with some acc
		waist		= "Virtuoso Belt",
		right_ring	= "Toreador's Ring",
		back		= "Cuchulain's Mantle",
		feet		= "Hydra Gaiters",
	})
	sets.ws.acc.vorpalblade = set_combine(sets.ws.hacc.vorpalblade,{ -- with some more acc
	    body		= "Hydra Doublet",
		hands		= "Hydra Gloves",
		legs		= "Hydra Brais",
		feet		= "Hydra Gaiters",
		neck		= "Fotia Gorget",
		waist		= "Virtuoso Belt",
		left_ear	= "Harmonius Earring",
		right_ear	= "Brutal Earring",
		left_ring	= "Toreador's Ring",
		right_ring	= "Toreador's Ring",
		back		= "Cuchulain's Mantle",
	})
	sets.ws.truestrike = { -- 100% STR
	    head		= "Maat's Cap",
		body		= "Antares Harness",
		hands		= "Alkyoneus's Brc.",
		legs		= "Dusk Trousers +1",
		feet		= "Ogre Ledelsens +1",
		neck		= "Fotia Gorget",
		waist		= "Warwolf Belt",
		left_ear	= "Harmonius Earring",
		right_ear	= "Brutal Earring",
		left_ring	= "Rajas Ring",
		right_ring	= "Flame Ring",
		back		= "Cerb. Mantle +1",
	}
	
	---------------
	-- Variables --
	---------------

	-- Don't change this:
	converting = false 			
	
	-- Default values, feel free to change
	nukeDmg = true 											-- true = nuking in damage (vs skill)
	enfeebPot = true 										-- true = enfeebling in potency (vs skill)
	display_mp_cost = true 									-- true = show cost of MP
	currentWeapons = 'swsh'									-- current weapons
	
	-- Lists of options. Default value is the first one
	clippingPlane = M{'1', '0.75', '0.5', '10', '5', '2'} 	-- config ClippingPlane value
	fightMode = M{'mage', 'melee'} 							-- fight modes
	meleeMode = M{'haste','hacc','acc'} 					-- melee modes

	initializeNakedHPMP() -- initialize HP and MP values for use in Uggalepih Pendant calculation

end

---------------
-- Functions --
---------------

function initializeNakedHPMP() -- magic numbers because the HP/MP % checks for latents aren't coded properly on LSB. It uses naked HP/MP, no gear, no food, no max HP/MP boost traits, but it does include HP and MP merits. Others will have to figure out these values for themselves for their own character.
    if player.sub_job == 'BLM' then
        nakedHP = 1147
        nakedMP = 671
    elseif player.sub_job == 'WHM' then
        nakedHP = 1166
        nakedMP = 652
    elseif player.sub_job == 'SCH' then
        nakedHP = 1166
        nakedMP = 643
    else
        nakedHP = 1214
        nakedMP = 574
    end
end

function status_change(new,old)
    choose_set()
end

-- Main function that decides whether to equip engaged/idle/resting gear
function choose_set()
    if player.status == "Engaged" then
        equip_engaged()
    elseif player.status == "Resting" then
		equip_rest()
	else
        equip_idle()
    end
end

function equip_engaged()

	local temp = fightMode.value
	if temp == 'melee' then
		-- equip a melee set when in melee mode
		equip(sets.melee[meleeMode.value])
	elseif temp == 'mage' then
		-- RDM has no staff skill: when in mage mode, disengage or go to melee mode
		equip_idle()
	end
end
 
function equip_idle()
	equip(sets.idle)
end
 
function equip_ws(name)

	if name == "True Strike" then
		equip(sets.ws.truestrike)
	elseif name == 'Knights of Round' then
		equip((sets.ws[meleeMode.current]).kor)
	elseif name == 'Vorpal Blade' or name == 'Savage Blade' or name == 'Circle Blade' or name == 'Death Blossom' then
		equip((sets.ws[meleeMode.current]).vorpalblade)
	elseif name == 'Mercy Stroke' then
		equip((sets.ws[meleeMode.current]).mercystroke)
	elseif name == 'Evisceration' then
		equip((sets.ws[meleeMode.current]).evisceration)
	else
		equip(sets.ws.haste.mercystroke) -- catchall, just STR in most places
	end

end 
 
function equip_rest()
	equip(sets.resting)
end

-- Auto-change to resting set with more MP when reaching treshold
windower.register_event('mpp change', function(new,old)
	if player.status == "Resting" then
	
		-- equip resting MP set if MP is near maximum in regular resting set
		if player.mpp > 95 then 
			equip(sets.resting.mp)
			windower.add_to_chat(122,'Switching to resting MP set.')
		end
	end
end)

-- Decide whether to use obi or not
function obi_check(spell)
    local weak_to_element = {Dark="Light",Light="Dark",Ice="Fire",Wind="Ice",Earth="Wind",Lightning="Earth",Water="Lightning",Fire="Water",}
    local weakEle = weak_to_element[spell.element]
	
	-- Iridescence trait on Chatoyant/Claustrum makes single weather stronger than day of the week, so we don't want to equip obi if day gives bonus but weather gives penalty
    if world.weather_element == spell.element or (world.day_element == spell.element and world.weather_element ~= weakEle) then
        return true
    else
        return false
    end
end

function equip_heal(spell)

	-- Cures
	if spell.name:contains('Cure')
	or spell.name:contains('Cura') then
		equip(sets.healing_magic)
		
		-- Matching day
		if obi_check(spell) then
			if spell.element == world.day_element then
				addedmagicinfo = "on matching day"
				equip(sets.matching_dayweather) -- obi
				
				-- Matching day and weather
				if spell.element == world.weather_element then
					addedmagicinfo = "on matching day and weather"
				end
				
			-- Matching weather
			elseif spell.element == world.weather_element then
				addedmagicinfo = "in matching weather"
				equip(sets.matching_dayweather) -- obi
			end
		end
		
	-- Other spells
	else
		equip(sets.fastcasthaste)
	end
end

function equip_enfeebling(spell)

	-- INT-based enfeebles
    if spell.name:contains('Poison')
	or spell.name:contains('Dia')
	or spell.name:contains('Sleep')
	or spell.name:contains('Blind')
	or spell.name == 'Dispel' 
	or spell.name == 'Bind'
	or spell.name == 'Gravity' then
		equip(sets.enfeebling_magic.int)
		
	-- MND-based enfeebles
	else
		equip(sets.enfeebling_magic.mnd)
	end
	
	-- Potency enfeebles
	if enfeebPot then
	
		if spell.name:contains('Blind')
		or spell.name:contains('Slow')
		or spell.name:contains('Paralyze')
		or spell.name == 'Distract'
		or spell.name == 'Frazzle' then
			addedmagicinfo = "potency enfeebling"
		end
	
		-- INT
		if spell.name:contains('Blind') then
			equip(sets.enfeebling_magic.intpotency)
			
		-- MND
		elseif spell.name:contains('Slow')
		or spell.name:contains('Paralyze')
		or spell.name == 'Distract'
		or spell.name == 'Frazzle' then
			equip(sets.enfeebling_magic.mndpotency)
		end
	end
	
	-- Dark grip for Sleep, Dispel and Blind
	if spell.name:contains('Sleep')
	or spell.name:contains('Blind')
	or spell.name == 'Dispel' then
		equip(sets.darkgrip)
	end
end

function equip_enhancing(spell) 

	-- Stoneskin
	if spell.name == 'Stoneskin' then
		equip(sets.enhancing_magic.stoneskin)
	
	-- Barspells/enspells/phalanx
	elseif spell.name:contains('Bar')
	or spell.name:startswith('En')
	or spell.name:contains('Phalanx') then
		equip(sets.enhancing_magic)
		
	-- Other spells
	else
		equip(sets.fastcasthaste)
	end
end

function equip_nuke(spell)

	-- Elemental debuffs
	if spell.name == 'Burn'
	or spell.name == 'Frost'
	or spell.name == 'Choke'
	or spell.name == 'Rasp'
	or spell.name == 'Shock'
	or spell.name == 'Drown' then
		equip(sets.elemental_magic.debuffs)
		
	-- Nukes
	else
	
		-- informative variables
		local skill, obi, ugg
	
		-- if nuke, potency or skill?
		if nukeDmg then 
			equip(sets.elemental_magic)
			skill = "potency"
		else
			equip(sets.elemental_magic.skill)
			skill = "skill"
		end
		
		-- check obi for matching day/weather
		if obi_check(spell) then
			if spell.element == world.day_element then
				equip(sets.matching_dayweather)
				if spell.element == world.weather_element then
					obi = ", day, weather"
				else
					obi = ", day"
				end
			elseif spell.element == world.weather_element then
				obi = ", weather"
				equip(sets.matching_dayweather)
			else obi = "" end
		else obi = "" end
		
		-- check MP for ugg. pendant
		if player.mp < math.floor(nakedMP * 0.5) + math.floor(spell.mp_cost * 0.75) then
			equip({neck= "Uggalepih Pendant"})
			ugg = ", ugg"
		else ugg = "" end
		
		-- informative text
		addedmagicinfo = skill .. obi .. ugg
		
	end
	
	-- Ice staff for ice spells
	if spell.element == 'Ice' then
		equip(sets.icestaff)
	end
	
end

function equip_dark(spell)

	-- Stun
	if spell.name == 'Stun' then
		equip(sets.dark_magic.stun)
		
	-- Other spells
	else
		equip(sets.dark_magic)
		
		-- Obi/legs/ring for Drain/Aspir
		if spell.name == 'Aspir' or spell.name == 'Drain' then
		
			-- Matching day
			if spell.element == world.day_element then
				addedmagicinfo = "on matching day"
				equip(sets.matching_dayweather) -- obi
				equip({right_ring="Diabolos's Ring"}) -- ring
				
				-- Matching day and weather
				if spell.element == world.weather_element then
					addedmagicinfo = "on matching day and weather"
				end
				
			-- Matching weather
			elseif spell.element == world.weather_element then
				addedmagicinfo = "in matching weather"
				equip(sets.matching_dayweather) -- obi
			end
		end
	end
end

function equip_divine(spell)
	equip(sets.fastcasthaste)
end
 
-----------------------
-- Pre/mid/aftercast --
-----------------------
 
-- Before casting/using ability
function precast(spell)
	
	-- Magic
	if spell.action_type == 'Magic' then
	
		-- Cancel magic when it is not up yet
		local spell_recasts = windower.ffxi.get_spell_recasts()
		if spell_recasts[spell.recast_id] > 60 then  -- some margin to account for server lag
			add_to_chat(167,spell.english .. ' is still on cooldown!')
			cancel_spell()
		else

			-- Fast cast for all spells	
			if not converting then equip(sets.precastfastcast) end
		
			-- Cancel status effects for spells that don't overwrite themselves
			if spell.name == "Sneak" then send_command("cancel sneak") end
			if spell.name == "Stoneskin" then send_command("wait 3;cancel stoneskin") end
			if spell.name == "Reraise" then send_command("cancel reraise") end
			if spell.name == "Blink" then send_command("wait 3;cancel blink") end
			if spell.name == "Aquaveil" then send_command("wait 3;cancel aquaveil") end
			if spell.name == "Ice Spikes" then send_command("cancel ice spikes") end
			if spell.name == "Shock Spikes" then send_command("cancel shock spikes") end
			if spell.name == "Phalanx" then send_command("cancel phalanx") end
		end
	
	-- Abilities	
	else
		-- Cancel sneak when using Spectral Jig
		if spell.name == "Spectral Jig" then
			send_command("cancel sneak")

		-- Weaponskills	
		elseif spell.type == 'WeaponSkill' then
			equip_ws(spell.name)
			
		-- Dancer steps
		elseif spell.type:contains('Step') then
			equip(sets.melee.acc)
			
		-- Ranged attack
		elseif spell.action_type == 'Ranged Attack' then
			equip(sets.throwing) 
		
		-- Convert: set converting to true as to not go into pre/mid/aftercast
		elseif spell.name == 'Convert' then
			converting = true
			windower.add_to_chat('Converting = true, dont go into midcast or aftercast.')
		end
	end
end

-- During casting magic
function midcast(spell)
 
	mpcost = tostring(spell.mp_cost)
	addedmagicinfo = ""
	showmagicinfo = display_mp_cost
	magicinfocolor = 0
 
	if spell.skill == 'Healing Magic' then
        if not converting then equip_heal(spell) end
		magicinfocolor = 8
    elseif spell.skill == 'Enfeebling Magic' then
        equip_enfeebling(spell)
		magicinfocolor = 7
    elseif spell.skill == 'Enhancing Magic' then
        equip_enhancing(spell)
		magicinfocolor = 50
    elseif spell.skill == 'Elemental Magic' then
		equip_nuke(spell)
		magicinfocolor = 3
    elseif spell.skill == 'Dark Magic' then
        equip_dark(spell)
		magicinfocolor = 207
	elseif spell.skill == 'Divine Magic' then
		equip_divine(spell)
		showmagicinfo = false
    elseif spell.name:contains('Utsusemi') then
		equip(sets.utsusemi)
		showmagicinfo = false
	else
		showmagicinfo = false
	end
	
	if showmagicinfo then
	
		-- align text
		if string.len(mpcost) == 1 then
			mpcost = ' *** ' .. mpcost
		elseif string.len(mpcost) == 2 then
			mpcost = ' ** ' .. mpcost
		elseif string.len(mpcost) == 3 then
			mpcost = ' * ' .. mpcost
		end
		
		-- display text
		if addedmagicinfo == "" then
			windower.add_to_chat(magicinfocolor,mpcost .. " MP \t" .. spell.name)
		else
			windower.add_to_chat(magicinfocolor,mpcost .. " MP \t" .. spell.name .. ": " .. addedmagicinfo)
		end
	end
	
	-- Magic chats (here so you only say this when you can actually cast the spell)
	-- WARNING: Use player.target.name if you use <t>. I have these on <stnpc> macros, so I use player.subtarget.name
	if spell.name == 'Stun' then send_command('input /p Stunning <t>! <wstar> Stun down for 29s!') end
	if spell.name == 'Sleep' or spell.name == 'Sleep II' then send_command('input /p Sleeping ' .. player.subtarget.name .. '! <wstar> Disengage!') end 
	if spell.name == 'Bind' then send_command('input /p Binding ' .. player.subtarget.name .. '! <wstar> Disengage!') end 
end
 
-- After casting or using an ability
function aftercast(spell)

	-- if you're converting, don't go into idle set just yet
    if not converting then
		choose_set()
	else
		-- always set converting back to false so it never stays on by accident
		converting = false
	end
end
 
---------------------
-- Player commands --
--------------------- 

function self_command(command)

	-- Toggle mage/melee
	if command == "fightMode" then
		fightMode:cycle() -- go to next
		
		local temp = fightMode.value
		if temp == 'melee' then 
			enable('main','sub','range','ammo')
			equip(sets.weapons[currentWeapons])	-- when going to melee, equip the last known weapons
			disable('main','sub','range','ammo')
			windower.add_to_chat(122,'Meleeing in ' .. meleeMode.current)
			
		elseif temp == 'mage' then
			enable('main','sub','range','ammo')
			windower.add_to_chat(122,'Mage mode')
		end	
		choose_set()
	
	-- Change melee mode	
	elseif command == "meleeMode" then
		meleeMode:cycle() -- go to next
		choose_set()
		windower.add_to_chat(122,'Meleeing in ' .. meleeMode.current)
		
	-- Change weapons
	elseif string.sub(command, 1, 3) == "wpn" then
		local wpn = string.sub(command, 4, -1)	
		currentWeapons = wpn -- remember what your current weapons are
		
		-- equip weapons if you're in melee mode
		if fightMode.value == 'melee' then
			enable('main','sub','range','ammo')
			equip(sets.weapons[wpn])	
			disable('main','sub','range','ammo')
		end
		
	-- Curing yourself with MP gear on after Convert	
	elseif command == "c4convert" then
		converting = true
		send_command('wait .1;input /ma "Cure IV" <me>')
		windower.add_to_chat(122,'Delayed Cure IV without gear swaps')
		
	elseif command == "c3convert" then
		converting = true
		send_command('wait .1;input /ma "Cure III" <me>')
		windower.add_to_chat(122,'Delayed Cure III without gear swaps')

	-- Potency/skill nukes	
    elseif command == "nukeDmg" then
		if nukeDmg == false then
			nukeDmg = true
			windower.add_to_chat(122,'Nuking in potency')
		else
			nukeDmg = false
			windower.add_to_chat(122,'Nuking in skill')
		end
		
	-- Potency/skill enfeebles	
	elseif command == "enfeebPot" then
		if enfeebPot == false then
			enfeebPot = true
			windower.add_to_chat(122,'Enfeebling in potency')
		else
			enfeebPot = false
			windower.add_to_chat(122,'Enfeebling in skill')
		end
		
	-- Toggle MP info
	elseif command == "dispmp" then
		if display_mp_cost then
			display_mp_cost = false
			windower.add_to_chat(122,'Stop showing magic MP cost.')
		else
			display_mp_cost = true
			windower.add_to_chat(122,'Show magic MP cost.')
		end		
		
	-- Clipping plane (requires Config plugin)		
	elseif command == "clippingPlane" then
		clippingPlane:cycle()
		send_command('input //config ClippingPlane ' .. clippingPlane.value)
		windower.add_to_chat(122,"ClippingPlane: " .. clippingPlane.current)
	end
end

---------------
-- Init code --
---------------

enable('main','sub','range','ammo','head','neck','left_ear','right_ear','body','hands','left_ring','right_ring','back','waist','legs','feet')
send_command('wait 1; input /cm u;wait 1;gs equip idle;wait 1;input /macro book 1;wait 2;input /lockstyleset 4; wait 1; input !myth; wait 1; input /echo Gearswap loaded.')