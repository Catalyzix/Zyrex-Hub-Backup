--[[
Created by Zyrex#4338

Documentation:
library:CreateWindow(Name <string>)
Window:Toggle(Name <string>, Callback <function>)
Window:Button(Name <string>, Callback <function>)
Window:Slider(Name <string>, Min <number>, Max <number>, Callback <function>)
Window:Dropdown(Name <string>, List <table>, Callback <function>)
Window:Box(Name <string>, Callback <function>)
Window:Label(Name <string>)

This is open-sourced and free to use.
You may use it for your own scripts as long as you give credits.
--]]

_G.Toggle_GUI = _G.Toggle_GUI or Enum.KeyCode.RightControl

local library = {WindowCount = 0}

local function randomStr() 
    --I didn't create this function (not sure who did)
    local chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
    local length = 10
    local randomString = ''

    math.randomseed(os.time())

    charTable = {}
    for c in chars:gmatch"." do
        table.insert(charTable, c)
    end

    for i = 1, length do
        randomString = randomString .. charTable[math.random(1, #charTable)]
    end
    return randomString
end

local function makeDraggable(obj) 
    --Got this from devforums because I was lazy
    local UserInputService = game:GetService("UserInputService")

    local gui = obj
    
    local dragging
    local dragInput
    local dragStart
    local startPos
    
    local function update(input)
        local delta = input.Position - dragStart
        gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    
    gui.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = gui.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    gui.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui
ScreenGui.Name = tostring(randomStr())

local GuiToggled = false
local UIS = game:GetService("UserInputService")
UIS.InputBegan:Connect(function(v)
    if v.KeyCode == _G.Toggle_GUI then
        GuiToggled = not GuiToggled
        if GuiToggled == true then
            ScreenGui.Enabled = false
        else
            ScreenGui.Enabled = true
        end
    end
end)

function library:CreateWindow(Name)
    local Frame = Instance.new("Frame")
    local Header = Instance.new("Frame")
    local CloseButton = Instance.new("TextButton")
    local ObjectFrame = Instance.new("Frame")
    local UIListLayout = Instance.new("UIListLayout")
    local Line = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    library.WindowCount = library.WindowCount + 1
    
    Frame.Parent = ScreenGui
    Frame.BackgroundColor3 = Color3.fromRGB(47, 47, 47)
    Frame.BorderSizePixel = 0
    Frame.ClipsDescendants = false
    Frame.Position = UDim2.new(0, (32 + (177 * library.WindowCount) - 177), 0, 11)
    Frame.Size = UDim2.new(0, 171, 0, UIListLayout.AbsoluteContentSize.Y + 43)
    Frame.Name = Name
    makeDraggable(Frame)
    
    Header.Name = "Header"
    Header.Parent = Frame
    Header.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
    Header.BorderSizePixel = 0
    Header.Size = UDim2.new(0, 171, 0, 30)
    
    CloseButton.Name = "CloseButton"
    CloseButton.Parent = Header
    CloseButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.BackgroundTransparency = 1.000
    CloseButton.BorderSizePixel = 0
    CloseButton.Position = UDim2.new(0.824561417, 0, 0, 0)
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.Font = Enum.Font.Gotham
    CloseButton.Text = "-"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.TextSize = 20.000
    local CloseBtn = CloseButton
    local Toggled = true
    local Win = CloseBtn.Parent.Parent
    local Old = Win.Size.Y.Offset
    CloseBtn.MouseButton1Down:Connect(function()
        Toggled = not Toggled
        if Toggled == false then
            Win:TweenSize(UDim2.new(0, 171, 0, 30), "Out", "Quad", 0.5)
            CloseBtn.Text = "+"
            Frame.ClipsDescendants = true
        else
            Win:TweenSize(UDim2.new(0, 171, 0, Old), "Out", "Quad", 0.5)
            CloseBtn.Text = "-"
            wait(0.5)
            Frame.ClipsDescendants = false
        end
    end)
    
    ObjectFrame.Name = "ObjectFrame"
    ObjectFrame.Parent = Header
    ObjectFrame.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
    ObjectFrame.BackgroundTransparency = 1.000
    ObjectFrame.BorderSizePixel = 0
    ObjectFrame.ClipsDescendants = false
    ObjectFrame.Position = UDim2.new(0.0350000039, 0, 1.20125008, 0)
    ObjectFrame.Size = UDim2.new(0, 158, 0, 210)
    local ObjFrame = ObjectFrame
    local Win2 = ObjFrame.Parent.Parent
    local Offset = Win2.Size.Y.Offset
    ObjFrame.Size = UDim2.new(0, 158, 0, Offset - 45)
        
    UIListLayout.Parent = ObjectFrame
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 6)
    UIListLayout.HorizontalAlignment = "Right"
    
    Title.Name = "Title"
    Title.Parent = Header
    Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Title.BackgroundTransparency = 1.000
    Title.BorderSizePixel = 0
    Title.Size = UDim2.new(0, 171, 0, 31)
    Title.Font = Enum.Font.Gotham
    Title.Text = tostring(Name)
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 20.000
    function Update()
        Frame.Size = UDim2.new(0, 171, 0, UIListLayout.AbsoluteContentSize.Y + 43)
        Old = Win.Size.Y.Offset
        local ObjFrame = ObjectFrame
        local Win2 = ObjFrame.Parent.Parent
        local Offset = Win2.Size.Y.Offset
        ObjFrame.Size = UDim2.new(0, 158, 0, Offset - 43)
    end
    local Window = {}
    function Window:Button(Name, Callback)
        Name = Name or "Button"
        local Button = Instance.new("TextButton")
        local Round = Instance.new("ImageLabel")
        local TextLabel = Instance.new("TextLabel")
        
        Button.Name = "Button"
        Button.Parent = ObjectFrame
        Button.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
        Button.BackgroundTransparency = 1.000
        Button.BorderSizePixel = 0
        Button.Size = UDim2.new(0, 158, 0, 25)
        Button.Font = Enum.Font.Gotham
        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
        Button.TextSize = 14.000
        Button.ClipsDescendants = true
        
        Round.Name = "Round"
        Round.Parent = Button
        Round.Active = true
        Round.AnchorPoint = Vector2.new(0.5, 0.5)
        Round.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Round.BackgroundTransparency = 1.000
        Round.Position = UDim2.new(0.5, 0, 0.5, 0)
        Round.Selectable = true
        Round.Size = UDim2.new(1, 0, 1, 0)
        Round.Image = "rbxassetid://3570695787"
        Round.ImageColor3 = Color3.fromRGB(36, 36, 36)
        Round.ScaleType = Enum.ScaleType.Slice
        Round.SliceCenter = Rect.new(100, 100, 100, 100)
        Round.SliceScale = 0.030
        
        TextLabel.Parent = Button
        TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel.BackgroundTransparency = 1.000
        TextLabel.BorderSizePixel = 0
        TextLabel.Size = UDim2.new(0, 158, 0, 25)
        TextLabel.Font = Enum.Font.Gotham
        TextLabel.Text = Name
        TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel.TextSize = 13.000
        Update()
        local Mouse = game.Players.LocalPlayer:GetMouse()
        local function FireClick()
            spawn(function()
                local Circle = Instance.new("ImageLabel")
                Circle.Name = "Circle"
                Circle.Parent = Button
                Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Circle.BackgroundTransparency = 1.000
                Circle.ZIndex = 10
                Circle.Image = "rbxassetid://266543268"
                Circle.ImageColor3 = Color3.fromRGB(0, 0, 0)
                Circle.ImageTransparency = 0.500
                local NewX = Mouse.X - Circle.AbsolutePosition.X
                local NewY = Mouse.Y - Circle.AbsolutePosition.Y
                Circle.Position = UDim2.new(0, NewX, 0, NewY)
                local Size = 0
                if Button.AbsoluteSize.X > Button.AbsoluteSize.Y then
                    Size = Button.AbsoluteSize.X*1.5
                elseif Button.AbsoluteSize.X < Button.AbsoluteSize.Y then
                    Size = Button.AbsoluteSize.Y*1.5
                elseif Button.AbsoluteSize.X == Button.AbsoluteSize.Y then
                    Size = Button.AbsoluteSize.X*1.5
                end
                local Time = 0.5
                Circle:TweenSizeAndPosition(UDim2.new(0, Size, 0, Size), UDim2.new(0.5, -Size/2, 0.5, -Size/2), "Out", "Quad", Time, false, nil)
                for i = 1,10 do
                    Circle.ImageTransparency = Circle.ImageTransparency + 0.1
                    wait(Time/10)
                end
                Circle:Destroy()
            end)
            pcall(Callback)
        end
        Button.MouseButton1Click:Connect(FireClick)
    end
    function Window:Section(Name)
        Name = Name or "Section"

        local Label = Instance.new("TextLabel")
        local Line = Instance.new("Frame")
        local Line_2 = Instance.new("Frame")
        
        Label.Name = "Section"
        Label.Parent = ObjectFrame
        Label.BackgroundColor3 = Color3.fromRGB(47, 47, 47)
        Label.BackgroundTransparency = 1.000
        Label.BorderColor3 = Color3.fromRGB(36, 36, 36)
        Label.Size = UDim2.new(0, 158, 0, 25)
        Label.Font = Enum.Font.Gotham
        Label.TextColor3 = Color3.fromRGB(255, 255, 255)
        Label.TextSize = 13.000
        Label.Text = Name
        
        Line.Name = "Line"
        Line.Parent = Label
        Line.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
        Line.BorderSizePixel = 0
        Line.Position = UDim2.new(0, 0, 0.909999967, 0)
        Line.Size = UDim2.new(0, 158, 0, 2)
        
        Line_2.Name = "Line"
        Line_2.Parent = Label
        Line_2.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
        Line_2.BorderSizePixel = 0
        Line_2.Position = UDim2.new(0, 0, -0.0100000501, 0)
        Line_2.Size = UDim2.new(0, 158, 0, 2)
        Update()
    end
    function Window:Toggle(Name, Callback)
        Name = Name or "Toggle"

        local toggled = false

        local Toggle = Instance.new("TextButton")
        local Round = Instance.new("ImageLabel")
        local Text = Instance.new("TextLabel")
        
        Toggle.Name = "Toggle"
        Toggle.Parent = ObjectFrame
        Toggle.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
        Toggle.BackgroundTransparency = 1.000
        Toggle.BorderSizePixel = 0
        Toggle.Position = UDim2.new(0.841772139, 0, 0.223556861, 0)
        Toggle.Size = UDim2.new(0, 25, 0, 25)
        Toggle.Font = Enum.Font.Gotham
        Toggle.Text = ""
        Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
        Toggle.TextSize = 20.000
        
        Round.Name = "Round"
        Round.Parent = Toggle
        Round.Active = true
        Round.AnchorPoint = Vector2.new(0.5, 0.5)
        Round.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Round.BackgroundTransparency = 1.000
        Round.Position = UDim2.new(0.5, 0, 0.5, 0)
        Round.Selectable = true
        Round.Size = UDim2.new(0.999999762, 0, 1, 0)
        Round.Image = "rbxassetid://3570695787"
        Round.ImageColor3 = Color3.fromRGB(255, 60, 63)
        Round.ScaleType = Enum.ScaleType.Slice
        Round.SliceCenter = Rect.new(100, 100, 100, 100)
        Round.SliceScale = 0.030
        
        Text.Name = "Text"
        Text.Parent = Toggle
        Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Text.BackgroundTransparency = 1.000
        Text.BorderSizePixel = 0
        Text.Position = UDim2.new(-5.23999977, 0, 0, 0)
        Text.Size = UDim2.new(0, 131, 0, 25)
        Text.Font = Enum.Font.Gotham
        Text.Text = Name
        Text.TextColor3 = Color3.fromRGB(255, 255, 255)
        Text.TextSize = 13.000
        Text.TextXAlignment = Enum.TextXAlignment.Left
        Update()
        local function FireToggle()
            toggled = not toggled
            if toggled == false then
                local Green = Color3.fromRGB(85, 255, 127)
                local Red = Color3.fromRGB(255, 60, 63)
                spawn(function()
                    for i = 0, 1, 0.3 do
                        Round.ImageColor3 = Green:lerp(Red, i)
                        wait()
                    end
                    Round.ImageColor3 = Color3.fromRGB(255, 60, 63)
                end)
            else
                local Red = Color3.fromRGB(255, 60, 63)
                local Green = Color3.fromRGB(85, 255, 127)
                
                spawn(function()
                    for i = 0, 1, 0.3 do
                        Round.ImageColor3 = Red:lerp(Green, i)
                        wait()
                    end
                    Round.ImageColor3 = Color3.fromRGB(85, 255, 127)
                end)
            end
            pcall(Callback, toggled)
        end

        Toggle.MouseButton1Click:Connect(FireToggle)
    end
    function Window:Slider(Name, Min, Max, Callback)
        Name = Name or "Slider"
        Min = Min or 0
        Max = Max or 100
        Callback = Callback or function() end

        local TextLabel = Instance.new("TextLabel")
        local Slider = Instance.new("TextButton")
        local Round = Instance.new("ImageLabel")
        local Frame = Instance.new("ImageLabel")
        local TextLabel_2 = Instance.new("TextLabel")
        
        TextLabel.Parent = ObjectFrame
        TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel.BackgroundTransparency = 1.000
        TextLabel.BorderSizePixel = 0
        TextLabel.Position = UDim2.new(0.0126582282, 0, 0.475285172, 0)
        TextLabel.Size = UDim2.new(0, 156, 0, 25)
        TextLabel.Font = Enum.Font.Gotham
        TextLabel.Text = Name
        TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel.TextSize = 13.000
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left
        
        Slider.Name = "Slider"
        Slider.Parent = TextLabel
        Slider.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
        Slider.BackgroundTransparency = 1.000
        Slider.BorderSizePixel = 0
        Slider.Position = UDim2.new(0.56321013, 0, 0.199999988, 0)
        Slider.Size = UDim2.new(0, 68, 0, 15)
        Slider.Font = Enum.Font.Gotham
        Slider.Text = ""
        Slider.TextColor3 = Color3.fromRGB(255, 255, 255)
        Slider.TextSize = 14.000
        
        Round.Name = "Round"
        Round.Parent = Slider
        Round.Active = true
        Round.AnchorPoint = Vector2.new(0.5, 0.5)
        Round.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Round.BackgroundTransparency = 1.000
        Round.Position = UDim2.new(0.485294104, 0, 0.5, 0)
        Round.Selectable = true
        Round.Size = UDim2.new(1, 0, 1, 0)
        Round.Image = "rbxassetid://3570695787"
        Round.ImageColor3 = Color3.fromRGB(36, 36, 36)
        Round.ScaleType = Enum.ScaleType.Slice
        Round.SliceCenter = Rect.new(100, 100, 100, 100)
        Round.SliceScale = 0.030
        
        Frame.Name = "Frame"
        Frame.Parent = Slider
        Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Frame.BackgroundTransparency = 1.000
        Frame.Position = UDim2.new(-0.0147058824, 0, 0, 0)
        Frame.Size = UDim2.new(0, 0, 0, 15)
        Frame.Image = "rbxassetid://3570695787"
        Frame.ImageColor3 = Color3.fromRGB(26, 26, 26)
        Frame.ScaleType = Enum.ScaleType.Slice
        Frame.SliceCenter = Rect.new(100, 100, 100, 100)
        Frame.SliceScale = 0.030
        
        TextLabel_2.Parent = Slider
        TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel_2.BackgroundTransparency = 1.000
        TextLabel_2.BorderSizePixel = 0
        TextLabel_2.Position = UDim2.new(-0.0147058824, 0, 0, 0)
        TextLabel_2.Size = UDim2.new(0, 69, 0, 16)
        TextLabel_2.ZIndex = 2
        TextLabel_2.Font = Enum.Font.Gotham
        TextLabel_2.Text = Min
        TextLabel_2.TextColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel_2.TextSize = 13.000
        Update()
        local mouse = game.Players.LocalPlayer:GetMouse()
        local uis = game:GetService("UserInputService")
        local Value;
        Slider.MouseButton1Down:Connect(function()
            Value = math.floor((((tonumber(Max) - tonumber(Min)) / 68) * Frame.AbsoluteSize.X) + tonumber(Min)) or 0
            TextLabel_2.Text = Value
            pcall(function()
                Callback(Value)
            end)
            Frame.Size = UDim2.new(0, math.clamp(mouse.X - Frame.AbsolutePosition.X, 0, 68), 0, 15)
            moveconnection = mouse.Move:Connect(function()
                Value = math.floor((((tonumber(Max) - tonumber(Min)) / 68) * Frame.AbsoluteSize.X) + tonumber(Min))
                TextLabel_2.Text = Value
                pcall(function()
                    Callback(Value)
                end)
                Frame.Size = UDim2.new(0, math.clamp(mouse.X - Frame.AbsolutePosition.X, 0, 68), 0, 15)
            end)
            releaseconnection = uis.InputEnded:Connect(function(Mouse)
                if Mouse.UserInputType == Enum.UserInputType.MouseButton1 then
                    Value = math.floor((((tonumber(Max) - tonumber(Min)) / 68) * Frame.AbsoluteSize.X) + tonumber(Min))
                    TextLabel_2.Text = Value
                    pcall(function()
                        Callback(Value)
                    end)
                    Frame.Size = UDim2.new(0, math.clamp(mouse.X - Frame.AbsolutePosition.X, 0, 68), 0, 15)
                    moveconnection:Disconnect()
                    releaseconnection:Disconnect()
                end
            end)
        end)
    end
    function Window:Dropdown(Name, List, Callback)
        List = List or {}
        Name = Name or "Dropdown"
        Callback = Callback or function() end

        local Selected = List[1]
        local Dropdown = Instance.new("TextButton")
        local Round = Instance.new("ImageLabel")
        local Frame = Instance.new("ImageLabel")
        local UIListLayout = Instance.new("UIListLayout")
        local Label = Instance.new("TextLabel")
        local TextButton_2 = Instance.new("TextButton")
        local TextLabel = Instance.new("TextLabel")
        local TextLabel_2 = Instance.new("TextLabel")
        local TextLabel_3 = Instance.new("TextLabel")

        TextLabel_2.Parent = Dropdown
        TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel_2.BackgroundTransparency = 1.000
        TextLabel_2.BorderColor3 = Color3.fromRGB(27, 42, 53)
        TextLabel_2.Position = UDim2.new(0.838000059, 0, -0.0350000001, 0)
        TextLabel_2.Size = UDim2.new(0, 24, 0, 25)
        TextLabel_2.ZIndex = 4
        TextLabel_2.Font = Enum.Font.Gotham
        TextLabel_2.Text = "v"
        TextLabel_2.TextColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel_2.TextSize = 15.000

        TextLabel_3.Parent = Dropdown
        TextLabel_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel_3.BackgroundTransparency = 1.000
        TextLabel_3.BorderColor3 = Color3.fromRGB(27, 42, 53)
        TextLabel_3.Position = UDim2.new(0.838000059, 0, -0.0350000001, 0)
        TextLabel_3.Size = UDim2.new(0, 24, 0, 25)
        TextLabel_3.ZIndex = 5
        TextLabel_3.Font = Enum.Font.Gotham
        TextLabel_3.Text = "v"
        TextLabel_3.TextColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel_3.TextSize = 15.000
        
        Dropdown.Name = "Dropdown"
        Dropdown.Parent = ObjectFrame
        Dropdown.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
        Dropdown.BackgroundTransparency = 1.000
        Dropdown.BorderSizePixel = 0
        Dropdown.Position = UDim2.new(0, 0, 0.235741451, 0)
        Dropdown.Size = UDim2.new(0, 158, 0, 25)
        Dropdown.Font = Enum.Font.Gotham
        Dropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
        Dropdown.TextSize = 14.000
        
        Round.Name = "Round"
        Round.Parent = Dropdown
        Round.Active = true
        Round.AnchorPoint = Vector2.new(0.5, 0.5)
        Round.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Round.BackgroundTransparency = 1.000
        Round.Position = UDim2.new(0.5, 0, 0.5, 0)
        Round.Selectable = true
        Round.Size = UDim2.new(1, 0, 1, 0)
        Round.Image = "rbxassetid://3570695787"
        Round.ImageColor3 = Color3.fromRGB(36, 36, 36)
        Round.ScaleType = Enum.ScaleType.Slice
        Round.SliceCenter = Rect.new(100, 100, 100, 100)
        Round.SliceScale = 0.030
        
        Frame.Name = "Frame"
        Frame.Parent = Dropdown
        Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Frame.BackgroundTransparency = 1.000
        Frame.ClipsDescendants = true
        Frame.Size = UDim2.new(0, 158, 0, 76)
        Frame.Visible = false
        Frame.ZIndex = 3
        Frame.Image = "rbxassetid://3570695787"
        Frame.ImageColor3 = Color3.fromRGB(36, 36, 36)
        Frame.ScaleType = Enum.ScaleType.Slice
        Frame.SliceCenter = Rect.new(100, 100, 100, 100)
        Frame.SliceScale = 0.030
        
        UIListLayout.Parent = Frame
        UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        
        Label.Name = "Label"
        Label.Parent = Frame
        Label.BackgroundColor3 = Color3.fromRGB(47, 47, 47)
        Label.BackgroundTransparency = 1.000
        Label.BorderColor3 = Color3.fromRGB(36, 36, 36)
        Label.Size = UDim2.new(0, 158, 0, 25)
        Label.ZIndex = 4
        Label.Font = Enum.Font.Gotham
        Label.Text = Name
        Label.TextColor3 = Color3.fromRGB(108, 108, 108)
        Label.TextSize = 13.000
        
        TextLabel.Parent = Dropdown
        TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel.BackgroundTransparency = 1.000
        TextLabel.BorderSizePixel = 0
        TextLabel.Size = UDim2.new(0, 156, 0, 25)
        TextLabel.Font = Enum.Font.Gotham
        TextLabel.Text = List[1]
        TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel.TextSize = 13.000
    
        Update()

        for i,v in pairs(List) do
            local TextButton = Instance.new("TextButton")
            TextButton.Parent = Frame
            TextButton.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
            TextButton.BackgroundTransparency = 1.000
            TextButton.Position = UDim2.new(0, 0, 0.328947365, 0)
            TextButton.Size = UDim2.new(0, 158, 0, 25)
            TextButton.ZIndex = 3
            TextButton.Font = Enum.Font.Gotham
            TextButton.Text = v
            TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextButton.TextSize = 13.000
        end

        local DropDownBtn = Dropdown
        local IsToggled = false
        local DropFrame = DropDownBtn.Frame
        local ListOffset = DropDownBtn.Frame.UIListLayout.AbsoluteContentSize.Y

        DropFrame.Visible = false
        DropFrame.Size = UDim2.new(0, 158, 0, 25)

        for i,v in pairs(DropFrame:GetChildren()) do
            if v:IsA("TextButton") then
                v.MouseButton1Down:Connect(function()
                    DropFrame:TweenSize(UDim2.new(0, 158, 0, 25), "Out", "Quad", 0.5)
                    IsToggled = false
                    Selected = v.Text
                    TextLabel.Text = Selected
                    pcall(Callback, Selected)
                    wait(0.4)
                    DropFrame.Visible = false
                    TextLabel_2.Visible = true
                    TextLabel_3.Visible = false
                end)
            end
        end

        DropDownBtn.MouseButton1Down:Connect(function()
            IsToggled = not IsToggled
            if IsToggled == true then
                DropFrame:TweenSize(UDim2.new(0, 158, 0, ListOffset), "Out", "Quad", 0.5)
                DropFrame.Visible = true
                TextLabel_2.Visible = true
                TextLabel_3.Visible = false
            else
                DropFrame:TweenSize(UDim2.new(0, 158, 0, 25), "Out", "Quad", 0.5)
                wait(0.4)
                DropFrame.Visible = false
                TextLabel_2.Visible = true
                TextLabel_3.Visible = false
            end
        end)
    end
    function Window:Box(Name, Callback)
        local TextBox = Instance.new("TextBox")
        local Round = Instance.new("ImageLabel")
        local Text = Instance.new("TextLabel")
        
        TextBox.Parent = ObjectFrame
        TextBox.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
        TextBox.BackgroundTransparency = 1.000
        TextBox.BorderSizePixel = 0
        TextBox.Position = UDim2.new(0.562409997, 0, 0.353612155, 0)
        TextBox.Size = UDim2.new(0, 69, 0, 25)
        TextBox.ZIndex = 2
        TextBox.Font = Enum.Font.Gotham
        TextBox.PlaceholderText = ""
        TextBox.Text = ""
        TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
        TextBox.TextSize = 13.000
        
        Round.Name = "Round"
        Round.Parent = TextBox
        Round.Active = true
        Round.AnchorPoint = Vector2.new(0.5, 0.5)
        Round.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Round.BackgroundTransparency = 1.000
        Round.Position = UDim2.new(0.5, 0, 0.5, 0)
        Round.Selectable = true
        Round.Size = UDim2.new(1, 0, 1, 0)
        Round.Image = "rbxassetid://3570695787"
        Round.ImageColor3 = Color3.fromRGB(36, 36, 36)
        Round.ScaleType = Enum.ScaleType.Slice
        Round.SliceCenter = Rect.new(100, 100, 100, 100)
        Round.SliceScale = 0.030
        
        Text.Name = "Text"
        Text.Parent = TextBox
        Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Text.BackgroundTransparency = 1.000
        Text.BorderSizePixel = 0
        Text.Position = UDim2.new(-1.26086962, 0, 0, 0)
        Text.Size = UDim2.new(0, 78, 0, 25)
        Text.Font = Enum.Font.Gotham
        Text.Text = Name
        Text.TextColor3 = Color3.fromRGB(255, 255, 255)
        Text.TextSize = 13.000
        Text.TextXAlignment = Enum.TextXAlignment.Left
        Update()
        local function FireInput()
            if TextBox.Text ~= "" then
                Input = TextBox.Text
                pcall(Callback, Input)
            end
        end
        TextBox.FocusLost:Connect(FireInput)
    end
    function Window:Label(Name)
        Name = Name or "Label"
        local Label = Instance.new("TextLabel")

        Label.Name = "Label"
        Label.Parent = ObjectFrame
        Label.BackgroundColor3 = Color3.fromRGB(47, 47, 47)
        Label.BackgroundTransparency = 1.000
        Label.BorderColor3 = Color3.fromRGB(36, 36, 36)
        Label.Size = UDim2.new(0, 158, 0, 25)
        Label.Font = Enum.Font.Gotham
        Label.TextColor3 = Color3.fromRGB(255, 255, 255)
        Label.TextSize = 13.000
        Label.Text = Name
        Update()
    end
    return Window;
end
return library;
