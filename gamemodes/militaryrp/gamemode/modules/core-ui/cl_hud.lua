surface.CreateFont("dbg-hud.normal", {font = "Calibri", extended = true, size = 27, weight = 350, shadow = true})
surface.CreateFont("dbg-hud.normal-sh", {font = "Calibri", extended = true, size = 27, blursize = 5, weight = 350})
surface.CreateFont("dbg-hud.small", {font = "Roboto", extended = true, size = 17, weight = 350, shadow = true})
surface.CreateFont("dbg-hud.small-sh", {font = "Roboto", extended = true, size = 17, blursize = 4, weight = 350})
surface.CreateFont("octoinv.3d", {font = "Arial Bold", extended = true, size = 18, weight = 300, antialias = true})
surface.CreateFont(
    "octoinv.3d-sh",
    {font = "Arial Bold", extended = true, size = 18, weight = 300, blursize = 5, antialias = true}
)

surface.CreateFont("HUDName", {
	size = 15,
   weight = 350,
   font = "Default"
})

surface.CreateFont("HUDName1", {
	size = 25,
   weight = 350,
   font = "CloseCaption_Bold"
})



local calph = ColorAlpha

local w, h = 181, 12

local color = {}
color.white = Color(255,255,255)
color.black = Color(30,30,30,200)

local alpha = 0
local cur_alpha = 100
function drawhud()
	local nameboxwidth = string.len(LocalPlayer():Nick()) * 6 + 10
    cur_alpha = Lerp(FrameTime() * 12, cur_alpha, alpha)
	local ply = LocalPlayer()
	local ang = LocalPlayer():GetAimVector():Angle().y
	
	-- Server
	draw.SimpleText( "Никнейм:", "dbg-hud.small", 20, 52, calph( color.white, cur_alpha), 0, 1, calph( color.black, cur_alpha))
	draw.SimpleText(ply:Nick(), "dbg-hud.small", 85, 52, calph( color.white, cur_alpha), 0, 1, calph( color.black, cur_alpha))
	draw.SimpleText( "Здоровье:", "dbg-hud.small", 20, 72, calph( color.white, cur_alpha), 0, 1, calph( color.black, cur_alpha))
	draw.SimpleText(ply:Health(), "dbg-hud.small", 90, 72, calph( color.white, cur_alpha), 0, 1, calph( color.black, cur_alpha))
	draw.SimpleText( "Броня:", "dbg-hud.small", 20, 92,calph( color.white, cur_alpha), 0, 1, calph( color.black, cur_alpha))
    draw.SimpleText( "Компас:", "dbg-hud.small", 20, 112, calph( color.white, cur_alpha), 0, 1, calph( color.black, cur_alpha))
	draw.SimpleText(ply:Armor(), "dbg-hud.small", 70, 92, calph( color.white, cur_alpha), 0, 1, calph( color.black, cur_alpha))

 --Clock
 if ply:Health() > 0 then
	surface.SetDrawColor( 255,255,255,255 )
	draw.SimpleText( os.date( "%d/%m/%Y" , Timestamp ), "dbg-hud.small", 20, 32, calph( color.white, cur_alpha), 0, 1, calph( color.black, cur_alpha))
 end
    --Compass
   if ply:Health() > 0 then
	draw.SimpleText(math.floor(361-(LocalPlayer():GetAngles().y%360)), "dbg-hud.small", 75, 112, calph( color.white, cur_alpha), 0, 1, calph( color.black, cur_alpha))
   surface.SetDrawColor( 255,255,255,255 )
end  
end

hook.Add( "HUDPaint",  "BSHUDPAINT", function()
	drawhud()
end)

hook.Add("HUDShouldDraw", "disableHUD", function(name)
	for k, v in pairs({"CHudHealth", "CHudBattery", "CHudSuitPower", "CHudAmmo", "CHudSecondaryAmmo"}) do
		if name == v then return false end
	end
end)


hook.Add('PlayerButtonDown', 'HUDButtonDown', function(pPlayer, kNum)
    if kNum == KEY_T then
        alpha = 200
    end
end)

hook.Add('PlayerButtonUp', 'HUDButtonUp', function(pPlayer, kNum)
    if kNum == KEY_T then
        alpha = 0
    end
end)

