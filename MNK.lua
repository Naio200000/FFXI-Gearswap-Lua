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
	v1 - Added movement speed and EVA sets.
	v2 - Added footwork sets and functions.

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

	sets.idle = {

		ammo			= "Bibiki Seashell",
		head			= "Optical Hat",
		body			= "Antares Harness",
		hands			= "Seiryu's Kote",
		legs			= "Raven Hose",
		feet			= "Herald's Gaiters",
		neck			= "Guarding Torque",
		waist			= "Scouter's Rope",
		left_ear		= "Triton Earring",
		right_ear		= "Novia Earring",
		left_ring		= "Shadow Ring",
		right_ring		= "Wivre Ring +1",
		back			= "Shadow Mantle",
	}

    -- melee sets
    sets.melee = {}

    -- TP sets
    -- Priority: Haste > Att > Acc

	sets.melee.tp = {

		ammo			= "White Tathlum",
		head			= "Walahra Turban",
		body			= "Hachiryu Haramaki",
		hands			= "Mel. Gloves +1",
		legs			= "Byakko's Haidate",
		feet			= "Setanta's Led.",
		neck			= "Faith Torque",
		waist			= "Black Belt",
		left_ear		= "Ethereal Earring",
		right_ear		= "Brutal Earring",
		left_ring		= "Mars's Ring",
		right_ring		= "Rajas Ring",
		back			= "Cerb. Mantle +1",
	}

	-- Acc sets
	-- Priority: Acc > Haste > Att
	
	sets.melee.acc = {

		ammo			= "Black Tathlum",
		head			= "Optical Hat",
		body			= "Hachiryu Haramaki",
		hands			= "Hachiryu Kote",
		legs			= "Byakko's Haidate",
		feet			= "Setanta's Led.",
		neck			= "Ancient Torque",
		waist			= "Black Belt",
		left_ear		= "Adroit Earring",
		right_ear		= "Brutal Earring",
		left_ring		= "Mars's Ring",
		right_ring		= "Toreador's Ring",
		back			= "Cuchulain's Mantle",
	}

	-- EVA sets
    -- Priority: EVA and Damage reduction

	sets.melee.eva = set_combine(sets.idle,{

		feet			= "Setanta's Led.",
		back			= "Boxer's Mantle",
		})

    -- WS sets

    sets.ws = {}

    -- WS.STR sets
    -- Priority: STR > Att > Acc

	sets.ws.str = {

		ammo			= "Black Tathlum",
		head			= "Gnadbhod's Helm",
		body			= "Kirin's Osode",
		hands			= "Alkyoneus's Brc.",
		legs			= "Hachiryu Haidate",
		feet			= "Setanta's Led.",
		neck			= "Fotia Gorget",
		waist			= "Black Belt",
		left_ear		= "Harmonius Earring",
		right_ear		= "Brutal Earring",
		left_ring		= "Mars's Ring",
		right_ring		= "Rajas Ring",
		back			= "Cerb. Mantle +1",
	}

	-- WS.DEX sets
	-- Priority: Acc > DEX > Att

	sets.ws.acc = {

		ammo			= "Black Tathlum",
		head			= "Optical Hat",
		body			= "Hachiryu Haramaki",
		hands			= "Hachiryu Kote",
		legs			= "Byakko's Haidate",
		feet			= "Setanta's Led.",
		neck			= "Fotia Gorget",
		waist			= "Black Belt",
		left_ear		= "Adroit Earring",
		right_ear		= "Brutal Earring",
		left_ring		= "Mars's Ring",
		right_ring		= "Toreador's Ring",
		back			= "Cuchulain's Mantle",
	}

	-- fastcast sets
	-- Priority: Fastcast > Haste > Acc

	sets.fastcast = {

		head			= "Acubens Helm",
		legs			= "Byakko's Haidate",
		feet			= "Setanta's Led.",
		waist			= "Black Belt",
		right_ear		= "Loquac. Earring",
	}

	-- Resting sets
	-- Priority: hHP+
	sets.rest = {

		back			= "Melee Cape",
	}

	-- Skill sets

	sets.skills = {}

	-- Chackra sets
	-- Equip Chackra gear and VIT+ gear

	sets.skills.chakra = {

		ammo			= "Bibiki Seashell",
		head			= "Genbu's Kabuto",
		body			= "Temple Cyclas",
		hands			= "Mel. Gloves +1",
		legs			= "Kensei Sitabaki",
		feet			= "Creek M Clomps",
		neck			= "Fortitude Torque",
		waist			= "Warwolf Belt",
		left_ear		= "Robust Earring +1",
		right_ear		= "Robust Earring +1",
		left_ring		= "Soil Ring",
		right_ring		= "Soil Ring",
		back			= "Melee Cape",
	}

	-- Focus sets
	--Equip Temple Crown

	sets.skills.focus = {head = "Temple Crown",}
	
	-- Dodge sets
	-- Equip Temple Gloves

	sets.skills.boost = {hands = "Temple Gloves",}

	-- Footwork sets
	-- Equip Wulong Shoes +1

	sets.skills.footwork = {feet = "Wulong Shoes +1",}

	sets.skills.chiblast = {
		--TODO
	}

	-- Weapons sets

	sets.weapons = {}

	-- Spharai sets

	sets.weapons.spharai = {main = "Spharai",}

	-- Shenlong sets

	sets.weapons.shenlong = {main = "Shlng. Baghnakhs",}

	-- Cross-Counters sets

	sets.weapons.cross = {main = "Cross-Counters",}


	---------------
	-- Variables --
	---------------

	-- This is used to if footwork is active or not

	footwork = false
	
    -- This is used to check what weapons are currently equipped
	currentWeapons = 'spharai'

    -- This is used to check what melee mode is currently set
	meleeMode = M{'tp','acc','eva'}

end

---------------
-- Functions --
---------------

-- This function is called when players changes status (engaged/resting/idle)
-- It will check if thirdeye is active or not and equip the correct gear
function status_change(new,old)
	if footwork then 
		windower.add_to_chat(122,'Fighting with Wulong Shoes +1') 
	end
	choose_set()
end

-- Main function to choose the correct set based on the current status
function choose_set()
    if player.status == "Engaged" then
        equip_engaged()
    elseif player.status == "Resting" then
		equip(sets.rest)
	else
        equip_idle()
    end
end
 -- This function is called when the player is engaged in combat
function equip_engaged()
	equip(sets.melee[meleeMode.value])
end	
 
-- This function is called when the player is idle
function equip_idle()
	equip(sets.idle)
end	

-- This function is used to enable legs when footwork is not active
function buff_change(name,gain)
	if name == 'Footwork' then
		if gain == false then
			footwork = false 
			enable('feet')
			windower.add_to_chat(122, 'Footwork wore, removing Wulong Shoes +1, back to normal.')
			choose_set()
		else 
			choose_set()
		end
	end
end

-----------------------
-- Pre/mid/aftercast --
-----------------------

-- Before casting/using ability
function precast(spell, spellMap, action)

	if spell.name == 'Footwork' then
		equip(sets.skills.footwork)
		disable('feet')
		footwork = true
	elseif spell.name == 'Chakra' then equip(sets.skills.chakra)
	elseif spell.name == 'Focus' then equip(sets.skills.focus)
	elseif spell.name == 'Boost' then equip(sets.skills.boost)
	elseif spell.name:contains('Utsusemi') then	equip(sets.melee.eva,sets.fastcast)
    elseif spell.type == 'WeaponSkill' then
		if spell.name == 'Asuran Fist' then 
			equip(sets.ws.acc)
		else
			equip(sets.ws.str)
		end
	end
end

-- After casting/using ability
function aftercast(spell)
	choose_set()
end

---------------------
-- Player commands --
--------------------- 

function self_command(command)

	-- Change weapons
	if string.sub(command, 1, 3) == "wpn" then
        local wpn = string.sub(command, 4, -1)
        equip(sets.weapons[wpn])
        currentWeapons = wpn -- remember what your current weapons are

	-- Change melee mode	
	elseif string.sub(command, 1, 3) == "mel" then
	
		local mel = string.sub(command, 4, -1)
		meleeMode:set(mel)
		choose_set()
		windower.add_to_chat(122,'Meleeing in ' .. meleeMode.current)

	end
end


enable('main','sub','range','ammo','head','neck','left_ear','right_ear','body','hands','left_ring','right_ring','back','waist','legs','feet') 
send_command('wait 1; input /cm u;  wait 1; gs equip idle; wit 1; gs equip weapons.spharai; wait 1; input /lockstyleset 6; wait 1; input /echo Gearswap loaded.')