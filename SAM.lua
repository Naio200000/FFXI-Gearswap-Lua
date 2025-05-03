

----------
-- Sets --
----------

function get_sets()

	include('Modes.lua')

	sets.idle = {
		ammo="Bibiki Seashell",
		head="Optical Hat",
		body="Nocturnus Mail",
		hands="Seiryu's Kote",
		legs="Akinji Salvars",
		feet="Askar Gambieras",
		neck="Guarding Torque",
		waist="Scouter's Rope",
		left_ear="Triton Earring",
		right_ear="Novia Earring",
		left_ring="Shadow Ring",
		right_ring="Wivre Ring +1",
		back="Boxer's Mantle",
	}

	sets.melee = {}

	sets.melee.tp = {
		ammo="Black Tathlum",
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

	sets.melee.acc = {
		head="Ace's Helm",
		body="Hachiryu Haramaki",
		hands="Hachiryu Kote",
		legs="Byakko's Haidate",
		feet="Enkidu's Leggings",
		neck="Ancient Torque",
		waist="Speed Belt",
		left_ear="Pixie Earring",
		right_ear="Brutal Earring",
		left_ring="Mars's Ring",
		right_ring="Toreador's Ring",
		back="Cuchulain's Mantle",
	}

	sets.melee.eva = sets.idle

	sets.skills = {}

	sets.skills.meditate = {
		head="Myochin Kabuto",
		hands="Saotome Kote",
	}

	sets.ws = {}

	sets.ws.str = {
		ammo="Black Tathlum",
		head="Maat's Cap",
		body="Nocturnus Mail",
		hands="Alkyoneus's Brc.",
		legs="Hachiryu Haidate",
		feet="Creek M Clomps",
		neck="Fotia Gorget",
		waist="Warwolf Belt",
		left_ear="Adroit Earring",
		right_ear="Brutal Earring",
		left_ring="Harmonius Ring",
		right_ring="Rajas Ring",
		back="Cerb. Mantle +1",
	}

	sets.ws.dex = {
		ammo="Black Tathlum",
		head="Maat's Cap",
		body="Nocturnus Mail",
		hands="Hachiryu Kote",
		legs="Byakko's Haidate",
		feet="Enkidu's Leggings",
		neck="Fotia Gorget",
		waist="Cuchulain's Belt",
		left_ear="Pixie Earring",
		right_ear="Brutal Earring",
		left_ring="Thunder Ring",
		right_ring="Rajas Ring",
		back="Cuchulain's Mantle",
	}

	sets.ws.bal = {
		ammo="Black Tathlum",
		head="Maat's Cap",
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
		back="Cerb. Mantle +1",
	}

	sets.fastcast = {
		head="Walahra Turban",
		hands="Dusk Gloves +1",
		legs="Byakko's Haidate",
		feet="Dusk Ledelsens +1",
		waist="Speed Belt",
		right_ring="Rajas Ring",
	}

	sets.weapons = {}

	sets.weapons.hagun = {
		main		= "Hagun",
	}

	sets.weapons.nanatsu = {
		main		= "Nanatsusaya",
	}

	sets.weapons.any = {}

	thirdeye = false
	currentWeapons = 'nanatsu'
	meleeMode = M{'tp','acc','eva'}
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