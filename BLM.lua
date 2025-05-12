--[[

-- About --

    This lua file is for the Monk job. It is designed to be used with the GearSwap addon for Windower 4.
    It includes sets for idle, melee, and WS gear, as well as functions for precasting, midcasting, and aftercasting spells.
    As well as variables for changing weapons and melee modes and WS modifiers.
	It also includes a function for buff changes, specifically for the Third Eye ability.

-- Comands --

    wpn - Change weapons. Example: wpnValk or wpnSky
    mel - Change melee mode. Example: melTP or melACC or melEVA
    TH  - Toggles TH mode on and off. Example: TH on or TH off
    RNG - Changes betweem range options. Example: Xbow or Archery or Darts
	
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

    -- Load the necessary files
    -- Modes.lua this help on the use of cycling/trigger/etc variables
    include('Modes.lua')

    -- Idle sets
    -- Has EVA and Damage reduction and absorbtion

    sets.idle = {}

    sets.melee = {}

    sets.ws = {}

    sets.magic = {}

    sets.magic.elemental = {}

    sets.magic.elemental.debuff = {}

    sets.magic.enfeebling = {}

    sets.magic.enfeebling.int = {}

    sets.magic.enfeebling.mnd = {}

    sets.magic.dark = {}

    sets.magic.dark.stun = {}

    sets.magic.healing = {}

    sets.magic.enhancing = {}

    sets.magic.enhancing.stoneskin = {}

    sets.fastcast = {}

    sets.yellowHP = {}

    sets.matching_day = {
	
        waist		= "Hachirin-no-Obi",
		legs		= "Src. Tonban +1"
	}

	sets.matching_dayweather = {waist = "Hachirin-no-Obi"}

    seets.resting = {}

    ---------------
	-- Variables --
	---------------

	display_mp_cost = true
    
   	use_terras = false

    meleeMode = M{'nuke', 'melee'}

    initializeNakedHPMP()
end

---------------
-- Functions --
---------------

function initializeNakedHPMP() -- magic numbers because the HP/MP % checks for latents aren't coded properly on LSB. It uses naked HP/MP, no gear, no food, no max HP/MP boost traits, but it does include HP and MP merits. Others will have to figure out these values for themselves for their own character.
    if player.sub_job == 'RDM' then
        nakedHP = 0
        nakedMP = 0
    elseif player.sub_job == 'WHM' then
        nakedHP = 0
        nakedMP = 0
    elseif player.sub_job == 'SCH' then
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
        equip_engaged()
    elseif player.status == "Resting" then
		equip_rest()
	else
        equip_idle()
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