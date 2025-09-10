--[[

-- About --

    This lua file is for the Monk job. It is designed to be used with the GearSwap addon for Windower 4.
    It includes sets for idle, melee, and WS gear, as well as functions for precasting, midcasting, and aftercasting spells.
    As well as variables for changing weapons and melee modes and WS modifiers.
	It also includes a function for buff changes, specifically for the Third Eye ability.

-- Comands --

    wpn - Change weapons. Example: wpnValk or wpnSky
    mel - Change melee mode. Example: melTP or melACC or melEVA
	
-- Version --

    v0 - Base sets and functions.

-- Credits --

	Thanks to Wren and Enedin for their example lua files.
    https://enedin.be 
	https://supernovaffxi.fandom.com/wiki/Wren%27s_Gearswaps .

]]--

----------
-- Sets --
----------


function get_sets() 

    include('Modes.lua')

    sets.idle = {
        main="Terra's Staff",
        sub="Vivid Strap +1",
        range="Gjallarhorn",
        head="Optical Hat",
        body="Dalmatica +1",
        hands="Hydra Gloves",
        legs="Hydra Brais",
        feet="Hydra Gaiters",
        neck="Evasion Torque",
        waist="Scouter's Rope",
        left_ear="Triton Earring",
        right_ear="Novia Earring",
        left_ring="Shadow Ring",
        right_ring="Alert Ring",
        back="Shadow Mantle",
    }

    sets.melee = {
        head="Walahra Turban",
        body="Bard's Jstcorps",
        hands="Dusk Gloves +1",
        legs="Byakko's Haidate",
        feet="Dusk Ledelsens +1",
        neck="Love Torque",
        waist="Ninurta's Sash",
        left_ear="Suppanomimi",
        right_ear="Brutal Earring",
        left_ring="Mars's Ring",
        right_ring="Rajas Ring",
        back="Cuchulain's Mantle",
    }

    sets.ws = {
        head="Hecatomb Cap +1",
        body="Kirin's Osode",
        hands="Hct. Mittens +1",
        legs="Hct. Subligar +1",
        feet="Hct. Leggings +1",
        neck="Fotia Gorget",
        waist="Cuchulain's Belt",
        left_ear="Pixie Earring",
        right_ear="Brutal Earring",
        left_ring="Thunder Ring",
        right_ring="Rajas Ring",
        back="Cuchulain's Mantle",
    }

    sets.songs = {}

    sets.songs.debuff = {
        main="Chatoyant Staff",
        sub="Vivid Strap +1",
        range="Gjallarhorn",
        hands="Choral Cuffs",
        legs="Choral Cannions",
        feet="Oracle's Pigaches",
        neck="Piper's Torque",
        waist="Gleeman's Belt",
        right_ear="Musical Earring",
        right_ring="Nereid Ring",
        back="Bard's Cape",
        head="Bard's Roundlet",
        body="Oracle's Robe",
        left_ear="Singing Earring",
        left_ring="Veela Ring",
    }

    sets.songs.buff = {
        main="Chatoyant Staff",
        sub="Vivid Strap +1",
        range="Gjallarhorn",
        hands="Choral Cuffs",
        legs="Choral Cannions",
        feet="Oracle's Pigaches",
        neck="Piper's Torque",
        waist="Gleeman's Belt",
        right_ear="Musical Earring",
        right_ring="Nereid Ring",
        back="Bard's Cape",
        head="Demon Helm +1",
        body="Choral Jstcorps",
        left_ear="Wind Earring",
        left_ring="Nereid Ring",
    }

    sets.songs.fastcast = {
        main="Terra's Staff",
        sub="Dark Grip",
        range="Gjallarhorn",
        body="Dalmatica +1",
        body="Sheikh Manteel",
        hands="Zenith Mitts +1",
        neck="Morgana's Choker",
        waist="Scouter's Rope",
        left_ear="Astral Earring",
        right_ear="Loquac. Earring",
        left_ring="Minstrel's Ring",
        right_ring="Serket Ring",
        back="Ixion Cape",
    }

    sets.fastcast = {
        sub			= "Vivid Strap +1",
		right_ear   = "Loquac. Earring",
		back		= "Veela Cape",
    }

    sets.magic = {}
    
    sets.magic.enhancing = {
        main="Terra's Staff",
        sub="Vivid Strap +1",
        range="Gjallarhorn",
        head="Walahra Turban",
        body="Goliard Saio",
        hands="Dusk Gloves +1",
        legs="Byakko's Haidate",
        feet="Dusk Ledelsens +1",
        neck="Enhancing Torque",
        waist="Ninurta's Sash",
        left_ear="Augment. Earring",
        right_ear="Loquac. Earring",
        left_ring="Karka Ring",
        right_ring="Galdr Ring",
        back="Merciful Cape",
    }   

    sets.magic.enhancing.stoneskin = {
        main="Alkalurops",
        sub="Bugard Strap +1",
        range="Gjallarhorn",
        head="Maat's Cap",
        body="Mahatma Hpl.",
        hands="Bricta's Cuffs",
        legs="Mahatma Slops",
        feet="Suzaku's Sune-Ate",
        neck="Faith Torque",
        waist="Steppe Rope",
        left_ear="Celestial Earring",
        right_ear="Celestial Earring",
        left_ring="Celestial Ring",
        right_ring="Karka Ring",
        back="Dew Silk Cape +1",
    }

    sets.magic.healing = {
        main="Chatoyant Staff",
        sub="Bugard Strap +1",
        range="Gjallarhorn",
        head="Maat's Cap",
        body="Mahatma Hpl.",
        hands="Bricta's Cuffs",
        legs="Mahatma Slops",
        feet="Suzaku's Sune-Ate",
        neck="Fylgja Torque +1",
        waist="Steppe Rope",
        left_ear="Celestial Earring",
        right_ear="Celestial Earring",
        left_ring="Celestial Ring",
        right_ring="Karka Ring",
        back="Dew Silk Cape +1",
    }

    sets.matchingDay = {waist = "Hachirin-no-Obi",}

    sets.resting = {
        main="Terra's Staff",
        sub="Vivid Strap +1",
        range="Gjallarhorn",
        head="Goliard Chapeau",
        body="Mahatma Hpl.",
        hands="Hydra Gloves",
        legs="Oracle's Braconi",
        feet="Goliard Clogs",
        neck="Gnole Torque",
        left_ring="Celestial Ring",
        right_ring="Celestial Ring",
    }

    sets.weapons = {}

    sets.weapons.dgsh = { 
        main ="Mandau",
        sub="Genbu's Shield",
    }

    sets.weapons.dgdg = {
        main ="Mandau",
        sub="Blau Dolch",
    }

    ---------------
	-- Variables --
	---------------

	meleeMode = M{'melee','mage'}
    
    initializeNakedHPMP() 

end

function initializeNakedHPMP()

    if player.sub_job == 'WHM' then
        nakedHP = 970
        nakedMP = 274
    elseif player.sub_job == 'RDM' or player.sub_job == 'NIN' then
        nakedHP = 988
        nakedMP = 255
	else
        nakedHP = 988
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
			if  spell.element == world.day_element or  
                spell.element == world.weather_element then
				equip(sets.matchingDay) -- obi
			end
		end
		
	-- Other spells
	else
		equip(sets.fastcast)
	end
end

function equip_enfeebling(spell)
	equip(sets.fastcast)
end

function equip_enhancing(spell) 
	
	-- Stoneskin
	if spell.name == 'Stoneskin' then
		equip(sets.magic.enhancing.stoneskin)
		
	-- Barspells/enspells/phalanx
	elseif  spell.name:contains('Bar')  or 
            spell.name:startswith('En') or 
            spell.name:contains('Phalanx') then

		equip(sets.magic.enhancing)
		
	-- Other spells
	else
		equip(sets.fastcast)
	end
end

function equip_song(spell)
	
	if spell.name:contains('Requiem') or
           spell.name:contains('Elegy') or
           spell.name:contains('Threnody') or
           spell.name:contains('Finale') or
           spell.name:contains('Lullaby') then
		equip(sets.songs.debuff)
		add_to_chat(122,'Debuff song: ' .. spell.name)
        -- other spells are all buffs with potency
	else
		equip(sets.songs.buff)
		add_to_chat(122,'Buff song: ' .. spell.name)
	end
	
end

-----------------------
-- Pre/mid/aftercast --
-----------------------

-- Before casting/using ability
function precast(spell, spellMap, action)

	if spell.action_type == 'Magic' then
        if spell.type == "BardSong" then
            equip(sets.songs.fastcast)
        else
            equip(sets.fastcast)
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
		equip(sets.fastcast)
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


---------------
-- Init code --
--------------- 
 
enable('main','sub','range','ammo','head','neck','left_ear','right_ear','body','hands','left_ring','right_ring','back','waist','legs','feet') 
send_command('wait 1; input /cm u; wait 2; gs equip idle; wait 1; input /lockstyleset 12; wait 1; input /echo Gearswap loaded.')