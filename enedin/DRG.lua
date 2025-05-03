--[[

----------------
-- Properties --
----------------

Only job-specific properties are shown here. For the general list, more info, tips etc. visit my Gearswap page: https://enedin.be/gs/

AUTOMATIC
- Equips HP+ gear during spellcasting to trigger Healing Breath earlier, and switches to potency before pet's breath.
	(note: some spells equip some potency gear, the list is in midcast).
	
COMMANDS
- melxxx						Switch melee sets. (xxx is the name of the melee set, see sets.melee.xxx)
- dring							Toggle the use of Defending Ring in your engaged melee set.
- ethereal						Toggle the use of Ethereal Earring in your engaged melee set (negated when not /mage).

---------------------
-- About this file --
---------------------

CHANGELOG
- v2.13:	removed spirit link set (it's based on current HP, not max HP, so changing to HP+ gear does nothing)
- v2.12:	added recast timer checks for Jump/High Jump so it doesnt change gear when trying to use it when it's not up
- v2.11:	added do-not-swap-to-HP-gear when casting magic during weakness
- v2.1:		added ethereal command
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
		head		="Wivre Mask +1",
		body		="Hydra Mail +1",
		hands		="Hydra Fng. Gnt. +1",
		legs		="Blood Cuisses",
		feet		="Askar Gambieras",
		neck		="Evasion Torque",
		waist		="Warwolf Belt",
		left_ear	="Ethereal Earring",
		right_ear	="Novia Earring",
		left_ring	="Shadow Ring",
		right_ring	="Defending Ring",
		back		="Shadow Mantle",
	}
	
	-- Melee sets (values /rdm, gungnir)
	
	sets.melee = {}
	sets.melee.easy = {
	-- 412 acc, 22% Haste (410 acc for DRing+Ethereal)
		head		="Walahra Turban",
		body		="Askar Korazin",
		hands		="Dusk Gloves +1",
		legs		="Homam Cosciales",
		feet		="Homam Gambieras",
		neck		="Love Torque",
		waist		="Ninurta's Sash",
		left_ear	="Assault Earring",
		right_ear	="Brutal Earring",
		left_ring	="Rajas Ring",
		right_ring	="Blitz Ring",
		back		="Cerb. Mantle +1",
    }
	
	sets.melee.medium = set_combine(sets.melee.easy,{
	-- 426 acc, 20% haste (417 acc for DRing+Ethereal)
		head		="Ace's Helm",
		right_ring	="Toreador's Ring",
	})
	
	sets.melee.hard = set_combine(sets.melee.medium,{
	-- 438 acc, 19% haste (429 acc for DRing+Ethereal)
		back		="Cuchulain's Mantle",
		hands		="Homam Manopolas",
	})
	
	sets.melee.veryhard = set_combine(sets.melee.hard,{
	-- 457 acc, 19% haste (448 acc for DRing+Ethereal)
		body		="Nocturnus Mail",
	})
	
	sets.melee.acc = set_combine(sets.melee.veryhard,{
	-- 482 acc, 6% haste (473 acc for DRing+Ethereal)
		head		="Optical Hat",
		neck		="Ancient Torque",
		left_ring	="Toreador's Ring",
		legs		="Oily Trousers",
		waist		="Virtuoso Belt",
	})
	
	-- WS/Jump sets
	
		-- Geirskogul (gk)		1 hit, 30% STR, 30% DEX, ignores 50% defense
		-- Drakesbane (db)		4 hits, 50% STR
	
	sets.ws = {}
	sets.ws.easy = {}
	sets.ws.medium = {}
	sets.ws.hard = {}
	sets.ws.veryhard = {}
	
	sets.ws.easy.gk = { -- 441 ws acc
		head		= "Hecatomb Cap +1",
		body		= "Nocturnus Mail",
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
	sets.ws.medium.gk = sets.ws.easy.gk
	sets.ws.hard.gk = sets.ws.easy.gk
	sets.ws.veryhard.gk = sets.ws.easy.gk
	
	sets.ws.easy.db = set_combine(sets.ws.easy.gk,{ -- 428 ws acc
		body		= "Aurum Cuirass",
	})
	sets.ws.medium.db = sets.ws.easy.db
	sets.ws.hard.db = set_combine(sets.ws.easy.db,{ -- 441 ws acc
		body		= "Nocturnus Mail",
	})
	sets.ws.veryhard.db = set_combine(sets.ws.hard.db, { -- 448 ws acc
		right_ring	= "Toreador's Ring",
	})
	
	sets.jump = {}
	sets.jump.easy = { -- 425 acc
	    head		= "Hecatomb Cap +1",
		body		= "Nocturnus Mail",
		hands		= "Hct. Mittens +1",
		legs		= "Hct. Subligar +1",
		feet		= "Drachen Greaves",
		neck		= "Ire Torque +1",
		waist		= "Warwolf Belt",
		left_ear	= "Harmonius Earring",
		right_ear	= "Brutal Earring",
		left_ring	= "Rajas Ring",
		right_ring	= "Flame Ring",
		back		= "Cerb. Mantle +1",
	}
	sets.jump.medium = sets.jump.easy
	sets.jump.hard = set_combine(sets.jump.medium,{ -- 440 acc
		neck		= "Ancient Torque",
	})
	sets.jump.veryhard = set_combine(sets.jump.hard,{ -- 447 acc
		right_ring	= "Toreador's Ring",
	})
	
	sets.highjump = {legs = "Wym. Brais +1"}
	
	-- Magic sets
	
	sets.enhancing_magic = { -- Skill (pot)
		back		= "Merciful Cape",
		left_ear	= "Augment. Earring",
	}
	sets.enhancing_magic.stoneskin = { -- MND (pot) > Skill (pot)
		head		= "Maat's Cap",
		body		= "Blood Scale Mail",
		hands		= "River Gauntlets",
		legs		= "Homam Cosciales",
		feet		= "Karasutengu",
		neck		= "Stone Gorget",
		waist		= "Ninurta's Sash",
		left_ear	= "Celestial Earring",
		right_ear	= "Celestial Earring",
		left_ring	= "Celestial Ring",
		right_ring	= "Celestial Ring",
		back		= "Merciful Cape",
	}
	
	sets.healing_magic = { -- Cure Potency > 1MND = 3VIT = 5skill
		head		= "Maat's Cap",
		body		= "Blood Scale Mail",
		hands		= "River Gauntlets",
		legs		= "Homam Cosciales",
		feet		= "Karasutengu",
		neck		= "Gnole Torque",
		waist		= "Ninurta's Sash",
		left_ear	= "Roundel Earring",
		right_ear	= "Celestial Earring",
		left_ring	= "Celestial Ring",
		right_ring	= "Celestial Ring",
		back		= "Merciful Cape",
	}
	
	-- Ability sets
	
	sets.hp = { -- HP+ used in Breath triggering
		head		= "Walahra Turban",
		body		= "Blood Scale Mail",
		hands		= "River Gauntlets",
		legs		= "Dusk Trousers +1",
		feet		= "Homam Gambieras",
		neck		= "Bloodbead Gorget",
		waist		= "Jungle Sash",
		left_ear	= "Harmonius Earring",
		right_ear	= "Harmonius Earring",
		left_ring	= "Bomb Queen Ring",
		right_ring	= "Bloodbead Ring",
		back		= "Gigant Mantle",
	}
	
	sets.breath = set_combine(sets.hp,{
		head		= "Drachen Armet", -- for higher trigger treshold
	})
	
	sets.breathpotency = { -- Wym. Armet +1 and Wyvern HP+ here
		head		= "Wym. Armet +1",
		neck		= "Chanoix's Gorget",
		legs        = "Drn. Brais +1",
		body		= "Wyvern Mail",
		feet		= "Homam Gambieras",
		left_ear	= "Dragoon's Earring",
	}
	
	sets.steps = set_combine(sets.melee.acc,{
	})
	
	sets.circle = {legs	= "Drn. Brais +1"}
	sets.callwyvern = {body	= "Wym. Mail +1"}
	sets.angon = {left_ear	= "Dragoon's Earring"}
	
	-- Fast Cast and Haste sets

	sets.precastfastcast = {
		right_ear   = "Loquac. Earring",
    }
	
	sets.fastcasthaste = {
		head		= "Walahra Turban",
		body		= "Wym. Mail +1",
		hands		= "Dusk Gloves +1",
		feet		= "Homam Gambieras",
		waist		= "Ninurta's Sash",
		right_ring	= "Blitz Ring",
		right_ear   = "Loquac. Earring",
    }
	
	-- Other sets
	
	sets.eva = { -- Evasion, PDT (never used on its own)
	    head		= "Wivre Mask +1",
		body		= "Hydra Mail +1",
		hands		= "River Gauntlets",
		legs		= "Raven Hose",
		feet		= "Askar Gambieras",
		neck		= "Evasion Torque",
		waist		= "Warwolf Belt",
		left_ear	= "Triton Earring",
		right_ear	= "Novia Earring",
		left_ring	= "Shadow Ring",
		right_ring	= "Defending Ring",
		back		= "Shadow Mantle",
	}

    sets.rest = { -- hMP
		head		= "Mirror Tiara",
		neck		= "Gnole Torque",
        left_ear    = "Relaxing Earring",
        right_ear   = "Antivenom Earring",
        left_ring   = "Celestial Ring",
        right_ring  = "Celestial Ring",
    }
	
	sets.matching_dayweather = {waist = "Hachirin-no-Obi"}
	
	-- Weapon sets
	
	sets.weapons = {}
	sets.weapons.main = {
		main		= "Gungnir",
		sub			= "Pole Grip",
		ammo		= "Black Tathlum",
	}
	
	sets.weapons.angon = {
		ammo 		= "Angon",
	}
	
	---------------
	-- Variables --
	---------------

	-- Default values, feel free to change
	dring = true											-- true = use dring in engaged set
	ethereal = true											-- true = use ethereal in engaged set (unless you're not /mage)
	
	-- Lists of options. Default value is the first one
	clippingPlane = M{'1', '0.75', '0.5', '10', '5', '2'} 	-- config ClippingPlane value
	meleeMode = M{'easy','medium','hard','veryhard','acc'} 	-- melee modes
		
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
	if ethereal and (player.sub_job == 'RDM' or player.sub_job == 'WHM' or player.sub_job == 'BLU') then equip({left_ear="Ethereal Earring"}) end
end	 

function equip_idle()
	equip(sets.idle)
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
		-- Cancel sneak when using Spectral Jig
		if spell.name == "Spectral Jig" then
			send_command("cancel sneak")

		-- Weaponskills
		elseif spell.type == 'WeaponSkill' then
			
			-- set wsMode to either easy, medium, hard or veryhard based on meleeMode
			local wsMode = meleeMode.current
			if wsMode == 'acc' then wsMode = 'veryhard' end
		
			if spell.name == 'Geirskogul' then
				equip((sets.ws[wsMode]).gk)
			elseif spell.name == 'Drakesbane' then
				equip((sets.ws[wsMode]).db)
			else -- catchall, just STR all the way
				equip(sets.ws.easy.gk)	
			end	 
			
		-- Jumps	
		elseif spell.name:contains('Jump') and spell.name ~= 'Super Jump' then
		
			-- set jumpMode to either easy, medium, hard or veryhard based on meleeMode
			local jumpMode = meleeMode.current
			if jumpMode == 'acc' then jumpMode = 'veryhard' end
			
			-- only change gear if Jump is actually up
			if windower.ffxi.get_ability_recasts()[158] == 0 then
				equip(sets.jump[jumpMode])
			end
			
			-- only change gear if High Jump is actually up
			if spell.name == 'High Jump' and windower.ffxi.get_ability_recasts()[159] == 0 then
				equip(sets.jump[jumpMode])
				equip(sets.highjump)
			end
		
		elseif spell.name == 'Angon' then equip(sets.angon,sets.weapons.angon)		
		elseif spell.name == 'Ancient Circle' then equip(sets.circle)
		elseif spell.name == 'Call Wyvern' then equip(sets.callwyvern)
		elseif spell.type:contains('Step') then equip(sets.steps)	
		elseif spell.name:contains('Utsusemi') then equip(sets.eva,sets.precastfastcast)
		end	
	end
end

-- During casting magic
function midcast(spell)

	-- Equip breath gear on magic
	if spell.action_type == 'Magic' then
	
		-- Only equip extra HP gear (for trigger treshold) during non-weakness (otherwise you always trigger it and can never cure other players)
		if buffactive['Weakness'] then
			add_to_chat(167,'Not using HP gear during magic casting in weak.')
		else
			equip(sets.breath)
		end

		-- The following magic overwrites breath gear since it requires potency

		-- Utsusemi
		if spell.name:contains('Utsusemi') then
			equip(sets.eva,sets.fastcasthaste)

		-- Stoneskin
		elseif spell.name == 'Stoneskin' then
			equip(sets.enhancing_magic.stoneskin)
		
		-- Enspells/phalanx
		elseif spell.name:startswith('En') or spell.name:contains('Phalanx') then
			equip(sets.enhancing_magic)
		
		-- Cures
		elseif spell.name:contains('Cure') or spell.name:contains('Cura') then
			equip(sets.healing_magic)
			if obi_check(spell) then equip(sets.matching_dayweather) end
		end
	end
end

-- During pet breath
function pet_midcast(spell)

	-- breath potency when pet uses Breath
	if spell.name:contains('Breath') then
		equip(sets.breath,sets.breathpotency)
	end
end
	
-- After casting or using an ability	
function aftercast(spell)
	if spell.name == "Angon" then equip(sets.weapons.main) end
	choose_set()
end

-- After pet breath
function pet_aftercast(spell)
	if spell.name:contains('Breath') then
		choose_set()
	end
end

---------------------
-- Player commands --
--------------------- 

function self_command(command)

	-- Change melee mode	
	if string.sub(command, 1, 3) == "mel" then	
		local mel = string.sub(command, 4, -1)
		meleeMode:set(mel)
		choose_set()
		windower.add_to_chat(122,'Meleeing in ' .. meleeMode.current)

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
send_command('wait 1; input /cm u; wait 2; gs equip weapons.main; wait 1; input /lockstyleset 7; wait 1; gs equip idle; wait 1; input /macro book 12; wait 1; input !myth; wait 1; input /echo Gearswap loaded.')