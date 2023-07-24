netstream.Hook('WhiteList_ChangeProfile',function(pPlayer,data)
	if pPlayer:isNearWhitelist() then
		local pTarget = data.target
		local team
		if data.team then
			if istable(data.team) then
				team = data.team.index
			elseif isnumber(data.team) and data.timed then
				team = data.team
			end
		end

		local newteam = team
		local oldteam = pTarget:Team()

		pTarget:SetTeam(team)

		if data.timed then
			local t_post = {}
			t_post.embeds = {
				{
					color = 0x3399FF,
					description = ":pencil2: "..pPlayer:Name().."(``"..pPlayer:SteamID().."``) выдал временную профессию ``"..mopp.jobs[team].Name.."`` игроку "..pTarget:Name().."(``"..pTarget:SteamID().."``)",
					footer = {
						text = "Временно",
					}
				}
			}
			t_post.username = "WhiteList:"
			t_post.avatar_url = nil

			local json_post = util.TableToJSON(t_post)
			local HTTPRequest = {
				["method"] = "POST",
				--["url"] = GmLogger.WebHookURL_Whitelist,
				["type"] = "application/json",
				["headers"] = {
					["Content-Type"] = "application/json",
					["Content-Length"] = string.len(json_post) or "0"
				},
				-- ["success"] = function(code, body, headers)
				-- 	print('~'..code)
				-- end,
				-- ["failed"] = function(reason)
				-- 	print('~'..reason)
				-- end,
				["body"] = json_post
			}
		else
			local old_player_data = pTarget:GetNVar('mo_data')

			if data.features then
				if data.features.jet == true then
					table.insert(mopp.jetplayers,pTarget)
					pTarget.JetPackToggle = false
				else
					table.RemoveByValue(mopp.jetplayers,pTarget)
					pTarget.JetPackToggle = nil
				end
			end

			local player_data = {
				data = data
			}

			if data.team then
				player_data.team = data.team
				-- player_data.data.team = nil
			else
				player_data.team = old_player_data.team
				-- player_data.data.team = nil
			end

			player_data.data.legion = data.legion
			player_data.data.rank = data.rank

			player_data.data.target = nil
			player_data.data.timed = nil

			--PostMessageInDiscord_Whitelist( pPlayer, pTarget, player_data.data, pTarget:GetNVar('mo_data').data, oldteam, newteam )

			pTarget:SetNVar('mo_data', player_data, NETWORK_PROTOCOL_PUBLIC)
			pTarget:SetNVar('mo_team', player_data.team, NETWORK_PROTOCOL_PUBLIC)

			if pPlayer:SteamID() == '' then
				PrintTable(player_data)
			end
			MySQLite.query( "UPDATE `mopple_player_data` SET `data` = '"..util.TableToJSON(player_data).."', `team` = '"..player_data.team.team.."' WHERE `steam_id` = '"..pTarget:SteamID().."'" )
		end

		local pos, ang = pTarget:GetPos(), pTarget:EyeAngles()
		pTarget:StripWeapons()
		pTarget:Spawn()

		if !data.respawn then
			pTarget:SetPos(pos)
			pTarget:SetEyeAngles(ang)
		end
	end
end)

netstream.Hook('OfflineList_ChangeProfile',function(pPlayer,data)
	if pPlayer:isNearWhitelist() then
		local player_data = {}

		player_data.data = table.Copy(data)

		player_data.team = data.team
		player_data.data.steam_id = nil
		player_data.data.team = nil
		player_data.data.target = nil
		player_data.data.timed = nil

		MySQLite.query( "UPDATE `mopple_player_data` SET `data` = '"..util.TableToJSON(player_data).."', `team` = '"..player_data.team.team.."' WHERE `steam_id` = '"..data.steam_id.."'" )
	end
end)

-- if eEnt:GetClass() == 'func_button' and eEnt:MapCreationID() == 2004 then
-- 	GmLogger.PostMessageInDiscord(pPlayer:Name()..'('..pPlayer:SteamID()..') переключил серену.','Console',false,'``['..#player.GetAll()..'/'..game.MaxPlayers()..'] # %s``','https://discordapp.com/api/webhooks/405305697589395456/0lZlLRc-48mC3lIJxYEDroZM7aX8GhJcBcYYJOnHR5sXbx-AipcvYxAwHIdxIQCeheof')
-- 	return true
-- end

hook.Add( "PlayerUse", "WhitelistVehicles_PlayerUse", function( pPlayer, eEnt ) -- TODO: Remove this shit.
	pPlayer.nextUseVehicle = pPlayer.nextUseVehicle or 0
	if pPlayer.nextUseVehicle < CurTime() then
		pPlayer.nextUseVehicle = CurTime() + 2

		if (table.HasValue(mopp.cfg.LandVehicles,eEnt:GetClass()) or table.HasValue(mopp.cfg.AirVehicles,eEnt:GetClass())) then
			if pPlayer:Team() == TEAM_CIPIL and eEnt.Category == "Star Wars Vehicles: CIS" then
				return true
			end
			if mopp.jobs[pPlayer:Team()].spawn_group == mopp.cfg.DefaultSpawnGroup then
				local features = pPlayer:GetNVar('mo_data').data.features
				if features and istable(features) then
					if table.HasValue(mopp.cfg.LandVehicles,eEnt:GetClass()) then
						if features.land == true then
							return true
						end
						pPlayer:ChatPrint('Вам нужно научится владеть наземным транспортом!')
					elseif table.HasValue(mopp.cfg.AirVehicles,eEnt:GetClass()) then
						if features.air == true then
							return true
						end
						pPlayer:ChatPrint('Вам нужно научится владеть воздушным транспортом!')
					end
				end
			end
			return false
		else
			return true
		end
	else
		return false
	end
end)

hook.Add( "Think", "WhitelistJetPack_Think", function( pPlayer, mv )
	for k, pPlayer in pairs(mopp.jetplayers) do
		if pPlayer and IsValid(pPlayer) and pPlayer:IsPlayer() then
			if ( pPlayer:GetMoveType() != MOVETYPE_NOCLIP or pPlayer:InVehicle() ) then
				pPlayer.NextJetpackPos = pPlayer.NextJetpackPos or false
				if ( IsValid(pPlayer) and pPlayer:IsPlayer() ) then
					if (pPlayer:KeyDown(IN_JUMP) and pPlayer:WaterLevel() == 0) then
						pPlayer.NextJetpackPos = pPlayer.NextJetpackPos == false and math.Round(pPlayer:GetPos().z) or pPlayer.NextJetpackPos

						if (!pPlayer.sound) then
							pPlayer.sound = CreateSound(pPlayer, "ambient/gas/cannister_loop.wav");
							pPlayer.sound:ChangeVolume(0.1, 0);
							pPlayer.sound:ChangePitch(150, 0);
						end;

						if pPlayer.sound and !pPlayer.sound:IsPlaying() then
							pPlayer.sound:Play();
						end;

						local buff = pPlayer:GetPos().z >= pPlayer.NextJetpackPos+800 and 0 or 36
						pPlayer:SetVelocity( ((pPlayer:GetAimVector() * 3) + Vector(0, 0, buff))*2 );
					else
						if pPlayer.sound then
							pPlayer.sound:Stop();
							pPlayer.sound = nil;
						end
					end
				end
				if pPlayer.NextJetpackPos and isnumber(pPlayer.NextJetpackPos) and pPlayer:OnGround() then
					pPlayer.NextJetpackPos = false
					if pPlayer.sound then
						pPlayer.sound:Stop();
						pPlayer.sound = nil;
					end
				end
			end
		end
	end
end)
