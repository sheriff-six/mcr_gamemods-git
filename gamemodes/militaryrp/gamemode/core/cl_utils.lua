local matrix = Matrix()
local matrixAngle = Angle(0, 0, 0)
local matrixScale = Vector(0, 0, 0)
local matrixTranslation = Vector(0, 0, 0)

function draw.TextRotated(text, font, x, y, xScale, yScale, angle, color, bshadow)
	render.PushFilterMag( TEXFILTER.LINEAR )
	render.PushFilterMin( TEXFILTER.LINEAR )
		matrix:SetTranslation( Vector( x, y ) )
		matrix:SetAngles( Angle( 0, angle, 0 ) )

		surface.SetFont( font )
		
		if bshadow then
			surface.SetTextColor( Color(0,0,0,90) )

			matrixScale.x = xScale
			matrixScale.y = yScale
			matrix:Scale(matrixScale)
			
			surface.SetTextPos(1, 1)
			
			cam.PushModelMatrix(matrix)
				surface.DrawText(text)
			cam.PopModelMatrix()
		end

		surface.SetTextColor( color )
		surface.SetTextPos(0, 0)
		
		cam.PushModelMatrix(matrix)
			surface.DrawText(text)
		cam.PopModelMatrix()
	render.PopFilterMag()
	render.PopFilterMin()
end

function draw.ShadowSimpleText( text, font, x, y, color, xalign, yalign, sh, color_shadow )
	local sh = sh or 1
	draw.SimpleText(text, font, x+sh, y+sh, color_shadow or Color(0,0,0,190), xalign, yalign)
	draw.SimpleText(text, font, x, y, color, xalign, yalign)
end

function draw.SimpleTextOutlined(text, font, x, y, colour, xalign, yalign, outlinewidth, outlinecolour)
	local steps = ( outlinewidth * 2 ) / 3
	if ( steps < 1 ) then steps = 1 end

	for _x = -outlinewidth, outlinewidth, steps do
		for _y = -outlinewidth, outlinewidth, steps do
			draw.SimpleText( text, font, x + _x, y + _y, outlinecolour, xalign, yalign )
		end
	end

	return draw.SimpleText( text, font, x, y, colour, xalign, yalign )
end

function draw.ShadowText(text, font, x, y, colortext, colorshadow, dist, xalign, yalign)
	draw.SimpleText(text, font, x + dist, y + dist, colorshadow, xalign, yalign)
	draw.SimpleText(text, font, x, y, colortext, xalign, yalign)
end

function draw.DrawPolyLine(tblVectors, tblColor)
	surface.SetDrawColor( tblColor )
	draw.NoTexture()
	surface.DrawPoly( tblVectors )
end

function draw.Icon( x, y, w, h, Mat, tblColor )
	surface.SetMaterial(Mat)
	surface.SetDrawColor(tblColor or Color(255,255,255,255))
	surface.DrawTexturedRect(x, y, w, h)
end

local blur = Material("pp/blurscreen", "noclamp")
function draw.DrawBlur(x, y, w, h, amount)
	render.ClearStencil()
	render.SetStencilEnable( true )
	render.SetStencilReferenceValue( 1 )
	render.SetStencilTestMask( 1 )
	render.SetStencilWriteMask( 1 )

	render.SetStencilCompareFunction( STENCILCOMPARISONFUNCTION_NEVER )
	render.SetStencilFailOperation( STENCILOPERATION_REPLACE )
	render.SetStencilPassOperation( STENCILOPERATION_REPLACE )
	render.SetStencilZFailOperation( STENCILOPERATION_REPLACE )

	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.DrawRect(x,y,w,h)

	render.SetStencilCompareFunction( STENCILCOMPARISONFUNCTION_EQUAL )
	render.SetStencilFailOperation( STENCILOPERATION_KEEP )
	render.SetStencilPassOperation( STENCILOPERATION_KEEP )
	render.SetStencilZFailOperation( STENCILOPERATION_KEEP )

	surface.SetMaterial( blur )
	surface.SetDrawColor( 255, 255, 255, 255 )

	for i = 0, 1, 0.33 do
		blur:SetFloat( '$blur', i * (amount or 0.2) )
		blur:Recompute()
		render.UpdateScreenEffectTexture()

		surface.DrawTexturedRect( 0, 0, ScrW(), ScrH() )
	end
	render.SetStencilEnable( false )
end

function draw.StencilBlur( panel, w, h )
	render.ClearStencil()
	render.SetStencilEnable( true )
	render.SetStencilReferenceValue( 1 )
	render.SetStencilTestMask( 1 )
	render.SetStencilWriteMask( 1 )

	render.SetStencilCompareFunction( STENCILCOMPARISONFUNCTION_NEVER )
	render.SetStencilFailOperation( STENCILOPERATION_REPLACE )
	render.SetStencilPassOperation( STENCILOPERATION_REPLACE )
	render.SetStencilZFailOperation( STENCILOPERATION_REPLACE )

	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.DrawRect( 0, 0, w, h )

	render.SetStencilCompareFunction( STENCILCOMPARISONFUNCTION_EQUAL )
	render.SetStencilFailOperation( STENCILOPERATION_KEEP )
	render.SetStencilPassOperation( STENCILOPERATION_KEEP )
	render.SetStencilZFailOperation( STENCILOPERATION_KEEP )

		surface.SetMaterial( blur )
		surface.SetDrawColor( 255, 255, 255, 255 )

		for i = 0, 1, 0.33 do
			blur:SetFloat( '$blur', 5 *i )
			blur:Recompute()
			render.UpdateScreenEffectTexture()

			local x, y = panel:GetPos()

			surface.DrawTexturedRect( -x, -y, ScrW(), ScrH() )
		end

	render.SetStencilEnable( false )
end