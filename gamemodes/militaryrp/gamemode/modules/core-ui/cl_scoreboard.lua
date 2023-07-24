local Main, menu
local HeightLine = 20
local tblClones, tblDroids, tblCivilians = {}, {}, {}
local RightCloumbWide = 200
local ply = LocalPlayer()
surface.CreateFont("dbg-hud.normal", {font = "Calibri", extended = true, size = 27, weight = 350, shadow = true})
surface.CreateFont("dbg-hud.normal-sh", {font = "Calibri", extended = true, size = 27, blursize = 5, weight = 350})
surface.CreateFont("dbg-hud.small", {font = "Roboto", extended = true, size = 17, weight = 350, shadow = true})
surface.CreateFont("dbg-hud.small-sh", {font = "Roboto", extended = true, size = 17, blursize = 4, weight = 350})
surface.CreateFont("octoinv.3d", {font = "Arial Bold", extended = true, size = 18, weight = 300, antialias = true})
surface.CreateFont(
    "octoinv.3d-sh",
    {font = "Arial Bold", extended = true, size = 18, weight = 300, blursize = 5, antialias = true}
)

surface.CreateFont( "font_scoreboard", {
	font = "Default",
	size = 18,
	weight = 300,
	antialias = true,
	underline = false,
	extended = true,
})

surface.CreateFont( "font_scoreboard_header", {
	font = "Default",
	size = 24,
	weight = 300,
	antialias = false,
	underline = false,
	extended = false,
})

surface.CreateFont( "font_scoreboard_title", {
	font = "Arial",
	size = 32,
	weight = 100,
	antialias = false,
	underline = false,
	extended = false,
})

surface.CreateFont( "font_scoreboard_small", {
	font = "Default",
	size = 14,
	weight = 300,
	antialias = false,
	underline = false,
	extended = false,
})

local mat_wrench = Material('icon16/wrench.png', 'noclamp smooth')
local mat_star = Material('tfc/star.png', 'noclamp smooth')
local mat_key = Material('tfc/key.png', 'noclamp smooth')
local mat_cross = Material('tfc/cross.png', 'noclamp smooth')
local mat_land = Material('tfc/land.png', 'noclamp smooth')
local mat_air = Material('tfc/air.png', 'noclamp smooth')
local mat_rocket = Material('tfc/rocket.png', 'noclamp smooth')
local mat_tick = Material('tfc/tick.png', 'noclamp smooth')
local mat_settings = Material('tfc/screwdriver-and-wrench.png', 'noclamp smooth')
local mat_case = Material('tfc/case.png', 'noclamp smooth')
local mat_hammer = Material('tfc/hammer.png', 'noclamp smooth')
local mat_lines = Material('tfc/lines.png', 'noclamp smooth')

local DummyPanel
local Scrollers = {}

function PlayerButtonClick(pPlayer)
	if not IsValid(pPlayer) then return end
	local rankData = serverguard.ranks:GetRank(serverguard.player:GetRank(LocalPlayer()))
	local commands = serverguard.command:GetTable()
	

	local bNoAccess = true
	local menu = DermaMenu();
	menu:SetSkin("serverguard");
	menu:AddOption("Открыть профиль Steam", function()
		pPlayer:ShowProfile()
	end):SetIcon("icon16/user_gray.png");
	menu:AddSpacer()
	menu:AddOption("Скопировать SteamID", function()
		SetClipboardText(pPlayer:SteamID());
	end):SetIcon("icon16/paste_plain.png");

	if LocalPlayer():isNearWhitelist() then
		menu:AddOption('Открыть Whitelist профиль', function()
			pPlayer:OpenWhitelistProfile()
		end):SetIcon("icon16/sport_8ball.png");

		local droids = {
			TEAM_CISS,
			TEAM_CISDJ,
			TEAM_CISTR,
			TEAM_CISS1,
			TEAM_CISCO,
			TEAM_CIDI
		}
		local civils = {
			TEAM_IVN,
			TEAM_IVN1,
			TEAM_IVN2
		}
	end
	if LocalPlayer():IsAdmin() or LocalPlayer():GetUserGroup() == 'founder' or serverguard.player:GetImmunity(LocalPlayer()) > 5 then
		local sub_commands = menu:AddSubMenu('Админ меню')
		for unique, data in pairs(commands) do
			if (data.ContextMenu and (!data.permissions or serverguard.player:HasPermission(LocalPlayer(), data.permissions))) then
				data:ContextMenu(pPlayer, sub_commands, rankData); bNoAccess = false;
			end;
		end;
		menu:AddOption ("Респавн из призрака", function () RunConsoleCommand("sg", "respawn_G", pPlayer:SteamID()) end ):SetImage("icon16/control_play.png")
	end
	menu:Open();
end

function ScoreboardOpen()
	if !IsValid(Main) then
		RightCloumbWide = 200

		local players_all = player.GetAll()

		table.sort( players_all, function( a, b ) return a:Team() > b:Team() end )
		tblClones, tblDroids, tblCivilians = {}, {}, {}
		Scrollers = {}
		for _, pPlayer in pairs(players_all) do
			local team = mopp.jobs[pPlayer:Team()]
			if team and team.spawn_group then
				if (team.spawn_group == "Clones" or team.spawn_group == "cadet" or team.spawn_group == "Jedi") then
					table.insert(tblClones,pPlayer)
				elseif team.spawn_group == "Civilians" then
					table.insert(tblCivilians,pPlayer)
				elseif (team.spawn_group == "Droids") then
					table.insert(tblDroids,pPlayer)
				end
			end
		end

		alpha = 0
		alpha_lerp = 0
		LocalPlayer().Scoreboard = true
		Main = vgui.Create("DFrame")
		Main:SetSize(ScrW(),ScrH())
		Main:SetPos((ScrW()-Main:GetWide())/2,(ScrH()-Main:GetTall())/2)
		Main:SetTitle('')
        

		local DummyPanel = vgui.Create( "DPanel", Main )
		DummyPanel.Paint = function( self, w, h ) end
		if #tblDroids >= 1 or #tblCivilians >= 1 then
			DummyPanel:SetSize(Main:GetWide()/1.5,Main:GetTall()/1.3)
			DummyPanel:SetPos(Main:GetWide()/6,Main:GetTall()/6)
		else
			DummyPanel:SetSize(Main:GetWide()/2.2,Main:GetTall()/1.2)
			DummyPanel:SetPos(Main:GetWide()/3.8,Main:GetTall()/12)
		end

		Main:SetDraggable(false)
		Main:ShowCloseButton(false)
		Main.Paint = function( self, w, h )
			alpha = 250
			alpha_lerp = Lerp(FrameTime()*6,alpha_lerp or 0,alpha or 0) or 0, Color( 29,21,29,255)
			local x, y = self:GetPos()
			draw.DrawBlur( x, y, self:GetWide(), self:GetTall(), (alpha_lerp/100) )

			draw.RoundedBox(0,0,0,w,h,Color(0,0,0,alpha_lerp or 100))
            draw.DrawText("Онлайн: "..player.GetCount(), "dbg-hud.small", ScrW() / 1.46, ScrH() * 0.08, color_white, TEXT_ALIGN_LEFT)
			draw.DrawText("MCR:RP", "dbg-hud.normal", w/2.05, h/20, Color(240,240,240,255), 1, 1)

			if #tblDroids >= 1 or #tblCivilians >= 1 then
				draw.ShadowSimpleText('Nitro project','font_scoreboard_title',w/2,60,Color(240,240,240,255),1,TEXT_ALIGN_BOTTOM)
				draw.ShadowSimpleText('Сейчас проходит ивент, пожалуйста соблюдайте отыгровку своих ролей.','font_scoreboard_small',w/2,70,Color(240,240,240,255),1,TEXT_ALIGN_BOTTOM)
				draw.ShadowSimpleText('Мы вам желаем хорошо провести время на инвенте.','font_scoreboard_small',w/2,82,Color(240,240,240,255),1,TEXT_ALIGN_BOTTOM)

				draw.ShadowSimpleText('Clones','font_scoreboard_title',(Main:GetWide()/6)+6,Main:GetTall()/6,Color(240,240,240,255),0,TEXT_ALIGN_BOTTOM)

				if #tblDroids >= 1 then
					draw.ShadowSimpleText('Droids','font_scoreboard_title',(Main:GetWide()/1.19)-16,Main:GetTall()/6,Color(240,240,240,255),TEXT_ALIGN_RIGHT,TEXT_ALIGN_BOTTOM)

					local droid_frags = 0
					for _, v in pairs(tblDroids) do
						if v and v:IsPlayer() and IsValid(v) then
							droid_frags = droid_frags + v:Frags()
						end
					end
					local clones_frags = 0
					for _, v in pairs(tblClones) do
						if v and v:IsPlayer() and IsValid(v) then
							clones_frags = clones_frags + v:Frags()
						end
					end
					local strFrags = clones_frags..' : '..droid_frags
					surface.SetFont('font_scoreboard_title')
					local w_frags, _ = surface.GetTextSize(strFrags)
					draw.ShadowSimpleText(clones_frags..' : '..droid_frags,'font_scoreboard_title',(Main:GetWide()/2)-4-w_frags/2,Main:GetTall()/6,Color(240,240,240,255),0,TEXT_ALIGN_BOTTOM)
				elseif #tblCivilians >= 1 then
					draw.ShadowSimpleText('Civilians','font_scoreboard_title',(Main:GetWide()/1.19)-16,Main:GetTall()/6,Color(240,240,240,255),TEXT_ALIGN_RIGHT,TEXT_ALIGN_BOTTOM)
				end
				draw.ShadowSimpleText(#player.GetAll()..'/'..game.MaxPlayers()..' всего игроков. '..#tblClones..' клонов, '..#tblDroids..' дройдов, '..#tblCivilians..' жителей. Карта: '..game.GetMap(),'font_scoreboard_small',(Main:GetWide()/6)+2,Main:GetTall()/1.045,Color(240,240,240,255),0,TEXT_ALIGN_BOTTOM)
			else
			end
		end

		local ScrollClones = vgui.Create("DScrollPanel",DummyPanel)
		ScrollClones.sbar = ScrollClones:GetVBar()
		ScrollClones.sbar.Paint = function( self, w, h ) draw.RoundedBox(0, 0, 0, w/1.8, h, Color(0, 0, 0, 90)) end

		function ScrollClones.sbar:PerformLayout()
			local Wide = self:GetWide()
			local Scroll = self:GetScroll() / self.CanvasSize
			local BarSize = math.max( self:BarScale() * ( self:GetTall() - ( Wide * 2 ) ), 10 )
			local Track = self:GetTall() - BarSize
			Track = Track + 1

			Scroll = Scroll * Track

			self.btnGrip:SetPos( 0, Scroll )
			self.btnGrip:SetSize( Wide, BarSize )

			self.btnUp:SetPos( 0, 0, 0, 0 )
			self.btnUp:SetSize( 0, 0 )

			self.btnDown:SetPos( 0, self:GetTall() - 0, 0, 0 )
			self.btnDown:SetSize( 0, 0 )
		end
		ScrollClones.sbar.btnGrip.Paint = function( self, w, h ) draw.RoundedBox(0, 0, 0, w/1.8, h, Color(245, 245, 245, 140)) end

		for k, v in pairs(tblClones) do
			DrawPlayerLine(ScrollClones,k,v,tblClones)
		end

		local div
		local ScrollDroids
		if #tblDroids >= 1 then
			ScrollDroids = vgui.Create("DScrollPanel",DummyPanel)
			ScrollDroids.sbar = ScrollDroids:GetVBar()
			ScrollDroids.sbar.Paint = function( self, w, h ) draw.RoundedBox(0, 0, 0, w/1.8, h, Color(0, 0, 0, 90)) end

			function ScrollDroids.sbar:PerformLayout()
				local Wide = self:GetWide()
				local Scroll = self:GetScroll() / self.CanvasSize
				local BarSize = math.max( self:BarScale() * ( self:GetTall() - ( Wide * 2 ) ), 10 )
				local Track = self:GetTall() - BarSize
				Track = Track + 1

				Scroll = Scroll * Track

				self.btnGrip:SetPos( 0, Scroll )
				self.btnGrip:SetSize( Wide, BarSize )

				-- self:SetScroll( 0 )

				self.btnUp:SetPos( 0, 0, 0, 0 )
				self.btnUp:SetSize( 0, 0 )

				self.btnDown:SetPos( 0, self:GetTall() - 0, 0, 0 )
				self.btnDown:SetSize( 0, 0 )
			end
				-- ScrollDroids.sbar.btnDown:Remove()
			ScrollDroids.sbar.btnGrip.Paint = function( self, w, h ) draw.RoundedBox(0, 0, 0, w/1.8, h, Color(245, 245, 245, 140)) end

			for k, v in pairs(tblDroids) do
				DrawPlayerLine(ScrollDroids,k,v,tblDroids)
			end
		else
			ScrollClones:SetSize(Main:GetWide(),DummyPanel:GetTall())
			-- ScrollClones:SetPos(Main:GetWide()/3.8,Main:GetTall()/12)
		end

		if #tblDroids >= 1 or #tblCivilians >= 1 then
			div = vgui.Create( "DHorizontalDivider", DummyPanel )
			div:Dock( FILL ) -- Make the divider fill the space of the DFrame
			div:SetDividerWidth( 4 ) -- Set the divider width. Default is 8
			-- div:SetLeftMin( Main:GetWide()/6 ) -- Set the Minimum width of left side
			-- div:SetRightMin( Main:GetWide()/6 )
			div:SetLeftWidth( DummyPanel:GetWide()/2 ) -- Set the default left side width
			-- div:SetPos(Main:GetWide()/6,Main:GetTall()/6)
			-- div:SetRight( ScrollClones )
			div:SetLeft( ScrollClones )

			div.Paint = function( self, w, h)
				-- (self:GetDragging())
				if self:GetDragging() then
					for pPlayer, v in pairs(Scrollers[tblClones]) do
						v.PlayerPanel:SetSize(self:GetLeftWidth()+14,HeightLine+2)
					end
					for pPlayer, v in pairs(Scrollers[tblDroids]) do
						v.PlayerPanel:SetSize(ScrollDroids:GetWide()+16,HeightLine+2)
					end
					if DummyRightPanel and tblCivilians >= 1 then
						for pPlayer, v in pairs(Scrollers[tblCivilians]) do
							v.PlayerPanel:SetSize(ScrollDroids:GetWide()+16,HeightLine+2)
						end
					end
					RightCloumbWide = div:GetRight():GetTall()
				end
			end
		end

		-- ScrollDroids:SetSize(ScrollDroids:GetWide(),ScrollDroids:GetTall()-14)

		if #tblCivilians >= 1 then
			if ScrollDroids then
				ScrollDroids:SetSize(Main:GetWide()/3,Main:GetTall()/2.55)
			end

			local ScrollCivilians = vgui.Create("DScrollPanel",Main)

			ScrollCivilians.sbar = ScrollCivilians:GetVBar()
			ScrollCivilians.sbar.Paint = function( self, w, h ) draw.RoundedBox(0, 0, 0, w/1.8, h, Color(0, 0, 0, 90)) end

			function ScrollCivilians.sbar:PerformLayout()
				local Wide = self:GetWide()
				local ScrollCivilians = self:GetScroll() / self.CanvasSize
				local BarSize = math.max( self:BarScale() * ( self:GetTall() - ( Wide * 2 ) ), 10 )
				local Track = self:GetTall() - BarSize
				Track = Track + 1

				ScrollCivilians = ScrollCivilians * Track

				self.btnGrip:SetPos( 0, ScrollCivilians )
				self.btnGrip:SetSize( Wide, BarSize )

				-- self:SetScroll( 0 )

				self.btnUp:SetPos( 0, 0, 0, 0 )
				self.btnUp:SetSize( 0, 0 )

				self.btnDown:SetPos( 0, self:GetTall() - 0, 0, 0 )
				self.btnDown:SetSize( 0, 0 )
			end
				-- ScrollCivilians.sbar.btnDown:Remove()
			ScrollCivilians.sbar.btnGrip.Paint = function( self, w, h ) draw.RoundedBox(0, 0, 0, w/1.8, h, Color(245, 245, 245, 140)) end

			for k, v in pairs(tblCivilians) do
				DrawPlayerLine(ScrollCivilians,k,v,tblCivilians)
			end

			if #tblDroids >= 1 then
				local DummyRightPanel = vgui.Create( "DVerticalDivider", DummyPanel )
				-- local div = vgui.Create( "DVerticalDivider", f )
				-- DummyRightPanel:Dock( FILL )
				DummyRightPanel:SetBottom( ScrollCivilians )
				DummyRightPanel:SetTop( ScrollDroids )
				DummyRightPanel:SetDividerHeight( 28 )
				DummyRightPanel:SetBottomMin( Main:GetTall()/4 )
				DummyRightPanel:SetTopMin( Main:GetTall()/4 )
				DummyRightPanel:SetTopHeight( Main:GetTall()/2 )
				DummyRightPanel.Paint = function( self, w, h )
					draw.ShadowSimpleText('Civilians','font_scoreboard_title',0,self:GetTopHeight(),Color(240,240,240,255),0,TEXT_ALIGN_TOP)
					-- draw.RoundedBox(0,0,0,w,h,Color(0,0,0))
				end
				div:SetRight( DummyRightPanel )
			else
				if div then
					div:SetRight( ScrollCivilians )
				end
			end
		else
			if div then
				div:SetRight( ScrollDroids )
			end
		end

	end
end

function ScoreboardClose()
	if IsValid(Main) then
		Main:Close()
		LocalPlayer().Scoreboard = false
	end
end

function GM:ScoreboardShow()
	ScoreboardOpen()

	if IsValid(Main) then
		Main:Show()
		Main:MakePopup()
		Main:SetKeyboardInputEnabled(false)
	end
end

function GM:ScoreboardHide()
	if IsValid(Main) then
		ScoreboardClose()
	end
end

function GM:OnReloaded()
	if Main and IsValid(Main) and ValidPanel(Main) then
		Main:Close()
	end
	LocalPlayer().Scoreboard = false
end

function DrawPlayerLine(Scroll,key,pPlayer,KeyPanel)
	local button_hover = {}
	if !IsValid(pPlayer) then return end
	Scrollers[KeyPanel] = Scrollers[KeyPanel] or {}
	local pColor = team.GetColor(pPlayer:Team())
	local PlayerPanel = vgui.Create("DPanel",Scroll)
	if #tblDroids >= 1 or #tblCivilians >= 1 then
		PlayerPanel:SetSize((Main:GetWide()/3)+24,HeightLine+10)
	else
		PlayerPanel:SetSize((Main:GetWide()/2.2)+16,HeightLine+25)
	end
	PlayerPanel:SetPos(1,((HeightLine+30)*key)-HeightLine) --вниз
	PlayerPanel.Paint = function( self, w, h )
		if pPlayer and pPlayer:IsPlayer() and IsValid(pPlayer) then
			w = w - 30
			h = h - 1
			local col = team.GetColor(pPlayer:Team())
			if button_hover and button_hover[key] then
				col = Color(col.r+20,col.g+20,col.b+20)
			end
			draw.RoundedBox(8, 0, 0, w, h, Color(85,68,85, 255))

			local name = pPlayer:Name()
			surface.SetFont('font_scoreboard')
			local w_name, h_name = surface.GetTextSize(name)
			draw.ShadowSimpleText(name, "dbg-hud.small", w/30, h/1.9, Color(240,240,240,255), 10, 1)
			if pPlayer and pPlayer:GetNVar('mo_rpid') then
			end

			local player_data = pPlayer:GetNVar('mo_data')

			local VehiclesIcons = {
				['jet'] = mat_rocket,
				['air'] = mat_air,
				['land'] = mat_land,
			}

			if w >= 300 then
				draw.ShadowSimpleText(team.GetName(pPlayer:Team()), "dbg-hud.small", w/2, h/1.9, Color(240,240,240,255), 1, 1)

				if player_data and player_data and player_data.data.rank and table.HasValue(tblClones,pPlayer) and player_data.data.legion != '' then
					draw.ShadowSimpleText(''..player_data.data.rank..'', "dbg-hud.small", w-4, h/1.9, Color(240,240,240,255), 2, 1)
				end
			else
				draw.ShadowSimpleText(team.GetName(pPlayer:Team()), "dbg-hud.small", w/2, h/1.9, Color(240,240,240,255), 2, 1)
			end
		end
	end



	local Avatar = vgui.Create( "AvatarImage", PlayerPanel )
	Avatar:SetSize( 0, 0 )
	Avatar:SetPos( 10, 10 )

	local Button = vgui.Create("DButton",PlayerPanel)
	Button:SetSize(PlayerPanel:GetWide(),PlayerPanel:GetTall())
	Button:SetText('')
	Button:SetPos(5,15)
	Button.Paint = function( self, w, h )
		button_hover[key] = Button:IsHovered()

		-- (self, self:CursorPos())

		if pPlayer:GetUserGroup() != '' then
			local group = serverguard.ranks:GetRank(pPlayer:GetUserGroup())
			surface.SetMaterial(Material(group.texture))
			surface.SetDrawColor(color_white)
			surface.DrawTexturedRect(Avatar:GetWide()/15,Avatar:GetTall()/10,16,16)
		end
	end

	Button.DoClick = function()
		PlayerButtonClick(pPlayer)
	end
	Scrollers[KeyPanel][pPlayer] = Scrollers[KeyPanel][pPlayer] or {Avatar = Avatar, Button = Button, PlayerPanel = PlayerPanel}
	end
