

----------
-- Sets --
----------

function get_sets()

    include('Modes.lua')

    sets.idle = {

        head        = "Optical Hat",
        body        = "Hydra Mail +1",
        hands       = "Akinji Bazubands",
        legs        = "Blood Cuisses",
        feet        = "Askar Gambieras",
        neck        = "Evasion Torque",
        waist       = "Warwolf Belt",
        left_ear    = "Triton Earring",
        right_ear   = "Novia Earring",
		left_ring   = "Shadow Ring",
        right_ring  = "Wivre Ring +1",
        back        = "Boxer's Mantle",
    }

    sets.melee = {}

    sets.melee.tp = {

        head        = "Ace's Helm",
        body        = "Askar Korazin",
        hands       = "Dusk Gloves +1",
        legs        = "Homam Cosciales",
        feet        = "Homam Gambieras",
        neck        = "Love Torque",
        waist       = "Speed Belt",
        left_ear    = "Pixie Earring",
        right_ear   = "Brutal Earring",
		left_ring   = "Mars's Ring",
        right_ring  = "Rajas Ring",
        back        = "Cerb. Mantle +1",
    }

    sets.melee.acc = {

        head        = "Optical Hat",
        body        = "Homam Corazza",
        hands       = "Homam Manopolas",
        legs        = "Homam Cosciales",
        feet        = "Homam Gambieras",
        neck        = "Ancient Torque",
        waist       = "Speed Belt",
        left_ear    = "Pixie Earring",
        right_ear   = "Brutal Earring",
        left_ring   = "Mars's Ring",
        right_ring  = "Toreador's Ring",
        back        = "Cuchulain's Mantle",
    }

	sets.melee.eva = sets.idle

    sets.ws = {

        head        = "Hecatomb Cap +1",
        body        = "Hct. Harness +1",
        hands       = "Hct. Mittens +1",
        legs        = "Hct. Subligar +1",
        feet        = "Hct. Leggings +1",
        neck        = "Fotia Gorget",
        waist       = "Warwolf Belt",
        left_ear    = "Tmph. Earring +1",
        right_ear   = "Brutal Earring",
        left_ring   = "Harmonius Ring",
        right_ring  = "Rajas Ring",
        back        = "Cerb. Mantle +1",
    }

    sets.jump = {

        head        = "Hecatomb Cap +1",
        body        = "Hct. Harness +1",
        hands       = "Hct. Mittens +1",
        legs        = "Wym. Brais +1",
        feet        = "Drachen Greaves",
        neck        = "Ancient Torque",
        waist       = "Warwolf Belt",
        left_ear    = "Tmph. Earring +1",
        right_ear   = "Brutal Earring",
        left_ring   = "Toreador's Ring",
        right_ring  = "Rajas Ring",
        back        = "Cerb. Mantle +1",
    }

    sets.enhancing = {
    
        back		= "Merciful Cape",
        left_ear	= "Augment. Earring",
    }

    sets.enhancing.stoneskin = {

        head        = "Maat's Cap",
        body        = "Blood Scale Mail",
        hands       = "Homam Manopolas",
        legs        = "Homam Cosciales",
        feet        = "Homam Gambieras",
        neck        = "Faith Torque",
        waist       = "Steppe Rope",
        left_ear    = "Celestial Earring",
        right_ear   = "Loquac. Earring",
        left_ring   = "Karka Ring",
        right_ring  = "Celestial Ring",
        back        = "Merciful Cape",
    }

    sets.hp = {

        body        = "Blood Scale Mail",
        hands       = "Creek M Mitts",
        legs        = "Homam Cosciales",
        feet        = "Homam Gambieras",
        neck        = "Promise Badge",
        waist       = "Steppe Belt",
        left_ear    = "Harmonius Earring",
        right_ear   = "Harmonius Earring",
        left_ring   = "Bloodbead Ring",
        right_ring  = "Bomb Queen Ring",
        back        = "Behem. Mantle +1",
    }

    sets.breath = set_combine(sets.hp,{
		head        = "Drachen Armet",
	})


    sets.breathpotency = { -- Wym. Armet +1 and Wyvern HP+ here
        head		= "Wym. Armet +1",
        neck		= "Chanoix's Gorget",
        legs        = "Drachen Brais",
        feet		= "Homam Gambieras",
        body		= "Wyvern Mail",
        left_ear	= "Dragoon's Earring",
    }

	sets.callwyvern = {body	= "Wym. Mail +1"}

    sets.angon = {left_ear	= "Dragoon's Earring"}

    sets.fastcasthaste = {
        head        = "Walahra Turban",
        body        = "Wym. Mail +1",
        hands       = "Dusk Gloves +1",
        legs        = "Homam Cosciales",
        feet        = "Homam Gambieras",
        waist       = "Speed Belt",
        right_ear   = "Loquac. Earring",
        back        = "Warlock's Mantle",
    }

    sets.rest = { -- hMP
        body		= "Wyvern Mail",
        neck		= "Gnole Torque",
        left_ring   = "Celestial Ring",
        right_ring  = "Celestial Ring",
    }

    sets.matching_dayweather = {waist = "Hachirin-no-Obi"}

    sets.weapons = {}

    sets.weapons.Valk = {
        main        = "Valkyrie's Fork",
		sub			= "Pole Grip",
		ammo		= "Black Tathlum",
	}

    sets.weapons.Sky = {
        main        = "Skystrider",
        sub         = "Pole Grip",
        ammo        = "Black Tathlum",
        left_ear    = "Supremacy Earring",
	}

    sets.weapons.angon = {
		ammo 		= "Angon",
	}

	footwork = false
	currentWeapons = 'Valk'
	meleeMode = M{'tp','acc','eva'}

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
    if ethereal and (player.sub_job == 'RDM' or player.sub_job == 'WHM' or player.sub_job == 'BLU') then equip({left_ear="Ethereal Earring"}) end
end	 

function equip_idle()
	equip(sets.idle)
end	

-- Decide whether to use obi or not
function obi_check(spell)
    local weak_to_element = {Dark       = "Light",Light  = "Dark",Ice      = "Fire",Wind    = "Ice",Earth      = "Wind",Lightning   = "Earth",Water    = "Lightning",Fire    = "Water",}
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
			equip(sets.fastcasthaste)	
		end
	
	-- Abilities	
	else
		-- Cancel sneak when using Spectral Jig
		if spell.name == "Spectral Jig" then send_command("cancel sneak")
		elseif spell.type == 'WeaponSkill' then equip(sets.ws)
		elseif spell.name:contains('Jump') then equip(sets.jump)
		elseif spell.name == 'Angon' then equip(sets.angon,sets.weapons.angon)		
		elseif spell.name == 'Call Wyvern' then equip(sets.callwyvern)
		elseif spell.name:contains('Utsusemi') then equip(sets.eva,sets.fastcasthaste)
		end	
	end
end

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
        -- Stoneskin
    elseif spell.name == 'Stoneskin' then
        equip(sets.enhancing.stoneskin)
        -- Enspells/phalanx
    elseif spell.name:startswith('En') or spell.name:contains('Phalanx') then
        equip(sets.enhancing)
        -- Cures
    elseif spell.name:contains('Cure') or spell.name:contains('Cura') then
        equip(sets.healing)
        if obi_check(spell) then equip(sets.matching_dayweather) end
    end
end

function pet_midcast(spell)
    equip(sets.breathpotency)
end

function aftercast(spell)
    if spell.name == 'Stone' or spell.name == 'Cure' or spell.name == 'Regen' then 
    elseif spell.name == "Angon" then 
        equip(sets.weapons[currentWeapons])
        choose_set()
    else choose_set() end
end

function pet_aftercast(spell)
    if spell.name:contains('Breath') then
        choose_set()
    end
end

---------------------
-- Player commands --
--------------------- 

function self_command(command)

	-- Change weapons
	if string.sub(command, 1, 3) == "wpn" then
        local wpn = string.sub(command, 4, -1)
        if wpn == "Valk" then enable('left_ear') end
        equip(sets.weapons[wpn])
        if wpn == "Sky" then disable('left_ear') end
        currentWeapons = wpn -- remember what your current weapons are

	-- Change melee mode	
	elseif string.sub(command, 1, 3) == "mel" then
	
		local mel = string.sub(command, 4, -1)
		meleeMode:set(mel)
		choose_set()
		windower.add_to_chat(122,'Meleeing in ' .. meleeMode.current)
	
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
    end
end

 
enable('main','sub','range','ammo','head','neck','left_ear','right_ear','body','hands','left_ring','right_ring','back','waist','legs','feet') 
send_command('wait 1; input /cm u; wait 2; gs equip weapons.valk; wait 1; input /lockstyleset 7; wait 1; gs equip idle; wait 1; input !myth; wait 1; input /echo Gearswap loaded.')