--[[

----------------
-- Properties --
----------------

Only job-specific properties are shown here. For the general list, more info, tips etc. visit my Gearswap page: https://enedin.be/gs/

AUTOMATIC
- Keeps your SA/TA gear equipped (through any status change) until you hit the monster and SA/TA wears.
- Keeps your TH gear locked when activating it.
	
COMMANDS
- melxxx						Switch melee sets. (xxx is the name of the melee set, see sets.melee.xxx)
- wpnxxx						Switch weapons. (xxx is the name of the weapon set, see sets.weapons.xxx)
- rangedMode					Cycle ranged sets.
- th							Toggle the use of TH gear and lock/unlock it.
- triggerRegen					Instantly equip Regen gear.
- dring							Toggle the use of Defending Ring in your engaged melee set.
- throw							Throw darts or boomerang.

-------------------------
-- Tips/Best practices --
-------------------------

- Use PDT mode for running away from things in dire situations. It'll equip Terra's Staff for maximum defensive capabilities.

---------------------
-- About this file --
---------------------

CHANGELOG
- v2.1:		Added Throw command, which throws your boomerang or switches to darts when needed.
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
	
	-- Melee sets (values /nin, mandau+TK)
	
	sets.melee = {}
	sets.melee.easy = {
	-- 392 acc, 25% haste
		head		= "Walahra Turban",
		body		= "Rapparee Harness",
		hands		= "Dusk Gloves +1",
		legs		= "Homam Cosciales",
		feet		= "Homam Gambieras",
		waist		= "Ninurta's Sash",
		back		= "Cerb. Mantle +1",
		neck		= "Love Torque",
		left_ring	= "Rajas Ring",
		right_ring	= "Toreador's Ring",
		left_ear	= "Suppanomimi",
		right_ear	= "Brutal Earring"
    }
	
	sets.melee.medium = set_combine(sets.melee.easy,{
	-- 408 acc, 24% haste
		neck		= "Love Torque",
		back		= "Cuchulain's Mantle",
		left_ring	= "Toreador's Ring",
		hands		= "Homam Manopolas"
    })
	
	sets.melee.hard = set_combine(sets.melee.medium,{
	-- 424 acc, 20% haste
		neck		= "Ancient Torque",
		body		= "Homam Corazza"
	})
	
	sets.melee.acc = { -- Accuracy
	-- 456 acc, 0% haste
		head		= "Optical Hat",
		body		= "Homam Corazza",
		hands		= "Enkidu's Mittens",
		legs		= "Oily Trousers",
		feet		= "Homam Gambieras",
		neck		= "Ancient Torque",
		waist		= "Virtuoso Belt",
		back		= "Cuchulain's Mantle",
		left_ring	= "Toreador's Ring",
		right_ring	= "Toreador's Ring",
		left_ear	= "Suppanomimi",
		right_ear	= "Brutal Earring",
	}
	
	sets.melee.acceva = { -- Evasion, accuracy
	--- 399 acc, 453 evasion
		head		= "Optical Hat",
		body		= "Antares Harness",
		hands		= "War Gloves +1",
		legs		= "Raven Hose",
		feet		= "Dance Shoes +1",
		neck		= "Evasion Torque",
		waist		= "Scouter's Rope",
		back		= "Boxer's Mantle",
		left_ear	= "Triton Earring",
		right_ear	= "Novia Earring",
		left_ring	= "Toreador's Ring",
		right_ring	= "Defending Ring",
	}
		
	sets.melee.eva = { -- Evasion
	--- 376 acc, 454 evasion
		head		= "Wivre Mask +1",
		body		= "Antares Harness",
		hands		= "Denali Wristbands",
		legs		= "Raven Hose",
		feet		= "Dance Shoes +1",
		neck		= "Evasion Torque",
		waist		= "Scouter's Rope",
		back		= "Boxer's Mantle",
		left_ear	= "Triton Earring",
		right_ear	= "Novia Earring",
		left_ring	= "Shadow Ring",
		right_ring	= "Defending Ring",
    }
	
	sets.idle = set_combine(sets.melee.eva,{feet = "Trotter Boots"}) -- Movement
	
	sets.melee.pdt = set_combine(sets.idle,{ -- Staff for "oh shit" moments
		main		= "Terra's Staff",
		sub			= "Reign Grip",
	})
	
	-- SA/TA sets
	
	sets.sa = {
		head		= "Hecatomb Cap +1",
		body		= "Dragon Harness +1",
		hands		= "Hct. Mittens +1",
		legs		= "Hct. Subligar +1",
		feet		= "Hct. Leggings +1",
		neck		= "Love Torque",
		waist		= "Cuchulain's Belt",
		left_ear	= "Suppanomimi",
		right_ear	= "Pixie Earring",
		left_ring	= "Rajas Ring",
		right_ring	= "Zilant Ring",
		back		= "Cerb. Mantle +1",
	}
	
	sets.ta = {
		head		= "Maat's Cap",
		body		= "Dragon Harness +1",
		hands		= "Hct. Mittens +1",
		legs		= "Hct. Subligar +1",
		feet		= "Hct. Leggings +1",
		neck		= "Ire Torque +1",
		waist		= "Cuchulain's Belt",
		left_ear	= "Suppanomimi",
		right_ear	= "Harmonius Earring",
		left_ring	= "Rajas Ring",
		right_ring	= "Flame Ring",
		back		= "Cerb. Mantle +1",
	}
	
	sets.sata = set_combine(sets.sa,{
	})
	
	-- WS sets
	
		-- Dancing Edge		5 hits, 30% DEX, 40% CHR
		-- Shark Bite		2 hits, 40% DEX, 40% AGI
		-- Evisceration		5 hits, 30% DEX, can crit
		-- Mercy Stroke		1 hit, 60% STR
		-- Mandalic Stab	1 hit, 30% DEX
		-- Cyclone			AoE, 30% DEX, 25% INT, magic damage
	
	sets.ws = {}
	sets.ws.easy = {}
	sets.ws.medium = {}
	sets.ws.hard = {}
	
	sets.ws.easy.de = { -- 409 ws acc
		head		= "Hecatomb Cap +1",
		body		= "Hct. Harness +1",
		hands		= "Hct. Mittens +1",
		legs		= "Hct. Subligar +1",
		feet		= "Hct. Leggings +1",
		neck		= "Fotia Gorget",
		waist		= "Cuchulain's Belt",
		left_ear	= "Harmonius Earring",
		right_ear	= "Brutal Earring",
		left_ring	= "Rajas Ring",
		right_ring	= "Flame Ring",
		back		= "Cerb. Mantle +1",
	} 
	sets.ws.medium.de = sets.ws.easy.de
	sets.ws.hard.de = set_combine(sets.ws.medium.de,{ -- 432 ws acc
		right_ring	= "Toreador's Ring",
		back		= "Cuchulain's Mantle",
		waist		= "Virtuoso Belt",	
	})
	
	sets.ws.easy.sb = sets.ws.easy.de
	sets.ws.medium.sb = sets.ws.medium.de
	sets.ws.hard.sb = sets.ws.hard.de
	
	sets.ws.easy.ev = { -- 409 ws acc
	    head		= "Hecatomb Cap +1",
		body		= "Dragon Harness +1",
		hands		= "Hct. Mittens +1",
		legs		= "Hct. Subligar +1",
		feet		= "Hct. Leggings +1",
		neck		= "Fotia Gorget",
		waist		= "Warwolf Belt",
		left_ear	= "Pixie Earring",
		right_ear	= "Brutal Earring",
		left_ring	= "Rajas Ring",
		right_ring	= "Zilant Ring",
		back		= "Cerb. Mantle +1",
	}
	sets.ws.medium.ev = sets.ws.easy.ev
	sets.ws.hard.ev = set_combine(sets.ws.medium.ev,{ -- 434 ws acc
		waist		= "Virtuoso Belt",
		body		= "Antares Harness",
		back		= "Cuchulain's Mantle",
	})
	
	sets.ws.easy.ms = { -- acc doesn't matter, on THF we'll never miss MS
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
	sets.ws.medium.ms = sets.ws.easy.ms
	sets.ws.hard.ms = sets.ws.easy.ms
	
	sets.ws_cyclone = set_combine(sets.ws_sb,{ -- MAB, DEX, INT
		head		= "Maat's Cap",
		body		= "Antares Harness",
		hands		= "Hct. Mittens +1",
		legs		= "Denali Kecks",
		feet		= "Denali Gamashes",
		neck		= "Fotia Gorget",
		waist		= "Cuchulain's Belt",
		left_ear	= "Novio Earring",
		right_ear	= "Moldavite Earring",
		left_ring	= "Rajas Ring",
		right_ring	= "Galdr Ring",
		back		= "Cuchulain's Mantle",
	})
	
	-- Fast Cast and Haste sets
	
	sets.precastfastcast = {
		right_ear   = "Loquac. Earring",
		legs		= "Homam Cosciales",
	}
	
	sets.fastcasthaste = {
		head		= "Walahra Turban",
		body		= "Rapparee Harness",
		hands		= "Dusk Gloves +1",
		feet		= "Homam Gambieras",
		legs		= "Homam Cosciales",
		neck		= "Tiercel Necklace",
		waist		= "Ninurta's Sash",
		right_ear   = "Loquac. Earring",
	}
	
	-- Other sets
	
	sets.racc = {
        head        = "Optical Hat",
		body		= "Antares Harness",
		feet		= "Homam Gambieras",
        neck        = "Peacock Amulet",
        hands       = "Enkidu's Mittens",
        left_ring   = "Dragon Ring +1",
        right_ring  = "Dragon Ring +1",
		left_ear	= "Suppanomimi",
        back        = "Jaeger Mantle",
        legs        = "Dusk Trousers +1",
		waist		= "Scouter's Rope",
	}
	
	sets.steps = set_combine(sets.melee.acc,{right_ear = "Pixie Earring"}) -- acc to da max
	
	sets.waltz = {
		head		= "Maat's Cap",
		body		= "Avalon Breastplate",
		hands		= "Denali Wristbands",
		feet		= "Dance Shoes +1",
		waist		= "Warwolf Belt",
		left_ear	= "Robust Earring +1",
		right_ear	= "Robust Earring +1",
		back		= "Shadow Mantle",
	}
	
	sets.th = {
        sub			= "Thief's Knife",
        hands		= "Asn. Armlets +1"
    }
	
	sets.rest = set_combine(sets.melee.eva,{
		head		= "Sol Cap",
		hands		= "Feronia's Bangles",
		neck		= "Orochi Nodowa +1",
		waist		= "Lycopodium Sash",
	})
	
	sets.steal = {}
	
	sets.flee = {feet = "Rogue's Poulaines"}
	
	-- Ranged weapon sets
	
	sets.ranged = {}
	sets.ranged.throwing = {
		range		= "Ungur Boomerang",
	}
	sets.ranged.hybrid = {
		ammo		= "Fire Bomblet",
	}
	sets.ranged.damage = {
		ammo		= "Bomb Core",
	}	
	sets.darts = {
		ammo		= "Aht Urhgan Dart",
	}
	
	-- Weapon sets
	
	sets.weapons = {}
	sets.weapons.dgdg = {
		main		= "Mandau",
		sub			= "Blau Dolch"
	}
	sets.weapons.dgkc = {
		main		= "Mandau",
		sub			= "Kraken Club"
	}
	sets.weapons.dgsw = {
		main		= "Mandau",
		sub			= "Ridill"
	}
	sets.weapons.dgdnc = { -- not using blau dolch when we're /dnc in survival mode (no WS) since blau's latent doesn't work when TP > 1000
		main		= "Mandau",
		sub			= "Ermine's Tail"
	}
	sets.weapons.swkc = { -- for mowing down real shitty mobs
		main		= "Ridill",
		sub			= "Kraken Club"
	}
	sets.weapons.kcsh = { -- maximum TP spam
		main		= "Kraken Club",
		sub			= "Tatami Shield"
	}
	sets.weapons.thkc = {
		main		= "Thief's Knife",
		sub			= "Kraken Club"
	}
	sets.weapons.thsw = {
		main		= "Thief's Knife",
		sub			= "Ridill"
	}
	
	---------------
	-- Variables --
	---------------

	-- Don't change this:
	sa_gear = false 
	ta_gear = false 	
	th = false	
	
	-- Default values, feel free to change
	dring = true														-- true = use dring in engaged set
	currentWeapons = 'dgkc'												-- current weapons
	
	-- Lists of options. Default value is the first one
	clippingPlane = M{'1', '0.75', '0.5', '10', '5', '2'} 				-- config ClippingPlane value
	meleeMode = M{'easy','medium','hard','acc','acceva','eva','pdt'} 	-- melee modes
	rangedMode = M{'damage','hybrid','throwing'}						-- ranged modes

end

---------------
-- Functions --
---------------

function status_change(new,old)

	-- SA/TA gearlock: don't change anything when SA or TA is up
	if sa_gear or ta_gear then
		if sa_gear then windower.add_to_chat(122,'Sneak Attack gear on.') end
		if ta_gear then windower.add_to_chat(122,'Trick Attack gear on.') end
		
	-- When SA/TA is not active	
	else
		choose_set()
	end
end

-- detects Sleep
-- windower.register_event('gain buff', function(buff_id)
    -- if buff_id == 2 then -- 2 comes from from windower4 > res > buffs.lua
		-- equip({neck="Opo-Opo Necklace"})
		-- windower.add_to_chat(122,'Choochoo time to get some TP')
	-- end
-- end)


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

function buff_change(name,gain)

	-- if SA or TA wore (or were used), remove their gearlock and return to normal
	if name == 'Sneak Attack' or name == 'Trick Attack' then
		if gain == false then
			if name == 'Sneak Attack' then sa_gear = false end
			if name == 'Trick Attack' then ta_gear = false end
			windower.add_to_chat(122, 'SA/TA wore, removing SA/TA gear, back to normal.')
			
			-- emulate an aftercast
			choose_set()
		end
	end
end

-----------------------
-- Pre/mid/aftercast --
-----------------------

-- Before casting/using ability
function precast(spell, spellMap, action)

	-- If you're not doing SA, TA, Hide or AC, remove SA/TA gearlock
	if spell.name ~= 'Sneak Attack' and spell.name ~= 'Trick Attack' and spell.name ~= 'Hide' and spell.name ~= "Assassin's Charge" then
		if (sa_gear or ta_gear) and not spell.type == 'WeaponSkill' then windower.add_to_chat(122,'Removing SA/TA gear, back to normal.') end
		if sa_gear then sa_gear = false end
		if ta_gear then ta_gear = false end
	end

	-- DNC stuff
	if spell.type:contains('Step') then
		equip(sets.steps)
	elseif spell.type:contains('Waltz') then
		equip(sets.waltz)
	elseif spell.name == 'Spectral Jig' then
		send_command('cancel sneak')
		
	-- Steal/Flee
	elseif spell.name == 'Steal' then equip(sets.steal)
	elseif spell.name == 'Flee' then equip(sets.flee)
		
	-- Ranged attack
	elseif spell.action_type == 'Ranged Attack' then
		equip(sets.racc) 
		
	-- SA/TA
	elseif spell.name == 'Sneak Attack' then
		equip(sets.sa)
		sa_gear = true
	elseif spell.name == 'Trick Attack' then
		if buffactive['Sneak Attack'] then
			equip(sets.sata)
		else
			equip(sets.ta)
		end
		ta_gear = true
		
	-- Weaponskills
	elseif spell.type == 'WeaponSkill' then
	
		-- set wsMode to either easy, medium or hard based on meleeMode
		local wsMode = meleeMode.current
		if not (wsMode == 'easy' or wsMode == 'medium') then wsMode = 'hard' end
	
		if spell.name == 'Dancing Edge' then
			equip((sets.ws[wsMode]).de)
		elseif spell.name == 'Shark Bite' then
			equip((sets.ws[wsMode]).sb)
		elseif spell.name == 'Evisceration' then
			equip((sets.ws[wsMode]).ev)
		elseif spell.name == 'Mercy Stroke' then
			equip((sets.ws[wsMode]).ms)
		elseif spell.name == 'Cyclone' then
			equip(sets.ws_cyclone)
		elseif spell.name == 'Mandalic Stab' then
			equip(sets.ws.easy.ms)
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

	if spell.action_type == 'Ranged Attack' then equip(sets.ranged[rangedMode.value]) end

	-- SA/TA gearlock
	if sa_gear or ta_gear then
		if sa_gear and not spell.name == "Sneak Attack" then windower.add_to_chat(122,'Sneak Attack gear on.') end
		if ta_gear and not spell.name == "Trick Attack" then windower.add_to_chat(122,'Trick Attack gear on.') end
	else
		choose_set()
	end
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
			equip(sets.weapons[wpn])
			currentWeapons = wpn -- remember what your current weapons are
			
			-- if in TH mode, re-equip that knife
			if th then
				enable('sub','hands')
				equip(sets.th)
				disable('sub','hands')
			end
		end

	-- Change melee mode	
	elseif string.sub(command, 1, 3) == "mel" then
	
		-- when coming from PDT, re-enable the locked slots and equip your previous weapons
		if meleeMode.value == 'pdt' then
			enable('main','sub','range','ammo')
			equip(sets.weapons[currentWeapons])
			equip(sets.ranged[rangedMode.value])
		end	
	
		local mel = string.sub(command, 4, -1)
		meleeMode:set(mel)
		choose_set()
		windower.add_to_chat(122,'Meleeing in ' .. meleeMode.current)
		
		-- if PDT, lock stuff
		if mel == 'pdt' then
			if th then
				th = false
				windower.add_to_chat(122,'Treasure Hunter 4: OFF')
				enable('sub','hands')
			end
			equip(sets.ranged.throwing)
			equip(sets.melee.pdt)
			disable('main','sub','range','ammo')
		end
		
	-- Cycle ranged mode	
	elseif command == "rangedMode" then
		if meleeMode.value == 'pdt' then
			windower.add_to_chat(122,'In PDT mode, you cannot change ranged weapons.')
		else
			rangedMode:cycle()
			equip(sets.ranged[rangedMode.value])
			windower.add_to_chat(122,'Ranged mode: ' .. rangedMode.current)
		end
		
	-- Throw darts when not using boomerang, or just throw boomerang	
	elseif command == "throw" then
		if rangedMode.value ~= 'throwing' then
			if player.target then
				if player.target.distance > 25 then
					add_to_chat(122,'You are too far to throw.')
				else
					equip(sets.darts)
					send_command("wait .5; input /ra <t>")
					gearswap.equip_sets:schedule(2, 'equip_command', nil, sets.ranged[rangedMode.value]) -- equip a fraction later
				end
			else
				add_to_chat(122,'There is no valid target.')
			end
		else
			send_command("input /ra <t>")
		end
	
	-- Treasure Hunter	
	elseif command == 'th' then
		if meleeMode.value == 'pdt' then
			windower.add_to_chat(122,'In PDT mode, TH is off and you cannot turn it on.')
		else
			if th == false then
				th = true
				windower.add_to_chat(122,'Treasure Hunter 4: ON')
				equip(sets.th)
				disable('sub','hands')
			else
				th = false
				windower.add_to_chat(122,'Treasure Hunter 4: OFF')
				enable('sub','hands')
				choose_set()
				equip(sets.weapons[currentWeapons])
			end
		end
		
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
send_command('wait 1; input /cm u; wait 1; gs equip ranged.damage; wait 1; gs equip idle; wait 1; gs equip weapons.dgkc; wait 1; input /macro book 7; wait 1; input /lockstyleset 9; wait 1; input !myth; wait 1; input /echo Gearswap loaded.')