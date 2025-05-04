--[[

-- About --

    This lua file is for the Dragoon job. It is designed to be used with the GearSwap addon for Windower 4.
    It includes sets for idle, melee, and WS gear, as well as functions for precasting, midcasting, and aftercasting spells.
    As well as variables for changing weapons and melee modes and WS modifiers.
    It also includes a function for checking the weather and day of the week to determine whether to use an obi or not.

-- Comands --

    wpn - Change weapons. Example: wpnValk or wpnSky
    mel - Change melee mode. Example: melTP or melACC or melEVA
    ethereal - Toggle ethereal earring on/off in melee set.

-- Version --

    v0 - Base sets and functions.
    v1 - Add Gugnir and healing sets.
    v2 - Add Jump and High Jump sets with precast functions.
    v3 - Add STR and ACC sets for WS.
    v4 - Add BLU spells ignores.

-- Credits --

    This lua is based on Enedin's DRG lua https://enedin.be/gs/Enedin_DRG_v2.13.lua, which was based on the original by Wren https://supernovaffxi.fandom.com/wiki/Wren%27s_Gearswaps .

]]--

----------
-- Sets --
----------

function get_sets()

    -- Load the necessary files
    -- Modes.lua this help on the use of cycling/trigger/etc variables
    include('Modes.lua')

    -- Idle sets
    -- Has EVA and Damage reduction and absorbtion

    sets.idle = {

		ammo        = "Bibiki Seashell",
        head        = "Nocturnus Helm",
        body        = "Nocturnus Mail",
        hands       = "Blood Fng. Gnt.",
        legs        = "Blood Cuisses",
        feet        = "Askar Gambieras",
        neck        = "Evasion Torque",
        waist       = "Warwolf Belt",
        left_ear    = "Ethereal Earring",
        right_ear   = "Novia Earring",
        left_ring   = "Shadow Ring",
        right_ring  = "Wivre Ring +1",
        back        = "Boxer's Mantle",
    }

    -- melee sets
    sets.melee = {}

    -- TP sets
    -- Priority: Haste > Att > Acc

    sets.melee.tp = {

        ammo        = "Black Tathlum",
        head        = "Ace's Helm",
        body        = "Nocturnus Mail",
        hands       = "Dusk Gloves +1",
        legs        = "Homam Cosciales",
        feet        = "Homam Gambieras",
        neck        = "Love Torque",
        waist       = "Speed Belt",
        left_ear    = "Ethereal Earring",
        right_ear   = "Brutal Earring",
        left_ring   = "Mars's Ring",
        right_ring  = "Rajas Ring",
        back        = "Cerb. Mantle +1",
    }

    -- Acc sets
    -- Priority: Acc > Haste > Att

    sets.melee.acc = {

        ammo        = "Black Tathlum",
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

    -- EVA sets
    -- Priority: EVA and Damage reduction

	sets.melee.eva = sets.idle

    -- WS sets

    sets.ws = {}

    -- WS.TP sets
    -- Priority: STR > Att > Acc

    sets.ws.tp = {

        ammo        = "Black Tathlum",
        head        = "Nocturnus Helm",
        body        = "Nocturnus Mail",
        hands       = "Hct. Mittens +1",
        legs        = "Hct. Subligar +1",
        feet        = "Hct. Leggings +1",
        neck        = "Fotia Gorget",
        waist       = "Warwolf Belt",
        left_ear    = "Harmonius Earring",
        right_ear   = "Brutal Earring",
        left_ring   = "Harmonius Ring",
        right_ring  = "Rajas Ring",
        back        = "Cerb. Mantle +1",
    }

    -- WS.ACC sets
    -- Priority: STR > Acc > DEX

    sets.ws.acc = {

        ammo        = "Black Tathlum",
        head        = "Hecatomb Cap +1",
        body        = "Hct. Harness +1",
        hands       = "Hct. Mittens +1",
        legs        = "Oily Trousers",
        feet        = "Hct. Leggings +1",
        neck        = "Fotia Gorget",
        waist       = "Cuchulain's Belt",
        left_ear    = "Pixie Earring",
        right_ear   = "Brutal Earring",
        left_ring   = "Mars's Ring",
        right_ring  = "Toreador's Ring",
        back        = "Cuchulain's Mantle",
    }

    -- you can use sets.ws.tp or sets.ws.acc for the eva set. your choise
    sets.ws.eva = sets.ws.tp

    -- Jump sets
    -- Priority: Jump > Att > STR
    sets.jump = {

        ammo        = "Black Tathlum",
        head        = "Hecatomb Cap +1",
        body        = "Nocturnus Mail",
        hands       = "Hct. Mittens +1",
        legs        = "Conte Cosciales",
        feet        = "Drachen Greaves",
        neck        = "Ancient Torque",
        waist       = "Warwolf Belt",
        left_ear    = "Pixie Earring",
        right_ear   = "Brutal Earring",
        left_ring   = "Mars's Ring",
        right_ring  = "Rajas Ring",
        back        = "Cerb. Mantle +1",
    }

    sets.highjump = set_combine(sets.jump,{
        legs        = "Wym. Brais +1",
    })


    -- Enhancing sets
    -- Priority: Enhancing

    sets.enhancing = {
    
        neck        = "Enhancing Torque",
        left_ear    = "Augment. Earring",
        back        = "Merciful Cape",
    }

    -- Stoneskin set
    -- Priority: MND > Enhancing
    sets.enhancing.stoneskin = {

        head        = "Maat's Cap",
        body        = "Blood Scale Mail",
        hands       = "Homam Manopolas",
        legs        = "Homam Cosciales",
        feet        = "Homam Gambieras",
        neck        = "Gnole Torque",
        waist       = "Steppe Rope",
        left_ear    = "Celestial Earring",
        right_ear   = "Celestial Earring",
        left_ring   = "Karka Ring",
        right_ring  = "Celestial Ring",
        back        = "Merciful Cape",
    }

    -- Cure potency sets
    -- Priority: Cure potency > MND > Enhancing

        sets.healing = {

            head        = "Maat's Cap",
            body        = "Blood Scale Mail",
            hands       = "Homam Manopolas",
            legs        = "Homam Cosciales",
            feet        = "Homam Gambieras",
            neck        = "Gnole Torque",
            waist       = "Steppe Rope",
            left_ear    = "Roundel Earring",
            right_ear   = "Celestial Earring",
            left_ring   = "Karka Ring",
            right_ring  = "Celestial Ring",
            back        = "Merciful Cape",
    }
    -- HP sets
    -- Priority: HP+
    -- This is use to increas the treshold for breath to trigger
        sets.hp = {

            ammo        = "White Tathlum",
            head        = "Walahra Turban",
            body        = "Blood Scale Mail",
            hands       = "Creek M Mitts",
            legs        = "Blood Cuisses",
            feet        = "Creek M Clomps",
            neck        = "Tempered Chain",
            waist       = "Steppe Belt",
            left_ear    = "Harmonius Earring",
            right_ear   = "Harmonius Earring",
            left_ring   = "Bomb Queen Ring",
            right_ring  = "Bloodbead Ring",
            back        = "Gigant Mantle",
        }

    -- Breath sets
    -- Priority: Breath
    -- This is use to increas the treshold for breath to trigger

    sets.breath = set_combine(sets.hp,{
		head        = "Drachen Armet",
	})

    -- Breath potency sets
    -- Priority: Breath potency > Wyrm HP+
    -- The HP healer by healing breath is half of the wyrm HP, so we use wyrm HP+ gear

    sets.breathpotency = {
        head        = "Wym. Armet +1",
        body        = "Wyvern Mail",
        hands       = "Ostreger Mitts",
        legs        = "Drachen Brais",
        feet        = "Homam Gambieras",
        neck        = "Chanoix's Gorget",
        left_ear    = "Dragoon's Earring",
    }

    -- Call Wyvern set
	sets.callwyvern = {body	= "Wym. Mail +1"}

    -- Angon set

    sets.angon = {left_ear	= "Dragoon's Earring"}

    -- Fast cast sets
    -- Priority: Fast cast > Haste

    sets.fastcasthaste = {
        head        = "Walahra Turban",
        body        = "Wym. Mail +1",
        hands       = "Dusk Gloves +1",
        legs        = "Homam Cosciales",
        feet        = "Homam Gambieras",
        waist       = "Speed Belt",
        left_ear    = "Loquac. Earring",
        right_ear   = "Novia Earring",
        back        = "Warlock's Mantle",
    }

    -- Resting sets
    -- Priority: hMP+ > hHP+

    sets.rest = { -- hMP
        body		= "Wyvern Mail",
        neck		= "Gnole Torque",
        left_ring   = "Celestial Ring",
        right_ring  = "Celestial Ring",
    }

    -- Obi sets

    sets.matching_dayweather = {waist = "Hachirin-no-Obi"}

    --Weapons sets

    sets.weapons = {}

    -- Valkyrie's Fork set

    sets.weapons.Valk = {
        main        = "Valkyrie's Fork",
		sub			= "Pole Grip",
		ammo		= "Black Tathlum",
	}

    -- Gungnir set

    sets.weapons.Gung = {
        main        = "Gungnir",
        sub			= "Pole Grip",
        ammo		= "Black Tathlum",
    }

    -- Angon set

    sets.weapons.angon = {
		ammo 		= "Angon",
	}

	---------------
	-- Variables --
	---------------

    -- This is used to check if the ethereal earring is used in the melee set
	ethereal = true

    -- This is used to check what weapons are currently equipped
    currentWeapons = 'Gung'

    -- This is used to check what melee mode is currently set
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

---- This function decides which melee set to use based on the current melee mode and if the ethereal earring is used or not
function equip_engaged()
	equip(sets.melee[meleeMode.value])
    if ethereal and (player.sub_job == 'RDM' or player.sub_job == 'WHM' or player.sub_job == 'BLU') then equip({left_ear        = "Ethereal Earring"}) end
end	 

function equip_idle()
	equip(sets.idle)
end	

-- Decide whether to use obi or not
function obi_check(spell)
    local weak_to_element = {Dark       = "Light",Light  = "Dark",Ice      = "Fire",Wind    = "Ice",Earth      = "Wind",Lightning   = "Earth",Water    = "Lightning",Fire    = "Water",}
    local weakEle = weak_to_element[spell.element]
	
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
        elseif spell.type == 'WeaponSkill' then equip(sets.ws[meleeMode.value])
        elseif spell.name == 'Jump' then equip(sets.jump)
        elseif spell.name == 'High Jump' then equip(sets.highjump)
		elseif spell.name == 'Angon' then equip(sets.angon,sets.weapons.angon)		
		elseif spell.name == 'Call Wyvern' then equip(sets.callwyvern)
		elseif spell.name:contains('Utsusemi') then equip(sets.eva,sets.fastcasthaste)
		end	
	end
end

-- During casting/using ability
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

-- During pet's casting/using ability
function pet_midcast(spell)
    equip(sets.breathpotency)
end

-- After casting/using ability
function aftercast(spell)
    if  spell.name == 'Stone' or 
        spell.name == 'Cure' or 
        spell.name == 'Regen' or
        spell.name == 'Cocoon' or
        spell.name == 'Foot Kick' or
        spell.name == 'Head Butt' or
        spell.name == 'Power Attack' then 
        -- Ignores this spells for the pet's aftercast function.
    elseif spell.name == "Angon" then 
        -- Angon is a ranged attack, so we need to equip the angon set
        equip(sets.weapons[currentWeapons])
        choose_set()
    else choose_set() end
end

-- Afeter pet's casting/using ability
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
        currentWeapons = wpn 
        
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
			windower.add_to_chat(122,'Using Ethereal in melee set.')
		else
			ethereal = false
			windower.add_to_chat(122,'Not using Ethereal in melee set.')
		end
		choose_set()
    end
end

 
enable('main','sub','range','ammo','head','neck','left_ear','right_ear','body','hands','left_ring','right_ring','back','waist','legs','feet') 
send_command('wait 1; input /cm u; wait 2; gs equip weapons.Gung; wait 1; input /lockstyleset 7; wait 1; gs equip idle; wait 1; input !myth; wait 1; input /echo Gearswap loaded.')