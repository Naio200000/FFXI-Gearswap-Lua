--[[

-- About --

    This lua file is for the Monk job. It is designed to be used with the GearSwap addon for Windower 4.
    It includes sets for idle, melee, and WS gear, as well as functions for precasting, midcasting, and aftercasting spells.
    As well as variables for changing weapons and melee modes and WS modifiers.
	It also includes a function for buff changes, specifically for the Third Eye ability.

-- Comands --

    wpn - Change weapons. Example: wpnValk or wpnSky
    mel - Change melee mode. Example: melTP or melACC or melEVA
    rng - Changes ranged mode. Example: rngatt or rngacc
	
-- Version --

    v0 - Base sets and functions.
	v1 - Add Gun and Bow tp sets.
	v2 - Add Barrage triggers
	v3 - Add Shadowbind sets and Functions.

-- Credits --

	Thanks to Wren and Enedin for their example lua files.
    https://enedin.be 
	https://supernovaffxi.fandom.com/wiki/Wren%27s_Gearswaps .

]]--

----------
-- Sets --
----------

function get_sets()

	-- Including this gives an easy way of defining cyclic/trigger/etc variables, makes handling self_commands easier.
	-- Motes also uses this, but this is completely independent from Motes
	include('Modes.lua')

	-- Idle sets

    sets.idle = {

		head="Optical Hat",
		body="Kirin's Osode",
		hands="Seiryu's Kote",
		legs="Blood Cuisses",
		feet="Setanta's Led.",
		neck="Evasion Torque",
		waist="Scouter's Rope",
		left_ear="Triton Earring",
		right_ear="Novia Earring",
		left_ring="Shadow Ring",
		right_ring="Wivre Ring +1",
		back="Boxer's Mantle",
	}

    sets.melee = {} 

    sets.melee.tp = {		
		
		head="Walahra Turban",
		body="Hachiryu Haramaki",
		hands="Dusk Gloves +1",
		legs="Byakko's Haidate",
    	feet="Enkidu's Leggings",
		neck="Temp. Torque",
		waist="Speed Belt",
		left_ear="Ethereal Earring",
		right_ear="Brutal Earring",
		left_ring="Mars's Ring",
		right_ring="Rajas Ring",
		back="Cerb. Mantle +1",}

    sets.melee.acc = {	

		head="Optical Hat",
		body="Hachiryu Haramaki",
		hands="Hachiryu Kote",
		legs="Byakko's Haidate",
		feet="Setanta's Led.",
		neck="Ancient Torque",
		waist="Cuchulain's Belt",
		left_ear="Pixie Earring",
		right_ear="Brutal Earring",
		left_ring="Mars's Ring",
		right_ring="Toreador's Ring",
		back="Cuchulain's Mantle",}

    sets.melee.eva = set_combine(sets.idle, {

			legs="Oily Trousers",
		})

    sets.ranged = {}

    sets.ranged.tp = {

		head="Zha'Go's Barbut",
		body="Kyudogi +1",
		legs="Scout's Braccae",
		feet="Sct. Socks +1",
		neck="Faith Torque",
		waist="Scout's Belt",
		left_ear="Altdorf's Earring",
		right_ear="Wilhelm's Earring",
		left_ring="Behemoth Ring +1",
		right_ring="Behemoth Ring +1",
	}

	sets.ranged.tp.gun = set_combine(sets.ranged.tp, {
		
    	hands="Seiryu's Kote",
	    back="Fowler's Mantle +1",
	})

	sets.ranged.tp.bow = set_combine(sets.ranged.tp, {

	    hands="Blood Fng. Gnt.",
		back="Amemet Mantle +1",	
	})

    sets.ws = {}

    sets.ws.str = {  

		head="Gnadbhod's Helm",
		body="Kirin's Osode",
		hands="Creek M Mitts",
		legs="Hachiryu Haidate",
		feet="Setanta's Led.",
		neck="Fotia Gorget",
		waist="Scout's Belt",
		left_ear="Harmonius Earring",
		right_ear="Harmonius Earring",
		left_ring="Harmonius Ring",
		right_ring="Rajas Ring",
		back="Amemet Mantle +1",	
	}

    sets.ws.agi = {
		    
		head="Maat's Cap",
		body="Kirin's Osode",
		hands="Seiryu's Kote",
		legs="Oily Trousers",
		feet="Enkidu's Leggings",
		neck="Fotia Gorget",
		waist="Scout's Belt",
		left_ear="Altdorf's Earring",
		right_ear="Wilhelm's Earring",
		left_ring="Breeze Ring",
		right_ring="Breeze Ring",
		back="Fowler's Mantle +1",
	}

    sets.ws.racc = {
	    head="Zha'Go's Barbut",
		body="Kyudogi +1",
		hands="Seiryu's Kote",
		legs="Oily Trousers",
		feet="Enkidu's Leggings",
		neck="Fotia Gorget",
		waist="Scout's Belt",
		left_ear="Altdorf's Earring",
		right_ear="Wilhelm's Earring",
		left_ring="Breeze Ring",
		right_ring="Behemoth Ring +1",
		back="Fowler's Mantle +1",
	}

    sets.skills = {}

    sets.skills.sharp = {

		legs="Hunter's Braccae"
	}

    sets.skills.barrage = {

		hands="Htr. Bracers +1"
	}

    sets.skills.scavage = {

		feet="Hunter's Socks"
	}

    sets.skills.camo = {

		body="Hunter's Jerkin"
	}

	sets.skills.shadowbind = set_combine(sets.ranged.tp, sets.skills.shadowbind)

    sets.fastcast = {

   		head		= "Acubens Helm",
		hands		= "Dusk Gloves +1",
		legs		= "Byakko's Haidate",
		feet		= "Dusk Ledelsens +1",
		waist		= "Ninurta's Sash",
		left_ear	= "Loquac. Earring",
	}

    sets.weapons = {}

    sets.weapons.gun = {

		ranged		= "Annihilator",
		ammo		= "Silver Bullet",
	}

    sets.weapons.bow = {

		range="Eurytos' Bow",
    	ammo="Kabura Arrow",
	}

    sets.weapons.axes = {

		main		= "Kriegsbeil",
		sub			= "Fransisca",
	}

    sets.weapons.vulcan = {

		main="Vulcan's Staff",
		sub="Claymore Grip",
	}

	sets.weapons.jupiter = {

		main="Jupiter's Staff",
    	sub="Brave Grip",
	}

    sets.weapons.rdkc = {

		main		= "Ridill",
		sub			= "Kraken Club",
	}


    ---------------
	-- Variables --
	---------------

    currentWeapons = 'staff'
    currentRange = 'gun'
	
	meleeMode = M{'tp','acc','eva'}
	gunMode = true

end

---------------
-- Functions --
---------------

-- After any status change, it calls this function and if sa_gear or ta_gear is on, it will not change the gear.

function status_change(new,old)
    choose_set()
end

-- Main function that decides whether to equip engaged/idle/resting gear
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

-- Before casting/using ability
function precast(spell, spellMap, action)

	-- DNC job abilities
	if spell.type:contains('Step') then
		equip(sets.melee.acc)
	elseif spell.name == 'Spectral Jig' then
		send_command('cancel sneak')
		
	-- Ranged Attack / Barrage
	elseif spell.action_type == 'Ranged Attack' then
		if gunMode then
			equip(sets.ranged.tp.gun)
		else
			equip(sets.ranged.tp.bow)
		end
		if buffactive['Barrage'] then equip(sets.skills.barrage) end

	-- Weaponskills
	elseif spell.type == 'WeaponSkill' then
		if player.target.distance > 15.90 then
			add_to_chat(122,'You are too far to WS.')
			cancel_spell()
		else
			if spell.name == 'Coronach' or spell.name == 'Heavy Shot' then
				equip(sets.ws.agi)
			elseif spell.name == 'Slug Shot' then
				equip(sets.ws.racc)
			else 
				equip(sets.ws.str)
			end
		end
		
	-- RNG job abilities	
	elseif spell.name == 'Scavenge' then equip(sets.skills.scavage)
	elseif spell.name == 'Sharpshot' then equip(sets.skills.sharp)
	elseif spell.name == 'Camouflage' then equip(sets.skills.camo)
	elseif spell.name == 'Shadowbind' then
		if player.target.distance > 17.50 then
			add_to_chat(122,'You are too far to Shadowbind.')
			cancel_spell()
		else
			equip(sets.skills.shadowbind)
		end
	
	-- Utsusemi
	elseif spell.name:contains('Utsusemi') then
		equip(sets.fastcast)
	end	
end
	
-- After casting or using an ability
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
        currentWeapons = wpn
		equip(sets.weapons[wpn])
        windower.add_to_chat(122,'Current Range ' .. wpn)
	
    -- Change ranged weapons
	elseif string.sub(command, 1, 3) == "rng" then
		local ran = string.sub(command, 4, -1)
		if ran == 'gun' then
			gunMode = true
		elseif ran == 'bow' then
			gunMode = false
		end
        currentRange = ran
		equip(sets.weapons[ran])
        windower.add_to_chat(122,'Current Range ' .. ran)

	-- Change melee mode
	elseif string.sub(command, 1, 3) == "mel" then	
		local mel = string.sub(command, 4, -1)
		meleeMode:set(mel)
		choose_set()
		windower.add_to_chat(122,'Meleeing in ' .. meleeMode.current)
	end
		
end

---------------
-- Init code --
--------------- 
 
enable('main','sub','range','ammo','head','neck','left_ear','right_ear','body','hands','left_ring','right_ring','back','waist','legs','feet') 
send_command('wait 1; input /cm u; wait 1; gs equip idle; wait 1; gs equip weapons.jupiter; wait 1; gs equip weapons.gun; wait 1; input !myth; wait 1; input /lockstyleset 10; wait 1; input /echo Gearswap loaded.')