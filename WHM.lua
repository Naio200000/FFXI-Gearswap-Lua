--[[

-- About --

    This lua file is for the Monk job. It is designed to be used with the GearSwap addon for Windower 4.
    It includes sets for idle, melee, and WS gear, as well as functions for precasting, midcasting, and aftercasting spells.
    As well as variables for changing weapons and melee modes and WS modifiers.
	It also includes a function for buff changes, specifically for the Third Eye ability.

-- Comands --

    mel - Change melee mode. Example: melnuke or melmelee
    toyellowHP - Equip yellow HP set for a split second, then go back to idle set to trigger yellow HP.
	
-- Version --

    v0 - Base sets and functions.
    v1 - Added functions to all magic types.
    v2 - Added check obi for matching day and weather.
    v3 - Added melee mode and weapons.
    v4 - Added atuo apply yellow HP set.
    v5 - Added distinction for yellow HP set on melee mode, and remember weapons.

-- Credits --

	Thanks to Wren and Enedin for their example lua files.
    https://enedin.be 
	https://supernovaffxi.fandom.com/wiki/Wren%27s_Gearswaps .

]]--

----------
-- Sets --
----------
--TODO: add divine funtions
--TODO: add comments to all sets

function get_sets()

    -- Load the necessary files
    -- Modes.lua this help on the use of cycling/trigger/etc variables
    include('Modes.lua')

    -- Idle sets
    -- Has EVA and Damage reduction and absorbtion

    sets.idle = {

        main="Terra's Staff",
        sub="Vivid Strap +1",
        ammo="Hedgehog Bomb",
        head="Optical Hat",
        body="Dalmatica +1",
        hands="Hydra Gloves",
        legs="Hydra Brais",
        feet="Herald's Gaiters",
        neck="Evasion Torque",
        waist="Scouter's Rope",
        left_ear="Triton Earring",
        right_ear="Novia Earring",
        left_ring="Shadow Ring",
        right_ring="Wivre Ring +1",
        back="Umbra Cape",
    }

    sets.melee = {

        ammo="Tiphia Sting",
        head="Walahra Turban",
        body="Hydra Doublet",
        hands="Blessed Mitts +1",
        legs="Bls. Trousers +1",
        feet="Blessed Pumps +1",
        neck="Ancient Torque",
        waist="Headlong Belt",
        left_ear="Ethereal Earring",
        right_ear="Brutal Earring",
        left_ring="Mars's Ring",
        right_ring="Rajas Ring",
        back="Umbra Cape",
    }

    sets.ws = {

        ammo="Tiphia Sting",
        head="Gnadbhod's Helm",
        body="Hydra Doublet",
        hands="Creek M Mitts",
        legs="Hydra Brais",
        feet="Creek M Clomps",
        neck="Ancient Torque",
        waist="Potent Belt",
        left_ear="Celestial Earring",
        right_ear="Brutal Earring",
        left_ring="Mars's Ring",
        right_ring="Toreador's Ring",
        back="Dew Silk Cape +1",
    }

    sets.magic = {}

    sets.magic.enfeebling = {

        main="Chatoyant Staff",
        sub="Bugard Strap +1",
        ammo="Nazar Bonjuk",
        head="Elite Beret +1",
        body="Healer's Bliaut",
        hands="Cleric's Mitts",
        legs="Valkyrie's Trews",
        feet="Goliard Clogs",
        neck="Enfeebling Torque",
        waist="Witch Sash",
        right_ear="Enfeebling Earring",
        right_ring="Omega Ring",
        back="Ixion Cape",
    }

    sets.magic.enfeebling.int = {

        left_ear="Omn. Earring +1",
        left_ring="Galdr Ring",
    }

    sets.magic.enfeebling.mnd = {

        left_ear="Celestial Earring",
        left_ring="Karka Ring",
    }

    sets.magic.dark = {

        main="Chatoyant Staff",
        sub="Bugard Strap +1",
        ammo="Nazar Bonjuk",
        body="Ixion Cloak",
        hands="Valkyrie's Cuffs",
        legs="Valkyrie's Trews",
        feet="Goliard Clogs",
        neck="Dark Torque",
        waist="Witch Sash",
        left_ear="Cass. Earring",
        right_ear="Helenus's Earring",
        left_ring="Galdr Ring",
        right_ring="Omega Ring",
        back="Merciful Cape",
    }

    sets.magic.healing = {

        main="Chatoyant Staff",
        sub="Bugard Strap +1",
        ammo="Nazar Bonjuk",
        head="Goliard Chapeau",
        body="Aristocrat's Coat",
        hands="Healer's Mitts",
        legs="Cleric's Pantaln.",
        feet="Blessed Pumps +1",
        neck="Fylgja Torque +1",
        waist="Witch Sash",
        left_ear="Celestial Earring",
        right_ear="Roundel Earring",
        left_ring="Karka Ring",
        right_ring="Celestial Ring",
        back="Dew Silk Cape +1",
    }

    sets.magic.enhancing = {

        main="Chatoyant Staff",
        sub="Bugard Strap +1",
        ammo="Nazar Bonjuk",
        head="Goliard Chapeau",
        body="Mahatma Hpl.",
        hands="Blessed Mitts +1",
        legs="Cleric's Pantaln.",
        feet="Cleric's Duckbills",
        neck="Enhancing Torque",
        waist="Witch Sash",
        left_ear="Celestial Earring",
        right_ear="Augment. Earring",
        left_ring="Karka Ring",
        right_ring="Celestial Ring",
        back="Merciful Cape",
    }

    sets.magic.enhancing.stoneskin = {

        main="Alkalurops",
        sub="Bugard Strap +1",
        ammo="Nazar Bonjuk",
        head="Goliard Chapeau",
        body="Mahatma Hpl.",
        hands="Blessed Mitts +1",
        legs="Bls. Trousers +1",
        feet="Cleric's Duckbills",
        neck="Enhancing Torque",
        waist="Witch Sash",
        left_ear="Celestial Earring",
        right_ear="Celestial Earring",
        left_ring="Karka Ring",
        right_ring="Celestial Ring",
        back="Dew Silk Cape +1",
    }

    sets.magic.divine = {

        main="Aquilo's Staff",
        sub="Bugard Strap +1",
        ammo="Nazar Bonjuk",
        head="Elite Beret +1",
        body="Mahatma Hpl.",
        hands="Bricta's Cuffs",
		legs		= "Valkyrie's Trews",
		feet		= "Shrewd Pumps",
        neck="Gnole Torque",
        waist="Witch Sash",
		left_ear	= "Moldavite Earring",
		right_ear	= "Novio Earring",
        left_ring="Karka Ring",
        right_ring="Omega Ring",
        back="Dew Silk Cape +1",
    }

    sets.fastcast = {

        sub="Vivid Strap +1",
        head="Walahra Turban",
        body="Goliard Saio",
        hands="Blessed Mitts +1",
        legs="Bls. Trousers +1",
        feet="Blessed Pumps +1",
        waist="Headlong Belt",
        right_ear="Loquac. Earring",
        back="Veela Cape",
    }

    sets.yellowHP = {

        main="Alkalurops",
        sub="Dark Grip",
        ammo="Tiphia Sting",
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
	}

    sets.resting = {

        main        = "Imperial Wand",
        sub         = "Legion Scutum",
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

    sets.weapons.clubs = {

        main="Brise-os +1",
        sub="Deae Gratia",
    }
    
    sets.weapons.clubshield = {

        main="Brise-os +1",
        sub="Avalon Shield",
    }

    sets.weapons.clubkc = {

        main="Brise-os +1",
        sub="Kraken Club",
    }   

    ---------------
	-- Variables --
	---------------

    currentWeapons = 'none' -- remember what your current weapons are

    meleeMode = M{'nuke', 'melee'}

    initializeNakedHPMP()
end

---------------
-- Functions --
---------------

function initializeNakedHPMP() -- magic numbers because the HP/MP % checks for latents aren't coded properly on LSB. It uses naked HP/MP, no gear, no food, no max HP/MP boost traits, but it does include HP and MP merits. Others will have to figure out these values for themselves for their own character.
    if player.sub_job == 'RDM' then
        nakedHP = 913
        nakedMP = 877
    elseif player.sub_job == 'BLM' then
        nakedHP = 876
        nakedMP = 915
    elseif player.sub_job == 'SCH' then
        nakedHP = 895
        nakedMP = 887
    else
        nakedHP = 913
        nakedMP = 818
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
        if meleeMode.current == 'nuke' and player.sub_job ~= 'SCH' then
            send_command('wait .1;gs c toyellowHP')
        end
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
			equip(sets.matching_day) -- obi
		end
        -- Medi ring
        if player.hp < math.floor(nakedHP * 0.76) or buffactive['Weakness'] then
			equip({ring2 = "Medicine Ring"})
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
	elseif spell.name:contains('Bar') or
	       spell.name:startswith('En') or
	       spell.name:contains('Phalanx') then
		equip(sets.magic.enhancing)
	
    -- Regen
    elseif spell.name:contains('Regen') then
        equip({body="Cleric's Bliaut"})
	-- Other spells
	else
		equip(sets.fastcast)
	end
end

function equip_dark(spell)
    -- Dark magic
    equip(sets.magic.dark)
    
    -- Obi for Drain/Aspir
    if spell.name == 'Aspir' or spell.name == 'Drain' then	
        -- Matching day
        if obi_check(spell) then
            if  spell.element == world.day_element or 
                spell.element == world.weather_element then
                equip(sets.matching_day) 
            end
        end
    end
end

function equip_divine(spell)
	-- Divine magic
	equip(sets.magic.divine)
	
	-- Matching day
	if obi_check(spell) then
		if  spell.element == world.day_element or 
			spell.element == world.weather_element then
			equip(sets.matching_day) 
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
	elseif spell.type == 'WeaponSkill' then		-- Weaponskills
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
	elseif spell.skill == 'Divine Magic' then
		equip_divine(spell)
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
			enable('main','sub')
            if currentWeapons == 'none' then
                equip(sets.weapons.clubshield)
            else
                equip(sets.weapons[currentWeapons])
            end
            disable('main','sub')
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

    -- Change weapons
    elseif string.sub(command, 1, 3) == "wpn" then

        local wpn = string.sub(command, 4, -1)
        enable('main','sub')
        equip(sets.weapons[wpn])
        disable('main','sub')
        currentWeapons = wpn -- remember what your current weapons are


	end
		
end

---------------
-- Init code --
---------------

enable('main','sub','range','ammo','head','neck','left_ear','right_ear','body','hands','left_ring','right_ring','back','waist','legs','feet')
send_command('wait 1; input /cm u;wait 1;gs equip idle; wait 1; input /lockstyleset 4; wait 1; input !myth; wait 1; input /echo Gearswap loaded.')