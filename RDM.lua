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
	meleeMode = M{'haste','hacc','acc'} 					-- melee modes

    initializeNakedHPMP() -- initialize HP and MP values for use in Uggalepih Pendant calculation

end

