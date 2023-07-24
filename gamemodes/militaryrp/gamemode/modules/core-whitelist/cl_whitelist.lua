local profiles, users = {}, {} -- panels
local team_to_id = {}

for index, team in pairs(mopp.jobs) do
	team_to_id[team.Name] = {team = team.jobID, index = index}
end


function pMeta:OpenWhitelistProfile()
	local select_team = team.GetName(self:Team())
	local Main = vgui.Create('DFrame')
	Main:SetSize(300,145)
	Main:Center()
	Main:SetTitle('       Профиль игрока '..self:Name())
	Main:MakePopup()

	local player_data = self:GetNVar('mo_data')

	local Avatar = vgui.Create( "AvatarImage", Main )
	Avatar:SetSize( 22, 22 )
	Avatar:SetPos( 2, 2 )
	Avatar:SetPlayer( self, 32 )

	local DComboBox = vgui.Create( "DComboBox", Main )
	DComboBox:SetSize( 180, 22 )
	local clumb_two_x = Main:GetWide() - DComboBox:GetWide() - 5
	DComboBox:SetPos( clumb_two_x, 50 )

	for name, team in pairs(team_to_id) do
		DComboBox:AddChoice( name )
	end

	local SearchTeam = vgui.Create( "DTextEntry", Main )
	SearchTeam:SetSize( DComboBox:GetWide(), 20 )
	local x, y = DComboBox:GetPos()
	SearchTeam:SetPos( x,y-20 )
	SearchTeam.OnChange = function( self )
		DComboBox:Clear()
		for _, team in pairs(mopp.jobs) do
			local heckStart, heckEnd = string.find( string.lower(team.Name), string.lower(self:GetValue()) )
			if heckStart then
				if LocalPlayer():isNearWhitelist() then
					DComboBox:AddChoice( team.Name )
					DComboBox:SetValue( team.Name )
				end
			end
		end
	end

	DComboBox:SetValue( select_team )
	DComboBox.OnSelect = function( panel, index, value )
		select_team = value
	end

	local fff = vgui.Create( "DLabel", Main )
	fff:SetPos( 6, 80 )
	fff:SetWide( 100 )
	fff:SetText( "Ле:\n\nРг:" )
	fff:SizeToContents()

	local Legion = vgui.Create( "DTextEntry", Main )
	Legion:SetSize( 82, 20 )
	Legion:SetPos( 24, 80 )
	Legion:SetText( player_data.data.legion )

	local Rank = vgui.Create( "DTextEntry", Main )
	Rank:SetSize( 82, 20 )
	Rank:SetPos( 24, 100 )
	Rank:SetText( player_data.data.rank )

	local features_boxes = {}	
	local features = {}

	for k, v in pairs(mopp.cfg.features) do
		features_boxes[v.prefix] = vgui.Create( "DCheckBoxLabel", Main )
		features_boxes[v.prefix]:SetPos( clumb_two_x, 60+(16*k) )
		features_boxes[v.prefix]:SetText( v.title )

		local value = (player_data.data.features and player_data.data.features[v.prefix] and player_data.data.features[v.prefix] == true) and 1 or 0
		features_boxes[v.prefix]:SetValue( value )
		features_boxes[v.prefix]:SizeToContents()
	end

	local Spawn = vgui.Create( "DCheckBoxLabel", Main )
	Spawn:SetPos( 6, 125 )
	Spawn:SetText( 'Зареспавнить?' )
	Spawn:SetValue( 0 )
	Spawn:SizeToContents()
	Spawn:SetTextColor( Color( 255,165,0 ) )

	local Change = vgui.Create( "DButton", Main )
	Change:SetSize( 100, 25 )
	Change:SetPos( 6, 30 )
	Change:SetText( 'Выдать' )
	Change.DoClick = function()
		for prefix, panel in pairs(features_boxes) do
			features[prefix] = panel:GetChecked()
		end

		netstream.Start('WhiteList_ChangeProfile',{
			legion = Legion:GetValue(), 
			rank = Rank:GetValue(), 
			team = team_to_id[DComboBox:GetValue()],
			features = features,
			respawn = Spawn:GetChecked(),
			target = self,
			timed = false
		})
	end

	local Change = vgui.Create( "DButton", Main )
	Change:SetSize( 100, 20 )
	Change:SetPos( 6, 55 )
	Change:SetText( 'На время' )
	Change.DoClick = function()
		netstream.Start('WhiteList_ChangeProfile',{
			timed = true,
			target = self,
			respawn = Spawn:GetChecked(),
			team = team_to_id[DComboBox:GetValue()]
		})
	end
end

netstream.Hook("OfflineList_OpenProfile", function(data)
	local team
	for _, v in pairs(mopp.jobs) do
		if v.jobID == data.mopp.team then
			team = v
		end
	end

	local select_team = team.Name
	local Main = vgui.Create('DFrame')
	Main:SetSize(300,145)
	Main:Center()
	Main:SetTitle('Профиль игрока '..data.mopp.player)
	Main:MakePopup()

	local player_data = util.JSONToTable(data.mopp.data).data -- oh yee. i like this shit

	PrintTable(player_data)

	local DComboBox = vgui.Create( "DComboBox", Main )
	DComboBox:SetSize( 180, 22 )
	local clumb_two_x = Main:GetWide() - DComboBox:GetWide() - 5
	DComboBox:SetPos( clumb_two_x, 30 )

	for name, team in pairs(team_to_id) do
		DComboBox:AddChoice( name )
	end

	DComboBox:SetValue( select_team )
	DComboBox.OnSelect = function( panel, index, value )
		select_team = value
	end

	local fff = vgui.Create( "DLabel", Main )
	fff:SetPos( 6, 80 )
	fff:SetWide( 100 )
	fff:SetText( "Ле:\n\nРг:" )
	fff:SizeToContents()

	local Legion = vgui.Create( "DTextEntry", Main )
	Legion:SetSize( 82, 20 )
	Legion:SetPos( 24, 80 )
	Legion:SetText( player_data.rank )

	local Rank = vgui.Create( "DTextEntry", Main )
	Rank:SetSize( 82, 20 )
	Rank:SetPos( 24, 100 )
	Rank:SetText( player_data.legion )

	local features_boxes = {}	
	local features = {}

	for k, v in pairs(mopp.cfg.features) do
		features_boxes[v.prefix] = vgui.Create( "DCheckBoxLabel", Main )
		features_boxes[v.prefix]:SetPos( clumb_two_x, 40+(16*k) )
		features_boxes[v.prefix]:SetText( v.title )

		local value = player_data.features[v.prefix] == true and 1 or 0
		features_boxes[v.prefix]:SetValue( value )
		features_boxes[v.prefix]:SizeToContents()
	end

	local Spawn = vgui.Create( "DCheckBoxLabel", Main )
	Spawn:SetPos( 6, 125 )
	Spawn:SetText( 'Заспаванить на спаване после выдачи?' )
	Spawn:SetValue( 0 )
	Spawn:SizeToContents()
	Spawn:SetTextColor( Color( 255,165,0 ) )

	local Change = vgui.Create( "DButton", Main )
	Change:SetSize( 100, 25 )
	Change:SetPos( 6, 30 )
	Change:SetText( 'Изменить' )
	Change.DoClick = function()
		for prefix, panel in pairs(features_boxes) do
			features[prefix] = panel:GetChecked()
		end

		netstream.Start('OfflineList_ChangeProfile',{
			legion = Legion:GetValue(), 
			rank = Rank:GetValue(), 
			team = team_to_id[DComboBox:GetValue()],
			features = features,
			respawn = Spawn:GetChecked(),
			steam_id = data.mopp.steam_id
		})
	end
end)

netstream.Hook("WhiteList_OpenMenu", function(data)
	profiles.main = vgui.Create('DFrame')
	profiles.main:SetSize(500,400)
	profiles.main:Center()
	profiles.main:SetTitle('WhiteList')
	profiles.main:MakePopup()

	profiles.list = vgui.Create( "DListView", profiles.main )
	profiles.list:SetSize(profiles.main:GetWide()-8,profiles.main:GetTall()-54)
	profiles.list:SetPos(4,50)
	profiles.list:SetMultiSelect( false )
	profiles.list:AddColumn( "Игрок" )
	profiles.list:AddColumn( "Псевдоним" )
	profiles.list:AddColumn( "Профессия" )

	local players = player.GetAll()
	profiles.search = vgui.Create( "DTextEntry", profiles.main )
	profiles.search:SetSize( profiles.list:GetWide(), 20 )
	local x, y = profiles.list:GetPos()
	profiles.search:SetPos( x, y-20 )
	profiles.search.OnChange = function( self )
		profiles.list:Clear()
		for _, pPlayer in pairs(players) do
			local heckStart, heckEnd = string.find( string.lower(pPlayer:Name()), string.lower(self:GetValue()) )
			if heckStart then
				profiles.list:AddLine(pPlayer,pPlayer:Name(),team.GetName(pPlayer:Team()))
			end
		end
	end
	for _, ply in pairs(player.GetAll()) do
		profiles.list:AddLine( ply, ply:Name(), team.GetName(ply:Team()) )
		profiles.list.OnRowSelected = function( lst, index, pnl )
			profiles.list:GetLine(index):GetValue(1):OpenWhitelistProfile()
		end
	end

	for _, line in pairs( profiles.list:GetLines() ) do
		local test = vgui.Create('DPanel', line)
		test:SetPos(300,3)
		test:SetSize(12,12)

		test.Paint = function( self, w, h )
			draw.RoundedBox(6.5,0,0,w,h,team.GetColor(line:GetValue(1):Team()))
		end
	end
end)