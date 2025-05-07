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

    sets.idle = {

        head="Optical Hat",
        body="Antares Harness",
        hands="War Gloves +1",
        legs="Raven Hose",
        feet="Trotter Boots",
        neck="Evasion Torque",
        waist="Scouter's Rope",
        left_ear="Novia Earring",
        right_ear="Triton Earring",
        left_ring="Shadow Ring",
        right_ring="Wivre Ring +1",
        back="Boxer's Mantle",
    }

    sets.melee = {}

    sets.melee.tp = {

        head="Walahra Turban",
        body="Rapparee Harness",
        hands="Dusk Gloves +1",
        legs="Homam Cosciales",
        feet="Enkidu's Leggings",
        neck="Love Torque",
        waist="Speed Belt",
        left_ear="Suppanomimi",
        right_ear="Brutal Earring",
        left_ring="Mars's Ring",
        right_ring="Rajas Ring",
        back="Cerb. Mantle +1",
    }

    sets.melee.acc = {

        head="Optical Hat",
        body="Homam Corazza",
        hands="Homam Manopolas",
        legs="Oily Trousers",
        feet="Homam Gambieras",
        neck="Ancient Torque",
        waist="Speed Belt",
        left_ear="Suppanomimi",
        right_ear="Brutal Earring",
        left_ring="Mars's Ring",
        right_ring="Toreador's Ring",
        back="Cuchulain's Mantle",
    }

	sets.melee.eva = set_combine(sets.idle,{

        feet="Setanta's Led.",
    })

    sets.ws = {}
    
    sets.ws.str = {

        head="Hecatomb Cap +1",
        body="Hct. Harness +1",
        hands="Hct. Mittens +1",
        legs="Hct. Subligar +1",
        feet="Hct. Leggings +1",
        neck="Fotia Gorget",
        waist="Warwolf Belt",
        left_ear="Harmonius Earring",
        right_ear="Brutal Earring",
        left_ring="Harmonius Ring",
        right_ring="Rajas Ring",
        back="Cerb. Mantle +1",
    }

    sets.ws.dex = {

        head="Hecatomb Cap +1",
        body="Antares Harness",
        hands="Hct. Mittens +1",
        legs="Hct. Subligar +1",
        feet="Hct. Leggings +1",
        neck="Fotia Gorget",
        waist="Cuchulain's Belt",
        left_ear="Pixie Earring",
        right_ear="Brutal Earring",
        left_ring="Thunder Ring",
        right_ring="Rajas Ring",
        back="Cuchulain's Mantle",
    }

    sets.ws.mab = {}

    sets.skills = {}

    sets.skills.sa = {

        head="Maat's Cap",
        body="Antares Harness",
        hands="Hct. Mittens +1",
        legs="Hct. Subligar +1",
        feet="Setanta's Led.",
        neck="Love Torque",
        waist="Cuchulain's Belt",
        left_ear="Pixie Earring",
        right_ear="Brutal Earring",
        left_ring="Thunder Ring",
        right_ring="Rajas Ring",
        back="Cuchulain's Mantle",
    }

    sets.skills.ta = {

        head="Maat's Cap",
        body="Antares Harness",
        hands="Rog. Armlets +1",
        legs="Oily Trousers",
        feet="Enkidu's Leggings",
        neck="Hope Torque",
        waist="Scouter's Rope",
        left_ear="Suppanomimi",
        right_ear="Brutal Earring",
        left_ring="Breeze Ring",
        right_ring="Breeze Ring",
        back="Fowler's Mantle +1",
    }

    sets.skills.steal = {}

    sets.skills.flee = {

        feet="Rog. Poulaines +1",
    }

    sets.fastcast = {

        head="Acubens Helm",
        body="Rapparee Harness",
        hands="Dusk Gloves +1",
        legs="Homam Cosciales",
        feet="Homam Gambieras",
        waist="Speed Belt",
        right_ear="Loquac. Earring",
    }

    sets.resting = {}

    sets.th = {

        sub="Thief's Knife",
        hands="Asn. Armlets +1",
    }

    sets.rangewpn = {}

    sets.rangewpn.xbow = {

        range="Ziska's Crossbow",
    }

    sets.rangewpn.bow = {

        range="Failnaught",
    }

    sets.rangewpn.darts = {}

    sets.weapons = {}

    sets.weapons.dgdg = {

        main="Mandau",
        sub="Blau Dolch",
    }

    sets.weapons.dgkc = {

        main="Mandau",
        sub="Kraken Club",
    }

    sets.weapons.dgws = {

        main="Mandau",
        sub="Ridill",
    }

    sets.weapons.thsh = {

        main="Thief's Knife",
        sub="Airy Buckler",
        hands="Asn. Armlets +1",
    }

    sets.weapons.dgth = {

        main="Mandau",
        sub="Thief's Knife",
        hands="Asn. Armlets +1",
    }

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
		equip(sets.steps)
	elseif spell.type:contains('Waltz') then
		equip(sets.waltz)
	elseif spell.name == 'Spectral Jig' then
		send_command('cancel sneak')
		
	-- Steal/Flee
	elseif spell.name == 'Steal' then equip(sets.steal)
	elseif spell.name == 'Flee' then equip(sets.flee)
		
	-- Ranged attack
	elseif spell.action_type == 'Ranged Attack' then
		equip(sets.racc) 
		
	-- SA/TA
	elseif spell.name == 'Sneak Attack' then
		equip(sets.sa)
		sa_gear = true
	elseif spell.name == 'Trick Attack' then
		if buffactive['Sneak Attack'] then
			equip(sets.sata)
		else
			equip(sets.ta)
		end
		ta_gear = true
		
	-- Weaponskills
	elseif spell.type == 'WeaponSkill' then
	
		-- set wsMode to either easy, medium or hard based on meleeMode
		local wsMode = meleeMode.current
		if not (wsMode == 'easy' or wsMode == 'medium') then wsMode = 'hard' end
	
		if spell.name == 'Dancing Edge' then
			equip((sets.ws[wsMode]).de)
		elseif spell.name == 'Shark Bite' then
			equip((sets.ws[wsMode]).sb)
		elseif spell.name == 'Evisceration' then
			equip((sets.ws[wsMode]).ev)
		elseif spell.name == 'Mercy Stroke' then
			equip((sets.ws[wsMode]).ms)
		elseif spell.name == 'Cyclone' then
			equip(sets.ws_cyclone)
		elseif spell.name == 'Mandalic Stab' then
			equip(sets.ws.easy.ms)
		else -- catchall, just STR all the way
			equip(sets.ws.easy.ms)	
		end
		
	-- Utsusemi
	elseif spell.name:contains('Utsusemi') then
		equip(sets.melee.eva,sets.precastfastcast)
	end	
end