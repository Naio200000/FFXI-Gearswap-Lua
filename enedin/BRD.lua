--[[

----------------
-- Properties --
----------------

Only job-specific properties are shown here. For the general list, more info, tips etc. visit my Gearswap page: https://enedin.be/gs/

- I have a precastfastcastsongs set which doubles as my yellow HP set. This makes the setup for precast pretty easy.
  This may not work for you, depending on race and gear options.

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
	    main		="Terra's Staff",
		sub			="Reign Grip",
		range		="Gjallarhorn",
		head		="Genbu's Kabuto",
		body		="Dalmatica +1",
		hands		="Seiryu's Kote",
		legs		="Goliard Trews",
		feet		="Suzaku's Sune-Ate",
		neck		="Jeweled Collar +1",
		waist		="Resolute Belt",
		left_ear	="Merman's Earring",
		right_ear	="Merman's Earring",
		left_ring	="Shadow Ring",
		right_ring	="Defending Ring",
		back		="Hexerei Cape",
	}
	
	-- Magic sets
	
	sets.debuff = { -- Skill/CHR/macc
	    main		="Chatoyant Staff",
		sub			="Reign Grip",
		range		="Gjallarhorn",
		head		="Brd. Roundlet +1",
		body		="Valkyrie's Coat",
		hands		="Chl. Cuffs +1",
		legs		="Chl. Cannions +1",
		feet		="Oracle's Pigaches", -- Upgrade to Valkyrie's when you have the ZAN
		neck		="Piper's Torque",
		waist		="Gleeman's Belt",
		left_ear	="Singing Earring",
		right_ear	="Musical Earring",
		left_ring	="Nereid Ring",
		right_ring	="Balrahn's Ring",
		back		="Jester's Cape +1",
	}
	sets.buff = { -- Skill
	    main		="Chanter's Staff",
		sub			="Vivid Strap +1",
		range		="Gjallarhorn",
		head		="Demon Helm +1",
		body		="Minstrel's Coat",
		hands		="Chl. Cuffs +1",
		legs		="Chl. Cannions +1",
		feet		="Oracle's Pigaches",
		neck		="Wind Torque",
		waist		="Ninurta's Sash",
		left_ear	="Wind Earring",
		right_ear	="Musical Earring",
		left_ring	="Nereid Ring",
		right_ring	="Nereid Ring",
		back		="Astute Cape",
	}
	
	sets.enhancing_magic = { -- Skill (pot) > MP
		main		="Terra's Staff",
		sub			="Vivid Strap +1",
		range		="Gjallarhorn",
		head		="Walahra Turban",
		body		="Goliard Saio",
		hands		="Dusk Gloves +1",
		legs		="Byakko's Haidate",
		feet		="Rostrum Pumps",
		neck		="Enhancing Torque",
		waist		="Pythia Sash +1",
		left_ear	="Augment. Earring",
		right_ear	="Loquac. Earring",
		left_ring	="Shadow Ring",
		right_ring	="Defending Ring",
		back		="Merciful Cape",
	}
	sets.enhancing_magic.stoneskin = { -- MND (pot), Fast Cast/MP when cap is reached
		main		="Alkalurops",
		sub			="Reign Grip",
		range		="Gjallarhorn",
		head		="Maat's Cap",
		body		="Mahatma Hpl.",
		hands		="Dvt. Mitts +1",
		legs		="Mahatma Slops",
		feet		="Suzaku's Sune-Ate",
		neck		="Stone Gorget",
		waist		="Pythia Sash +1",
		left_ear	="Celestial Earring",
		right_ear	="Celestial Earring",
		left_ring	="Celestial Ring",
		right_ring	="Celestial Ring",
		back		="Dew Silk Cape +1",
	}
	
	sets.healing_magic = { -- Cure Potency > 1MND = 3VIT = 5skill
		main		="Chatoyant Staff",
		sub			="Reign Grip",
		range		="Gjallarhorn",
		head		="Maat's Cap",
		body		="Mahatma Hpl.",
		hands		="Dvt. Mitts +1",
		legs		="Mahatma Slops",
		feet		="Suzaku's Sune-Ate",
		neck		="Fylgja Torque +1",
		waist		="Pythia Sash +1",
		left_ear	="Celestial Earring",
		right_ear	="Celestial Earring",
		left_ring	="Celestial Ring",
		right_ring	="Celestial Ring",
		back		="Dew Silk Cape +1",
	}
	
	-- Fast Cast and Haste sets
	
	sets.precastfastcast = { -- Fast Cast (casting time)
		sub			= "Vivid Strap +1",
		right_ear   = "Loquac. Earring",
		feet		= "Rostrum Pumps",
		back		= "Veela Cape",
	}
	sets.precastfastcastsongs = { -- Fast Cast / Song Spellcasting Time - also doubles as yellow HP set, if you reach less than 3/4 of your naked HP (with merits)
	    main		="Terra's Staff",
		sub			="Vivid Strap +1",
		range		="Gjallarhorn",
		head		="Zenith Crown +1",
		body		="Sheikh Manteel",
		hands		="Zenith Mitts +1",
		legs		="Zenith Slacks +1",
		feet		="Rostrum Pumps",
		neck		="Morgana's Choker",
		waist		="Scouter's Rope",
		left_ear	="Astral Earring",
		right_ear	="Loquac. Earring",
		left_ring	="Serket Ring",
		right_ring	="Minstrel's Ring",
		back		="Veela Cape",
	}
	
	sets.fastcasthaste = { -- Fast Caste = Haste (recast time)
		main		= "Chatoyant Staff",
		sub			= "Reign Grip",
		range		= "Gjallarhorn",
		head		= "Walahra Turban",
		body		= "Goliard Saio",
		hands		= "Dusk Gloves +1",
		legs		= "Byakko's Haidate",
		feet		= "Rostrum Pumps",
		neck		= "Bloodbead Gorget",
		waist		= "Ninurta's Sash",
		left_ear	= "Celestial Earring",
		right_ear	= "Loquac. Earring",
		left_ring	= "Shadow Ring",
		right_ring	= "Defending Ring",
		back		= "Veela Cape",
	}
	sets.fastcasthastesongs = set_combine(sets.fastcasthaste,{ -- Song Recast Delay
		hands		= "Sheikh Gages"
	})
	
	-- Other sets

	sets.matching_day = {waist = "Hachirin-no-Obi",}
	sets.matching_dayweather = {waist = "Hachirin-no-Obi"}
	
	sets.rest = { -- hMP
		main		= "Chatoyant Staff",
		sub			= "Reign Grip",
		range		= "Gjallarhorn",
		head		= "Mirror Tiara",
		body		= "Mahatma Hpl.",
		hands		= "Oracle's Gloves",
		legs		= "Oracle's Braconi",
		feet		= "Goliard Clogs",
		neck		= "Gnole Torque",
		waist		= "Qiqirn Sash +1",
		left_ear	= "Relaxing Earring",
		right_ear	= "Antivenom Earring",
		left_ring	= "Celestial Ring",
		right_ring	= "Celestial Ring",
		back		= "Invigorating Cape"
	}
	
	-- Melee sets
	
	sets.melee = {
		main		="Mandau",
		sub			="Genbu's Shield",
		ammo		="White Tathlum",
		head		="Walahra Turban",
		body		="Hydra Doublet",
		hands		="Hydra Gloves",
		legs		="Byakko's Haidate",
		feet		="Hydra Gaiters",
		neck		="Ancient Torque",
		waist		="Ninurta's Sash",
		left_ear	="Harmonius Earring",
		right_ear	="Harmonius Earring",
		left_ring	="Rajas Ring",
		right_ring	="Defending Ring",
		back		="Cuchulain's Mantle"
	}
	sets.ws = {
		head		="Hecatomb Cap +1",
		body		="Hct. Harness +1",
		hands		="Hct. Mittens +1",
		legs		="Hct. Subligar +1",
		feet		="Hct. Leggings +1",
		neck		="Fotia Gorget",
		waist		="Warwolf Belt",
		left_ear	="Harmonius Earring",
		right_ear	="Harmonius Earring",
		left_ring	="Rajas Ring",
		right_ring	="Flame Ring",
		back		="Cerb. Mantle +1",
	}
	
	---------------
	-- Variables --
	---------------
	
	-- Lists of options. Default value is the first one
	clippingPlane = M{'1', '0.75', '0.5', '10', '5', '2'} 	-- config ClippingPlane value
	
	initializeNakedHPMP() -- initialize HP and MP values for use in Minstrel's Ring calculation

end

---------------
-- Functions --
---------------

function initializeNakedHPMP() -- magic numbers because the HP/MP % checks for latents aren't coded properly on LSB. It uses naked HP/MP, no gear, no food, no max HP/MP boost traits, but it does include HP and MP merits. Others will have to figure out these values for themselves for their own character.
    if player.sub_job == 'WHM' then
        nakedHP = 1166
        nakedMP = 217
    elseif player.sub_job == 'RDM' then
        nakedHP = 1184
        nakedMP = 198
	else
        nakedHP = 1214
        nakedMP = 80
    end
end

function status_change(new,old)
    choose_set()
end

-- Main function that decides whether to equip engaged/idle/resting gear
function choose_set()
    if player.status == "Engaged" then
        equip(sets.melee)
    elseif player.status == "Resting" then
		equip(sets.rest)
	else
        equip(sets.idle)
    end
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

function equip_enfeebling(spell)
	-- if you're enfeebling on BRD, I take it you mean Dia so no potency gear here
	equip(sets.fastcasthaste)
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

function equip_song(spell)
	
	-- no potency/macc songs
	if spell.name:contains('Mazurka')
	or spell.name:contains('Paeon')
	or spell.name:contains('Ballad')
	or spell.name:contains('Etude') then
		equip(sets.fastcasthastesongs)
		
	-- debuffs	
	elseif spell.name:contains('Requiem')
	or spell.name:contains('Elegy')
	or spell.name:contains('Threnody')
	or spell.name:contains('Finale')
	or spell.name:contains('Lullaby') then
		equip(sets.debuff)
		
	-- other spells are all buffs with potency
	else
		equip(sets.buff)
	end
	
end

-----------------------
-- Pre/mid/aftercast --
-----------------------

-- Before casting/using ability
function precast(spell, spellMap, action)
	
		-- Magic
	if spell.action_type == 'Magic' then
	
		-- Cancel magic when it is not up yet
		local spell_recasts = windower.ffxi.get_spell_recasts()
		if spell_recasts[spell.recast_id] > 60 then  -- some margin to account for server lag
			add_to_chat(167,spell.english .. ' is still on cooldown!')
			cancel_spell()
		else
		
			-- Check range 
			if spell.name:contains('Requiem') and player.target.distance > 16.3 then
				add_to_chat(122,'You are too far to sing Requiem.')
				cancel_spell()
			elseif spell.name:contains('Lullaby') and player.subtarget.distance > 16.3 then
				add_to_chat(122,'You are too far to sing Lullaby.')
				cancel_spell()
			elseif (spell.name:contains('Threnody') or spell.name:contains('Finale') or spell.name:contains('Elegy')) and player.target.distance > 20.3 then
				add_to_chat(122,'You are too far to sing ' .. spell.name)
				cancel_spell()
			end 

			-- Fast cast for all spells	
			if spell.type == "BardSong" then
				equip(sets.precastfastcastsongs)
			else
				equip(sets.precastfastcast)
			end
		
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
	end
end

-- During casting magic
function midcast(spell)
 
	if spell.skill == 'Healing Magic' then
        equip_heal(spell)
    elseif spell.skill == 'Enhancing Magic' then
        equip_enhancing(spell)
    elseif spell.name:contains('Utsusemi') then
		equip(sets.fastcasthaste)
	elseif spell.type == 'BardSong' then
		equip_song(spell)
	elseif spell.type == 'WeaponSkill' then
		equip(sets.ws)
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
		
	-- Clipping plane (requires Config plugin)		
	if command == "clippingPlane" then
		clippingPlane:cycle()
		send_command('input //config ClippingPlane ' .. clippingPlane.value)
		windower.add_to_chat(122,"ClippingPlane: " .. clippingPlane.current)
	end
end

---------------
-- Init code --
--------------- 
 
enable('main','sub','range','ammo','head','neck','left_ear','right_ear','body','hands','left_ring','right_ring','back','waist','legs','feet') 
send_command('wait 1; input /cm u; wait 2; gs equip idle; wait 2; input /macro book 18; wait 1; input /lockstyleset 46; wait 1; input /echo Gearswap loaded.')