--[[

-- About --

    This lua file is for the Monk job. It is designed to be used with the GearSwap addon for Windower 4.
    It includes sets for idle, melee, and WS gear, as well as functions for precasting, midcasting, and aftercasting spells.
    As well as variables for changing weapons and melee modes and WS modifiers.
	It also includes a function for buff changes, specifically for the Third Eye ability.

-- Comands --

    mel - Change melee mode. Example: melnuke or melmelee
    use_terras - Toggle between using Terra's Staff and Claustrum in idle.
    toyellowHP - Equip yellow HP set for a split second, then go back to idle set to trigger yellow HP.
	gloves - toggle between using the Sorcerer's gloves for magic burst
	
-- Version --

    v0 - Base sets and functions.
    v1 - Added functions to all magic types.
    v2 - Added yellow HP function.
    v3 - Added nuke and melee toggle.
    v4 - Added Initialization of naked HP/MP for latents.
	v5 - Added Glove variable to toggle Sorcerer's gloves for magic burst.

-- Credits --

	Thanks to Wren and Enedin for their example lua files.
    https://enedin.be 
	https://supernovaffxi.fandom.com/wiki/Wren%27s_Gearswaps .

]]--

----------
-- Sets --
----------

--TODO: add comments to all sets

function get_sets()

    -- Load the necessary files
    -- Modes.lua this help on the use of cycling/trigger/etc variables
    include('Modes.lua')

    -- Idle sets
    -- Has EVA and Damage reduction and absorbtion

    sets.idle = {
		
		main		= "Claustrum",
		sub			= "Wise Strap",
		range		=  "Aureole",
		head		= "Optical Hat",
		body		= "Dalmatica +1",
		hands		= "Hydra Gloves",
		legs		= "Hydra Brais",
		feet		= "Herald's Gaiters",
		neck		= "Evasion Torque",
		waist		= "Sorcerer's Belt",
		left_ear	= "Ethereal Earring",
		right_ear	= "Novia Earring",
		left_ring	= "Shadow Ring",
		right_ring	= "Alert Ring",
		back		= "Shadow Mantle",
	}

    sets.melee = {

		head		= "Walahra Turban",
		body		= "Goliard Saio",
		hands		= "Hydra Gloves",
		legs		= "Hydra Brais",
		feet		= "Nashira Crackows",
		neck		= "Ancient Torque",
		waist		= "Ninurta's Sash",
		left_ear	= "Ethereal Earring",
		right_ear	= "Brutal Earring",
		left_ring	= "Mars's Ring",
		right_ring	= "Rajas Ring",
		back		= "Umbra Cape",
	}

    sets.ws = {

		head		= "Optical Hat",
		body		= "Hydra Doublet",
		hands		= "Hydra Gloves",
		legs		= "Hydra Brais",
		feet		= "Hydra Gaiters",
		neck		= "Ancient Torque",
		waist		= "Headlong Belt",
		left_ear	= "Ethereal Earring",
		right_ear	= "Brutal Earring",
		left_ring	= "Mars's Ring",
		right_ring	= "Toreador's Ring",
		back		= "Umbra Cape",
	}

    sets.magic = {}

    sets.magic.elemental = {

		main={ name="Claustrum", augments={'"Mag.Atk.Bns."+5','"Refresh"+1','MP recovered while healing +7',}},
		sub			= "Wise Strap",
		range		=  "Aureole",
		head		= "Src. Petasos +1",
		body		= "Genie Weskit",
		hands		= "Zenith Mitts +1",
		legs		= "Valkyrie's Trews",
		feet		= "Shrewd Pumps",
		neck		= "Lmg. Medallion +1",
		waist		= "Witch Sash",
		left_ear	= "Moldavite Earring",
		right_ear	= "Novio Earring",
		left_ring	= "Omega Ring",
		right_ring	= "Galdr Ring",
		back		= "Ixion Cape",
	}

    sets.magic.elemental.debuff = {

		main={ name="Claustrum", augments={'"Mag.Atk.Bns."+5','"Refresh"+1','MP recovered while healing +7',}},
    	sub			= "Bugard Strap +1",
		range		= "Aureole",
		head		= "Maat's Cap",
		body		= "Mahatma Hpl.",
		hands		= "Valkyrie's Cuffs",
		legs		= "Mahatma Slops",
		feet		= "Goliard Clogs",
		neck		= "Lmg. Medallion +1",
		waist		= "Witch Sash",
		left_ear	= "Omn. Earring +1",
		right_ear	= "Novio Earring",
		left_ring	= "Omega Ring",
		right_ring	= "Galdr Ring",
		back		= "Ixion Cape",
	}

    sets.magic.enfeebling = {

		main={ name="Claustrum", augments={'"Mag.Atk.Bns."+5','"Refresh"+1','MP recovered while healing +7',}},
		sub			= "Bugard Strap +1",
		range		= "Aureole",
		head		= "Genie Tiara",
		body		= "Wizard's Coat",
		legs		= "Genie Lappas",
		neck		= "Enfeebling Torque",
		waist		= "Witch Sash",
		left_ear	= "Helenus's Earring",
		right_ear	= "Cass. Earring",
		right_ring	= "Omega Ring",
		back		= "Altruistic Cape",
	}

    sets.magic.enfeebling.int = set_combine(sets.magic.enfeebling, {

	    hands		= "Valkyrie's Cuffs",
    	left_ring	= "Galdr Ring",
	    feet		= "Valkyrie's Clogs",
	})

    sets.magic.enfeebling.mnd = set_combine(sets.magic.enfeebling, {

		hands		= "Bricta's Cuffs",
		left_ring	= "Karka Ring",
		feet		= "Goliard Clogs",
	})

    sets.magic.dark = {

		main={ name="Claustrum", augments={'"Mag.Atk.Bns."+5','"Refresh"+1','MP recovered while healing +7',}},
		sub			= "Dark Grip",
		range		= "Aureole",
		head		= "Nashira Turban",
		body		= "Oracle's Robe",
		hands		= "Sorcerer's Gloves",
		legs		= "Wizard's Tonban",
		feet		= "Genie Huaraches",
		neck		= "Dark Torque",
		waist		= "Witch Sash",
		left_ear	= "Dark Earring",
		right_ear	= "Omn. Earring +1",
		left_ring	= "Galdr Ring",
		right_ring	= "Omega Ring",
		back		= "Merciful Cape",
	}

    sets.magic.dark.stun = {

		sub			= "Vivid Strap +1",
		head		= "Walahra Turban",
		body		= "Goliard Saio",
		hands		= "Nashira Gages",
		feet		= "Nashira Crackows",
		left_ear	= "Omn. Earring +1",
		back		= "Veela Cape",
	}

    sets.magic.healing = {

		main		= "Chatoyant Staff",
		sub			= "Bugard Strap +1",
		range		= "Aureole",
		body		= "Ixion Cloak",
		hands		= "Bricta's Cuffs",
		legs		= "Mahatma Slops",
    	feet		= "Valkyrie's Clogs",
		neck		= "Fylgja Torque +1",
		waist		= "Witch Sash",
		left_ear	= "Celestial Earring",
		right_ear	= "Roundel Earring",
		left_ring	= "Karka Ring",
		right_ring	= "Celestial Ring",
		back		= "Dew Silk Cape +1",
	}

    sets.magic.enhancing = {

		main={ name="Claustrum", augments={'"Mag.Atk.Bns."+5','"Refresh"+1','MP recovered while healing +7',}},
		sub			= "Bugard Strap +1",
		range		= "Aureole",
		head		= "Nashira Turban",
		body		= "Mahatma Hpl.",
		hands		= "Bricta's Cuffs",
		legs		= "Mahatma Slops",
		feet		= "Genie Huaraches",
		neck		= "Enhancing Torque",
		waist		= "Ninurta's Sash",
		left_ear	= "Augment. Earring",
		right_ear	= "Celestial Earring",
		left_ring	= "Karka Ring",
		right_ring	= "Celestial Ring",
		back		= "Merciful Cape",
	}

    sets.magic.enhancing.stoneskin = {

		main={ name="Claustrum", augments={'"Mag.Atk.Bns."+5','"Refresh"+1','MP recovered while healing +7',}},
		sub			= "Bugard Strap +1",
		range		= "Aureole",
		head		= "Maat's Cap",
		body		= "Mahatma Hpl.",
		hands		= "Bricta's Cuffs",
		legs		= "Mahatma Slops",
    	feet		= "Valkyrie's Clogs",
		neck		= "Gnole Torque",
		waist		= "Witch Sash",
		left_ear	= "Celestial Earring",
		right_ear	= "Celestial Earring",
		left_ring	= "Karka Ring",
		right_ring	= "Celestial Ring",
		back		= "Dew Silk Cape +1",
	}

    sets.fastcast = {

		sub			= "Vivid Strap +1",
		range		= "Aureole",
		head		= "Walahra Turban",
		body		= "Goliard Saio",
		hands		= "Nashira Gages",
		right_ear	= "Loquac. Earring",
		waist		= "Ninurta's Sash",
		back		= "Veela Cape",
	}

    sets.yellowHP = {
		
        main="Alkalurops",
        sub="Dark Grip",
        body="Dalmatica +1",
        hands="Zenith Mitts +1",
        feet="Zenith Pumps +1",
        neck="Morgana's Choker",
        left_ear="Astral Earring",
        left_ring="Serket Ring",
        right_ring="Ether Ring",
        back="Ixion Cape",
	}

    sets.matching_day = {
	
        waist		= "Hachirin-no-Obi",
		legs		= "Src. Tonban +1"
	}

	sets.matching_dayweather = {waist = "Hachirin-no-Obi"}

    sets.resting = {

		main		= "Claustrum",		
		head		= "Goliard Chapeau",
		body		= "Oracle's Robe",
		hands		= "Hydra Gloves",
		legs		= "Oracle's Braconi",
		feet		= "Goliard Clogs",
		neck		= "Gnole Torque",
		waist		= "Hierarch Belt",
		left_ring	= "Celestial Ring",
		right_ring	= "Celestial Ring",
	}

    sets.weapons = {}

    sets.weapons.staff = {
		    
		main		= { name="Claustrum", augments={'"Mag.Atk.Bns."+5','"Refresh"+1','MP recovered while healing +7',}},
		sub			= "Pole Grip",
		range		= "Aureole",
	}

    ---------------
	-- Variables --
	---------------
    
   	use_terras = false
	gloves = false

    meleeMode = M{'nuke', 'melee'}

    initializeNakedHPMP()
end

---------------
-- Functions --
---------------

function initializeNakedHPMP() -- magic numbers because the HP/MP % checks for latents aren't coded properly on LSB. It uses naked HP/MP, no gear, no food, no max HP/MP boost traits, but it does include HP and MP merits. Others will have to figure out these values for themselves for their own character.
    if player.sub_job == 'RDM' then
        nakedHP = 852
        nakedMP = 938
    elseif player.sub_job == 'WHM' then
        nakedHP = 834
        nakedMP = 957
    elseif player.sub_job == 'SCH' then
        nakedHP = 834
        nakedMP = 938
    else
        nakedHP = 852
        nakedMP = 879
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
	    send_command('wait .1;gs c toyellowHP')
    end
end
	
function equip_engaged()
	equip(sets.melee)
end	
	
function equip_idle()
	equip(sets.idle)
	if use_terras then equip({main="Terra's Staff"}) end
end

function equip_rest()
	equip(sets.resting)
end

function equip_ws()
    equip(sets.ws)
end

-- Equip yellow HP set for a split second, then go back to idle set to trigger yellow
function equip_yellow()
    equip(sets.yellowHP)
    send_command('wait .1;gs equip idle')
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
		equip(sets.magic.healing)
		
		-- Matching day
		if obi_check(spell) then
			equip(sets.matching_dayweather) -- obi
		end
		
	-- Other spells
	else
		equip(sets.fastcast)
	end
end

function equip_enfeebling(spell)

	-- INT-based enfeebles
    if spell.name:contains('Poison')
	or spell.name:contains('Sleep')
	or spell.name:contains('Blind')
	or spell.name == 'Dispel' 
	or spell.name == 'Bind'
	or spell.name == 'Gravity' then
		equip(sets.magic.enfeebling.int)
		
	-- MND-based enfeebles
	else
		equip(sets.magic.enfeebling.mnd)
	end
	
	-- Dark grip for Sleep, Dispel and Blind
	if spell.name:contains('Sleep')
	or spell.name:contains('Blind')
	or spell.name == 'Dispel' then
		equip({sub="Dark Grip"})
	end
	
end

function equip_enhancing(spell) 

	-- Stoneskin
	if spell.name == 'Stoneskin' then
		equip(sets.magic.enhancing.stoneskin)
	
	-- Barspells/enspells/phalanx
	elseif spell.name:contains('Bar')
	or spell.name:startswith('En')
	or spell.name:contains('Phalanx') then
		equip(sets.magic.enhancing)
		
	-- Other spells
	else
		equip(sets.fastcast)
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
		equip(sets.magic.elemental.debuffs)
		
	-- Nukes
	else
	
		equip(sets.magic.elemental)
		-- check obi/tonban for matching day/weather
		if obi_check(spell) then
			if spell.element == world.day_element then
				-- do not equip relic pants if it's double weather and matching day, as that exceeds the +40% day/weather bonus cap even without them
				if not (world.weather_element == world.day_element and world.weather_intensity == 2) then
					equip(sets.matching_day)
				end
			elseif spell.element == world.weather_element then
				equip(sets.matching_dayweather)
        	end
		end
		-- check MP for ugg. pendant
		if player.mp < math.floor(nakedMP * 0.5) + math.floor(spell.mp_cost * 0.75) then
			equip({neck="Uggalepih Pendant"})
        end
		
		-- sorc. ring
		if player.hp < math.floor(nakedHP * 0.76) or buffactive['Weakness'] then
			equip({left_ring = "Sorcerer's Ring"})
        end	

		if gloves then
			equip({hands="Sorcerer's Gloves"})
		end
	end
end

function equip_dark(spell)

	-- Stun
	if spell.name == 'Stun' then
		equip(sets.magic.dark.stun)
		
	-- Other spells
	else
		equip(sets.magic.dark)
		
		-- Obi/legs/ring for Drain/Aspir
		if spell.name == 'Aspir' or spell.name == 'Drain' then	
			-- Matching day
			if obi_check(spell) then
				if spell.element == world.day_element then
                    -- do not equip relic pants if it's double weather and matching day, as that exceeds the +40% day/weather bonus cap even without them
                    equip(sets.matching_day) -- legs and obi		
				-- Matching weather
				elseif spell.element == world.weather_element then
					equip(sets.matching_dayweather) -- obi
				end
			end
		end
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
		if spell_recasts[spell.recast_id] > 60 then -- some margin to account for server lag
			add_to_chat(167,spell.english .. ' is still on cooldown!')
			cancel_spell()
		else

			-- Fast cast for all spells	
			equip(sets.fastcast)	
		
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
	elseif spell.type == 'WeaponSkill' then --Weaponskills
			equip_ws()
	end
end

-- During casting magic
function midcast(spell)
 
	if spell.skill == 'Healing Magic' then
        equip_heal(spell)
    elseif spell.skill == 'Enfeebling Magic' then
        equip_enfeebling(spell)
    elseif spell.skill == 'Enhancing Magic' then
        equip_enhancing(spell)
    elseif spell.skill == 'Elemental Magic' then
		equip_nuke(spell)
    elseif spell.skill == 'Dark Magic' then
        equip_dark(spell)
	end
end
 
-- After casting or using an ability
function aftercast(spell)
    choose_set()
end

 
function self_command(command)

	-- Change melee mode
	if command == "meleeMode" then
		meleeMode:cycle() -- go to next
		
		local temp = meleeMode.value
		if temp == 'melee' then
			enable('main','sub','range','ammo')
            equip(sets.weapons.staff)
            disable('main','sub','range','ammo')
			windower.add_to_chat(122,'Melee Mode on')
			
		elseif temp == 'nuke' then -- mage mode
			enable('main','sub','range','ammo')
			windower.add_to_chat(122,'Mage mode on')
		end
		choose_set()
		
	-- Induce yellow HP
	elseif command == "toyellowHP" then
		if buffactive['Weakness'] then
			add_to_chat(167,'You cannot use the yellow HP macro while weakened.')
		else
			equip_yellow()
		end
	
	-- Toggle Terra's/Claustrum in idle
	elseif command == "use_terras" then
		if use_terras then
			use_terras = false
			windower.add_to_chat(122,'Using Claustrum in idle.')
		else
			use_terras = true
			windower.add_to_chat(122,'Using Terra\'s Staff in idle')
		end	
		choose_set()
	elseif command == "gloves" then
		if gloves then
			gloves = false
			windower.add_to_chat(122,'Using Sorcerer\'s gloves to nuke.')
		else
			gloves = true
			windower.add_to_chat(122,'Not using Sorcerer\'s gloves to nuke.')
		end	
	end
		
end

---------------
-- Init code --
---------------

enable('main','sub','range','ammo','head','neck','left_ear','right_ear','body','hands','left_ring','right_ring','back','waist','legs','feet')
send_command('wait 1; input /cm u;wait 1;gs equip idle;wait 2;gs equip weapons.staff;wait 1;input /macro book 4;wait 1; input !myth; wait 1; input /lockstyleset 5; wait 1; input /echo Gearswap loaded.')