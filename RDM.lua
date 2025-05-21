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

    sets.idle = {

		main="Terra's Staff",
		sub="Vivid Strap +1",
		range="Aureole",
		head="Dls. Chapeau +1",
		body="Dalmatica +1",
		hands="Hydra Gloves",
		legs="Blood Cuisses",
		feet="Hydra Gaiters",
		neck="Evasion Torque",
		waist="Scouter's Rope",
		left_ear="Novia Earring",
		right_ear="Triton Earring",
		left_ring="Shadow Ring",
		right_ring="Wivre Ring +1",
		back="Shadow Mantle",
	}

    sets.melee = {}

    sets.melee.tp = {

		head="Walahra Turban",
		body="Antares Harness",
		hands="Dusk Gloves +1",
		legs="Hydra Brais",
		feet="Dusk Ledelsens +1",
		waist="Speed Belt",
		left_ear="Suppanomimi",
		right_ear="Brutal Earring",
		left_ring="Mars's Ring",
		right_ring="Rajas Ring",
		back="Cuchulain's Mantle",
	}

    sets.melee.acc = {

		head="Optical Hat",
		body="Antares Harness",
		hands="Hydra Gloves",
		legs="Hydra Brais",
		feet="Hydra Gaiters",
		neck="Ancient Torque",
		waist="Speed Belt",
		left_ear="Suppanomimi",
		right_ear="Brutal Earring",
		left_ring="Mars's Ring",
		right_ring="Toreador's Ring",
		back="Cuchulain's Mantle",
	}

    sets.melee.eva = set_combine(sets.idle, {

		legs="Hydra Brais",
	})

    sets.melee.ranged = {

		head="Optical Hat",
		body="Akinji Peti",
		hands="Blood Fng. Gnt.",
		legs="Oily Trousers",
		feet="Akinji Nails",
		neck="Hope Torque",
		waist="Warwolf Belt",
		left_ear="Altdorf's Earring",
		right_ear="Wilhelm's Earring",
		left_ring="Behemoth Ring +1",
		right_ring="Behemoth Ring +1",
		back="Amemet Mantle +1",
	}

    sets.ws = {}

    sets.ws.str = {

		head="Gnadbhod's Helm",
		body="Antares Harness",
		hands="Alkyoneus's Brc.",
		legs="Oily Trousers",
		feet="Creek M Clomps",
		neck="Fotia Gorget",
		waist="Warwolf Belt",
		left_ear="Harmonius Earring",
		right_ear="Brutal Earring",
		left_ring="Strigoi Ring",
		right_ring="Rajas Ring",
		back="Cerb. Mantle +1",
	}

    sets.ws.dex = {

		head="Gnadbhod's Helm",
		body="Antares Harness",
		hands="Creek M Mitts",
		legs="Oily Trousers",
    	feet="Goliard Clogs",
		neck="Fotia Gorget",
		waist="Warwolf Belt",
		left_ear="Pixie Earring",
		right_ear="Brutal Earring",
		left_ring="Thunder Ring",
		right_ring="Rajas Ring",
		back="Cuchulain's Mantle",
	}

    sets.ws.mnd = {

		head="Maat's Cap",
		body="Antares Harness",
		hands="Bricta's Cuffs",
		legs="Oily Trousers",
		feet="Goliard Clogs",
		neck="Fotia Gorget",
		waist="Witch Sash",
		left_ear="Celestial Earring",
		right_ear="Brutal Earring",
		left_ring="Karka Ring",
		right_ring="Rajas Ring",
		back="Cerb. Mantle +1",
	}

	sets.ranged = {}

    sets.ranged.racc = {

		head="Optical Hat",
		body="Akinji Peti",
		hands="Blood Fng. Gnt.",
		legs="Oily Trousers",
		feet="Akinji Nails",
		neck="Hope Torque",
		waist="Warwolf Belt",
		left_ear="Altdorf's Earring",
		right_ear="Wilhelm's Earring",
		left_ring="Behemoth Ring +1",
		right_ring="Behemoth Ring +1",
		back="Amemet Mantle +1",
	}

    sets.ranged.ws = {

		head="Maat's Cap",
		body="Akinji Peti",
		hands="Blood Fng. Gnt.",
		legs="Oily Trousers",
		feet="Creek M Clomps",
		neck="Hope Torque",
		waist="Warwolf Belt",
		left_ear="Altdorf's Earring",
		right_ear="Wilhelm's Earring",
		left_ring="Behemoth Ring +1",
		right_ring="Strigoi Ring",
		back="Amemet Mantle +1",
	}

    sets.magic = {}

    sets.magic.elemental = {

		main="Chatoyant Staff",
		sub="Bugard Strap +1",
		range="Aureole",
		head="Warlock's Chapeau",
		body="Blood Scale Mail",
		hands="Zenith Mitts +1",
		legs="Valkyrie's Trews",
		feet="Dls. Boots +1",
		neck="Lmg. Medallion +1",
		waist="Witch Sash",
		left_ear="Moldavite Earring",
		right_ear="Novio Earring",
		left_ring="Galdr Ring",
		right_ring="Omega Ring",
		back="Merciful Cape",
	}

    sets.magic.elemental.debuff = {

		main="Chatoyant Staff",
		sub="Bugard Strap +1",
		range="Aureole",
		head="Warlock's Chapeau",
		body="Blood Scale Mail",
		hands="Valkyrie's Cuffs",
		legs="Mahatma Slops",
		feet="Goliard Clogs",
		neck="Lmg. Medallion +1",
		waist="Witch Sash",
		left_ear="Helenus's Earring",
		right_ear="Cass. Earring",
		left_ring="Galdr Ring",
		right_ring="Omega Ring",
		back="Merciful Cape",
	}

    sets.magic.enfeebling = {

		main="Chatoyant Staff",
		sub="Bugard Strap +1",
		range="Aureole",
		head="Dls. Chapeau +1",
		body="Warlock's Tabard",
		legs="Valkyrie's Trews",
		neck="Enfeebling Torque",
		waist="Witch Sash",
		left_ear="Helenus's Earring",
		right_ear="Cass. Earring",
		right_ring="Omega Ring",
		back="Prism Cape",
	}
	
	sets.magic.enfeebling.int = set_combine(sets.magic.enfeebling, {

		hands="Valkyrie's Cuffs",
		feet="Goliard Clogs",
		left_ring="Galdr Ring",
	})

    sets.magic.enfeebling.mnd = set_combine(sets.magic.enfeebling, {

		hands="Bricta's Cuffs",
		feet="Valkyrie's Clogs",
		left_ring="Karka Ring",
	})

    sets.magic.enhancing = {

		main="Chatoyant Staff",
		sub="Bugard Strap +1",
		range="Aureole",
		head="Maat's Cap",
		body="Blood Scale Mail",
		hands="Dls. Gloves +1",
		legs="Warlock's Tights",
		feet="Valkyrie's Clogs",
		neck="Enhancing Torque",
		waist="Witch Sash",
		left_ear="Augment. Earring",
		right_ear="Celestial Earring",
		left_ring="Karka Ring",
		right_ring="Omega Ring",
		back="Merciful Cape",
	}

    sets.magic.enhancing.stoneskin = {

		main="Alkalurops",
		sub="Bugard Strap +1",
		range="Aureole",
		head="Maat's Cap",
		body="Blood Scale Mail",
		hands="Dls. Gloves +1",
		legs="Warlock's Tights",
		feet="Valkyrie's Clogs",
		neck="Faith Torque",
		waist="Witch Sash",
		left_ear="Celestial Earring",
		right_ear="Celestial Earring",
		left_ring="Karka Ring",
		right_ring="Celestial Ring",
		back="Dew Silk Cape +1",
	}

    sets.magic.healing = {

		main="Chatoyant Staff",
		sub="Bugard Strap +1",
		range="Aureole",
		head="Maat's Cap",
		body="Dls. Tabard +1",
		hands="Bricta's Cuffs",
		legs="Warlock's Tights",
		feet="Valkyrie's Clogs",
		neck="Fylgja Torque +1",
		waist="Witch Sash",
		left_ear="Roundel Earring",
		right_ear="Healing Earring",
		left_ring="Karka Ring",
		right_ring="Celestial Ring",
		back="Dew Silk Cape +1",
	}

    sets.magic.dark = {

		main="Chatoyant Staff",
		sub="Bugard Strap +1",
		range="Aureole",
		head="Nashira Turban",
		body="Blood Scale Mail",
		hands="Valkyrie's Cuffs",
		legs="Valkyrie's Trews",
		feet="Goliard Clogs",
		neck="Dark Torque",
		waist="Witch Sash",
		left_ear="Dark Earring",
		right_ear="Omn. Earring +1",
		left_ring="Galdr Ring",
		right_ring="Omega Ring",
		back="Merciful Cape",
	}

    sets.magic.dark.stun = set_combine(sets.magic.dark, sets.fastcast)

    sets.fastcast = {    
		
		sub="Vivid Strap +1",
		head="Warlock's Chapeau",
		body="Dls. Tabard +1",
		hands="Dusk Gloves +1",
		feet="Dusk Ledelsens +1",
		waist="Speed Belt",
		right_ear="Loquac. Earring",}

    sets.resting = {

		main="Imperial Wand",
		sub="Legion Scutum",
		head="Dls. Chapeau +1",
		body="Mahatma Hpl.",
		hands="Hydra Gloves",
		legs="Hydra Brais",
		feet="Goliard Clogs",
		neck="Gnole Torque",
		waist="Duelist's Belt",
		left_ring="Celestial Ring",
		right_ring="Celestial Ring",
	}

    sets.matchingDay = {

		waist = "Hachirin-no-Obi"
	}

	sets.icestaff = {main = "Aquilo's Staff"}

	sets.darkgrip = {sub = 'Dark Grip'}

    sets.weapons = {}

    sets.weapons.swdg = {

		main="Excalibur",
		sub={ name="Mandau", augments={'Accuracy+15','Attack+15','"Triple Atk."+3',}},
	}

    sets.weapons.dgsw = {

		main={ name="Mandau", augments={'Accuracy+15','Attack+15','"Triple Atk."+3',}},
		sub="Excalibur",
	}
	
    sets.weapons.swkc = {
		
		main="Excalibur",
		sub="Kraken Club",
	}
	
    sets.weapons.dgkc = {
		
		main={ name="Mandau", augments={'Accuracy+15','Attack+15','"Triple Atk."+3',}},
		sub="Kraken Club",
	}
	
    sets.weapons.swsh = {
		
		main="Excalibur",
		sub="Avalon Shield",
	}
	
    sets.weapons.dgsh = {
		
		main={ name="Mandau", augments={'Accuracy+15','Attack+15','"Triple Atk."+3',}},
		sub="Avalon Shield",
	}

    sets.weapons.ranged = {

		range="Lamian Kaman +1",
		ammo="Kabura Arrow",
	}

	currentWeapons = 'swsh' -- default weapons

    fightMode = M{'mage', 'melee'} 							-- fight modes
	meleeMode = M{'tp','acc','eva'} 					-- melee modes

    initializeNakedHPMP() -- initialize HP and MP values for use in Uggalepih Pendant calculation

end

---------------
-- Functions --
---------------

function initializeNakedHPMP() -- magic numbers because the HP/MP % checks for latents aren't coded properly on LSB. It uses naked HP/MP, no gear, no food, no max HP/MP boost traits, but it does include HP and MP merits. Others will have to figure out these values for themselves for their own character.
    if player.sub_job == 'BLM' then
        nakedHP = 951
        nakedMP = 854
    elseif player.sub_job == 'WHM' then
        nakedHP = 970
        nakedMP = 835
    elseif player.sub_job == 'SCH' then
        nakedHP = 970
        nakedMP = 826
    else
        nakedHP = 988
        nakedMP = 757
    end
end

-- Sets up everytime the player changes status
function status_change(new,old)
    choose_set()
end

-- Main function that decides whether to equip engaged/idle/resting gear
function choose_set()
    if player.status == "Engaged" then
        equip_engaged()
    elseif player.status == "Resting" then
		equip_rest()
	else
        equip_idle()
    end
end

-- Equips engaged gear
function equip_engaged()

	local temp = fightMode.value
	if temp == 'melee' then
		-- equip a melee set when in melee mode
		equip(sets.melee[meleeMode.value])
		if currentWeapons == 'swsh' or currentWeapons == 'swdg' or currentWeapons == 'swkc' then
			equip(neck="Fortitude Torque",)
		else
			equip(neck="Love Torque",)
		end
	elseif temp == 'mage' then
		-- RDM has no staff skill: when in mage mode, disengage or go to melee mode
		equip_idle()
	end
end

-- Equips resting gear
function equip_rest()
	equip(sets.resting)
end
 
-- Equips idle gear
function equip_idle()
	equip(sets.idle)
end

-- Equips weaponskill gear
function equip_ws(name)

	if name == 'Knights of Round' or 'Death Blossom' then
		equip(sets.ws.mnd)
	elseif name == 'Evisceration' then
		equip(sets.ws.dex)
	elseif name == 'Sidewinder' then
		equip(sets.ws.racc)
	else
		equip(sets.ws.str)
	end
end 

-- Check wether or not Obi should be equipped
function obi_check(spell)
    local weak_to_element = {Dark="Light",Light="Dark",Ice="Fire",Wind="Ice",Earth="Wind",Lightning="Earth",Water="Lightning",Fire="Water",}
    local weakEle = weak_to_element[spell.element]
	
	-- Iridescence trait on Chatoyant/Claustrum makes single weather stronger than day of the week, so we don't want to equip obi if day gives bonus but weather gives penalty
    if world.weather_element == spell.element or (world.day_element == spell.element and world.weather_element ~= weakEle) then
        return true
    else
        return false
    end
end

--Equips Healing magic gear
function equip_heal(spell)

	-- Cures
	if spell.name:contains('Cure')
	or spell.name:contains('Cura') then
		equip(sets.magic.healing)
		
		-- Matching day
		if obi_check(spell) then
			if spell.element == world.day_element or spell.element == world.weather_element then
				equip(sets.matchingDay) -- obi
			end
		end
		
	-- Other spells
	else
		equip(sets.fastcast)
	end
end

-- Equips Enfeebling magic gear
function equip_enfeebling(spell)

	-- INT-based enfeebles
    if   spell.name:contains('Poison') or
	     spell.name:contains('Bio') or
	     spell.name:contains('Sleep') or
	     spell.name:contains('Blind') or
	     spell.name == 'Dispel' or
	     spell.name == 'Bind' or
	     spell.name == 'Gravity' then
		equip(sets.magic.enfeebling.int)
		
	-- MND-based enfeebles
	else
		equip(sets.magic.enfeebling.mnd)
	end
	
	-- Dark grip for Sleep, Dispel and Blind
	if spell.name:contains('Sleep') or
	     spell.name:contains('Blind') or
	     spell.name == 'Dispel' then
		equip(sets.darkgrip)
	end
end

--Equips Elemental magic gear
function equip_nuke(spell)

	-- Elemental debuffs
	if spell.name == 'Burn'
	or spell.name == 'Frost'
	or spell.name == 'Choke'
	or spell.name == 'Rasp'
	or spell.name == 'Shock'
	or spell.name == 'Drown' then
		equip(sets.magic.element.debuffs)
		
	-- Nukes
	else
        
        equip(sets.magic.elemental)
		-- check obi for matching day/weather
		if obi_check(spell) then
			if spell.element == world.day_element or spell.element == world.weather_element then
				equip(sets.matchingDay)
            end
		end
		
		-- check MP for ugg. pendant
		if player.mp < math.floor(nakedMP * 0.5) + math.floor(spell.mp_cost * 0.75) then
			equip({neck= "Uggalepih Pendant"})
         end	
	end
	
	-- Ice staff for ice spells
	if spell.element == 'Ice' then
		equip(sets.icestaff)
	end
end

-- Equips Enhancing magic gear
function equip_enhancing(spell) 

	-- Stoneskin
	if spell.name == 'Stoneskin' then
		equip(sets.magic.enhancing.stoneskin)
	
	-- Barspells/enspells/phalanx
	elseif spell.name:contains('Bar') or
	         spell.name:startswith('En') or
	         spell.name:contains('Phalanx') then
		equip(sets.magic.enhancing)
		
	-- Other spells
	else
		equip(sets.fastcast)
	end
end

-- Equips Dark magic gear
function equip_dark(spell)

	-- Stun
	if spell.name == 'Stun' then
		equip(sets.magic.dark.stun)
		
	-- Other spells
	else
		equip(sets.dark_magic)
		
		-- Obi/legs/ring for Drain/Aspir
		if spell.name == 'Aspir' or spell.name == 'Drain' then
		
			-- Matching day
			if spell.element == world.day_element or spell.element == world.weather_element then
				equip(sets.matching_dayweather) -- obi
				equip({right_ring="Diabolos's Ring"}) -- ring
			end
		end
	end
end

-- Equips Divine magic gear
function equip_divine(spell)
	equip(sets.fastcast)
end

---------------------------
-- Main Action Functions --
---------------------------

-- Precast function for when you are about to cast a spell
function precast(spell)
	
	-- Magic
	if spell.action_type == 'Magic' then
	
		-- Cancel magic when it is not up yet
		local spell_recasts = windower.ffxi.get_spell_recasts()
		if spell_recasts[spell.recast_id] > 60 then  -- some margin to account for server lag
			add_to_chat(167,spell.english .. ' is still on cooldown!')
			cancel_spell()
		else

			-- Fast cast for all spells	
            equip(sets.fastcast)
		
			-- Cancel status effects for spells that don't overwrite themselves
			if spell.name == "Sneak" then send_command("cancel sneak") end
			if spell.name == "Stoneskin" then send_command("wait 3;cancel stoneskin") end
			if spell.name == "Reraise" then send_command("cancel reraise") end
			if spell.name == "Blink" then send_command("wait 3;cancel blink") end
			if spell.name == "Aquaveil" then send_command("wait 3;cancel aquaveil") end
			if spell.name == "Ice Spikes" then send_command("cancel ice spikes") end
			if spell.name == "Shock Spikes" then send_command("cancel shock spikes") end
			if spell.name == "Phalanx" then send_command("cancel phalanx") end
		end
	
	-- Abilities	
	else
		-- Cancel sneak when using Spectral Jig
		if spell.name == "Spectral Jig" then
			send_command("cancel sneak")

		-- Weaponskills	
		elseif spell.type == 'WeaponSkill' then
			equip_ws(spell.name)
			
		-- Dancer steps
		elseif spell.type:contains('Step') then
			equip(sets.melee.acc)
			
		-- Ranged attack
		elseif spell.action_type == 'Ranged Attack' then
			equip(sets.ranged) 
		end
	end
end

-- Precast function for when you are casting a spell
function midcast(spell)
 
	if spell.skill == 'Healing Magic' then
        equip_heal(spell)
    elseif spell.skill == 'Enfeebling Magic' then
        equip_enfeebling(spell)
    elseif spell.skill == 'Enhancing Magic' then
        equip_enhancing(spell)
    elseif spell.skill == 'Elemental Magic' then
		equip_nuke(spell)
    elseif spell.skill == 'Dark Magic' then
        equip_dark(spell)
	elseif spell.skill == 'Divine Magic' then
		equip_divine(spell)
    elseif spell.name:contains('Utsusemi') then
		equip(sets.utsusemi)
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

	-- Toggle mage/melee
	if command == "fightMode" then
		fightMode:cycle() -- go to next
		
		local temp = fightMode.value
		if temp == 'melee' then 
			enable('main','sub','range','ammo')
			equip(sets.weapons[currentWeapons])	-- when going to melee, equip the last known weapons
			if player.sub_job == 'RNG' then
				equip(sets.weapons.ranged) -- equip acc set if DNC
			end
			disable('main','sub','range','ammo')
			windower.add_to_chat(122,'Meleeing in ' .. meleeMode.current)
			
		elseif temp == 'mage' then
			enable('main','sub','range','ammo')
			windower.add_to_chat(122,'Mage mode')
		end	
		choose_set()
	
	-- Change melee mode	
	elseif command == "meleeMode" then
		meleeMode:cycle() -- go to next
		choose_set()
		windower.add_to_chat(122,'Meleeing in ' .. meleeMode.current)
		
	-- Change weapons
	elseif string.sub(command, 1, 3) == "wpn" then
		local wpn = string.sub(command, 4, -1)	
		currentWeapons = wpn -- remember what your current weapons are
		
		-- equip weapons if you're in melee mode
		if fightMode.value == 'melee' then
			enable('main','sub','range','ammo')
			equip(sets.weapons[wpn])	
			disable('main','sub','range','ammo')
		end
	end
end

---------------
-- Init code --
---------------

enable('main','sub','range','ammo','head','neck','left_ear','right_ear','body','hands','left_ring','right_ring','back','waist','legs','feet')
send_command('wait 1; input /cm u;wait 1;gs equip idle;wait 1;input /lockstyleset 3; wait 1; input !myth; wait 1; input /echo Gearswap loaded.')