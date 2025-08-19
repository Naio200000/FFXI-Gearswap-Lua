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
    v1 - Added ranged sets and functions.
    v2 - Added TH gear and functions.
    v3 - Added SA/TA gear and functions.
    v3.5 - Added check if SA or TA runs out and remove gear.
    v4 - Add Cancel SA/TA if still in cooldown.

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

        head        = "Optical Hat",
        body        = "Antares Harness",
        hands       = "War Gloves +1",
        legs        = "Raven Hose",
        feet        = "Trotter Boots",
        neck        = "Evasion Torque",
        waist       = "Scouter's Rope",
        left_ear    = "Novia Earring",
        right_ear   = "Triton Earring",
        left_ring   = "Shadow Ring",
        right_ring  = "Wivre Ring +1",
		back        = "Shadow Mantle",
    }

    sets.melee = {}

    sets.melee.tp = {

        head        = "Walahra Turban",
        body        = "Rapparee Harness",
        hands       = "Dusk Gloves +1",
        legs        = "Homam Cosciales",
        feet        = "Enkidu's Leggings",
        neck        = "Love Torque",
        waist       = "Speed Belt",
        left_ear    = "Suppanomimi",
        right_ear   = "Brutal Earring",
        left_ring   = "Mars's Ring",
        right_ring  = "Rajas Ring",
        back        = "Cerb. Mantle +1",
    }

    sets.melee.acc = {

        head        = "Optical Hat",
        body        = "Homam Corazza",
        hands       = "Homam Manopolas",
        legs        = "Oily Trousers",
        feet        = "Homam Gambieras",
        neck        = "Ancient Torque",
        waist       = "Speed Belt",
        left_ear    = "Suppanomimi",
        right_ear   = "Brutal Earring",
        left_ring   = "Mars's Ring",
        right_ring  = "Toreador's Ring",
        back        = "Cuchulain's Mantle",
    }

	sets.melee.eva = set_combine(sets.idle,{

        feet        = "Setanta's Led.",
    })

    sets.ws = {}
    
    sets.ws.str = {

        head        = "Hecatomb Cap +1",
        body        = "Hct. Harness +1",
        hands       = "Hct. Mittens +1",
        legs        = "Hct. Subligar +1",
        feet        = "Hct. Leggings +1",
        neck        = "Fotia Gorget",
        waist       = "Warwolf Belt",
        left_ear    = "Harmonius Earring",
        right_ear   = "Brutal Earring",
        left_ring   = "Strigoi Ring",
        right_ring  = "Rajas Ring",
        back        = "Cerb. Mantle +1",
    }

    sets.ws.dex = {

        head        = "Hecatomb Cap +1",
        body        = "Antares Harness",
        hands       = "Hct. Mittens +1",
        legs        = "Hct. Subligar +1",
        feet        = "Hct. Leggings +1",
        neck        = "Fotia Gorget",
        waist       = "Cuchulain's Belt",
        left_ear    = "Pixie Earring",
        right_ear   = "Brutal Earring",
        left_ring   = "Thunder Ring",
        right_ring  = "Rajas Ring",
        back        = "Cuchulain's Mantle",
    }

    sets.ws.mab = {

        head        = "Ree's Headgear",
        body        = "Antares Harness",
        hands       = "Hct. Mittens +1",
        legs        = "Denali Kecks",
        feet        = "Hct. Leggings +1",
        neck        = "Fotia Gorget",
        waist       = "Cuchulain's Belt",
   		left_ear	= "Moldavite Earring",
		right_ear	= "Novio Earring",
  		left_ring	= "Galdr Ring",
    	right_ring	= "Omega Ring",
        right_ring  = "Rajas Ring",
        back        = "Cuchulain's Mantle",
    }

    sets.skills = {}

    sets.skills.sa = {

        head        = "Maat's Cap",
        body        = "Antares Harness",
        hands       = "Hct. Mittens +1",
        legs        = "Hct. Subligar +1",
        feet        = "Setanta's Led.",
        neck        = "Love Torque",
        waist       = "Cuchulain's Belt",
        left_ear    = "Pixie Earring",
        right_ear   = "Brutal Earring",
        left_ring   = "Thunder Ring",
        right_ring  = "Rajas Ring",
        back        = "Cuchulain's Mantle",
    }

    sets.skills.ta = {

        head        = "Maat's Cap",
        body        = "Antares Harness",
        hands       = "Rog. Armlets +1",
        legs        = "Oily Trousers",
        feet        = "Enkidu's Leggings",
        neck        = "Hope Torque",
        waist       = "Scouter's Rope",
        left_ear    = "Suppanomimi",
        right_ear   = "Brutal Earring",
        left_ring   = "Breeze Ring",
        right_ring  = "Breeze Ring",
        back        = "Fowler's Mantle +1",
    }

    sets.skills.steal = {
        --TODO
    }

    sets.skills.flee = {

        feet        = "Rog. Poulaines +1",
    }

    sets.fastcast = {

        head        = "Acubens Helm",
        body        = "Rapparee Harness",
        hands       = "Dusk Gloves +1",
        legs        = "Homam Cosciales",
        feet        = "Homam Gambieras",
        waist       = "Speed Belt",
        right_ear   = "Loquac. Earring",
    }

    sets.resting = {
        --TODO
    }

    sets.th = {

        sub         = "Thief's Knife",
        hands       = "Asn. Armlets +1",
    }

    sets.range = {

        head        = "Optical Hat",
        body        = "Akinji Peti",
        hands       = "Akinji Bazubands",
        legs        = "Akinji Salvars",
        feet        = "Enkidu's Leggings",
        neck        = "Peacock Charm",
        waist       = "R.K. Belt +2",
        left_ear    = "Altdorf's Earring",
        right_ear   = "Wilhelm's Earring",
        left_ring   = "Behemoth Ring +1",
        right_ring  = "Behemoth Ring +1",
        back        = "Amemet Mantle +1",
    }

    sets.range.wpn = {}

    sets.range.wpn.xbow = {

        range       = "Ziska's Crossbow",
    }

    sets.range.wpn.bow = {

        range       = "Lamian Kaman +1",
    }

    sets.range.wpn.darts = {
        --TODO
    }

    sets.weapons = {}

    sets.weapons.dgdg = {

        main        = "Mandau",
        sub         = "Blau Dolch",
    }

    sets.weapons.dgkc = {

        main        = "Mandau",
        sub         = "Kraken Club",
    }

    sets.weapons.dgsw = {

        main        = "Mandau",
        sub         = "Ridill",
    }

    sets.weapons.thsh = {

        main        = "Thief's Knife",
        sub         = "Airy Buckler",
        hands       = "Asn. Armlets +1",
    }

    sets.weapons.dgth = {

        main        = "Mandau",
        sub         = "Thief's Knife",
        hands       = "Asn. Armlets +1",
    }
  	
    ---------------
	-- Variables --
	---------------
    
	sa_gear = false 
	ta_gear = false 	

	currentWeapons = 'dgkc'	
    currentRange = 'xbow'										

	meleeMode = M{'tp','acc','eva'}
	rangedMode = M{'xbow','bow','darts'}
    thMode = M{'no','thsh','no','dgth'}

end

---------------
-- Functions --
---------------

-- After any status change, it calls this function and if sa_gear or ta_gear is on, it will not change the gear.
function status_change(new,old)

	if sa_gear or ta_gear then
		if sa_gear then windower.add_to_chat(122,'Sneak Attack gear on.') end
		if ta_gear then windower.add_to_chat(122,'Trick Attack gear on.') end
	else
		choose_set()
	end
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

function buff_change(name,gain)

	-- if SA or TA wore (or were used), remove their gearlock and return to normal
	if name == 'Sneak Attack' or name == 'Trick Attack' then
		if gain == false then
			if name == 'Sneak Attack' then sa_gear = false end
			if name == 'Trick Attack' then ta_gear = false end
			windower.add_to_chat(122, 'SA/TA wore, removing SA/TA gear, back to normal.')
			
			-- emulate an aftercast
			choose_set()
		end
	end
end

-----------------------
-- Pre/mid/aftercast --
-----------------------

-- Before casting/using ability

function precast(spell, spellMap, action)

	-- If you're not doing SA, TA, Hide or AC, remove SA/TA gearlock
	if spell.name ~= 'Sneak Attack' and spell.name ~= 'Trick Attack' and spell.name ~= 'Hide' and spell.name ~= "Assassin's Charge" then
		if (sa_gear or ta_gear) and not spell.type == 'WeaponSkill' then windower.add_to_chat(122,'Removing SA/TA gear, back to normal.') end
		if sa_gear then sa_gear = false end
		if ta_gear then ta_gear = false end
	end

	-- DNC stuff
	if spell.type:contains('Step') then
		equip(sets.melee.acc)
	elseif spell.name == 'Spectral Jig' then
		send_command('cancel sneak')
		
	-- Steal/Flee
	elseif spell.name == 'Steal' then equip(sets.skills.steal)
	elseif spell.name == 'Flee' then equip(sets.skills.flee)
		
	-- Ranged attack
	elseif spell.action_type == 'Ranged Attack' then
		equip(sets.range) 
		
	-- SA/TA with check for recast time
	elseif spell.name == 'Sneak Attack' or spell.name == 'Trick Attack' then

        local spell_recasts = windower.ffxi.get_spell_recasts()
        if spell_recasts[spell.recast_id] > 60 then
            add_to_chat(167,'SA/TA is on cooldown, unable to use.')
            cancel_spell()
        else
            if spell.name == 'Sneak Attack' then
                equip(sets.skills.sa)
		        sa_gear = true
	        else
		        equip(sets.skills.ta)
		        ta_gear = true
            end
        end
	-- Weaponskills
	elseif spell.type == 'WeaponSkill' then
	
		if spell.name == 'Cyclone' then
			equip(sets.ws.mab)
		elseif spell.name == 'Shark Bite' or spell.name == 'Mercy Stroke' or spell.name == 'Mandalic Stab' then
			equip(sets.ws.str)
		else
            equip(sets.ws.dex)
		end
		
	-- Utsusemi
	elseif spell.name:contains('Utsusemi') then
		equip(sets.melee.eva,sets.fastcast)
	end	
end

-- After casting or using an ability
function aftercast(spell)

	if spell.action_type == 'Ranged Attack' then equip(sets.ranged) end

	-- SA/TA gearlock
	if sa_gear or ta_gear then
		if sa_gear and not spell.name == "Sneak Attack" then windower.add_to_chat(122,'Sneak Attack gear on.') end
		if ta_gear and not spell.name == "Trick Attack" then windower.add_to_chat(122,'Trick Attack gear on.') end
	else
		choose_set()
	end
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
		
	-- Cycle ranged mode	
	elseif string.sub(command, 1, 3) == 'rng' then

        local rng = string.sub(command, 4, -1)
        equip(sets.range.wpn[rng])
        currentRange = rng -- remember what your current range is
		windower.add_to_chat(122,'Ranged mode: ' .. currentRange)
		
	-- Treasure Hunter	
	elseif command == 'th' then
        thMode:cycle()
        if thMode.current == 'no' then
            windower.add_to_chat(122,'Treasure Hunter 4: OFF')
            enable('sub','hands')
            choose_set()
            equip(sets.weapons[currentWeapons])
        elseif thMode.current == 'thsh' then
            windower.add_to_chat(122,'Treasure Hunter 4: ON')
            equip(sets.weapons.thsh)
            disable('sub','hands')
        elseif thMode.current == 'dgth' then
            windower.add_to_chat(122,'Treasure Hunter 4: ON')
            equip(sets.weapons.dgth)
            disable('sub','hands')
        end
	end
end
 
---------------
-- Init code --
--------------- 

enable('main','sub','range','ammo','head','neck','left_ear','right_ear','body','hands','left_ring','right_ring','back','waist','legs','feet')  
send_command('wait 1; input /cm u; wait 1; gs equip idle; wait 1; gs equip weapons.dgth; wait 1; gs equip range.wpn.xbow; wait 1; input /lockstyleset 9; wait 1; input !myth; wait 1; input /echo Gearswap loaded.')