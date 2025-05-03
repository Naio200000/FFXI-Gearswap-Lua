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
- luzaf							Toggle the use of Luzaf's Ring for Rolls.
- qdchat						Toggle the use of Chatoyant's Staff for Quick Draw.
- gatherall						Notifies party to gather.
- gathermages					Notifies mages to gather.
- gathermelees					Notifies melees to gather.

---------------------
-- About this file --
---------------------

DISCLAIMER
I don't play COR at 75 anymore; I will not be updating this file. I recommend adding /mage stuff.

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
		head		="Blood Mask",
		body		="Blood Scale Mail",
		hands		="Denali Wristbands",
		legs		="Blood Cuisses",
		feet		="Hermes' Sandals +1",
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
	
	-- acc: sword 374 / dagger 384
	sets.melee.easy = {
	    head		="Walahra Turban",
		body		="Antares Harness",
		hands		="Dusk Gloves +1",
		legs		="Oily Trousers",
		feet		="Dusk Ledelsens +1",
		neck		="Ancient Torque",
		waist		="Ninurta's Sash",
		left_ear	="Suppanomimi",
		right_ear	="Pixie Earring",
		left_ring	="Toreador's Ring",
		right_ring	="Toreador's Ring",
		back		="Cuchulain's Mantle",
	}
	-- acc: sword 397 / dagger 407
	sets.melee.medium = set_combine(sets.melee.easy,{
	    head		="Optical Hat",
		body		="Antares Harness",
		hands		="Enkidu's Mittens",
		legs		="Oily Trousers",
		feet		="Denali Gamashes",
	})
	-- acc: sword 409 / dagger 419
	sets.melee.hard = set_combine(sets.melee.medium,{
		waist		="Virtuoso Belt",
	})
	
	sets.ranged.easy = {
	-- 396 racc
		head		="Zha'Go's Barbut",
		body		="Denali Jacket",
		hands		="Blood Fng. Gnt.",
		legs		="Dusk Trousers +1",
		feet		="Cor. Bottes +1",
		neck		="Peacock Amulet",
		waist		="Commodore Belt",
		left_ear	="Harmonius Earring",
		right_ear	="Harmonius Earring",
		left_ring	="Rajas Ring",
		right_ring	="Flame Ring",
		back		="Amemet Mantle +1",
	}
	sets.ranged.medium = set_combine(sets.ranged.easy,{
	-- 420 racc
	    left_ring	="Dragon Ring +1",
		right_ring	="Dragon Ring +1",
	})
	sets.ranged.hard = set_combine(sets.ranged.medium,{
	-- 455 racc
	    back		="Jaeger Mantle",
	})
	
	-- WS sets
	
		-- Coronach 		40% AGI, 40% DEX (fixed low enmity)
		-- Slug Shot 		70% AGI (accuracy multiplier: 0.8 at 1000 TP, 0.9 at 2000 TP, 1 at 3000 TP)
		-- Detonator		30% AGI
		-- Leaden Salute	30% AGI
	
	sets.ws = {}
	sets.ws.easy = {}
	sets.ws.medium = {}
	sets.ws.hard = {} -- 396 / 420 / 455

	sets.ws.easy.coronach = { -- 401 ws acc
	    head		="Maat's Cap",
		body		="Denali Jacket",
		hands		="Blood Fng. Gnt.",
		legs		="Dusk Trousers +1",
		feet		="Cor. Bottes +1",
		neck		="Fotia Gorget",
		waist		="Commodore Belt",
		left_ear	="Harmonius Earring",
		right_ear	="Brutal Earring",
		left_ring	="Rajas Ring",
		right_ring	="Flame Ring",
		back		="Amemet Mantle +1",
	}
	sets.ws.medium.coronach = set_combine(sets.ws.easy.coronach,{ -- 425 ws acc
	    left_ring	="Dragon Ring +1",
		right_ring	="Dragon Ring +1",
	})
	sets.ws.hard.coronach = set_combine(sets.ws.medium.coronach,{ -- 445 ws acc
		back		="Jaeger Mantle",
	})
	
	sets.ws.easy.slugshot = set_combine(sets.ws.hard.coronach,{ -- don't think I'll ever use Slug Shot on COR really
	})
	sets.ws.medium.slugshot = set_combine(sets.ws.easy.slugshot,{
	})
	sets.ws.hard.slugshot = set_combine(sets.ws.medium.slugshot,{
	})
	
	-- COR sets
	
	sets.phantomroll = {
		head		="Comm. Tricorne +1",
	}
	sets.quickdraw = { -- dmg+ = mab/gundmg/bulletdmg | acc+ = macc/agi
	    head		="Cor. Tricorne +1",
		body		="Denali Jacket",
		hands		="Rover's Gloves",
		legs		="Denali Kecks",
		feet		="Denali Gamashes",
		neck		="Uggalepih Pendant",
		waist		="Scouter's Rope",
		left_ear	="Novio Earring",
		right_ear	="Moldavite Earring",
		left_ring	="Blobnag Ring",
		right_ring	="Balrahn's Ring",
		back		="Fowler's Mantle +1",
	}
	sets.quickdrawnodmg = set_combine(sets.quickdraw,{
		left_ear	="Drone Earring",
		right_ear	="Drone Earring",
	})
	
	-- Fast Cast and Haste sets
	
	sets.precastfastcast = {
		right_ear   ="Loquac. Earring",
	}
	
	sets.utsusemi = {
		head		="Walahra Turban",
		hands		="Dusk Gloves +1",
		feet		="Dusk Ledelsens +1",
		neck		="Tiercel Necklace",
		waist		="Ninurta's Sash",
		left_ear	="Loquac. Earring",
	}
	
	-- Other sets
	
	sets.steps = {
	    head		="Optical Hat",
		body		="Antares Harness",
		hands		="Enkidu's Mittens",
		legs		="Oily Trousers",
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
	
	sets.matching_dayweather = {waist = "Hachirin-no-Obi"}
	
	-- Weapon sets
	
	sets.weapons = {}
	sets.weapons.gun = {
		ranged		= "Annihilator",
		ammo		= "Steel Bullet",
	}
	sets.weapons.chatoyant = {
		main		= "Chatoyant Staff",
		sub			= "Axe Grip",
	}
	sets.weapons.vulcans = {
		main		= "Vulcan's Staff",
		sub			= "Axe Grip",
	}
	sets.weapons.mekki = {
		main		= "Mekki Shakki",
		sub			= "Rose Grip",
	}
	sets.weapons.sword = {
		main		= "Joyeuse",
		sub			= "Legion Scutum",
	}
	sets.weapons.dagger = {
		main		= "Mercurial Kris",
		sub			= "Legion Scutum",
	}
	sets.weapons.swdg = {
		main		= "Joyeuse",
		sub			= "Mercurial Kris",
	}
	sets.weapons.unequip = {
		main		= empty,
		sub			= empty,
	}
	
	---------------
	-- Variables --
	---------------
	
	-- Don't change this:
	init_rolls()

	-- Default values, feel free to change
	dring = true											-- true = use dring in engaged set
	qdchat = false											-- true = swap to chatoyant for QD
	luzaf = true											-- true = use Luzaf's ring for rolling
	
	-- Lists of options. Default value is the first one
	clippingPlane = M{'1', '0.75', '0.5', '10', '5', '2'} 	-- config ClippingPlane value
	meleeMode = M{'easy','medium','hard'} 	-- melee modes
	rangedMode = M{'easy','medium','hard'} 	-- ranged modes
	
end

---------------
-- Functions --
---------------

-- Set up roll helper
function init_rolls()
	sets.current = {}
	current_roll = ""
	rollNames = {
		'Beast Roll',
		'Chaos Roll',
		'Choral Roll',
		'Corsair\'s Roll',
		'Dancer\'s Roll',
		'Drachen Roll',
		'Evoker\'s Roll',
		'Fighter\'s Roll',
	    'Gallant\'s Roll',
		'Healer\'s Roll',
		'Hunter\'s Roll',
		'Magus\'s Roll',
		'Monk\'s Roll',
		'Ninja Roll',
	    'Puppet Roll',
		'Rogue\'s Roll',
		'Samurai Roll',
		'Scholar\'s Roll',
		'Warlock\'s Roll',
		'Wizard\'s Roll', 
	}
	rollInfo = {
        -- 1-11 boost, Bust effect, Effect, Lucky, Unlucky, +1 Phantom Roll Effect, Job Bonus, Bonus Equipment and Effect,
        --[['Beast']] {"6%","8%","9%","25%","11%","12%","16%","3%","17%","18%","31%",'0','Pet Attack',4,8, 32,{'bst',10}},
        --[['Chaos']] {"6%","8%","9%","25%","11%","12%","16%","3%","17%","18%","31%","-9.76",'Attack', 4,8, 32,{'drk',10}},
		--[['Choral']] {"8%","42%","11%","15%","19%","4%","23%","27%","31%","35%","50%",'+25','Spell Interruption Rate Down',2,6, 4,{'brd',25}},
		--[['Corsair\'s']] {"15%","16%","16%","17%","25%","18%","20%","21%","13%","22%","29%",'-6','Experience Points',5,9, 2,{'cor',5}},
		--[['Dancer\'s']] {3,4,12,5,6,7,1,8,9,10,16,'-4','Regen',3,7, 2,{'dnc',4}},
        --[['Drachen']] {"10%","13%","15%","40%","18%","20%","25%","5%","28%","30%","50%",'0','Pet Accuracy',4,8, 5,{'drg',15}},
		--[['Evoker\'s']] {1,1,1,1,3,2,2,2,1,3,4,'-1','Refresh',5,9, 1,{'smn',1}},
        --[['Fighter\'s']] {"2%","2%","3%","4%","12%","5%","6%","7%","1%","9%","18%",'-4','Double Attack',5,9, 1,{'war',5}},
		--[['Gallant\'s']] {"48%","60%","200%","72%","88%","104%","32%","120%","140%","160%","240%",'-11.72','Defense',3,7, 24,{'pld',120}},
        --[['Healer\'s']] {"3%","4%","12%","5%","6%","7%","1%","8%","9%","10%","16%",'-4','Cure Potency Received',3,7, 1,{'whm',4}},
        --[['Hunter\'s']] {10,13,15,40,18,20,25,5,28,30,50,'-15','Accuracy',4,8, 5,{'rng',15}},
        --[['Magus\'s']] {5,20,6,8,9,3,10,13,14,15,25,'-8','Magic Defense',2,6, 2,{'blu',8}},
        --[['Monk\'s']] {8,10,32,12,14,15,4,20,22,24,40,'-?','Subtle Blow', 3,7, 4,{'mnk',10}},
        --[['Ninja']] {10,13,15,40,18,20,25,5,28,30,50,'-15','Evasion',4,8, 5,{'nin',15}},
        --[['Puppet']] {5,8,35,11,14,18,2,22,26,30,40,'-8','Pet Macc/MAB',3,7, 3,{'pup',12}},
        --[['Rogue\'s']] {"2%","2%","3%","4%","12%","5%","6%","6%","1%","8%","14%",'-6','Critical Hit Rate',5,9, 1,{'thf',5}},
        --[['Samurai']] {8,32,10,12,14,4,16,20,22,24,40,'-10','Store TP',2,6, 4,{'sam',10}},
        --[['Scholar\'s']] {"2%","10%","3%","4%","4%","1%","5%","6%","7%","7%","12%",'-3','Conserve MP',2,6, 1,{'sch',3}},
        --[['Warlock\'s']] {10,13,15,40,18,20,25,5,28,30,50,'-15','Magic Accuracy',4,8, 5,{'rdm',15}},
        --[['Wizard\'s']] {4,6,8,10,25,12,14,17,2,20,30, "-10",'MAB',5,9, 2,{'blm',10}},
    }
end

-- Rolling strategy helper (mildly conservative)
windower.register_event('action', function(act)

	-- If it's a roll or double-up (act.param IDs from job_abilities res file)
    if act.category == 6 and (act.param > 96 and act.param < 124) then
        local rollID = act.param
        local rollNum = act.targets[1].actions[1].param
		local rollIndex
		
		-- Convert windower IDs to alphabetical IDs
		if rollID == 98 then rollIndex = 8
		elseif rollID == 99 then rollIndex = 13
		elseif rollID == 100 then rollIndex = 10
		elseif rollID == 101 then rollIndex = 20
		elseif rollID == 102 then rollIndex = 19
		elseif rollID == 103 then rollIndex = 16
		elseif rollID == 104 then rollIndex = 9
		elseif rollID == 105 then rollIndex = 2
		elseif rollID == 106 then rollIndex = 1
		elseif rollID == 107 then rollIndex = 3
		elseif rollID == 108 then rollIndex = 11
		elseif rollID == 109 then rollIndex = 17
		elseif rollID == 110 then rollIndex = 14
		elseif rollID == 111 then rollIndex = 6
		elseif rollID == 112 then rollIndex = 7
		elseif rollID == 113 then rollIndex = 12
		elseif rollID == 114 then rollIndex = 4
		elseif rollID == 115 then rollIndex = 15
		elseif rollID == 116 then rollIndex = 5
		elseif rollID == 117 then rollIndex = 18
		end
		
		-- Determine rolling strategy message
		local strategy = "again"
		if rollNum > 6 or rollNum == rollInfo[rollIndex][14] then strategy = "keep" -- if the number is > 7 or lucky
		elseif rollNum > 12 then strategy = "bust" end -- if you bust
		if rollInfo[rollIndex][14] == 3 and rollNum == 7 then strategy = "again" end -- in 3/7 rolls we reroll 7
		
		-- Messages for party members
		if rollNum == rollInfo[rollIndex][14] then -- Lucky
			send_command("input /p <wstar> Lucky " .. rollNum .. " " .. rollNames[rollIndex] .. " = " .. rollInfo[rollIndex][13] .. " +" .. rollInfo[rollIndex][rollNum] .. " <wstar>" )
		elseif rollNum == 11 then -- 11
			send_command("input /p <wstar><wstar> 11 " .. rollNames[rollIndex] .. " = " .. rollInfo[rollIndex][13] .. " +" .. rollInfo[rollIndex][rollNum] .. " <wstar><wstar>" )
		elseif rollNum > 11 then -- Bust
			send_command("input /p <bcircle>_<bcircle> Busted " .. rollNames[rollIndex] .. "! <bcircle>_<bcircle>" )
		else
			-- Message for self
			if strategy == "again" then
				windower.add_to_chat(122,rollNames[rollIndex] .. " " .. rollInfo[rollIndex][14] .. "/" .. rollInfo[rollIndex][15] .. ", you rolled " .. rollNum .. ". Keep rolling.")
			elseif strategy == "keep" then
				windower.add_to_chat(122,rollNames[rollIndex] .. " " .. rollInfo[rollIndex][14] .. "/" .. rollInfo[rollIndex][15] .. ", you end on a " .. rollNum .. ". " .. rollInfo[rollIndex][13] .. " +" .. rollInfo[rollIndex][rollNum] .. ".")
			elseif strategy == "bust" then
				windower.add_to_chat(122,"You BUSTED!")
			end
		end
	end
end)


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

	-- Weaponskills
	elseif spell.type == 'WeaponSkill' then
		if player.target.distance > 15.90 then
			add_to_chat(122,'You are too far to WS.')
			cancel_spell()
		else
			if spell.name == 'Coronach' or spell.name == 'Detonator' or spell.name == 'Leaden Salute' then
				equip((sets.ws[rangedMode.current]).coronach)
			elseif spell.name == 'Slug Shot' then
				equip((sets.ws[rangedMode.current]).slugshot)
			else -- catchall
				equip(sets.ws.easy.coronach)	
			end
		end
		
	-- Phantom roll
	elseif spell.name:contains("Roll") then
		checkLuzaf(luzaf)
		current_roll = spell.name
		equip(sets.phantomroll)
		
	-- Double-up
	elseif spell.name == "Double-Up" then
		checkLuzaf(luzaf)
		equip(sets.phantomroll)
		
	-- Quick Draw
	elseif spell.name == 'Fire Shot' or
	 	   spell.name == 'Ice Shot' or
	 	   spell.name == 'Wind Shot' or
	 	   spell.name == 'Earth Shot' or
	 	   spell.name == 'Water Shot' or
	 	   spell.name == 'Thunder Shot' or
	 	   spell.name == 'Light Shot' or
		   spell.name == 'Dark Shot'
	then
		if player.target.distance > 17.9 then
			add_to_chat(122,'You are too far to use Quick Draw.')
			cancel_spell()
		else
			equip(sets.quickdraw)
			if qdchat then equip({main="Chatoyant Staff",sub="Reaver Grip +1"}) end
			if obi_check(spell) then equip(sets.matching_dayweather) end
			if spell.name == 'Light Shot' or spell.name == 'Dark Shot' then equip(sets.quickdrawnodmg) end
			if spell.name == 'Light Shot' then send_command('input /p Sleeping ' .. player.subtarget.name .. '! <wstar> Disengage!') end
		end
	
	-- Utsusemi
	elseif spell.name:contains('Utsusemi') then
		equip(sets.precastfastcast) -- if you end up going /mage and casting, add FC to other spells too
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

-- Handle Luzaf
function checkLuzaf(luzaf)
	if luzaf then
		if not player.equipment.right_ring == "Luzaf's Ring" then
			cancel_spell()
			windower.add_to_chat(122,"Could not equip Luzaf's Ring.")
		end
	end
end

function self_command(command)

	-- Toggle Luzafs
	if command == "luzaf" then
		if luzaf then
			luzaf = false
			windower.add_to_chat(122,'Don\'t use Luzaf\'s Ring.')
		else
			luzaf = true
			windower.add_to_chat(122,'Use Luzaf\'s Ring.')
		end	
		
	-- Equip Luzafs pre-roll for range visualization
	elseif command == "prepareRoll" then
		if luzaf then equip({right_ring = "Luzaf's Ring"}) end
		
	-- Change weapons
	elseif string.sub(command, 1, 3) == "wpn" then
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
		
	-- Quick Draw with Chatoyant swaps
	elseif command == 'qdchat' then
		if qdchat == false then
			qdchat = true
			windower.add_to_chat(122,'Quick Draw with Chatoyant/Grip.')
		else
			qdchat = false
			windower.add_to_chat(122,'Do not switch to Chatoyant for Quick Draw.')
		end	
		
	-- Notify party to gather for rolls
	elseif command == "gatherall" then send_command("input /p <wustriangle> Everyone <bustriangle> Gather for Roll <wustriangle>")
	elseif command == "gathermages" then send_command("input /p <wustriangle> Mages <bustriangle> Gather for Roll <wustriangle>")
	elseif command == "gathermelees" then send_command("input /p <wustriangle> Melees <bustriangle> Gather for Roll <wustriangle>")
		
	-- Something to re-equip bullets (or do automatically with addon idk)	
		
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
	elseif command == "equipgun" then
		send_command('input /equipset 5')
	end
end

---------------
-- Init code --
--------------- 
 
enable('main','sub','range','ammo','head','neck','left_ear','right_ear','body','hands','left_ring','right_ring','back','waist','legs','feet') 
send_command('wait 1; input /cm u; wait 2; gs equip weapons.chatoyant; wait 1; gs equip idle; wait 1; gs equip weapons.gun; wait 1; input /macro book 19; wait 2; input !myth; wait 1; input /lockstyleset 45; wait 1; input /echo Gearswap loaded.')