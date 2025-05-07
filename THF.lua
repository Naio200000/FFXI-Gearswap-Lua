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

    sets.melee.tp = {}

    sets.melee.acc = {}

    sets.melee.eva = {}

    sets.ws.str = {}

    sets.ws.dex = {}

    sets.ws.mab = {}

    sets.skills = {}

    sets.skills.sa = {}

    sets.skills.ta = {}

    sets.skills.steal = {}

    sets.skills.flee = {}

    sets.fastcast = {}

    sets.resting = {}

    sets.th = {}

    sets.range = {}

    sets.range.wpn = {}

    sets.range.wpn.xbow = {}

    sets.range.wpn.bow = {}

    sets.range.wpn.darts = {}

    sets.weapons = {}

    sets.weapons.dgdg = {}

    sets.weapons.dgkc = {}

    sets.weapons.dgws = {}

    	---------------
	-- Variables --
	---------------

	-- Don't change this:
	sa_gear = false 
	ta_gear = false 	
	th = false	

	currentWeapons = 'dgkc'											

	meleeMode = M{'tp','acc','eva'}
	rangedMode = M{'xbow','bow','darts'}

end

