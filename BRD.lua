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
