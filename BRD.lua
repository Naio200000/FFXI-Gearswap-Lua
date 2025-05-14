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

    sets.idle = {}

    sets.melee = {}

    sets.ws = {}

    sets.songs = {}

    sets.songs.debuff = {}

    sets.songs.buffs = {}

    sets.magic = {}
    
    sets.magic.enhancing = {}   

    sets.magic.enhancing.stoneskin = {}

    sets.magic.healing = {}

    sets.yellow = {}

    sets.fastcast = {}

    sets.fastcast.songs = {}

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

function initializeNakedHPMP() -- magic numbers because the HP/MP % checks for latents aren't coded properly on LSB. It uses naked HP/MP, no gear, no food, no max HP/MP boost traits, but it does include HP and MP merits. Others will have to figure out these values for themselves for their own character.
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