function pMeta:SavePlayerData(name,value)
	MySQLite.query( "UPDATE `mopple_player_data` SET " .. name .. " = '" .. value .. "' WHERE steam_id = '" .. self:SteamID() .. "'" )
end

function InitPlayerData( pPlayer )
	MySQLite.query( "SELECT * FROM `mopple_player_data` WHERE steam_id = '"..pPlayer:SteamID().."'",function(data)
		if (data and istable(data)) then
			local player_data = util.JSONToTable(data[1].data)
			local team
			for _, t in pairs(mopp.jobs) do
				if t.jobID == data[1].team then
					team = {team = t.jobID, index = t.index}
				end
			end

			pPlayer:SetNVar('mo_data', player_data, NETWORK_PROTOCOL_PUBLIC)
			pPlayer:SetNVar('mo_team', team, NETWORK_PROTOCOL_PUBLIC)
			pPlayer:SetNVar('mo_rpid', data[1].rpid, NETWORK_PROTOCOL_PUBLIC)
			pPlayer:SetNVar('mo_name', data[1].player, NETWORK_PROTOCOL_PUBLIC)
			pPlayer:SetNWString( "rpname", data[1].player )

			pPlayer:SetTeam(team.index)
			pPlayer:Spawn()
		else
			local name = pPlayer:Name() == '' and pPlayer:Name() or pPlayer:Nick()
			local team = {team = mopp.jobs[TEAM_CADET].jobID, index = TEAM_CADET}

			local rpid = string.char(math.random(48,57))..string.char(math.random(48,57))..string.char(math.random(48,57))..string.char(math.random(48,57))
			local player_data = {
				team = team,
				data = {
					rank = "",
					legion = "",
					features = {},
				}
			}

			pPlayer:SetNVar('mo_data', player_data, NETWORK_PROTOCOL_PUBLIC)
			pPlayer:SetNVar('mo_team', team, NETWORK_PROTOCOL_PUBLIC)
			pPlayer:SetNVar('mo_rpid', rpid, NETWORK_PROTOCOL_PUBLIC)
			pPlayer:SetNVar('mo_name', name, NETWORK_PROTOCOL_PUBLIC)
			pPlayer:SetNWString( "rpname", name )

			pPlayer:SetTeam(TEAM_CADET)
			pPlayer:Spawn()

			MySQLite.query(string.format("INSERT INTO mopple_player_data VALUES(%s, %s, %s, %s, %s, %s);", 
				MySQLite.SQLStr(pPlayer:SteamID()),
				MySQLite.SQLStr(pPlayer:SteamID64()),
				MySQLite.SQLStr(team.team),
				MySQLite.SQLStr(name),
				MySQLite.SQLStr(rpid),
				MySQLite.SQLStr(util.TableToJSON(player_data))
			))
		end
	end )
	MySQLite.query( "SELECT * FROM `mopple_discord_integration` WHERE steamid = '"..pPlayer:SteamID64().."'",function(data)
		if (data and istable(data)) then
			pPlayer:SetNVar('DiscordToken',data[1].token,NETWORK_PROTOCOL_PRIVATE)
		else
			local RandomToken = ""
			for i = 1, 6 do
				RandomToken = RandomToken .. string.char( math.random( 65, 90 ) )
			end
			MySQLite.query( "INSERT INTO `mopple_discord_integration` VALUES('".. tostring(pPlayer:SteamID64()).."', '"..tostring(RandomToken).."','0');" )
			pPlayer:SetNVar('DiscordToken', RandomToken, NETWORK_PROTOCOL_PRIVATE)
		end
	end )
	-- MySQLite.query( "SELECT * FROM `sp_ips_log` WHERE steamid = '"..pPlayer:SteamID64().."'",function(data)
	-- 	if !(data and istable(data)) then
	-- 		MySQLite.query( "INSERT INTO `sp_ips_log` VALUES('".. tostring(pPlayer:SteamID64()).."', '"..tostring(pPlayer:IPAddress()).."');" )
	-- 	end
	-- end )
end
hook.Add("PlayerIsLoaded","InitPlayerData",InitPlayerData)

function pMeta:ChangeTeam(index)
	self:SetTeam(index)

	hook.Call( "PlayerLoadout", GAMEMODE, self );
end

mopp.cfg.Jails = {
	['gm_construct'] = {
		Vector(-2226.752197, -1948.696167, 320.031250)
	},
	['rp_rishimoon_crimson'] = {
		Vector(-8545.546875, -11398.548828, 100.031250),
		Vector(-8412.456055, -11397.974609, 100.031250),
		Vector(-8287.672852, -11400.831055, 100.031250),
		Vector(-8152.676270, -11399.748047, 100.031250)
	},
	['rp_venator_extensive'] = {
		Vector(647.233582, -2116.832764, -2463.968750),
		Vector(642.920532, -2242.028076, -2463.968750)
		-- Vector(-8287.672852, -11400.831055, 100.031250),
		-- Vector(-8152.676270, -11399.748047, 100.031250)
	},
	['rp_kamino_extensive'] = {
    Vector(3565.313965, 1645.067383, -10470.968750),
    Vector(3063.418213, 1621.157227, -10470.968750),
    Vector(2556.847900, 1652.161255, -10470.968750)
	},
}

function pMeta:Arrest(time, pPlayer)
	if !self:GetNVar("Arrested") then
		if game.GetMap() == mopp.cfg.DefaultMainMap then
			time = time or 300

			self:StripWeapons()
			self:StripAmmo()

			-- self:SetPos(Vector(3573.202637, 766.800293, -10461.968750))
			-- self:SetPos(Vector(-360.165619, -2021.855835, -2436.218994))
			self:SetPos(table.Random(mopp.cfg.Jails[game.GetMap()]))
			-- self:SetNVar("Arrested", true, NETWORK_PROTOCOL_PUBLIC)
			self:SetNWBool( 'mo_arrest', true )

			if pPlayer and pPlayer:IsPlayer() then
				GmLogger.PostMessageInDiscord(pPlayer:NameWithSteamID()..' арестовал игрока '..self:NameWithSteamID())
			end
			timer.Create("Arrested_"..self:SteamID64(), time, 1, function()
				self:UnArrest()
			end)
		else
			pPlayer:ChatPrint('Вы не можете арестовавать на этой карте.')
		end
	end
end

function pMeta:UnArrest(pPlayer)
	self:SetNWBool( 'mo_arrest', false )
	self:Spawn()
	timer.Remove("Arrested_"..self:SteamID64())
	GmLogger.PostMessageInDiscord(self:NameWithSteamID()..' разарестовал игрока '..self:NameWithSteamID())
end

local tblNoFallDamage = {
	-- TEAM_18777GEN,
	TEAM_187CT,
	TEAM_187CT2,
	TEAM_187CT3,
	TEAM_187SNI,
	TEAM_187CTR,
	TEAM_187CTR1,
	TEAM_187MED1,
	TEAM_187MED,
	TEAM_187ASP,
	TEAM_187ASP1,
	TEAM_187ASPS12,
	TEAM_187ASPS,
	TEAM_187UYT,
	TEAM_187ASPS1,
	TEAM_187SGT,
	TEAM_187LTS,
	TEAM_187LTS2,
	TEAM_187EL,
	TEAM_187LT,
	TEAM_187CO
}

function GM:GetFallDamage( pPlayer, flFallSpeed )
	-- print(pPlayer:Team())
	return table.HasValue(tblNoFallDamage,pPlayer:Team()) and 0 or (flFallSpeed/10)
end

hook.Add("GetFallDamage","NoFallDamageFor187_GetFallDamage",function( pPlayer, flFallSpeed )
	return table.HasValue(tblNoFallDamage,pPlayer:Team()) and 0 or (flFallSpeed/10)
end)

util.AddNetworkString('TalkIconChat')

net.Receive('TalkIconChat', function(_, ply)
	local bool = net.ReadBool()
	ply:SetNW2Bool('mopp_istyping', (bool ~= nil) and bool or false)
end)
