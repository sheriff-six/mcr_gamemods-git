--______________________--
--██▄██ ▄▀▀ █▀▄ :█▀▄ █▀▄--
--█░▀░█ █░░ █▀▄ :█▀▄ █▀░--
--▀░░░▀ ░▀▀ ▀░▀ :▀░▀ ▀░░--
--______________________--
--█░░░█ █░█ ▀█▀ ▀█▀ █▀▀--
--█▄█▄█ █▀█ ░█░ ░█░ █▀▀--
--▀▀░▀▀ ▀░▀ ▀▀▀ ░▀░ ▀▀▀--
--______________________--


local FKeyBinds = {
	["gm_showhelp"] = "ShowHelp",
	["gm_showteam"] = "ShowTeam",
	["gm_showspare1"] = "ShowSpare1",
	["gm_showspare2"] = "ShowSpare2"
}

function GM:PlayerBindPress(ply, bind, pressed)
	-- if LocalPlayer():IsBanned() then return end
	local bnd = string.match(string.lower(bind), "gm_[a-z]+[12]?")
	if bnd and FKeyBinds[bnd] and GAMEMODE[FKeyBinds[bnd]] then
		GAMEMODE[FKeyBinds[bnd]](GAMEMODE)
	end
	return
end




function GM:ShowSpare2()
	local buttons = {
		-- {'Включить вид от 3-го лица.',function() RunConsoleCommand('thirdperson_toggle') end},
		-- {'Открыть Forum.',function() gui.OpenURL('http://forum.gmodlook.ru/') end},
		-- {'Открыть группу STEAM.',function() gui.OpenURL('http://steamcommunity.com/groups/mofuproject') end},
		--{icon = Material('icon16/flag_green.png','noclamp smooth'),name = 'Контент сервера',func = function() gui.OpenURL('https://steamcommunity.com/sharedfiles/filedetails/?id=2138193189') end},
		--{icon = Material('icon16/award_star_gold_2.png','noclamp smooth'),name = 'Устав',func = function() gui.OpenURL('https://docs.google.com/document/d/1Ree_0zJWrrjdPaWcONKgftDxV1ncezfQDim8zYgEKiA/edit?usp=sharing') end},
		--{icon = Material('icon16/report.png','noclamp smooth'),name = 'Открыть группу Вконтакте',func = function() gui.OpenURL('https://vk.com/np_gmod') end},
		--{icon = Material('icon16/emoticon_grin.png','noclamp smooth'), x = true,name = 'Сервер в Discord',func = function() gui.OpenURL('https://discord.gg/yFue98x') end},
		--{icon = Material('icon16/coins.png','noclamp smooth'), x = true,name = 'Донат',func = function() gui.OpenURL('') end},
		--{icon = Material('icon16/report.png','noclamp smooth'),x = true, name = 'Сайт/Форум',func = function() gui.OpenURL('http://mopple.ru/') end},
	}

	--local frame = vgui.Create("DFrame")
		--frame:SetSize(ScrW() * 0.5, ScrH() * 0.5)
		--frame:SetTitle("MCR:RP")
		--frame:Center()
		--frame:MakePopup()
		--local html = vgui.Create("DHTML", frame)
		--html:Dock(FILL)
		--html:OpenURL("https://clck.ru/qCFcr")

	LocalPlayer().Thirtperson = LocalPlayer().Thirtperson or {}

local frame = vgui.Create( "DFrame" )
	frame:Center()
	frame:SetSize( 400, 400 )
	frame:SetTitle( "Настройки" )
	frame:SetVisible( true )
	frame:SetDraggable( true )
	frame:ShowCloseButton( true )
	frame:MakePopup()
	frame:SetBackgroundBlur( true )


 local PropertySheet = vgui.Create( "DPropertySheet" )
 PropertySheet:SetParent( frame )
 PropertySheet:SetPos( 5, 30 )
 PropertySheet:SetSize( 390, 390 )
 local SomeCollapsibleCategory = vgui.Create("DCollapsibleCategory", frame)
 SomeCollapsibleCategory:SetPos( 25,50 )
 SomeCollapsibleCategory:SetSize( 200, 50 ) -- Keep the second number at 50
 SomeCollapsibleCategory:SetExpanded( 0 ) -- Expanded when popped up
 SomeCollapsibleCategory:SetLabel( "Симфиз" )

 CategoryList = vgui.Create( "DPanelList" )
 CategoryList:SetAutoSize( true )
 CategoryList:SetSpacing( 5 )
 CategoryList:EnableHorizontal( false )
 CategoryList:EnableVerticalScrollbar( true )

 SomeCollapsibleCategory:SetContents( CategoryList ) -- Add our list above us as the contents of the collapsible category

    local CategoryContentOne = vgui.Create( "DCheckBoxLabel" )
    CategoryContentOne:SetText( "Управление мышью" )
    CategoryContentOne:SetConVar( "cl_simfphys_mousesteer" )
    CategoryContentOne:SetValue( 0 )
    CategoryContentOne:SizeToContents()
CategoryList:AddItem( CategoryContentOne ) -- Add the above item to our list

    local CategoryContentTwo = vgui.Create( "DCheckBoxLabel" )
    CategoryContentTwo:SetText( "Включить Интерфейс" )
    CategoryContentTwo:SetConVar( "cl_simfphys_hud" )
    CategoryContentTwo:SetValue( 0 )
    CategoryContentTwo:SizeToContents()
CategoryList:AddItem( CategoryContentTwo )

    local CategoryContentThree = vgui.Create( "DCheckBoxLabel" )
    CategoryContentThree:SetText( "Зафиксировать камеру" )
    CategoryContentThree:SetConVar( "cl_simfphys_ms_lockedpitch" )
    CategoryContentThree:SetValue( 0 )
    CategoryContentThree:SizeToContents()
CategoryList:AddItem( CategoryContentThree )

    local CategoryContentFour = vgui.Create( "DCheckBoxLabel" )
    CategoryContentFour:SetText( "Включить упрощённый интерфейс" )
    CategoryContentFour:SetConVar( "cl_simfphys_althud" )
    CategoryContentFour:SetValue( 0 )
    CategoryContentFour:SizeToContents()
CategoryList:AddItem( CategoryContentFour )

    local CategoryContentFive = vgui.Create( "DCheckBoxLabel" )
    CategoryContentFive:SetText( "Отключить тени автомобиля" )
    CategoryContentFive:SetConVar( "cl_simfphys_shadows" )
    CategoryContentFive:SetValue( 0 )
    CategoryContentFive:SizeToContents()
CategoryList:AddItem( CategoryContentFive )

 local CategoryContentSix = vgui.Create( "DNumSlider" )
     CategoryContentSix:SetSize( 150, 50 ) -- Keep the second number at 50
     CategoryContentSix:SetText( "Мертвая зона" )
     CategoryContentSix:SetMin( 0 )
     CategoryContentSix:SetMax( 256 )
     CategoryContentSix:SetDecimals( 0 )
     CategoryContentSix:SetConVar( "cl_simfphys_ms_deadzone" )
 CategoryList:AddItem( CategoryContentSix )

 local CategoryContentSeven = vgui.Create( "DNumSlider" )
 		CategoryContentSeven:SetSize( 150, 50 ) -- Keep the second number at 50
 		CategoryContentSeven:SetText( "Чувствительность" )
 		CategoryContentSeven:SetMin( 0 )
 		CategoryContentSeven:SetMax( 256 )
 		CategoryContentSeven:SetDecimals( 0 )
 		CategoryContentSeven:SetConVar( "cl_simfphys_ms_sensitivity" )
 CategoryList:AddItem( CategoryContentSeven )

 local CategoryContentEight = vgui.Create( "DNumSlider" )
 	 CategoryContentEight:SetSize( 150, 50 ) -- Keep the second number at 50
 	 CategoryContentEight:SetText( "Cкорость возврата" )
 	 CategoryContentEight:SetMin( 0 )
 	 CategoryContentEight:SetMax( 256 )
 	 CategoryContentEight:SetDecimals( 0 )
 	 CategoryContentEight:SetConVar( "cl_simfphys_ms_return" )
 CategoryList:AddItem( CategoryContentEight )
PropertySheet:AddSheet( "Автомобиль",  SomeCollapsibleCategory, "icon16/car.png")


local SomeCollapsibleCategory = vgui.Create("DCollapsibleCategory", frame)
SomeCollapsibleCategory:SetPos( 25,50 )
SomeCollapsibleCategory:SetSize( 200, 50 ) -- Keep the second number at 50
SomeCollapsibleCategory:SetExpanded( 0 ) -- Expanded when popped up
SomeCollapsibleCategory:SetLabel( "Прицел" )

CategoryList = vgui.Create( "DPanelList" )
CategoryList:SetAutoSize( true )
CategoryList:SetSpacing( 5 )
CategoryList:EnableHorizontal( false )
CategoryList:EnableVerticalScrollbar( true )

SomeCollapsibleCategory:SetContents( CategoryList ) -- Add our list above us as the contents of the collapsible category

	 local CategoryContentOne = vgui.Create( "DCheckBoxLabel" )
	 CategoryContentOne:SetText( "Включить" )
	 CategoryContentOne:SetConVar( "crosshairdot_enabled")
	 CategoryContentOne:SetValue( 1 )
	 CategoryContentOne:SizeToContents()
CategoryList:AddItem( CategoryContentOne ) -- Add the above item to our list

	 local CategoryContentTwo = vgui.Create( "DCheckBoxLabel" )
	 CategoryContentTwo:SetText( "Обводка" )
	 CategoryContentTwo:SetConVar( "crosshairdot_enabled_outline" )
	 CategoryContentTwo:SetValue( 0 )
	 CategoryContentTwo:SizeToContents()
CategoryList:AddItem( CategoryContentTwo )



PropertySheet:AddSheet( "Пользователь",  SomeCollapsibleCategory, "icon16/user_gray.png")
	for k, v in pairs(buttons) do
		local Button = vgui.Create('DButton',Main)
		local x = v.x and 150 or 0

		k = v.x and k - 3 or k

		Button:SetPos(x,20+((k-1)*20)+70)
		Button:SetSize(550,20)
		Button:SetText( v.name )
		Button.DoClick = v.func
	end

	


end
    
	
function GM:ShowSpare1()    -- Window frame for the RichText
	TextFrame = vgui.Create("DFrame")
	TextFrame:SetSize(400, 400)
	TextFrame:AlignLeft()
	TextFrame:SetTitle("Правила")
	TextFrame:SetVisible( true )
	TextFrame:SetDraggable( true )
	TextFrame:ShowCloseButton( true )
	TextFrame:MakePopup()
	TextFrame:SetBackgroundBlur( true )-- Results in "Connection Refused - VAC"

-- RichText panel
	local richtext = vgui.Create("RichText", TextFrame)
	richtext:Dock(FILL)

-- Set the text to the message you get when VAC banned
richtext:AppendText( "Не используйте моды, программы и скрипты, дающие преимущество (читы, эксплойты, автокликеры, антиAFK и подобные). Также, при игре на сервере, в папке вашей игры не должно быть посторонних файлов, которые относятся к запрещенным;\n\n Не предоставляйте любую внутриигровую информацию о нахождении противника, вне рамок сервера, иначе к вам будут предъявлены санкции;\n\nНе используйте баги и недоработки и не скрывайте их. При обнаружении недоработок подайте тикет в баг-трекер;\n\nНе используйте аккаунты для обхода каких-либо серверных систем (система MedicMod, ServerGuard) для получения выгоды;\n\nНе транслируйте в голосовой чат и не включайте музыку или звуки, заведомо выбивающиеся из атмосферы и доставляющие дискомфорт игрокам. Например, чересчур сильные бассбустеды и прочее;\n\nНе спамьте в текстовый и голосовой чаты;\n\nНе рекламируйте что-либо в неролевых чатах;\n\nНе оскорбляйте других и не веди себя грубо в неролевых чатах;\n\nНе игнорируйте вопросы и просьбы администраторов, не грубите им;\n\nНе пытайтесь вводить администраторов в заблуждение, предоставляйте им лишь правдивую информацию;\n\nНе спорьте с решением администратора, лучше изложите проблему в жалобах;\n\nНе содействуйте совершаемым нарушениям правил сервера, не укрывайте важные факты о нарушениях от администрации. К укрывательству относятся те случаи, когда игрок, зная о том, что другой игрок нарушает правила, по каким-то причинам специально скрывает важные факты произошедшего перед администрацией;\n\nНе пытайтесь каким-либо способом обойти выданное наказание;\n\nНе покидайте разборки с администратором без его предварительного предупреждения и одобрения;\n\nНе копируйте и не используйте инициалы иных игроков и администраторов, чтобы не вводить других в заблуждение;\n\nНе обманывайте игроков на донатные услуги в процессе ролевого взаимодействия;" )



end
 