--[[

----------------
-- Properties --
----------------

Only job-specific properties are shown here. For the general list, more info, tips etc. visit my Gearswap page: https://enedin.be/gs/
	
COMMANDS
- melxxx						Switch melee sets. (xxx is the name of the melee set, see sets.melee.xxx)
- wpnxxx						Switch weapons. (xxx is the name of the weapon set, see sets.weapons.xxx)
- ranxxx						Switch ranged mode. (xxx is the name of the ranged mode, see sets.ranged.xxx)
- triggerRegen					Instantly equip Regen gear.
- dring							Toggle the use of Defending Ring in your engaged melee set.

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

	-- Idle sets
	
	sets.idle = {
	    head		="Genbu's Kabuto",
		body		="Kirin's Osode",
		hands		="Denali Wristbands",
		legs		="Blood Cuisses",
		feet		="Trotter Boots",
		neck		="Bloodbead Gorget",
		waist		="Jungle Sash",
		left_ear	="Harmonius Earring",
		right_ear	="Harmonius Earring",
		left_ring	="Shadow Ring",
		right_ring	="Defending Ring",
		back		="Shadow Mantle",
	}
	
	-- Melee/ranged sets (values /nin)
	
	sets.melee = {}
	sets.ranged = {}
	
	-- acc: club 389 / sword 398 / axe 425
	sets.melee.easy = {
	    head		="Walahra Turban",
		body		="Hachiryu Haramaki",
		hands		="Dusk Gloves +1",
		legs		="Byakko's Haidate",
		feet		="Dusk Ledelsens +1",
		neck		="Ancient Torque",
		waist		="Ninurta's Sash",
		left_ear	="Pixie Earring",
		right_ear	="Brutal Earring",
		left_ring	="Toreador's Ring",
		right_ring	="Toreador's Ring",
		back		="Cuchulain's Mantle",
	}
	-- acc: club 414 / sword 423 / axe 450
	sets.melee.medium = set_combine(sets.melee.easy,{
		hands		="Hachiryu Kote",
		waist		="Virtuoso Belt",
	})
	-- acc: club 429 / sword 438 / axe 465
	sets.melee.hard = set_combine(sets.melee.medium,{
		head		="Optical Hat",
		feet		="Denali Gamashes",
	})
	
	sets.ranged.easy = {
	-- 454 racc
	    head		="Maat's Cap",
		body		="Kirin's Osode",
		hands		="Blood Fng. Gnt.",
		legs		="Hachiryu Haidate",
		feet		="Sct. Socks +1",
		neck		="Faith Torque",
		waist		="Scout's Belt",
		left_ear	="Harmonius Earring",
		right_ear	="Harmonius Earring",
		left_ring	="Rajas Ring",
		right_ring	="Flame Ring",
		back		="Amemet Mantle +1",
	}
	sets.ranged.medium = set_combine(sets.ranged.easy,{
	-- 478 racc
		hands		="Blood Fng. Gnt.",
		left_ring	="Dragon Ring +1",
		right_ring	="Dragon Ring +1",
	})
	sets.ranged.hard = set_combine(sets.ranged.medium,{
	-- 491 racc
		head		="Zha'Go's Barbut",
		hands		="Seiryu's Kote",
	})
	
	-- WS sets
	
		-- Coronach 		40% AGI, 40% DEX (fixed low enmity)
		-- Slug Shot 		70% AGI (accuracy multiplier: 0.8 at 1000 TP, 0.9 at 2000 TP, 1 at 3000 TP)
		-- Heavy Shot		30% AGI
		-- Trueflight		30% AGI, magic damage
	
	sets.ws = {}
	sets.ws.easy = {}
	sets.ws.medium = {}
	sets.ws.hard = {} -- 454 / 478 / 491

	sets.ws.easy.coronach = { -- 467 ws acc
	    head		="Maat's Cap",
		body		="Kirin's Osode",
		hands		="Seiryu's Kote",
		legs		="Hachiryu Haidate",
		feet		="Sct. Socks +1",
		neck		="Fotia Gorget",
		waist		="Scout's Belt",
		left_ear	="Harmonius Earring",
		right_ear	="Brutal Earring",
		left_ring	="Rajas Ring",
		right_ring	="Flame Ring",
		back		="Amemet Mantle +1",
	}
	sets.ws.medium.coronach = set_combine(sets.ws.easy.coronach,{ -- 479 ws acc
		right_ring	="Dragon Ring +1",
	})
	sets.ws.hard.coronach = set_combine(sets.ws.medium.coronach,{ -- 491 ws acc
		left_ring	="Dragon Ring +1",
	})
	
	sets.ws.easy.slugshot = { -- 397 ws acc (incl. 20% racc penalty)
	    head		="Zha'Go's Barbut",
		body		="Kirin's Osode",
		hands		="Seiryu's Kote",
		legs		="Hachiryu Haidate",
		feet		="Sct. Socks +1",
		neck		="Fotia Gorget",
		waist		="Scout's Belt",
		left_ear	="Harmonius Earring",
		right_ear	="Brutal Earring",
		left_ring	="Dragon Ring +1",
		right_ring	="Dragon Ring +1",
		back		="Amemet Mantle +1",
	}
	sets.ws.medium.slugshot = set_combine(sets.ws.easy.slugshot,{
	})
	sets.ws.hard.slugshot = set_combine(sets.ws.medium.slugshot,{
	})

	sets.ws.trueflight = {}
	
	-- Fast Cast and Haste sets
	
	sets.precastfastcast = {
		right_ear   ="Loquac. Earring",
	}
	
	sets.utsusemi = {
		head		="Walahra Turban",
		hands		="Dusk Gloves +1",
		legs		="Byakko's Haidate",
		feet		="Dusk Ledelsens +1",
		neck		="Tiercel Necklace",
		waist		="Ninurta's Sash",
		left_ear	="Loquac. Earring",
	}
	
	-- Other sets
	
	sets.steps = {
	    head		="Optical Hat",
		body		="Enkidu's Harness",
		hands		="Enkidu's Mittens",
		legs		="Byakko's Haidate",
		feet		="Denali Gamashes",
		neck		="Ancient Torque",
		waist		="Virtuoso Belt",
		left_ear	="Pixie Earring",
		right_ear	="Harmonius Earring",
		left_ring	="Toreador's Ring",
		right_ring	="Toreador's Ring",
		back		="Cuchulain's Mantle",
	}
	
	sets.rest = {
		head		="Blood Mask",
		hands		="Feronia's Bangles",
		neck		="Orochi Nodowa +1",
		waist		="Lycopodium Sash",
	}
	
	-- Weapon sets
	
		-- Axe skill 	240
		-- Sword skill	210 (-27 acc)
		-- Club skill	200 (-36 acc)
	
	sets.weapons = {}
	sets.weapons.gun = {
		ranged		= "Annihilator",
		ammo		= "Silver Bullet",
	}
	sets.weapons.axes = {
		main		= "Kriegsbeil",
		sub			= "Fransisca",
	}
	sets.weapons.vulcans = {
		main		= "Vulcan's Staff",
		sub			= "Axe Grip",
	}
	sets.weapons.mekki = {
		main		= "Mekki Shakki",
		sub			= "Rose Grip",
	}
	sets.weapons.kclub = {
		main		= "Kraken Club",
		sub			= "Legion Scutum",
	}
	sets.weapons.ridill = {
		main		= "Ridill",
		sub			= "Legion Scutum",
	}
	sets.weapons.ridillkclub = {
		main		= "Ridill",
		sub			= "Kraken Club",
	}
	sets.weapons.unequip = {
		main		= empty,
		sub			= empty,
	}
	

	---------------
	-- Variables --
	---------------

	-- Default values, feel free to change
	dring = true											-- true = use dring in engaged set
	
	-- Lists of options. Default value is the first one
	clippingPlane = M{'1', '0.75', '0.5', '10', '5', '2'} 	-- config ClippingPlane value
	meleeMode = M{'easy','medium','hard'} 	-- melee modes
	rangedMode = M{'easy','medium','hard'} 	-- ranged modes

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

	-- DNC job abilities
	if spell.type:contains('Step') then
		equip(sets.steps)
	elseif spell.type:contains('Waltz') then
		equip(sets.waltz)
	elseif spell.name == 'Spectral Jig' then
		send_command('cancel sneak')
		
	-- Ranged Attack / Barrage
	elseif spell.action_type == 'Ranged Attack' then
		equip(sets.ranged[rangedMode.current])
		if buffactive['Barrage'] then equip({hands="Htr. Bracers +1"}) end

	-- Weaponskills
	elseif spell.type == 'WeaponSkill' then
		if player.target.distance > 15.90 then
			add_to_chat(122,'You are too far to WS.')
			cancel_spell()
		else
			if spell.name == 'Coronach' or spell.name == 'Heavy Shot' then
				equip((sets.ws[rangedMode.current]).coronach)
			elseif spell.name == 'Slug Shot' then
				equip((sets.ws[rangedMode.current]).slugshot)
			elseif spell.name == 'Trueflight' then
				equip(sets.ws.trueflight)
			else -- catchall
				equip(sets.ws.easy.coronach)	
			end
		end
		
	-- RNG job abilities	
	elseif spell.name == 'Scavenge' then equip({feet="Hunter's Socks"})
	elseif spell.name == 'Sharpshot' then equip({legs="Hunter's Braccae"})
	elseif spell.name == 'Camouflage' then equip({body="Hunter's Jerkin"})
	elseif spell.name == 'Shadowbind' then
		if player.target.distance > 17.50 then
			add_to_chat(122,'You are too far to Shadowbind.')
			cancel_spell()
		else
			equip({hands="Htr. Bracers +1"})
			send_command('input /p Shadowbinding ' .. player.subtarget.name .. '! <wstar> Disengage!')
		end
	
	-- Utsusemi
	elseif spell.name:contains('Utsusemi') then
		equip(sets.precastfastcast)
	end	
end

-- During casting magic
function midcast(spell)
	if spell.name:contains('Utsusemi') then
		equip(sets.utsusemi)
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
		
	-- Change ranged mode
	elseif string.sub(command, 1, 3) == "ran" then	
		local ran = string.sub(command, 4, -1)
		rangedMode:set(ran)
		windower.add_to_chat(122,'Shooting in ' .. rangedMode.current)
		
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
			equip(sets.idle,{head="Blood Mask",neck="Orochi Nodowa +1",hands="Feronia's Bangles",waist="Lycopodium Sash"})
		else
			equip(sets.idle,{head="Blood Mask",neck="Orochi Nodowa +1"})
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
send_command('wait 1; input /cm u; wait 2; gs equip weapons.vulcans; wait 1; gs equip weapons.gun; wait 1; gs equip idle; wait 1; input /macro book 10; wait 1; input !myth; wait 1; input /lockstyleset 43; wait 1; input /echo Gearswap loaded.')