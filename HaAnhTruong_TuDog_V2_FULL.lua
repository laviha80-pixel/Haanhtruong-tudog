--========================================================
-- HÀ ANH TRƯỜNG - TÚ DOG
-- V2 FULL
-- FLY JOYSTICK + SPEED + BRIGHTNESS 300
-- SHIFT LOCK + LOCATION + TELEPORT
-- WALLHOP + INVISIBLE + AIM + FPS
-- ANTI AFK + ANTI LAG
-- MINIMIZE + FLOAT BUTTON + KEY 2012
--========================================================

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Camera = workspace.CurrentCamera

--========================================================
-- CHARACTER
--========================================================

local Character
local Humanoid
local Root

local function GetCharacter()
    Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    Humanoid = Character:WaitForChild("Humanoid")
    Root = Character:WaitForChild("HumanoidRootPart")
end

GetCharacter()

--========================================================
-- SCREEN GUI
--========================================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HaAnhTruong_TuDog_V2"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui

--========================================================
-- BUTTON FUNCTION
--========================================================

local function CreateButton(Parent, Text, Position, Size)
    local Button = Instance.new("TextButton")
    Button.Size = Size
    Button.Position = Position
    Button.BackgroundColor3 = Color3.fromRGB(35,35,35)
    Button.BorderSizePixel = 0
    Button.Text = Text
    Button.TextColor3 = Color3.fromRGB(235,235,235)
    Button.TextSize = 12
    Button.Font = Enum.Font.GothamBold
    Button.AutoButtonColor = true
    Button.Active = true
    Button.Parent = Parent

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0,7)
    Corner.Parent = Button

    return Button
end

--========================================================
-- MAIN MENU
--========================================================

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.fromOffset(600,365)
Main.Position = UDim2.new(0.5,-300,0.5,-182)
Main.BackgroundColor3 = Color3.fromRGB(20,20,20)
Main.BorderSizePixel = 0
Main.Visible = false
Main.Active = true
Main.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0,10)
MainCorner.Parent = Main

--========================================================
-- TITLE
--========================================================

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,-90,0,40)
Title.Position = UDim2.fromOffset(10,0)
Title.BackgroundTransparency = 1
Title.Text = "HÀ ANH TRƯỜNG - TÚ DOG"
Title.TextColor3 = Color3.fromRGB(0,255,200)
Title.TextSize = 18
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 20
Title.Parent = Main

--========================================================
-- CLOSE / MINIMIZE
--========================================================

local CloseButton = CreateButton(
    Main,"X",
    UDim2.new(1,-40,0,6),
    UDim2.fromOffset(32,28)
)
CloseButton.TextColor3 = Color3.fromRGB(255,80,80)
CloseButton.TextSize = 15
CloseButton.ZIndex = 100

local MinimizeButton = CreateButton(
    Main,"_",
    UDim2.new(1,-78,0,6),
    UDim2.fromOffset(32,28)
)
MinimizeButton.ZIndex = 100

--========================================================
-- LEFT PANEL
--========================================================

local Left = Instance.new("Frame")
Left.Size = UDim2.fromOffset(280,315)
Left.Position = UDim2.fromOffset(10,42)
Left.BackgroundColor3 = Color3.fromRGB(27,27,27)
Left.BorderSizePixel = 0
Left.Parent = Main

local LeftCorner = Instance.new("UICorner")
LeftCorner.CornerRadius = UDim.new(0,8)
LeftCorner.Parent = Left

--========================================================
-- FLY
--========================================================

local FlyButton = CreateButton(
    Left,"FLY : OFF",
    UDim2.fromOffset(10,8),
    UDim2.fromOffset(260,30)
)

--========================================================
-- SPEED
--========================================================

local Speed = 70
local SpeedMin = 10
local SpeedMax = 1000

local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(1,-20,0,18)
SpeedLabel.Position = UDim2.fromOffset(10,42)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "Speed: 70"
SpeedLabel.TextColor3 = Color3.fromRGB(255,255,255)
SpeedLabel.TextSize = 12
SpeedLabel.Font = Enum.Font.GothamBold
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
SpeedLabel.Parent = Left

local SpeedMinus = CreateButton(
    Left,"-",
    UDim2.fromOffset(10,62),
    UDim2.fromOffset(55,28)
)

local SpeedPlus = CreateButton(
    Left,"+",
    UDim2.fromOffset(72,62),
    UDim2.fromOffset(55,28)
)

local SpeedFast = CreateButton(
    Left,"FAST",
    UDim2.fromOffset(134,62),
    UDim2.fromOffset(62,28)
)

local SpeedMaxButton = CreateButton(
    Left,"MAX",
    UDim2.fromOffset(204,62),
    UDim2.fromOffset(66,28)
)

SpeedPlus.TextColor3 = Color3.fromRGB(0,255,200)
SpeedMaxButton.TextColor3 = Color3.fromRGB(255,220,70)

SpeedMinus.Activated:Connect(function()
    Speed = math.max(SpeedMin,Speed-10)
    SpeedLabel.Text = "Speed: "..Speed
end)

SpeedPlus.Activated:Connect(function()
    Speed = math.min(SpeedMax,Speed+10)
    SpeedLabel.Text = "Speed: "..Speed
end)

SpeedFast.Activated:Connect(function()
    Speed = 300
    SpeedLabel.Text = "Speed: 300"
end)

SpeedMaxButton.Activated:Connect(function()
    Speed = 1000
    SpeedLabel.Text = "Speed: 1000"
end)

--========================================================
-- BRIGHTNESS
--========================================================

local BrightnessValue = 0
local BrightnessMax = 300

local OriginalBrightness = Lighting.Brightness
local OriginalExposure = Lighting.ExposureCompensation
local OriginalAmbient = Lighting.Ambient
local OriginalOutdoorAmbient = Lighting.OutdoorAmbient

local BrightnessLabel = Instance.new("TextLabel")
BrightnessLabel.Size = UDim2.new(1,-20,0,18)
BrightnessLabel.Position = UDim2.fromOffset(10,95)
BrightnessLabel.BackgroundTransparency = 1
BrightnessLabel.Text = "Brightness: 0"
BrightnessLabel.TextColor3 = Color3.fromRGB(255,255,255)
BrightnessLabel.TextSize = 12
BrightnessLabel.Font = Enum.Font.GothamBold
BrightnessLabel.TextXAlignment = Enum.TextXAlignment.Left
BrightnessLabel.Parent = Left

local BrightMinus = CreateButton(
    Left,"-",
    UDim2.fromOffset(10,115),
    UDim2.fromOffset(55,28)
)

local BrightPlus = CreateButton(
    Left,"+",
    UDim2.fromOffset(72,115),
    UDim2.fromOffset(55,28)
)

local BrightMax = CreateButton(
    Left,"MAX",
    UDim2.fromOffset(134,115),
    UDim2.fromOffset(65,28)
)

BrightPlus.TextColor3 = Color3.fromRGB(0,255,200)
BrightMax.TextColor3 = Color3.fromRGB(255,220,70)

local BrightnessFilter = Instance.new("ColorCorrectionEffect")
BrightnessFilter.Name = "HaAnhTruong_Brightness"
BrightnessFilter.Enabled = false
BrightnessFilter.Parent = Lighting

local function ApplyBrightness()
    local Alpha = BrightnessValue / BrightnessMax

    if BrightnessValue <= 0 then
        Lighting.Brightness = OriginalBrightness
        Lighting.ExposureCompensation = OriginalExposure
        Lighting.Ambient = OriginalAmbient
        Lighting.OutdoorAmbient = OriginalOutdoorAmbient
        BrightnessFilter.Enabled = false
        return
    end

    Lighting.Brightness = OriginalBrightness + Alpha * 10
    Lighting.ExposureCompensation = OriginalExposure + Alpha * 3

    local BrightAmbient = Color3.fromRGB(180,180,180)

    Lighting.Ambient = OriginalAmbient:Lerp(
        BrightAmbient,Alpha * 0.75
    )

    Lighting.OutdoorAmbient = OriginalOutdoorAmbient:Lerp(
        BrightAmbient,Alpha * 0.75
    )

    BrightnessFilter.Enabled = true
    BrightnessFilter.Brightness = Alpha * 0.18
    BrightnessFilter.Contrast = 0
    BrightnessFilter.Saturation = 0
end

BrightMinus.Activated:Connect(function()
    BrightnessValue = math.max(0,BrightnessValue-10)
    BrightnessLabel.Text = "Brightness: "..BrightnessValue
    ApplyBrightness()
end)

BrightPlus.Activated:Connect(function()
    BrightnessValue = math.min(300,BrightnessValue+10)
    BrightnessLabel.Text = "Brightness: "..BrightnessValue
    ApplyBrightness()
end)

BrightMax.Activated:Connect(function()
    BrightnessValue = 300
    BrightnessLabel.Text = "Brightness: 300"
    ApplyBrightness()
end)

--========================================================
-- SHIFT LOCK / LOCATION
--========================================================

local ShiftButton = CreateButton(
    Left,"SHIFT LOCK : OFF",
    UDim2.fromOffset(10,150),
    UDim2.fromOffset(125,30)
)

local LocationButton = CreateButton(
    Left,"LOCATION : OFF",
    UDim2.fromOffset(145,150),
    UDim2.fromOffset(125,30)
)

--========================================================
-- INVISIBLE / WALLHOP
--========================================================

local InvisibleButton = CreateButton(
    Left,"INVISIBLE : OFF",
    UDim2.fromOffset(10,185),
    UDim2.fromOffset(125,30)
)

local WallHopButton = CreateButton(
    Left,"WALLHOP : OFF",
    UDim2.fromOffset(145,185),
    UDim2.fromOffset(125,30)
)

--========================================================
-- FPS / AIM
--========================================================

local FPSLabel = Instance.new("TextLabel")
FPSLabel.Size = UDim2.fromOffset(125,25)
FPSLabel.Position = UDim2.fromOffset(10,220)
FPSLabel.BackgroundTransparency = 1
FPSLabel.Text = "FPS: --"
FPSLabel.TextColor3 = Color3.fromRGB(0,255,200)
FPSLabel.TextSize = 12
FPSLabel.Font = Enum.Font.GothamBold
FPSLabel.TextXAlignment = Enum.TextXAlignment.Left
FPSLabel.Parent = Left

local AimButton = CreateButton(
    Left,"AIM : OFF",
    UDim2.fromOffset(145,217),
    UDim2.fromOffset(125,30)
)

--========================================================
-- ANTI AFK / ANTI LAG
--========================================================

local AntiAFKButton = CreateButton(
    Left,"ANTI AFK : ON",
    UDim2.fromOffset(10,250),
    UDim2.fromOffset(125,30)
)

local AntiLagButton = CreateButton(
    Left,"ANTI LAG : OFF",
    UDim2.fromOffset(145,250),
    UDim2.fromOffset(125,30)
)

--========================================================
-- RIGHT PANEL
--========================================================

local Right = Instance.new("Frame")
Right.Size = UDim2.fromOffset(290,315)
Right.Position = UDim2.fromOffset(300,42)
Right.BackgroundColor3 = Color3.fromRGB(27,27,27)
Right.BorderSizePixel = 0
Right.Parent = Main

local RightCorner = Instance.new("UICorner")
RightCorner.CornerRadius = UDim.new(0,8)
RightCorner.Parent = Right

--========================================================
-- SELECTED PLAYER
--========================================================

local SelectedPlayer = nil

local SelectedLabel = Instance.new("TextLabel")
SelectedLabel.Size = UDim2.new(1,-20,0,25)
SelectedLabel.Position = UDim2.fromOffset(10,8)
SelectedLabel.BackgroundTransparency = 1
SelectedLabel.Text = "Selected: None"
SelectedLabel.TextColor3 = Color3.fromRGB(0,255,200)
SelectedLabel.TextSize = 12
SelectedLabel.Font = Enum.Font.GothamBold
SelectedLabel.TextXAlignment = Enum.TextXAlignment.Left
SelectedLabel.Parent = Right

--========================================================
-- PLAYER LIST
--========================================================

local PlayerList = Instance.new("ScrollingFrame")
PlayerList.Size = UDim2.new(1,-20,1,-85)
PlayerList.Position = UDim2.fromOffset(10,35)
PlayerList.BackgroundColor3 = Color3.fromRGB(18,18,18)
PlayerList.BorderSizePixel = 0
PlayerList.ScrollBarThickness = 4
PlayerList.CanvasSize = UDim2.fromOffset(0,0)
PlayerList.Parent = Right

local ListLayout = Instance.new("UIListLayout")
ListLayout.Padding = UDim.new(0,4)
ListLayout.Parent = PlayerList

local function UpdateCanvas()
    PlayerList.CanvasSize = UDim2.fromOffset(
        0,
        ListLayout.AbsoluteContentSize.Y + 5
    )
end

ListLayout:GetPropertyChangedSignal(
    "AbsoluteContentSize"
):Connect(UpdateCanvas)

local function RefreshPlayers()

    for _,Object in ipairs(PlayerList:GetChildren()) do
        if Object:IsA("TextButton") then
            Object:Destroy()
        end
    end

    for _,Player in ipairs(Players:GetPlayers()) do

        if Player ~= LocalPlayer then

            local Button = CreateButton(
                PlayerList,
                Player.DisplayName.."  @"..Player.Name,
                UDim2.new(),
                UDim2.new(1,-5,0,30)
            )

            Button.Activated:Connect(function()
                SelectedPlayer = Player
                SelectedLabel.Text =
                    "Selected: "..Player.Name
            end)

        end

    end

    UpdateCanvas()
end

RefreshPlayers()

Players.PlayerAdded:Connect(RefreshPlayers)

Players.PlayerRemoving:Connect(function(Player)

    if SelectedPlayer == Player then
        SelectedPlayer = nil
        SelectedLabel.Text = "Selected: None"
    end

    RefreshPlayers()
end)

--========================================================
-- TELEPORT
--========================================================

local TeleportButton = CreateButton(
    Right,
    "TELEPORT TO SELECTED",
    UDim2.fromOffset(10,275),
    UDim2.fromOffset(270,30)
)

TeleportButton.TextColor3 =
    Color3.fromRGB(255,220,70)

TeleportButton.Activated:Connect(function()

    if not SelectedPlayer then
        return
    end

    local TargetCharacter =
        SelectedPlayer.Character

    if not TargetCharacter then
        return
    end

    local TargetRoot =
        TargetCharacter:FindFirstChild(
            "HumanoidRootPart"
        )

    if not TargetRoot then
        return
    end

    if not Root then
        GetCharacter()
    end

    Root.CFrame =
        TargetRoot.CFrame *
        CFrame.new(0,0,4)

end)

--========================================================
-- FLY
--========================================================

local Flying = false
local FlyVelocity
local FlyGyro

local function StopFly()

    Flying = false

    if FlyVelocity then
        FlyVelocity:Destroy()
        FlyVelocity = nil
    end

    if FlyGyro then
        FlyGyro:Destroy()
        FlyGyro = nil
    end

    FlyButton.Text = "FLY : OFF"
    FlyButton.TextColor3 =
        Color3.fromRGB(230,230,230)

end

local function StartFly()

    if not Root then
        GetCharacter()
    end

    Flying = true

    FlyVelocity =
        Instance.new("BodyVelocity")

    FlyVelocity.MaxForce =
        Vector3.new(
            math.huge,
            math.huge,
            math.huge
        )

    FlyVelocity.Velocity =
        Vector3.zero

    FlyVelocity.Parent = Root

    FlyGyro =
        Instance.new("BodyGyro")

    FlyGyro.MaxTorque =
        Vector3.new(
            math.huge,
            math.huge,
            math.huge
        )

    FlyGyro.P = 90000
    FlyGyro.CFrame = Root.CFrame
    FlyGyro.Parent = Root

    FlyButton.Text = "FLY : ON"
    FlyButton.TextColor3 =
        Color3.fromRGB(0,255,200)

end

FlyButton.Activated:Connect(function()

    if Flying then
        StopFly()
    else
        StartFly()
    end

end)

--========================================================
-- MOBILE UP / DOWN
--========================================================

local UpButton = CreateButton(
    ScreenGui,
    "↑",
    UDim2.new(1,-130,1,-170),
    UDim2.fromOffset(55,55)
)

local DownButton = CreateButton(
    ScreenGui,
    "↓",
    UDim2.new(1,-130,1,-105),
    UDim2.fromOffset(55,55)
)

UpButton.TextSize = 24
DownButton.TextSize = 24

UpButton.Visible = false
DownButton.Visible = false

local UpHeld = false
local DownHeld = false

UpButton.MouseButton1Down:Connect(function()
    UpHeld = true
end)

UpButton.MouseButton1Up:Connect(function()
    UpHeld = false
end)

UpButton.MouseLeave:Connect(function()
    UpHeld = false
end)

DownButton.MouseButton1Down:Connect(function()
    DownHeld = true
end)

DownButton.MouseButton1Up:Connect(function()
    DownHeld = false
end)

DownButton.MouseLeave:Connect(function()
    DownHeld = false
end)

--========================================================
-- FLY MOVEMENT - JOYSTICK
--========================================================

RunService.RenderStepped:Connect(function()

    if not Flying then
        return
    end

    if not Root or not Root.Parent then
        return
    end

    if not Humanoid then
        return
    end

    local MoveDirection =
        Humanoid.MoveDirection

    local Move = Vector3.zero

    if MoveDirection.Magnitude > 0 then
        Move = MoveDirection * Speed
    end

    if UIS:IsKeyDown(Enum.KeyCode.Space)
        or UpHeld then

        Move += Vector3.new(
            0,Speed,0
        )

    end

    if UIS:IsKeyDown(Enum.KeyCode.LeftControl)
        or UIS:IsKeyDown(Enum.KeyCode.C)
        or UIS:IsKeyDown(Enum.KeyCode.Down)
        or DownHeld then

        Move -= Vector3.new(
            0,Speed,0
        )

    end

    FlyVelocity.Velocity = Move

    local Look =
        Camera.CFrame.LookVector

    local FlatLook =
        Vector3.new(
            Look.X,
            0,
            Look.Z
        )

    if FlatLook.Magnitude > 0 then

        FlyGyro.CFrame =
            CFrame.lookAt(
                Root.Position,
                Root.Position + FlatLook.Unit
            )

    end

end)

--========================================================
-- SHIFT LOCK
--========================================================

local ShiftLock = false

ShiftButton.Activated:Connect(function()

    ShiftLock = not ShiftLock

    if ShiftLock then

        ShiftButton.Text =
            "SHIFT LOCK : ON"

        ShiftButton.TextColor3 =
            Color3.fromRGB(0,255,200)

    else

        ShiftButton.Text =
            "SHIFT LOCK : OFF"

        ShiftButton.TextColor3 =
            Color3.fromRGB(230,230,230)

        if Humanoid then
            Humanoid.AutoRotate = true
        end

    end

end)

RunService.RenderStepped:Connect(function()

    if not ShiftLock then
        return
    end

    if not Root or not Humanoid then
        return
    end

    Humanoid.AutoRotate = false

    local Look =
        Camera.CFrame.LookVector

    local Flat =
        Vector3.new(
            Look.X,
            0,
            Look.Z
        )

    if Flat.Magnitude > 0 then

        Root.CFrame =
            CFrame.lookAt(
                Root.Position,
                Root.Position + Flat.Unit
            )

    end

end)

--========================================================
-- LOCATION
--========================================================

local LocationEnabled = false

local function RemoveLocation(Player)

    local TargetCharacter =
        Player.Character

    if not TargetCharacter then
        return
    end

    local TargetRoot =
        TargetCharacter:FindFirstChild(
            "HumanoidRootPart"
        )

    if not TargetRoot then
        return
    end

    local Old =
        TargetRoot:FindFirstChild(
            "HaAnhTruong_Location"
        )

    if Old then
        Old:Destroy()
    end

end

local function AddLocation(Player)

    if Player == LocalPlayer then
        return
    end

    local TargetCharacter =
        Player.Character

    if not TargetCharacter then
        return
    end

    local TargetRoot =
        TargetCharacter:FindFirstChild(
            "HumanoidRootPart"
        )

    if not TargetRoot then
        return
    end

    RemoveLocation(Player)

    local Billboard =
        Instance.new("BillboardGui")

    Billboard.Name =
        "HaAnhTruong_Location"

    Billboard.Size =
        UDim2.fromOffset(170,35)

    Billboard.StudsOffset =
        Vector3.new(0,3,0)

    Billboard.AlwaysOnTop = true
    Billboard.Parent = TargetRoot

    local Label =
        Instance.new("TextLabel")

    Label.Size =
        UDim2.fromScale(1,1)

    Label.BackgroundTransparency = 1

    Label.TextColor3 =
        Color3.fromRGB(255,255,255)

    Label.TextStrokeTransparency = 0

    Label.TextSize = 12

    Label.Font =
        Enum.Font.GothamBold

    Label.Parent = Billboard

    task.spawn(function()

        while LocationEnabled
            and Billboard.Parent do

            if Root
                and Root.Parent
                and TargetRoot.Parent then

                local Distance =
                    (
                        Root.Position -
                        TargetRoot.Position
                    ).Magnitude

                Label.Text =
                    Player.DisplayName ..
                    " [" ..
                    math.floor(Distance) ..
                    "m]"

            end

            task.wait(0.2)

        end

    end)

end

local function UpdateLocations()

    for _,Player in ipairs(
        Players:GetPlayers()
    ) do

        if Player ~= LocalPlayer then

            if LocationEnabled then
                AddLocation(Player)
            else
                RemoveLocation(Player)
            end

        end

    end

end

LocationButton.Activated:Connect(function()

    LocationEnabled =
        not LocationEnabled

    if LocationEnabled then

        LocationButton.Text =
            "LOCATION : ON"

        LocationButton.TextColor3 =
            Color3.fromRGB(0,255,200)

    else

        LocationButton.Text =
            "LOCATION : OFF"

        LocationButton.TextColor3 =
            Color3.fromRGB(230,230,230)

    end

    UpdateLocations()

end)

Players.PlayerAdded:Connect(function(Player)

    Player.CharacterAdded:Connect(function()

        task.wait(1)

        if LocationEnabled then
            AddLocation(Player)
        end

    end)

end)

--========================================================
-- INVISIBLE
--========================================================

local Invisible = false
local SavedTransparency = {}
local InvisibleDot

local function SetInvisible(State)

    Invisible = State

    if not Character then
        return
    end

    for _,Object in ipairs(
        Character:GetDescendants()
    ) do

        if Object:IsA("BasePart") then

            if Object ~= Root then

                if State then

                    if SavedTransparency[Object] == nil then
                        SavedTransparency[Object] =
                            Object.LocalTransparencyModifier
                    end

                    Object.LocalTransparencyModifier = 1

                else

                    Object.LocalTransparencyModifier =
                        SavedTransparency[Object] or 0

                end

            end

        elseif Object:IsA("Decal")
            or Object:IsA("Texture") then

            if State then

                if SavedTransparency[Object] == nil then
                    SavedTransparency[Object] =
                        Object.Transparency
                end

                Object.Transparency = 1

            else

                Object.Transparency =
                    SavedTransparency[Object] or 0

            end

        end

    end

    if State then

        if InvisibleDot then
            InvisibleDot:Destroy()
        end

        InvisibleDot =
            Instance.new("BillboardGui")

        InvisibleDot.Name =
            "HaAnhTruong_InvisibleDot"

        InvisibleDot.Size =
            UDim2.fromOffset(6,6)

        InvisibleDot.AlwaysOnTop = true
        InvisibleDot.Parent = Root

        local Dot =
            Instance.new("Frame")

        Dot.Size =
            UDim2.fromScale(1,1)

        Dot.BackgroundColor3 =
            Color3.fromRGB(255,0,0)

        Dot.BorderSizePixel = 0
        Dot.Parent = InvisibleDot

        local Corner =
            Instance.new("UICorner")

        Corner.CornerRadius =
            UDim.new(1,0)

        Corner.Parent = Dot

    else

        if InvisibleDot then
            InvisibleDot:Destroy()
            InvisibleDot = nil
        end

    end

end

InvisibleButton.Activated:Connect(function()

    Invisible =
        not Invisible

    if Invisible then

        InvisibleButton.Text =
            "INVISIBLE : ON"

        InvisibleButton.TextColor3 =
            Color3.fromRGB(0,255,200)

    else

        InvisibleButton.Text =
            "INVISIBLE : OFF"

        InvisibleButton.TextColor3 =
            Color3.fromRGB(230,230,230)

    end

    SetInvisible(Invisible)

end)

--========================================================
-- WALLHOP
--========================================================

local WallHop = false

WallHopButton.Activated:Connect(function()

    WallHop =
        not WallHop

    if WallHop then

        WallHopButton.Text =
            "WALLHOP : ON"

        WallHopButton.TextColor3 =
            Color3.fromRGB(0,255,200)

    else

        WallHopButton.Text =
            "WALLHOP : OFF"

        WallHopButton.TextColor3 =
            Color3.fromRGB(230,230,230)

    end

end)

UIS.JumpRequest:Connect(function()

    if not WallHop then
        return
    end

    if not Root or not Humanoid then
        return
    end

    local Params =
        RaycastParams.new()

    Params.FilterType =
        Enum.RaycastFilterType.Exclude

    Params.FilterDescendantsInstances =
        {Character}

    local Directions = {

        Root.CFrame.RightVector,
        -Root.CFrame.RightVector,
        Root.CFrame.LookVector,
        -Root.CFrame.LookVector

    }

    for _,Direction in ipairs(
        Directions
    ) do

        local Result =
            workspace:Raycast(
                Root.Position,
                Direction * 3,
                Params
            )

        if Result then

            Root.AssemblyLinearVelocity =
                Vector3.new(
                    Root.AssemblyLinearVelocity.X,
                    55,
                    Root.AssemblyLinearVelocity.Z
                )

            Root.AssemblyLinearVelocity +=
                Result.Normal * 35

            break

        end

    end

end)

--========================================================
-- AIM
--========================================================

local Aim = false

AimButton.Activated:Connect(function()

    Aim = not Aim

    if Aim then

        AimButton.Text = "AIM : ON"

        AimButton.TextColor3 =
            Color3.fromRGB(0,255,200)

        Camera.CameraType =
            Enum.CameraType.Custom

        Camera.CameraSubject =
            Humanoid

    else

        AimButton.Text = "AIM : OFF"

        AimButton.TextColor3 =
            Color3.fromRGB(230,230,230)

    end

end)

RunService.RenderStepped:Connect(function()

    if not Aim then
        return
    end

    if not Root then
        return
    end

    local Viewport =
        Camera.ViewportSize

    local Center =
        Vector2.new(
            Viewport.X / 2,
            Viewport.Y / 2
        )

    local BestHead = nil
    local BestDistance = math.huge

    for _,Player in ipairs(
        Players:GetPlayers()
    ) do

        if Player ~= LocalPlayer
            and Player.Character then

            local TargetHumanoid =
                Player.Character:
                FindFirstChildOfClass(
                    "Humanoid"
                )

            local Head =
                Player.Character:
                FindFirstChild("Head")

            if TargetHumanoid
                and Head
                and TargetHumanoid.Health > 0 then

                local ScreenPosition,
                    OnScreen =
                    Camera:
                    WorldToViewportPoint(
                        Head.Position
                    )

                if OnScreen
                    and ScreenPosition.Z > 0 then

                    local Distance =
                        (
                            Vector2.new(
                                ScreenPosition.X,
                                ScreenPosition.Y
                            ) - Center
                        ).Magnitude

                    if Distance <
                        BestDistance then

                        BestDistance =
                            Distance

                        BestHead =
                            Head

                    end

                end

            end

        end

    end

    if BestHead then

        local Direction =
            BestHead.Position -
            Root.Position

        local Flat =
            Vector3.new(
                Direction.X,
                0,
                Direction.Z
            )

        if Flat.Magnitude > 0 then

            Root.CFrame =
                CFrame.lookAt(
                    Root.Position,
                    Root.Position +
                    Flat.Unit
                )

        end

    end

end)

--========================================================
-- FPS
--========================================================

local Frames = 0
local LastFPS = tick()

RunService.RenderStepped:Connect(function()

    Frames += 1

    local Now = tick()

    if Now - LastFPS >= 1 then

        FPSLabel.Text =
            "FPS: "..Frames

        Frames = 0
        LastFPS = Now

    end

end)

--========================================================
-- ANTI AFK
--========================================================

local AntiAFK = true

LocalPlayer.Idled:Connect(function()

    if not AntiAFK then
        return
    end

    VirtualUser:CaptureController()

    VirtualUser:ClickButton2(
        Vector2.new(0,0)
    )

end)

AntiAFKButton.Activated:Connect(function()

    AntiAFK =
        not AntiAFK

    if AntiAFK then

        AntiAFKButton.Text =
            "ANTI AFK : ON"

        AntiAFKButton.TextColor3 =
            Color3.fromRGB(0,255,200)

    else

        AntiAFKButton.Text =
            "ANTI AFK : OFF"

        AntiAFKButton.TextColor3 =
            Color3.fromRGB(230,230,230)

    end

end)

--========================================================
-- ANTI LAG
--========================================================

local AntiLag = false
local SavedEffects = {}

local GrayFilter =
    Instance.new("ColorCorrectionEffect")

GrayFilter.Name =
    "HaAnhTruong_Gray"

GrayFilter.Saturation = -1
GrayFilter.Contrast = 0
GrayFilter.Brightness = 0
GrayFilter.TintColor =
    Color3.new(1,1,1)

GrayFilter.Enabled = false
GrayFilter.Parent = Lighting

local function HandleEffect(
    Object,
    Disable
)

    if not (
        Object:IsA("ParticleEmitter")
        or Object:IsA("Trail")
        or Object:IsA("Beam")
        or Object:IsA("Smoke")
        or Object:IsA("Fire")
        or Object:IsA("Sparkles")
    ) then
        return
    end

    if Disable then

        if SavedEffects[Object] == nil then
            SavedEffects[Object] =
                Object.Enabled
        end

        Object.Enabled = false

    else

        if SavedEffects[Object] ~= nil then

            Object.Enabled =
                SavedEffects[Object]

            SavedEffects[Object] = nil

        end

    end

end

local function ApplyAntiLag()

    for _,Object in ipairs(
        workspace:GetDescendants()
    ) do

        HandleEffect(
            Object,
            AntiLag
        )

    end

    GrayFilter.Enabled =
        AntiLag

end

workspace.DescendantAdded:Connect(function(Object)

    if AntiLag then

        task.wait()

        HandleEffect(
            Object,
            true
        )

    end

end)

AntiLagButton.Activated:Connect(function()

    AntiLag =
        not AntiLag

    if AntiLag then

        AntiLagButton.Text =
            "ANTI LAG : ON"

        AntiLagButton.TextColor3 =
            Color3.fromRGB(0,255,200)

    else

        AntiLagButton.Text =
            "ANTI LAG : OFF"

        AntiLagButton.TextColor3 =
            Color3.fromRGB(230,230,230)

    end

    ApplyAntiLag()

end)

--========================================================
-- MINIMIZE
--========================================================

local Minimized = false

MinimizeButton.Activated:Connect(function()

    Minimized =
        not Minimized

    if Minimized then

        Main.Size =
            UDim2.fromOffset(
                600,45
            )

        Left.Visible = false
        Right.Visible = false

        MinimizeButton.Text = "+"

    else

        Main.Size =
            UDim2.fromOffset(
                600,365
            )

        Left.Visible = true
        Right.Visible = true

        MinimizeButton.Text = "_"

    end

end)

--========================================================
-- DRAG BAR
-- CHỈ KÉO THANH TIÊU ĐỀ
--========================================================

local DragBar =
    Instance.new("Frame")

DragBar.Name = "DragBar"
DragBar.Size =
    UDim2.new(1,-90,0,40)

DragBar.Position =
    UDim2.fromOffset(0,0)

DragBar.BackgroundTransparency = 1
DragBar.Active = true
DragBar.ZIndex = 50
DragBar.Parent = Main

local Dragging = false
local DragStart
local StartPosition

DragBar.InputBegan:Connect(function(Input)

    if Input.UserInputType ==
        Enum.UserInputType.MouseButton1
        or Input.UserInputType ==
        Enum.UserInputType.Touch then

        Dragging = true

        DragStart =
            Input.Position

        StartPosition =
            Main.Position

    end

end)

DragBar.InputEnded:Connect(function(Input)

    if Input.UserInputType ==
        Enum.UserInputType.MouseButton1
        or Input.UserInputType ==
        Enum.UserInputType.Touch then

        Dragging = false

    end

end)

UIS.InputChanged:Connect(function(Input)

    if not Dragging then
        return
    end

    if Input.UserInputType ==
        Enum.UserInputType.MouseMovement
        or Input.UserInputType ==
        Enum.UserInputType.Touch then

        local Delta =
            Input.Position -
            DragStart

        Main.Position =
            UDim2.new(
                StartPosition.X.Scale,
                StartPosition.X.Offset + Delta.X,
                StartPosition.Y.Scale,
                StartPosition.Y.Offset + Delta.Y
            )

    end

end)

--========================================================
-- CLOSE MENU
--========================================================

CloseButton.Activated:Connect(function()

    Main.Visible = false

end)

--========================================================
-- FLOAT BUTTON
--========================================================

local FloatButton =
    CreateButton(
        ScreenGui,
        "☰",
        UDim2.new(
            0.5,-27.5,
            0,75
        ),
        UDim2.fromOffset(55,55)
    )

FloatButton.TextSize = 20
FloatButton.TextColor3 =
    Color3.fromRGB(0,255,200)

FloatButton.ZIndex = 200

FloatButton.Activated:Connect(function()

    Main.Visible = true

end)

--========================================================
-- FLY BUTTONS VISIBILITY
--========================================================

task.spawn(function()

    while ScreenGui.Parent do

        UpButton.Visible = Flying
        DownButton.Visible = Flying

        task.wait(0.1)

    end

end)

--========================================================
-- RESPAWN
--========================================================

LocalPlayer.CharacterAdded:Connect(function()

    task.wait(1)

    GetCharacter()

    if Invisible then
        SetInvisible(true)
    end

    if LocationEnabled then
        UpdateLocations()
    end

    ApplyBrightness()

    if Aim then

        Camera.CameraType =
            Enum.CameraType.Custom

        Camera.CameraSubject =
            Humanoid

    end

end)

--========================================================
-- KEY GUI
--========================================================

local KeyGui =
    Instance.new("ScreenGui")

KeyGui.Name =
    "HaAnhTruong_Key"

KeyGui.ResetOnSpawn = false
KeyGui.DisplayOrder = 999
KeyGui.Parent = PlayerGui

local KeyFrame =
    Instance.new("Frame")

KeyFrame.Size =
    UDim2.fromOffset(150,150)

KeyFrame.Position =
    UDim2.new(
        0.5,-75,
        0.5,-75
    )

KeyFrame.BackgroundColor3 =
    Color3.fromRGB(20,20,20)

KeyFrame.BorderSizePixel = 0
KeyFrame.Parent = KeyGui

local KeyCorner =
    Instance.new("UICorner")

KeyCorner.CornerRadius =
    UDim.new(0,10)

KeyCorner.Parent = KeyFrame

local KeyTitle =
    Instance.new("TextLabel")

KeyTitle.Size =
    UDim2.new(1,0,0,30)

KeyTitle.BackgroundTransparency = 1
KeyTitle.Text = "ENTER KEY"
KeyTitle.TextColor3 =
    Color3.fromRGB(0,255,200)
KeyTitle.TextSize = 15
KeyTitle.Font =
    Enum.Font.GothamBold
KeyTitle.Parent = KeyFrame

local KeyBox =
    Instance.new("TextBox")

KeyBox.Size =
    UDim2.fromOffset(125,35)

KeyBox.Position =
    UDim2.fromOffset(12,38)

KeyBox.BackgroundColor3 =
    Color3.fromRGB(35,35,35)

KeyBox.TextColor3 =
    Color3.fromRGB(255,255,255)

KeyBox.PlaceholderText =
    "Nhập key"

KeyBox.Text = ""
KeyBox.TextSize = 14
KeyBox.Font =
    Enum.Font.GothamBold

KeyBox.ClearTextOnFocus = false
KeyBox.Parent = KeyFrame

local KeyCorner2 =
    Instance.new("UICorner")

KeyCorner2.CornerRadius =
    UDim.new(0,7)

KeyCorner2.Parent = KeyBox

local AcceptButton =
    CreateButton(
        KeyFrame,
        "ĐỒNG Ý",
        UDim2.fromOffset(12,80),
        UDim2.fromOffset(125,32)
    )

AcceptButton.TextColor3 =
    Color3.fromRGB(0,255,200)

local KeyStatus =
    Instance.new("TextLabel")

KeyStatus.Size =
    UDim2.fromOffset(125,25)

KeyStatus.Position =
    UDim2.fromOffset(12,118)

KeyStatus.BackgroundTransparency = 1
KeyStatus.Text = ""
KeyStatus.TextColor3 =
    Color3.fromRGB(255,70,70)

KeyStatus.TextSize = 11
KeyStatus.Font =
    Enum.Font.GothamBold

KeyStatus.Parent = KeyFrame

local function CheckKey()

    if KeyBox.Text == "2012" then

        KeyGui:Destroy()
        Main.Visible = true

    else

        KeyBox.Text = ""
        KeyStatus.Text = "KEY SAI!"

    end

end

AcceptButton.Activated:Connect(CheckKey)

KeyBox.FocusLost:Connect(function(EnterPressed)

    if EnterPressed then
        CheckKey()
    end

end)

--========================================================
-- DEFAULT
--========================================================

Main.Visible = false
UpButton.Visible = false
DownButton.Visible = false

print("HÀ ANH TRƯỜNG - TÚ DOG V2 LOADED")
