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
        right_ring="Wivre Ring +1",
        back="Shadow Mantle",
    }

    sets.melee = {
        head="Walahra Turban",
        body="Antares Harness",
        hands="Dusk Gloves +1",
        legs="Byakko's Haidate",
        feet="Dusk Ledelsens +1",
        neck="Love Torque",
        waist="Speed Belt",
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

    sets.songs = {
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
    }

    sets.songs.debuff = set_combine(sets.songs,{
        head="Bard's Roundlet",
        body="Oracle's Robe",
        left_ear="Singing Earring",
        left_ring="Veela Ring",
    })

    sets.songs.buffs = {}

    sets.songs.fastcast = set_combine(sets.yellow, {

    })

    sets.magic = {}
    
    sets.magic.enhancing = {}   

    sets.magic.enhancing.stoneskin = {}

    sets.magic.healing = {}

    sets.yellow = {}

    sets.fastcast = {}

    sets.matchingDay = {}

    sets.resting = {}

    sets.weapons = {}

    sets.weapons.dgsh = {}

    sets.weapons.dgdg = {}

    ---------------
	-- Variables --
	---------------

	meleeMode = M{'melee','mage'}
    
    initializeNakedHPMP() 

end

function initializeNakedHPMP()

    if player.sub_job == 'WHM' then
        nakedHP = 0
        nakedMP = 0
    elseif player.sub_job == 'RDM' then
        nakedHP = 0
        nakedMP = 0
	else
        nakedHP = 0
        nakedMP = 0
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
	
	-- no potency/macc songs
	if spell.name:contains('Mazurka') or
	   spell.name:contains('Paeon') or
	   spell.name:contains('Ballad') or
	   spell.name:contains('Etude') then
		equip(sets.songs.fastcast)
		
	-- debuffs	
	elseif spell.name:contains('Requiem') or
           spell.name:contains('Elegy') or
           spell.name:contains('Threnody') or
           spell.name:contains('Finale') or
           spell.name:contains('Lullaby') then
		equip(sets.songs.debuff)
		
	-- other spells are all buffs with potency
	else
		equip(sets.songs.buff)
	end
	
end