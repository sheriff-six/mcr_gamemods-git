surface.CreateFont('CircleFont', {
    font = 'Roboto',
    size = 27, --Размер шрифта текста
    weight = 500, --Жирность текста
    extended = true
})

local progress = 0
local start = CurTime()
MGD = MGD or {}

function draw.Circle(x, y, radius, seg, rotate, time)
    local cir = {}

    table.insert(cir, {x = x, y = y, u = 0.5, v = 0.5})
    for i = 0, seg do
        local a = (i / seg - 1)
        if rotate then
            a = a * (-(CurTime() - MGD.CircleProgress.Start) / (time / 350)) * 1 
        else
            a = a * -360
        end

        a = math.rad(a)
        table.insert(
            cir,
            {
                x = x + math.sin(a) * radius,
                y = y + math.cos(a) * radius,
                u = math.sin(a) / 2 + 0.5,
                v = math.cos(a) / 2 + 0.5
            }
        )
    end

    local a = math.rad(0)
    table.insert(
        cir,
        {
            x = x + math.sin(a) * radius,
            y = y + math.cos(a) * radius,
            u = math.sin(a) / 2 + 0.5,
            v = math.cos(a) / 2 + 0.5
        }
    )

    surface.DrawPoly(cir)
end

function MGD.SetLoadingCircle(time, text)
    MGD.CircleProgress = {Time = time, Text = text, Start = CurTime()}
end

net.Receive("MGD.SendCircleTimer", function()
    local time = net.ReadInt(10)
    local text = net.ReadString()

    MGD.SetLoadingCircle(time, text)
end )

net.Receive("MGD.RemoveCircleTimer", function()
    MGD.CircleProgress = nil
end )

hook.Add("HUDPaint", "MGD.CircleProgress", function()
    if MGD.CircleProgress then
        if CurTime() < MGD.CircleProgress.Start + MGD.CircleProgress.Time then
            draw.NoTexture()

            surface.SetDrawColor(39, 39, 39) --Цвет фона
            draw.Circle(ScrW() / 2, ScrH() / 1.15, 25, 1000, false)
            surface.SetDrawColor(Color(231, 231, 231)) --Цвет круга
            draw.Circle(ScrW() / 2, ScrH() / 1.15, 22, 1000, true, MGD.CircleProgress.Time)
            
            if progress < 360 then
                draw.SimpleText(
                    MGD.CircleProgress.Text,
                    "CircleFont",
                    ScrW() / 2,
                    ScrH() / 1.1, --Высота текста относительно экрана (чем меньше число, тем ниже)
                    Color(231, 231, 231),
                    TEXT_ALIGN_CENTER
                )
            end
        end
    end
end )