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

    sets.idle = {}

    sets.melee = {}

    sets.melee.tp = {}

    sets.melee.acc = {}

    sets.melee.eva = {}

    sets.ws = {}

    sets.ws.str = {}

    sets.ws.dex = {}

    sets.ws.mnd = {}

    sets.ws.racc = {}

    sets.magic = {}

    sets.magic.elemental = {}

    sets.magic.elemental.debuff = {}

    sets.magic.enfeebles.int = {}

    sets.magic.enfeebles.mnd = {}

    sets.magic.enhancing = {}

    sets.magic.enhancing.stoneskin = {}

    sets.magic.healing = {}

    sets.magic.dark = {}

    sets.magic.dark.stun = {}

    sets.fastcast = {}

    sets.resting = {}

    sets.matchingDay = {}

    sets.icestaff = {}

    sets.darkgrip = {}

    fightMode = M{'mage', 'melee'} 							-- fight modes
	meleeMode = M{'tp','acc','eva'} 					-- melee modes

    initializeNakedHPMP() -- initialize HP and MP values for use in Uggalepih Pendant calculation

end

function initializeNakedHPMP() -- magic numbers because the HP/MP % checks for latents aren't coded properly on LSB. It uses naked HP/MP, no gear, no food, no max HP/MP boost traits, but it does include HP and MP merits. Others will have to figure out these values for themselves for their own character.
    if player.sub_job == 'BLM' then
        nakedHP = 0
        nakedMP = 0
    elseif player.sub_job == 'WHM' then
        nakedHP = 0
        nakedMP = 0
    elseif player.sub_job == 'SCH' then
        nakedHP = 0
        nakedMP = 0
    else
        nakedHP = 0
        nakedMP = 0
    end
end

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

function equip_engaged()

	local temp = fightMode.value
	if temp == 'melee' then
		-- equip a melee set when in melee mode
		equip(sets.melee[meleeMode.value])
	elseif temp == 'mage' then
		-- RDM has no staff skill: when in mage mode, disengage or go to melee mode
		equip_idle()
	end
end

function equip_rest()
	equip(sets.resting)
end
 
function equip_idle()
	equip(sets.idle)
end
 
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

-- Decide whether to use obi or not
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

function equip_enfeebling(spell)

	-- INT-based enfeebles
    if   spell.name:contains('Poison')    or
	     spell.name:contains('Dia') or
	     spell.name:contains('Sleep')   or
	     spell.name:contains('Blind')   or
	     spell.name == 'Dispel'     or
	     spell.name == 'Bind'   or
	     spell.name == 'Gravity' then
		equip(sets.magic.enfeebles.int)
		
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
			if spell.element == world.day_element then
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

function equip_divine(spell)
	equip(sets.fastcast)
end

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