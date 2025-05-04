--[[

-- About --

    This lua file is for the Samurai job. It is designed to be used with the GearSwap addon for Windower 4.
    It includes sets for idle, melee, and WS gear, as well as functions for precasting, midcasting, and aftercasting spells.
    As well as variables for changing weapons and melee modes and WS modifiers.
	It also includes a function for buff changes, specifically for the Third Eye ability.

-- Comands --

    wpn - Change weapons. Example: wpnValk or wpnSky
    mel - Change melee mode. Example: melTP or melACC or melEVA
	wsk - Change WS mode. Example: wskSTR or wskDEX or wskBAL
	thirdeye - Enable/disable Third Eye. Example: thirdeye on or thirdeye off
	
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

	sets.idle = {

		ammo="Bibiki Seashell",
		head="Nocturnus Helm",
		body="Nocturnus Mail",
		hands="Seiryu's Kote",
		legs="Hachiryu Haidate",
		feet="Askar Gambieras",
		neck="Evasion Torque",
		waist="Scouter's Rope",
		left_ear="Triton Earring",
		right_ear="Novia Earring",
		left_ring="Shadow Ring",
		right_ring="Wivre Ring +1",
		back="Boxer's Mantle",
	}

    -- melee sets
    sets.melee = {}

    -- TP sets
    -- Priority: Haste > Att > Acc

	sets.melee.tp = {

		ammo="White Tathlum",
		head="Ace's Helm",
		body="Hachiryu Haramaki",
		hands="Dusk Gloves +1",
		legs="Byakko's Haidate",
		feet="Dusk Ledelsens +1",
		neck="Ancient Torque",
		waist="Speed Belt",
		left_ear="Ethereal Earring",
		right_ear="Brutal Earring",
		left_ring="Mars's Ring",
		right_ring="Rajas Ring",
		back="Cerb. Mantle +1",
	}

	-- Acc sets
	-- Priority: Acc > Haste > Att
	
	sets.melee.acc = {

		ammo="Black Tathlum",
		head="Ace's Helm",
		body="Hachiryu Haramaki",
		hands="Hachiryu Kote",
		legs="Byakko's Haidate",
		feet="Enkidu's Leggings",
		neck="Ancient Torque",
		waist="Cuchulain's Belt",
		left_ear="Pixie Earring",
		right_ear="Brutal Earring",
		left_ring="Mars's Ring",
		right_ring="Toreador's Ring",
		back="Cuchulain's Mantle",
	}

	-- EVA sets
    -- Priority: EVA and Damage reduction

	sets.melee.eva = sets.idle

    -- WS sets

    sets.ws = {}

    -- WS.STR sets
    -- Priority: STR > Att > Acc

	sets.ws.str = {

		ammo="Black Tathlum",
		head="Nocturnus Helm",
		body="Nocturnus Mail",
		hands="Alkyoneus's Brc.",
		legs="Hachiryu Haidate",
		feet="Creek M Clomps",
		neck="Fotia Gorget",
		waist="Warwolf Belt",
		left_ear="Harmonius Earring",
		right_ear="Brutal Earring",
		left_ring="Harmonius Ring",
		right_ring="Rajas Ring",
		back="Cerb. Mantle +1",
	}

	-- WS.DEX sets
	-- Priority: DEX > Att > Acc

	sets.ws.dex = {

		ammo="Black Tathlum",
		head="Nocturnus Helm",
		body="Nocturnus Mail",
		hands="Hachiryu Kote",
		legs="Byakko's Haidate",
		feet="Enkidu's Leggings",
		neck="Fotia Gorget",
		waist="Cuchulain's Belt",
		left_ear="Adroit Earring",
		right_ear="Brutal Earring",
		left_ring="Thunder Ring",
		right_ring="Rajas Ring",
		back="Cuchulain's Mantle",
	}

	-- WS.BAL sets
	-- Priority: DEX + STR > Att > Acc

	sets.ws.bal = {

		ammo="Black Tathlum",
		head="Nocturnus Helm",
		body="Nocturnus Mail",
		hands="Alkyoneus's Brc.",
		legs="Byakko's Haidate",
		feet="Creek M Clomps",
		neck="Fotia Gorget",
		waist="Cuchulain's Belt",
		left_ear="Pixie Earring",
		right_ear="Brutal Earring",
		left_ring="Harmonius Ring",
		right_ring="Rajas Ring",
		back="Cuchulain's Mantle",
	}

	-- fastcast sets
	-- Priority: Fastcast > Haste > Acc

	sets.fastcast = {

		head="Walahra Turban",
		hands="Dusk Gloves +1",
		legs="Byakko's Haidate",
		feet="Dusk Ledelsens +1",
		waist="Speed Belt",
		right_ear="Loquac. Earring",
	}

	-- Skill sets

	sets.skills = {}

	-- Meditate sets
	-- Equip Meditate gear

	sets.skills.meditate = {

		head="Myochin Kabuto",
		hands="Saotome Kote",
	}

	-- Weapons sets

	sets.weapons = {}

	-- Hagun sets

	sets.weapons.hagun = {
		main		= "Hagun",
	}

	-- Nanatsusaya sets

	sets.weapons.nanatsu = {
		main		= "Nanatsusaya",
	}

	-- Set for any weapon

	sets.weapons.any = {}

	---------------
	-- Variables --
	---------------

	-- This is used to if thirdeye is active or not

	thirdeye = false
	
    -- This is used to check what weapons are currently equipped
	currentWeapons = 'nanatsu'

    -- This is used to check what melee mode is currently set
	meleeMode = M{'tp','acc','eva'}

	-- This is used to check what WS mode is currently set
	
	wsMode = M{'str','dex','bal'}

end

---------------
-- Functions --
---------------

function status_change(new,old)
	if thirdeye then 
		windower.add_to_chat(122,'Fighting with Saotome Haidate') 
	else
		choose_set()
	end
end

function choose_set()
    if player.status == "Engaged" then
        equip_engaged()
    elseif player.status == "Resting" then
		equip(sets.rest)
	else
        equip_idle()
    end
end
 
function equip_engaged()
	equip(sets.melee[meleeMode.value])
end	

function equip_idle()
	equip(sets.idle)
end	

function buff_change(name,gain)

	if name == 'Third Eye' then
		if gain == false then
			thirdeye = false 
			enable('legs')
			windower.add_to_chat(122, 'Third Eye wore, removing Saotome Haidate gear, back to normal.')
			choose_set()
		else 
			choose_set()
		end
	end
end
-----------------------
-- Pre/mid/aftercast --
-----------------------

function precast(spell, spellMap, action)

	if spell.name == 'Third Eye' then
		equip({legs="Saotome Haidate",})
		disable('legs')
		thirdeye = true
	
	elseif spell.name == 'Meditate' then
		equip(sets.skills.meditate)

	elseif spell.name:contains('Utsusemi') then
		equip(sets.melee.eva,sets.fastcast)

	    -- Weaponskills   sets.ws.de
    elseif spell.type == 'WeaponSkill' then
		equip(sets.ws[wsMode.value])
	end
end

function aftercast(spell)
	choose_set()
end

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

	-- Change WS mode
	elseif string.sub(command, 1, 3) == "wsk" then
	
		local mel = string.sub(command, 4, -1)
		meleeMode:set(mel)
		choose_set()
		windower.add_to_chat(122,'WeaponSkilling in ' .. meleeMode.current)
	end
end


enable('main','sub','range','ammo','head','neck','left_ear','right_ear','body','hands','left_ring','right_ring','back','waist','legs','feet') 
send_command('wait 1; input /cm u;  wait 1; gs equip idle; wait 1; gs equip weapons.nanatsu; wait 1; input /lockstyleset 11; wait 1; input /echo Gearswap loaded.')