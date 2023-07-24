util.AddNetworkString("MGD.SendCircleTimer")
local meta = FindMetaTable('Player')

function meta:SetActivity(name, time, check, callback, action_name, anim, act_sound, custom_sound, action_name_head)
	if self.MGD_IsActivityBusy then return false end

	local timer_name, time = 'MGD.Activity.' .. tostring(self:SteamID64()) .. '.' .. tostring(name), time or 1
	self.MGD_IsActivityBusy = true

	-- if action_name then
	-- 	if !action_name_head then
	-- 		self:SetAction(action_name, time)
	-- 	else
	-- 		self:SetAction(action_name_head, time)
	-- 	end
	-- end

	local mn = 3

	if time > 3 then
		mn = mn*(time/4)
	end

	net.Start("MGD.SendCircleTimer")
		net.WriteInt(time, 10)
		net.WriteString(action_name)
	net.Send(self)

	timer.Simple(0, function()
		if IsValid(self) then
			self:DoAnimationEvent(anim or ACT_GMOD_GESTURE_ITEM_DROP)
		end
	end )

	if !custom_sound then
		self:EmitSound(act_sound or 'weapon.ImpactSoft', 5, 90, 1)
	else
		self:EmitSound(act_sound or 'weapon.ImpactSoft')
	end
	
	timer.Create(timer_name, time / mn, mn, function()
		if check(self) then
			self:DoAnimationEvent(anim or ACT_GMOD_GESTURE_ITEM_DROP)

			if !custom_sound then
				self:EmitSound(act_sound or 'weapon.ImpactSoft', 5, 90, 1)
			else
				self:EmitSound(act_sound or 'weapon.ImpactSoft')
			end
		else
			timer.Remove(timer_name)
			timer.Remove(timer_name .. '.Callback')
			-- self:SetAction('', 0)
			self.MGD_IsActivityBusy = false

			net.Start("MGD.SendCircleTimer")
				net.WriteInt(0, 10)
				net.WriteString("Доставание оружия..")
			net.Send(self)
		end
	end )

	timer.Create(timer_name .. '.Callback', time, 1, function()
		if check(self) then
			callback(self)
		else
			-- self:SetAction('', 0)
			net.Start("MGD.SendCircleTimer")
				net.WriteInt(0, 10)
				net.WriteString("Доставание оружия..")
			net.Send(self)
		end
		
		self.MGD_IsActivityBusy = false
	end ) 
end

hook.Add("simfphysUse", "simfphysUseCD", function(veh, ply)
	ply:SetActivity('MGD.EnterSimfphys', 2, 
	function() --Check 
			if !IsValid(ply) then return false end
			if ply:GetPos():Distance(veh:GetPos()) > 200 then return false end
			if ply:GetEyeTrace().Entity != veh then return false end

			return true
		end,
		function() --Callback
			veh:SetPassenger( ply )
		end,
		'Садится в автомобиль', nil, 'Metal_Box.Strain'
	)
	return true
end )