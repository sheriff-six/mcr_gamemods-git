-- function eMeta:GetEntityOwner()
-- 	return self:GetNVar("EntityOwner")
-- end

-- function pMeta:JobName()
-- 	return self:GetNVar('JobName') and self:GetNVar('JobName') or team.GetName(self:Team())
-- end

-- local pMeta = FindMetaTable( "Player" )

-- pMeta.Name = pMeta.Nick -- duplicate functions built into gmod for backwords compatability I assume
-- pMeta.GetName = pMeta.Nick
-- pMeta.oldNick = pMeta.Name

-- function pMeta:Nick()
-- 	return self:oldNick()
-- end

-- function pMeta:Name()
-- 	return self:GetNVar('mo_name') ~= '' and self:GetNVar('mo_name') or self:Nick()
-- end

-- -- -- This replaces their name everywhere except by C calls (status command, for example)
-- function pMeta:Nick()
-- 	return self:GetNVar('mo_name') or self:oldNick()
-- end


-- function meta:SetName(str)
--    self.NickName = str
-- end

-- function meta:ResetName()
--    self.NickName = nil
-- end

-- function pMeta:Name()
-- 	return self:GetNVar('mo_name') or self:Nick()
-- end

local pmeta = FindMetaTable("Player")
pmeta.OldName = pmeta.OldName or pmeta.Name
function pmeta:Name()
    return self:GetNWString( "rpname" ) ~= '' and self:GetNWString( "rpname" ) or self:OldName()
end
pmeta.GetName = pmeta.Name
pmeta.Nick = pmeta.Name

function pMeta:IsArrested()
	return self:GetNWBool("Arrested")
end

function pMeta:NameWithSteamID()
	local name = self:Name() or self:SteamName()
	return name..'('..self:SteamID()..')'
end

if SERVER then
	util.AddNetworkString( "PlayerDisplayChat" )
	local PLAYER = FindMetaTable( "Player" )
	if PLAYER then
		function PLAYER:SendMessage( ... )
			local args = { ... }
			net.Start( "PlayerDisplayChat" )
				net.WriteTable( args )
			net.Send( self )
		end
	end
	function SendMessageAll( ... )
		local args = { ... }
		net.Start( "PlayerDisplayChat" )
			net.WriteTable( args )
		net.Broadcast()
	end
end

if CLIENT then
	net.Receive( "PlayerDisplayChat", function()
		local args = net.ReadTable()
		chat.AddText(unpack( args ) )
	end )
end