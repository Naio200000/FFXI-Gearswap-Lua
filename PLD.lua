--[[

----------------
-- Properties --
----------------

Only job-specific properties are shown here. For the general list, more info, tips etc. visit my Gearswap page: https://enedin.be/gs/

AUTOMATIC
- Equips parade gorget (when idling) when your HP is high enough.
- Equips more Spell interruption rate down gear (PLD emergency earring) during magic when HP is low enough.
	
COMMANDS
- melxxx						Switch melee sets. (xxx is the name of the melee set, see sets.melee.xxx)
- wpnxxx						Switch weapons. (xxx is the name of the weapon set, see sets.weapons.xxx)
- use_parade					Toggle the use of Parade Gorget in your engaged melee set (when your HP is high enough).
- ethereal						Toggle the use of Ethereal Earring in your engaged melee set.
- kiting						Toggle the use of kiting gear (Valhalla) vs idle (Royal Cloak).
- triggerPdt					Instantly equip PDT- gear.
- triggerMdt					Instantly equip MDT- gear.
- triggerBreath					Instantly equip BDT- gear.
- triggerReturn					Instantly return to your idle/engaged gear, to be used after the other triggers. Any aftercast will also do the trick.
- chivalry_check				Check how much MP Chivalry would return at your current TP
								(the MND is hardcoded in the command, you should change that to your Chivalry set's MND value).							

---------------------
-- About this file --
---------------------

CHANGELOG
- v2.21:	added Waltz set
- v2.2:		updated Obi handling
- v2.1:		added ethereal command
- v2.0:		base (core functionality)	

CREDITS
- Adapted this from Wren's GearSwap luas: https://supernovaffxi.fandom.com/wiki/Wren%27s_Gearswaps	
	
]]--

----------
-- TODO --
----------

--[[    
    Full Kaiser set
    Valhalla HEad/Body from Odin
    D Ring from KB/KS99
]]--

----------
-- Sets --
----------

function get_sets()

	-- Including this gives an easy way of defining cyclic/trigger/etc variables, makes handling self_commands easier.
	-- Motes also uses this, but this is completely independent from Motes
	include('Modes.lua')

	-- Idle sets
 
	sets.idle = {
		body		= "Royal Cloak",
    	hands="Blood Fng. Gnt.", -- TOTO: replace with kaiser
		legs		= "Blood Cuisses",
		feet		= "Askar Gambieras",
		neck		= "Parade Gorget",
		waist		= "Warwolf Belt",
		left_ear	= "Merman's Earring",
		right_ear	= "Merman's Earring",
		left_ring	= "Shadow Ring",
		right_ring	= "Alert Ring", -- TODO replace with Dring
		back		= "Shadow Mantle",
	}
	
	sets.kiting = set_combine(sets.idle,{
		head		= "Valhalla Helm",
		body		= "Valhalla Brstplate",
		neck		= "Bloodbead Gorget",
	})
	
	-- Melee sets (values /nin)
	
	sets.melee = {}
	sets.melee.ddEasy = {
	-- 358 acc, 22% haste *387 acc now
	    head		= "Walahra Turban",
		body		= "Askar Korazin",
		hands		= "Dusk Gloves +1",
		legs		= "Homam Cosciales",
		feet		= "Homam Gambieras",
		neck		= "Fortitude Torque",
		waist		= "Ninurta's Sash",
		left_ear	= "Suppanomimi",
		right_ear	= "Brutal Earring",
		left_ring	= "Mars's Ring",
		right_ring	= "Rajas Ring",
		back		= "Cerb. Mantle +1",
	}
	sets.melee.ddMedium = set_combine(sets.melee.ddEasy,{
	-- 395 acc, 21% haste
		body		= "Nocturnus Mail",
		hands		= "Homam Manopolas",
		neck		= "Ancient Torque",
		left_ring	= "Toreador's Ring",
		back		= "Cuchulain's Mantle",
	})
	sets.melee.tkAcc = set_combine(sets.melee.ddMedium,{
	-- 395 acc, DT-10%, MDT-35%, 5% chance of absorbing magic damage
		right_ring	= "Succor Ring",
	})
	sets.melee.tkAccMag = set_combine(sets.melee.tkAcc,{
	-- 388 acc, DT-10%, MDT-35%, 13% chance of annuling magic damage, 5% chance of absorbing magic damage
		left_ring	= "Shadow Ring",
	})
	sets.melee.tkAccBreath = set_combine(sets.melee.tkAccMag,{
	-- 371 acc, DT-10%, BDT-46%, 13% chance of annuling magic damage
		body		= "Blood Scale Mail"
	})
	sets.melee.tkTurtle = {
	-- 332 acc, DT-22%, MDT-49%, 13% chance of annuling magic damage, 6% chance of annuling physical damage
	    head		= "Valhalla Helm",
		body		= "Valhalla Brstplate",
		hands		= "Kaiser Handschuhs",
		legs		= "Kaiser Diechlings",
		feet		= "Askar Gambieras",
		neck		= "Shield Torque",
		waist		= "Warwolf Belt",
		left_ear	= "Buckler Earring",
		right_ear	= "Merman's Earring",
		left_ring	= "Shadow Ring",
		right_ring	= "Soccur Ring",
		back		= "Shadow Mantle",
	}
	sets.melee.tkMagic = {
	-- 335 acc, DT-22%, MDT-56%, MDB+6, 13% chance of annuling magic damage
		head		= "Valhalla Helm",
		hands		= "Coral Fng. Gnt. +1",
		body		= "Valhalla Brstplate",
		legs		= "Coral Cuisses +1",
		feet		= "Askar Gambieras",
		neck		= "Bloodbead Gorget",
		waist		= "Resolute Belt",
		left_ear	= "Merman's Earring",
		right_ear	= "Merman's Earring",
		left_ring	= "Shadow Ring",
		back		= "Lamia Mantle +1",
		right_ring	= "Succor Ring",
	}
	
	-- Trigger sets
	
	sets.trigger = {}
	sets.trigger.pdt = set_combine(sets.melee.tkTurtle,{
		neck		= "Bloodbead Gorget",
		left_ear	= "Robust Earring +1",
		right_ear	= "Robust Earring +1",
		left_ring	= "Succor Ring",
	})
	sets.trigger.mdt = sets.melee.tkMagic
	sets.trigger.breath = set_combine(sets.trigger.mdt,{
		body		= "Blood Scale Mail"
	})
 
	-- Magic sets
	
	sets.flash = { -- Haste/FC > Enmity
		head		= "Walahra Turban",
		body		= "Hydra Haubert",
		hands		= "Homam Manopolas",
		legs		= "Homam Cosciales",
		feet		= "Homam Gambieras",
		neck		= "Harmonia's Torque",
		waist		= "Warwolf Belt",
		right_ear	= "Hades Earring +1",
		left_ear    = "Loquac. Earring",
		left_ring	= "Hercules' Ring",
		right_ring	= "Blitz Ring",
		back		= "Cerb. Mantle +1",
	}
	
	sets.healing_magic = { -- Enmity/interrupt/some HP that you'd lose otherwise
		head		= "Hydra Salade",
		body		= "Hydra Haubert",
		hands		= "River Gauntlets",
		legs		= "Vlr. Breeches +1",
		feet		= "Karasutengu",
		neck		= "Harmonia's Torque",
		waist		= "Ninurta's Sash",
		left_ear	= "Hospitaler Earring",
		right_ear	= "Knightly Earring",
		left_ring	= "Hercules' Ring",
		right_ring  = "Succor Ring",
		back		= "Cerb. Mantle +1",
	}

	sets.enhancing_magic = { -- Skill (pot)
		back		= "Merciful Cape",
		left_ear	= "Augment. Earring",
	}
	sets.enhancing_magic.stoneskin = { -- MND (pot), Haste/FC/interrupt when cap is reached
	-- With 231 (210+16merits+5cape) skill and 450 being SN cap, you need 133 MND on PLD to get cap 
		head		= "Maat's Cap",
		body		= "Blood Scale Mail",
		hands		= "Dvt. Mitts +1",
		legs		= "Jet Seraweels",
		feet		= "Vlr. Leggings +1",
		neck		= "Stone Gorget",
		waist		= "Pythia Sash +1",
		left_ear	= "Celestial Earring",
		right_ear	= "Celestial Earring",
		left_ring	= "Celestial Ring",
		right_ring	= "Celestial Ring",
		back		= "Merciful Cape",
	}
	sets.enhancing_magic.blink = { -- Interrupt
		feet		= "Karasutengu",
		head		= "Valhalla Helm",
		body		= "Valhalla Brstplate",
		neck        = "Shield Torque",
		waist       = "Ninurta's Sash",
		left_ear    = "Buckler Earring",
		right_ear	= "Knightly Earring",
	}
	sets.enhancing_magic.reprisal = { -- Haste/FC > HP+
		head		= "Walahra Turban",
		body		= "Blood Scale Mail",
		hands		= "Dusk Gloves +1",
		legs		= "Homam Cosciales",
		feet		= "Homam Gambieras",
		neck		= "Bloodbead Gorget",
		waist		= "Ninurta's Sash",
		left_ear	= "Hades Earring +1",
		right_ear   = "Loquac. Earring",
		left_ring	= "Blitz Ring",
		right_ring  = "Succor Ring",
		back		= "Gigant Mantle",
	}
 
    sets.utsu_ni = { -- Haste/FC
        head        = "Walahra Turban",
		body		= "Hydra Haubert",
        hands       = "Dusk Gloves +1",
		legs		= "Homam Cosciales",
		feet		= "Homam Gambieras",
		neck        = "Shield Torque",
		waist       = "Ninurta's Sash",
		back		= "Boxer's Mantle",
        left_ring   = "Blitz Ring",
		right_ring  = "Succor Ring",
		left_ear    = "Buckler Earring",
        right_ear   = "Knightly Earring",
    }
    sets.utsu_ichi = { -- Haste/FC/interrupt
	    head        = "Walahra Turban",
		body		= "Hydra Haubert",
        hands       = "Dusk Gloves +1",
		legs		= "Vlr. Breeches +1",
		feet        = "Karasutengu",
        neck        = "Shield Torque",
		waist       = "Ninurta's Sash",
		back		= "Boxer's Mantle",
		left_ring   = "Blitz Ring",
		right_ring  = "Succor Ring",
        left_ear    = "Buckler Earring",
        right_ear   = "Knightly Earring",
    }
	
	-- Ability sets
 
    sets.enmity = { -- Base set for others
        head        = "Hydra Salade",
		body        = "Hydra Haubert",
		hands       = "Hydra Moufles",
		legs        = "Hydra Brayettes",
        feet        = "Hydra Sollerets",
        neck        = "Harmonia's Torque",
		waist       = "Warwolf Belt",
        left_ear    = "Hades Earring +1",
        right_ear   = "Hades Earring +1",
        left_ring   = "Hercules' Ring",
        right_ring  = "Succor Ring",
        back        = "Cerb. Mantle +1",
    }

    sets.bash = {
        right_ear   = "Knightly Earring",
        hands       = "Vlr. Gauntlets +1",
    }
    sets.sentinel = {feet = "Vlr. Leggings +1"}
    sets.rampart = {head = "Vlr. Coronet +1"}
	sets.chivalry = { -- MND
		head		= "Maat's Cap",
		body		= "Blood Scale Mail",
		hands		= "Dvt. Mitts +1",
		legs		= "Jet Seraweels",
		feet		= "Vlr. Leggings +1",
		neck		= "Gnole Torque",
		waist		= "Pythia Sash +1",
		left_ear	= "Celestial Earring",
		right_ear	= "Celestial Earring",
		left_ring	= "Celestial Ring",
		right_ring	= "Celestial Ring",
	}
	
	sets.steps = {
	    head        = "Optical Hat",
		body		= "Homam Corazza",
        hands       = "Hydra Moufles",
		legs        = "Oily Trousers",
        feet		= "Homam Gambieras",
        neck        = "Ancient Torque",
		waist       = "Virtuoso Belt",
        left_ear    = "Suppanomimi",
        right_ear   = "Pixie Earring",
        left_ring   = "Toreador's Ring",
        right_ring  = "Toreador's Ring",
        back        = "Cuchulain's Mantle",
	}
	
	sets.waltz = {
	    head		= "Kaiser Schaller",
		body		= "Kaiser Cuirass",
		hands		= "Kaiser Handschuhs",
		legs		= "Kaiser Diechlings",
		feet		= "Kaiser Schuhs",
		neck		= "Fortitude Torque",
		waist		= "Warwolf Belt",
		left_ear	= "Robust Earring +1",
		right_ear	= "Robust Earring +1",
		left_ring	= "Shadow Ring",
		right_ring	= "Succor Ring",
		back		= "Shadow Mantle",
	}
	
	-- Fast Cast and Haste sets
	
    sets.precastfastcast = {
        right_ear   = "Loquac. Earring",
		legs		= "Homam Cosciales",
    }
	sets.fastcasthaste = {
		head		= "Walahra Turban",
		hands		= "Dusk Gloves +1",
		legs		= "Homam Cosciales",
		feet		= "Homam Gambieras",
		neck        = "Shield Torque",
		waist		= "Ninurta's Sash",
		left_ear	= "Buckler Earring",
		right_ear   = "Loquac. Earring",
		left_ring	= "Blitz Ring",
		right_ring	= "Succor Ring",
		back		= "Shadow Mantle",
	}
	
	-- Other sets
	
    sets.rest = { -- hMP
		head		= "Mirror Tiara",
		body		= "Valhalla Brstplate",
	    hands       = "Genie Gages",
		neck		= "Gnole Torque",
		feet		= "King's Sabatons",
        left_ear    = "Relaxing Earring",
        right_ear   = "Antivenom Earring",
        left_ring   = "Celestial Ring",
        right_ring  = "Celestial Ring",
        waist       = "Qiqirn Sash +1"
    }
	
    sets.parade = {neck = "Parade Gorget"}
	sets.extrainterrupt = {left_ear = "Guardian Earring"}
	sets.matching_dayweather = {waist = "Hachirin-no-Obi"}
	
	-- WS sets
	
	sets.ws = {}
	sets.ws.easy = {}
	sets.ws.medium = {}
	sets.ws.hard = {}
	
	sets.ws.str = { -- Full on strength, for mowing down easy mobs (and as a catchall)
        head		= "Hecatomb Cap +1",
		body		= "Hct. Harness +1",
		hands		= "Hct. Mittens +1",
		legs		= "Hct. Subligar +1",
		feet		= "Hct. Leggings +1",
		neck		= "Fotia Gorget",
		waist		= "Warwolf Belt",
		left_ear	= "Harmonius Earring",
		right_ear	= "Brutal Earring",
		left_ring	= "Rajas Ring",
		right_ring	= "Flame Ring",
		back		= "Cerb. Mantle +1",
    }
	
	sets.ws.easy.multi = set_combine(sets.ws.str,{ -- 377 ws acc
		body		= "Nocturnus Mail"
	})
	sets.ws.medium.multi = set_combine(sets.ws.easy.multi,{ -- 394 ws acc
		right_ring	= "Toreador's Ring",
		waist		= "Virtuoso Belt",	
	})
	sets.ws.hard.multi = set_combine(sets.ws.medium.multi,{ -- 405 ws acc
		back		= "Cuchulain's Mantle",
		left_ring	= "Toreador's Ring",
	})
	
	sets.ws.easy.kor = sets.ws.str -- 373 ws acc
	sets.ws.medium.kor = sets.ws.medium.multi -- 394 ws acc
	sets.ws.hard.kor = sets.ws.hard.multi -- 405 ws acc
	
	-- Weapon sets
	
	sets.weapons = {}
	sets.weapons.pdt = {
		main		= "Terra's Staff",
		sub			= "Reign Grip",
		range       = "Lamian Kaman +1",
        ammo        = "Fang Arrow",
	}
	sets.weapons.swsh = { -- sword/shield
		main		= "Excalibur",
		sub			= "Aegis",
		range       = "Lamian Kaman +1",
        ammo        = "Fang Arrow",
	}
	sets.weapons.swsw = { -- sword/sword
		main		= "Excalibur",
		sub			= "Joyeuse",
		range       = "",
        ammo        = "White Tathlum",
	}
	sets.weapons.swkc = { -- sword/kclub
		main		= "Excalibur",
		sub			= "Kraken Club",
		range       = "",
        ammo        = "White Tathlum",
	}
	sets.weapons.kcsh = { -- kclub/shield
		main		= "Kraken Club",
		sub			= "Aegis",
		range       = "",
        ammo        = "White Tathlum",
	}
	sets.weapons.unequip = {
		main		= empty,
		sub			= empty,
		range       = empty,
        ammo        = empty,
	}
	
	---------------
	-- Variables --
	---------------

	-- Default values, feel free to change
	kiting = false																				-- true = VIT/def, false = Royal Cloak
	use_parade = false																			-- use parade in engaged set or not
	ethereal = false																			-- true = use ethereal in engaged set
	
	-- Lists of options. Default value is the first one
	clippingPlane = M{'1', '0.75', '0.5', '10', '5', '2'} 										-- config ClippingPlane value
	meleeMode = M{'ddEasy','ddMedium','tkAcc','tkAccMag','tkAccBreath','tkTurtle','tkMagic'}	-- melee modes
 
end
 
---------------
-- Functions --
---------------
 
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
	equip(sets.melee[meleeMode.value])
    if use_parade and player.hpp >= 85 and player.mpp <= 99 then equip(sets.parade) end
	if ethereal then equip({right_ear="Ethereal Earring"}) end
end
 
function equip_idle()
	if kiting then equip(sets.kiting) else equip(sets.idle) end
    if player.hpp >= 85 and player.mpp <= 99 then equip(sets.parade) end
end

function equip_ws(name)

	-- enmity for Atonement
	if name == 'Atonement' then
		equip(sets.enmity)

	else
		-- set wsMode to either easy, medium or hard based on meleeMode
		local wsMode = meleeMode.current
		
		if wsMode == 'ddEasy' then wsMode = 'easy'
		elseif wsMode == 'ddMedium' or wsMode == 'tkAcc' then wsMode = 'medium'
		else wsMode = 'hard' end
		
		if name == 'Knights of Round' then
			equip((sets.ws[wsMode]).kor)
		elseif name == 'Vorpal Blade' or name == 'Savage Blade' or name == 'Swift Blade' then
			equip((sets.ws[wsMode]).multi)
		else -- catchall, just STR all the way
			equip(sets.ws.str)
		end
	end
end

function equip_rest()
    equip(sets.rest)
end

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

function equip_enhancing(spell) 

	-- Stoneskin
	if spell.name == 'Stoneskin' then
		equip(sets.enhancing_magic.stoneskin)
	elseif spell.name == 'Blink' then
		equip(sets.enhancing_magic.blink)
	elseif spell.name == 'Reprisal' then
		equip(sets.enhancing_magic.reprisal)
	
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
			equip(sets.precastfastcast)	

			-- Cancel status effects for spells that don't overwrite themselves
			if spell.name == "Sneak" then send_command("cancel sneak") end
			if spell.name == "Stoneskin" then send_command("wait 4;cancel stoneskin") end
			if spell.name == "Reraise" then send_command("cancel reraise") end
			if spell.name == "Blink" then send_command("wait 4;cancel blink") end
			if spell.name == "Aquaveil" then send_command("wait 4;cancel aquaveil") end
			if spell.name == "Ice Spikes" then send_command("cancel ice spikes") end
			if spell.name == "Shock Spikes" then send_command("cancel shock spikes") end
			if spell.name == "Phalanx" then send_command("cancel phalanx") end
		end

	-- Abilities	
	else
	
		-- DNC stuff
		if spell.type:contains('Step') then
			equip(sets.steps)
		elseif spell.type:contains('Waltz') then
			equip(sets.waltz)
		elseif spell.name == 'Spectral Jig' then
			send_command('cancel sneak')
			
		-- Weaponskills		
		elseif spell.type == 'WeaponSkill' then
			equip_ws(spell.name)
		
		-- Tank abilities
		elseif spell.name == 'Shield Bash' then equip(sets.enmity,sets.bash)
		elseif spell.name == 'Sentinel' then equip(sets.enmity,sets.sentinel)
		elseif spell.name == 'Rampart' then equip(sets.enmity,sets.rampart)
		elseif spell.name == 'Holy Circle' then equip(sets.enmity,sets.holycircle)	
		elseif spell.name == 'Provoke' or spell.name == 'Fealty' then equip(sets.enmity)
		elseif spell.name == 'Chivalry' then equip(sets.chivalry)
		
		end
	end
end
 
-- During casting magic
function midcast(spell)

	mpcost = tostring(spell.mp_cost)
	addedmagicinfo = ""
	showmagicinfo = true
	magicinfocolor = 0

    if spell.name == 'Flash' then
        equip(sets.flash)
		magicinfocolor = 3
    elseif spell.name == 'Utsusemi: Ni' then
        equip(sets.utsu_ni)
		showmagicinfo = false
	elseif spell.name == 'Utsusemi: Ichi' then
        equip(sets.utsu_ichi)
		showmagicinfo = false
    elseif spell.skill == 'Healing Magic' then
        equip_heal(spell)
		magicinfocolor = 8
	elseif spell.skill == 'Enhancing Magic' then
        equip_enhancing(spell)
		magicinfocolor = 50
    else
		showmagicinfo = false
	end
	
	-- extra interrupt
	if spell.action_type == 'Magic' and player.hpp < 26 then
		equip(sets.extrainterrupt)
		windower.add_to_chat(122,'Extra interrupt earring.')
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
end
 
-- After casting or using an ability
function aftercast(spell)
    choose_set()
end
 
---------------------
-- Player commands --
---------------------  
 
function self_command(command)

	-- Change weapons
	if string.sub(command, 1, 3) == "wpn" then
		local wpn = string.sub(command, 4, -1)
		equip(sets.weapons.unequip) -- unequip first
		gearswap.equip_sets:schedule(1, 'equip_command', nil, sets.weapons[wpn]) -- equip a fraction later
		
	-- Change melee mode	
	elseif string.sub(command, 1, 3) == "mel" then	
		local mel = string.sub(command, 4, -1)
		meleeMode:set(mel)
		choose_set()
		windower.add_to_chat(122,'Meleeing in ' .. meleeMode.current)
		
	-- Kiting
	elseif command == 'kiting' then
		if kiting == false then
			kiting = true
			windower.add_to_chat(122,'Kiting gear on: less damage taken.')
		else
			kiting = false
			windower.add_to_chat(122,'Kiting gear off: more Refresh.')
		end
		choose_set()		
		
	-- Parade gorget
	elseif command == 'use_parade' then
		if use_parade == false then
			use_parade = true
			windower.add_to_chat(122,'Using Parade Gorget in engaged set.')
		else
			use_parade = false
			windower.add_to_chat(122,'Using neck piece from melee set.')
		end
		choose_set()
		
	-- Ethereal Earring
	elseif command == 'ethereal' then
		if ethereal == false then
			ethereal = true
			windower.add_to_chat(122,'Using Ethereal Earring in melee set.')
		else
			ethereal = false
			windower.add_to_chat(122,'Using earring from melee set.')
		end
		choose_set()
		
	-- Chivalry check
	elseif command == 'chivalry_check' then
		local chivmp
		chivmp = math.floor((player.tp*0.05+player.tp*0.0015*128)*1.2) -- 128 MND. 1.2 = 5 merits, 1.15 = 4 merits, 1.1 = 3 merits, 1.05 = 2 merits, 1 = 1 merit
		windower.add_to_chat(122,'Chivalry MP: ' .. chivmp .. ' / Player is short ' .. player.max_mp-player.mp .. ' MP.')
		
	-- Trigger sets below immediately equip that set, in any situation. Overwritten by any aftercast, or using the return trigger
	elseif command == "triggerReturn" then
		choose_set()
		windower.add_to_chat(200,'Back to regular set.')
	elseif command == "triggerMdt" then
		equip(sets.trigger.mdt)
		windower.add_to_chat(200,'Triggering MDT set!')
	elseif command == "triggerPdt" then
		equip(sets.trigger.pdt)
		windower.add_to_chat(200,'Triggering PDT set!')
	elseif command == "triggerBreath" then
		equip(sets.trigger.breath)
		windower.add_to_chat(200,'Triggering Breath set!')
	end
end
 
---------------
-- Init code --
---------------
  
enable('main','sub','range','ammo','head','neck','left_ear','right_ear','body','hands','left_ring','right_ring','back','waist','legs','feet')
send_command('wait 1; input /cm u;wait 1;gs equip idle; wait 1;gs equip weapons.swsh; wait 1; input /lockstyleset 1')