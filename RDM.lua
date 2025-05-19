--[[

-- About --

    This lua file is for the Monk job. It is designed to be used with the GearSwap addon for Windower 4.
    It includes sets for idle, melee, and WS gear, as well as functions for precasting, midcasting, and aftercasting spells.
    As well as variables for changing weapons and melee modes and WS modifiers.
	It also includes a function for buff changes, specifically for the Third Eye ability.

-- Comands --

    - fightMode						Toggle mage/melee mode.
    - meleeMode						Cycle melee sets.
    - wpnxxx						Switch weapons. (xxx is the name of the weapon set, see sets.weapons.xxx)
	
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

--TODO: add comments to all sets

function get_sets()

    -- Load the necessary files
    -- Modes.lua this help on the use of cycling/trigger/etc variables
    include('Modes.lua')

    -- Idle sets
    -- Has EVA and Damage reduction and absorbtion

    sets.idle = {}

    sets.melee = {}

    sets.melee.tp = {}

    sets.melee.acc = {}

    sets.melee.eva = {}

    sets.ws = {}

    sets.ws.str = {}

    sets.ws.dex = {}

    sets.ws.mnd = {}

    sets.ws.racc = {}

    sets.magic = {}

    sets.magic.elemental = {}

    sets.magic.elemental.debuff = {}

    sets.magic.enhancing = {}

    sets.magic.enhancing.stoneskin = {}

    sets.magic.healing = {}

    sets.magic.dark = {}

    sets.magic.dark.stun = {}

    sets.fastcast = {}

    sets.resting = {}

    sets.matchingDay = {}

    sets.icestaff = {}

    sets.darkgrip = {}

    fightMode = M{'mage', 'melee'} 							-- fight modes
	meleeMode = M{'tp','acc','eva'} 					-- melee modes

    initializeNakedHPMP() -- initialize HP and MP values for use in Uggalepih Pendant calculation

end

function initializeNakedHPMP() -- magic numbers because the HP/MP % checks for latents aren't coded properly on LSB. It uses naked HP/MP, no gear, no food, no max HP/MP boost traits, but it does include HP and MP merits. Others will have to figure out these values for themselves for their own character.
    if player.sub_job == 'BLM' then
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

	local temp = fightMode.value
	if temp == 'melee' then
		-- equip a melee set when in melee mode
		equip(sets.melee[meleeMode.value])
	elseif temp == 'mage' then
		-- RDM has no staff skill: when in mage mode, disengage or go to melee mode
		equip_idle()
	end
end
 
function equip_idle()
	equip(sets.idle)
end
 
function equip_ws(name)

	if name == 'Knights of Round' or 'Death Blossom' then
		equip(sets.ws.mnd)
	elseif name == 'Evisceration' then
		equip(sets.ws.dex)
	elseif name == 'Sidewinder' then
		equip(sets.ws.racc)
	else
		equip(sets.ws.str)
	end

end 