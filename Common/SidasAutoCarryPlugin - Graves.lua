require "iFoundation_v2"

class 'Plugin' -- {
	
	if myHero.charName ~= "Graves" then return end 
	local SkillQ = Caster(_Q, 950, SPELL_LINEAR, 2150, 0.218, 200, true)
	local SkillW = Caster(_W, 950, SPELL_CIRCLE)
	local SkillE = Caster(_E, 425, SPELL_LINEAR)
	local SkillR = Caster(_R, 1000, SPELL_LINEAR, 2250, 0.234, 150, true)
	local combo = ComboLibrary()

	local Menu = nil
	
	function Plugin:__init() 
		AutoCarry.Crosshair:SetSkillCrosshairRange(1000)
		combo:AddCasters({SkillQ, SkillW, SkillE, SkillR})
		combo:AddCast(_E, function(Target) SkillE:CastMouse(mousePos) end)
		combo:AddCustomCast(_R, function(Target) 
				return ComboLibrary.KillableCast(Target, "R") or Monitor.CountEnemies(Target, 600)
			end)
	end 

	function Plugin:OnTick() 
		Target = AutoCarry.Crosshair:GetTarget()
		if Target and AutoCarry.Keys.AutoCarry then
			combo:CastCombo(Target) 
		end
	end 

	function Plugin:OnLoad() 
	end 

	Menu = AutoCarry.Plugins:RegisterPlugin(Plugin(), "Graves") 
	Menu:addParam("desc1","-- Casting Options --", SCRIPT_PARAM_INFO, "")
	Menu:addParam("rAmount", "Amount to override R",SCRIPT_PARAM_SLICE, 3, 0, 5, 0)
-- }