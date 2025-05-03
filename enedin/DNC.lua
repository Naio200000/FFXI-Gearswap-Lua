--[[

----------------
-- Properties --
----------------

Only job-specific properties are shown here. For the general list, more info, tips etc. visit my Gearswap page: https://enedin.be/gs/

AUTOMATIC
- Removes Saber Dance before using Waltz, and Fan Dance before using Sambas (requires Cancel addon).
	
COMMANDS
- melxxx						Switch melee sets. (xxx is the name of the melee set, see sets.melee.xxx)
- wpnxxx						Switch weapons. (xxx is the name of the weapon set, see sets.weapons.xxx)
- rangedMode					Cycle ranged sets.
- triggerRegen					Instantly equip Regen gear.
- dring							Toggle the use of Defending Ring in your engaged melee set.

-------------------------
-- Tips/Best practices --
-------------------------

- Use PDT mode for running away from things in dire situations. It'll equip Terra's Staff for maximum defensive capabilities.
- Equipset 1 are my daggers and equipset 2 is my dagger/joyeuse.

---------------------
-- About this file --
---------------------

CHANGELOG
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

	-- Melee sets (values /nin, mandau+ermine's)
	
	sets.melee = {}
	sets.melee.easy = {
	-- 402 acc, 25% haste
		head		= "Walahra Turban",
		body		= "Rapparee Harness",
		hands		= "Dusk Gloves +1",
		legs		= "Etoile Tights +1",
		feet		= "Dusk Ledelsens +1",
		neck		= "Tiercel Necklace",
		waist		= "Ninurta's Sash",
		left_ear	= "Suppanomimi",
		right_ear	= "Brutal Earring",
		left_ring	= "Rajas Ring",
		right_ring	= "Toreador's Ring",
		back		= "Cerb. Mantle +1",
    }
	
	sets.melee.medium = set_combine(sets.melee.easy,{
	-- 415 acc, 25% haste
		left_ring	= "Toreador's Ring",
		back		= "Etoile Cape",
		neck		= "Ancient Torque",
	})
	
	sets.melee.hard = set_combine(sets.melee.medium,{
	-- 430 acc, 21% haste
		body        = "Etoile Casaque +1",
    })
	
	sets.melee.acc = { -- Accuracy
	-- 477 acc, 0% haste
		head        = "Optical Hat",
        neck		= "Ancient Torque",
		hands       = "Enkidu's Mittens",
		body        = "Etoile Casaque +1",
		legs		= "Oily Trousers",
		waist 		= "Virtuoso Belt",
		left_ring	= "Toreador's Ring",
		right_ring	= "Toreador's Ring",
		left_ear	= "Suppanomimi",
		right_ear	= "Brutal Earring",
		feet		= "Etoile Shoes +1",
		back		= "Etoile Cape",
	}
	
	sets.melee.acceva = { -- Evasion, accuracy
	--- 420 acc, 413 evasion
		head        = "Optical Hat",
		body		= "Antares Harness",
		hands		= "Denali Wristbands",
		legs		= "Raven Hose",
		feet		= "Dance Shoes +1",
		neck		= "Evasion Torque",
		waist		= "Scouter's Rope",
		left_ear	= "Suppanomimi",
		right_ear	= "Novia Earring",
		left_ring	= "Toreador's Ring",
		right_ring	= "Defending Ring",
		back		= "Etoile Cape",
	}
		
	sets.melee.eva = { -- Evasion
	--- 394 acc, 423 evasion
		head		= "Wivre Mask +1",
		body		= "Antares Harness",
		hands		= "Denali Wristbands",
		legs		= "Raven Hose",
		feet		= "Dance Shoes +1",
		neck		= "Evasion Torque",
		waist		= "Scouter's Rope",
		left_ear	= "Triton Earring",
		right_ear	= "Novia Earring",
		left_ring	= "Shadow Ring",
		right_ring	= "Defending Ring",
		back		= "Boxer's Mantle",
    }
	
	sets.idle = sets.melee.eva
	
	sets.melee.pdt = set_combine(sets.idle,{ -- Staff for "oh shit" moments
		main		= "Terra's Staff",
		sub			= "Reign Grip",
	})
	
	-- Dance sets
	
    sets.samba = {
        head        = "Dancer's Tiara"
    }
    sets.jigs = {
        legs        = "Etoile Tights +1",
        feet        = "Dancer's Shoes"
    }
	sets.steps = {
		hands       = "Dancer's Bangles",
        feet        = "Etoile Shoes +1"
    }
	sets.violent_flourish = {
        body        = "Etoile Casaque +1",
    }
	sets.animated_flourish = { -- Enmity+
	}
    sets.waltz = { -- Waltz+, CHR, VIT
		head		= "Etoile Tiara +1",
		body		= "Dancer's Casaque",
		hands		= "River Gauntlets",
		legs		= "Etoile Tights +1",
		feet		= "Dance Shoes +1",
		waist		= "Warwolf Belt",
		left_ear	= "Roundel Earring",
		right_ear	= "Robust Earring +1",
		back		= "Etoile Cape",
	}
	
	-- Other sets
	
	sets.rest = set_combine(sets.melee.eva,{
		head		= "Sol Cap",
		hands		= "Feronia's Bangles",
		neck		= "Orochi Nodowa +1",
		waist		= "Lycopodium Sash",
	})
	
	-- WS sets
	
		-- Dancing Edge		5 hits, 30% DEX, 40% CHR
		-- Pyrrhic Kleos	4 hits, 30% DEX, 20% STR
		-- Shark Bite		1 hit, 40% DEX, 40% AGI
		-- Evisceration		5 hits, 30% DEX, can crit
		-- Mercy Stroke		1 hit, 60% STR
		-- Cyclone			AoE, 30% DEX, 25% INT, magic damage
	
	sets.ws = {}
	sets.ws.easy = {}
	sets.ws.medium = {}
	sets.ws.hard = {}
	
	sets.ws.easy.de = { -- 430 ws acc
		head		= "Maat's Cap",
		body		= "Enkidu's Harness",
		hands		= "Enkidu's Mittens",
		legs		= "Enkidu's Subligar",
		feet		= "Denali Gamashes",
		neck		= "Fotia Gorget",
		waist		= "Cuchulain's Belt",
		left_ear	= "Harmonius Earring",
		right_ear	= "Brutal Earring",
		left_ring	= "Rajas Ring",
		right_ring	= "Flame Ring",
		back		= "Cerb. Mantle +1",
	}
	sets.ws.medium.de = sets.ws.easy.de
	sets.ws.hard.de = sets.ws.easy.de
	
	sets.ws.easy.sb = sets.ws.easy.de
	sets.ws.medium.sb = sets.ws.easy.de
	sets.ws.hard.sb = sets.ws.easy.de
	
	sets.ws.easy.ev = { -- 441 ws acc
	    head		= "Maat's Cap",
		body		= "Antares Harness",
		hands		= "Enkidu's Mittens",
		legs		= "Enkidu's Subligar",
		feet		= "Etoile Shoes +1",
		neck		= "Fotia Gorget",
		waist		= "Cuchulain's Belt",
		left_ear	= "Pixie Earring",
		right_ear	= "Brutal Earring",
		left_ring	= "Rajas Ring",
		right_ring	= "Adroit Ring",
		back		= "Cuchulain's Mantle",
	}
	sets.ws.medium.ev = sets.ws.easy.ev
	sets.ws.hard.ev = sets.ws.easy.ev
	
	sets.ws.easy.ms = { -- 416 ws acc
	    head		= "Maat's Cap",
		body		= "Enkidu's Harness",
		hands		= "Alkyoneus's Brc.",
		legs		= "Enkidu's Subligar",
		feet		= "Denali Gamashes",
		neck		= "Fotia Gorget",
		waist		= "Warwolf Belt",
		left_ear	= "Harmonius Earring",
		right_ear	= "Brutal Earring",
		left_ring	= "Rajas Ring",
		right_ring	= "Flame Ring",
		back		= "Cerb. Mantle +1",
	}
	sets.ws.medium.ms = sets.ws.easy.ms
	sets.ws.hard.ms = set_combine(sets.ws.medium.ms,{ -- 424 ws acc
		back		= "Cuchulain's Mantle",
	})
	
	sets.ws_cyclone = { -- MAB, DEX, INT
		head		= "Maat's Cap",
		body		= "Antares Harness",
		hands		= "Enkidu's Mittens",
		legs		= "Denali Kecks",
		feet		= "Denali Gamashes",
		neck		= "Fotia Gorget",
		waist		= "Cuchulain's Belt",
		left_ear	= "Novio Earring",
		right_ear	= "Moldavite Earring",
		left_ring	= "Rajas Ring",
		right_ring	= "Galdr Ring",
		back		= "Cuchulain's Mantle",
	}
	
	-- Fast Cast and Haste sets
	
	sets.precastfastcast = {
		right_ear   = "Loquac. Earring",
		legs		= "Homam Cosciales",
	}
	
	sets.fastcasthaste = {
		head		= "Walahra Turban",
		body		= "Rapparee Harness",
		hands		= "Dusk Gloves +1",
		feet		= "Dusk Ledelsens +1",
		legs		= "Etoile Tights +1",
		neck		= "Tiercel Necklace",
		waist		= "Ninurta's Sash",
		right_ear   = "Loquac. Earring",
	}
	
	-- Other sets
	
	sets.racc = {
		head		= "Optical Hat",
		body		= "Antares Harness",
		hands		= "Enkidu's Mittens",
		legs		= "Dusk Trousers +1",
		neck		= "Peacock Amulet",
		waist		= "Scouter's Rope",
		left_ear	= "Suppanomimi",
		left_ring	= "Dragon Ring +1",
		right_ring	= "Dragon Ring +1",
		back		= "Jaeger Mantle",
	}
	
	-- Weapon sets
	
	sets.weapons = {}
	sets.weapons.dgdg = {
		main		="Mandau",
		sub			="Ermine's Tail",
	}
	sets.weapons.dgsw = {
		main		="Mandau",
		sub			="Joyeuse",
	}
	
	-- Ranged weapon sets
	
	sets.ranged = {}
	sets.ranged.throwing = {
		range		= "Rising Sun +1",
	}
	sets.ranged.damage = {
		ammo		= "Black Tathlum"
	}	
	
	---------------
	-- Variables --
	---------------

	-- Default values, feel free to change
	dring = true														-- true = use dring in engaged set
	currentWeapons = 'dgdg'												-- current weapons
	
	-- Lists of options. Default value is the first one
	clippingPlane = M{'1', '0.75', '0.5', '10', '5', '2'} 				-- config ClippingPlane value
	meleeMode = M{'easy','medium','hard','acc','acceva','eva','pdt'} 	-- melee modes
	rangedMode = M{'throwing','damage'}									-- ranged modes

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
		equip(sets.rest)
	else
        equip_idle()
    end
end

function equip_engaged()
	equip(sets.melee[meleeMode.value])
	if dring then equip({right_ring="Defending Ring"}) end
end	 

function equip_idle()
	equip(sets.idle)
end	

-----------------------
-- Pre/mid/aftercast --
-----------------------

-- Before casting/using ability
function precast(spell, spellMap, action)

	-- Dances
	if spell.type:contains('Waltz') then
		equip(sets.waltz)
		if buffactive['Saber Dance'] then
			send_command('cancel "Saber Dance"')
			windower.add_to_chat(122,'Cancelled Saber Dance for Waltz.')
		end
	elseif spell.type:contains('Step') then
		equip(sets.melee.acc,sets.steps)
	elseif spell.type:contains('Jig') then
		equip(sets.jigs)
		if spell.name == 'Spectral Jig' then
			send_command('cancel sneak')
		end
	elseif spell.type:contains('Samba') then
		equip(sets.samba)
		if buffactive['Fan Dance'] then
			send_command('cancel "Fan Dance"')
			windower.add_to_chat(122,'Cancelled Fan Dance for Samba.')
		end
	elseif spell.name == 'Violent Flourish' then
		equip(sets.violent_flourish)
	elseif spell.name == 'Wild Flourish' then
		equip(sets.melee.acc)
		
	-- Ranged Attack
	elseif spell.action_type == 'Ranged Attack' then
		 equip(sets.racc) 	

	-- Weaponskills
	elseif spell.type == 'WeaponSkill' then
	
		-- set wsMode to either easy, medium or hard based on meleeMode
		local wsMode = meleeMode.current
		if not (wsMode == 'easy' or wsMode == 'medium') then wsMode = 'hard' end
	
		if spell.name == 'Dancing Edge' or spell.name == 'Pyrrhic Kleos' then
			equip((sets.ws[wsMode]).de)
		elseif spell.name == 'Shark Bite' then
			equip((sets.ws[wsMode]).sb)
		elseif spell.name == 'Evisceration' then
			equip((sets.ws[wsMode]).ev)
		elseif spell.name == 'Mercy Stroke' then
			equip((sets.ws[wsMode]).ms)
		elseif spell.name == 'Cyclone' then
			equip(sets.ws_cyclone)
		else -- catchall, just STR all the way
			equip(sets.ws.easy.ms)	
		end	 
		
	-- Utsusemi
	elseif spell.name:contains('Utsusemi') then
		equip(sets.melee.eva,sets.precastfastcast)
	end	
end

-- During casting magic
function midcast(spell)
	if spell.name:contains('Utsusemi') then
		equip(sets.melee.eva,sets.fastcasthaste)
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
		if meleeMode.value == 'pdt' then
			windower.add_to_chat(122,'In PDT mode, you cannot change weapons.')
		else
			local wpn = string.sub(command, 4, -1)
			if wpn == 'dgdg' then
				equip(sets.weapons.dgdg)
			elseif wpn == 'dgsw' then
				equip(sets.weapons.dgsw)
			end
			currentWeapons = wpn -- remember what your current weapons are
		end

	-- Change melee mode	
	elseif string.sub(command, 1, 3) == "mel" then
	
		-- when coming from PDT, re-enable the locked slots and equip your previous weapons
		if meleeMode.value == 'pdt' then
			enable('main','sub')
			if currentWeapons == 'dgdg' then
				equip(sets.weapons.dgdg)
			elseif currentWeapons == 'dgsw' then
				equip(sets.weapons.dgsw)
			end
		end	
	
		local mel = string.sub(command, 4, -1)
		meleeMode:set(mel)
		choose_set()
		windower.add_to_chat(122,'Meleeing in ' .. meleeMode.current)
		
		-- if PDT, lock stuff
		if mel == 'pdt' then
			equip(sets.melee.pdt)
			disable('main','sub')
		end
		
	-- Cycle ranged mode	
	elseif command == "rangedMode" then
		rangedMode:cycle()
		equip(sets.ranged[rangedMode.value])
		windower.add_to_chat(122,'Ranged mode: ' .. rangedMode.current)
		
	-- Defending Ring
	elseif command == 'dring' then
		if dring == false then
			dring = true
			windower.add_to_chat(122,'Using Defending Ring in melee set.')
		else
			dring = false
			windower.add_to_chat(122,'Using ring from melee set.')
		end
		choose_set()
		
	-- Trigger regen
	elseif command == 'triggerRegen' then
		if world.time <= 1080 and world.time >= 360 then
			equip(sets.idle,{head="Sol Cap",neck="Orochi Nodowa +1",hands="Feronia's Bangles",waist="Lycopodium Sash"})
		else
			equip(sets.idle,{head="Sol Cap",neck="Orochi Nodowa +1"})
		end
		windower.add_to_chat(200,'Triggering Regen set!')
		
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
send_command('wait 1; input /cm u;wait 1;gs equip ranged.throwing;wait 1;gs equip idle;wait 1;gs equip weapons.dgdg; wait 2;input /lockstyle on;wait 2;input /macro book 3; wait 1; input !myth; wait 1; input /echo Gearswap loaded.')