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

    sets.idle = {}

    sets.melee = {} 

    sets.melee.tp = {}

    sets.melee.acc = {}

    sets.melee.eva = {}

    sets.ranged = {}

    sets.ranged.tp = {}

    sets.ws = {}

    sets.ws.str = {}

    sets.ws.agi = {}

    sets.ws.racc = {}

    sets.skills = {}

    sets.skills.sharp = {
		legs="Hunter's Braccae"
	}

    setes.skills.barrage = {
		hands="Htr. Bracers +1"
	}

    sets.skills.scavage = {
		feet="Hunter's Socks"
	}

    sets.skills.camo = {}

    sets.fastcast = {
		head		="Walahra Turban",
		hands		="Dusk Gloves +1",
		legs		="Byakko's Haidate",
		feet		="Dusk Ledelsens +1",
		waist		="Ninurta's Sash",
		left_ear	="Loquac. Earring",
	}

    sets.weapons = {}

    sets.weapons.gun = {
		ranged		= "Annihilator",
		ammo		= "Silver Bullet",
	}

    sets.weapons.bow = {}

    sets.weapons.axes = {
		main		= "Kriegsbeil",
		sub			= "Fransisca",
	}

    sets.weapons.staff = {
		main		= "Vulcan's Staff",
		sub			= "Brave Grip",
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
		equip(sets.ranged[rangedMode.current])
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
			equip({hands="Htr. Bracers +1"})
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

---------------
-- Init code --
--------------- 
 
enable('main','sub','range','ammo','head','neck','left_ear','right_ear','body','hands','left_ring','right_ring','back','waist','legs','feet') 
send_command('wait 1; input /cm u; wait 1; gs equip idle; wait 1; gs equip weapons.staff; wait 1; gs equip weapons.gun; wait 1; input !myth; wait 1; input /lockstyleset 10; wait 1; input /echo Gearswap loaded.')