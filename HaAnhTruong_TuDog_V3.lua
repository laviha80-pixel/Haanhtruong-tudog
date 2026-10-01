--========================================================--

-- HÀ ANH TRƯỜNG - TÚ DOG V3

-- MENU V2 PURPLE NEON

-- FULL VERSION + LANGUAGE MENU + NOCLIP

--========================================================--

local Players = game:GetService("Players")

local UIS = game:GetService("UserInputService")

local RS = game:GetService("RunService")

local VU = game:GetService("VirtualUser")

local Lighting = game:GetService("Lighting")

local LP = Players.LocalPlayer

local PG = LP:WaitForChild("PlayerGui")

local Cam = workspace.CurrentCamera

local ANIME_IMAGE_ID = ""

local Char = LP.Character or LP.CharacterAdded:Wait()

local Hum = Char:WaitForChild("Humanoid")

local Root = Char:WaitForChild("HumanoidRootPart")

local function RefreshCharacter(c)

	Char = c
	Hum = c:WaitForChild("Humanoid")
	Root = c:WaitForChild("HumanoidRootPart")

end

--========================================================--

-- VARIABLES

--========================================================--

local FlyOn = false

local FlySpeed = 70

local FlyUp = false

local FlyDown = false

local FlyBV = nil

local FlyBG = nil

local MobileUp = nil

local MobileDown = nil

local Float = nil

local AimOn = false

local AimTarget = nil

local AimDot = nil

local AimCameraOffset = nil

local WallHopOn = false

local ShiftLockOn = false

local InvisibleOn = false

local LocationOn = false

local AntiLagOn = false

-- NOCLIP

local NoclipOn = false

local BrightnessValue = 0

local SelectedPlayer = nil

local LocationGuis = {}

local SavedEffects = {}

local SavedAppearance = {}

local SavedAnimations = {}

local Language = "VI"

--========================================================--

-- COLORS

--========================================================--

local BG = Color3.fromRGB(8,4,15)

local BG2 = Color3.fromRGB(15,7,25)

local CARD = Color3.fromRGB(22,10,36)

local CARD2 = Color3.fromRGB(37,17,57)

local PURPLE = Color3.fromRGB(190,70,255)

local PURPLE2 = Color3.fromRGB(120,35,220)

local PURPLE3 = Color3.fromRGB(225,150,255)

local WHITE = Color3.fromRGB(245,240,255)

local GRAY = Color3.fromRGB(165,150,185)

local GREEN = Color3.fromRGB(0,255,175)

local RED = Color3.fromRGB(255,55,85)

local YELLOW = Color3.fromRGB(255,215,40)

--========================================================--

-- REMOVE OLD GUI

--========================================================--

for _,name in ipairs({

	"HaAnhTruong_TuDog_V3",
	"HaAnhTruong_Key"

}) do

	local old = PG:FindFirstChild(name)
	if old then
		old:Destroy()
	end

end

--========================================================--

-- MAIN GUI

--========================================================--

local GUI = Instance.new("ScreenGui")

GUI.Name = "HaAnhTruong_TuDog_V3"

GUI.ResetOnSpawn = false

GUI.IgnoreGuiInset = true

GUI.DisplayOrder = 100

GUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

GUI.Parent = PG

--========================================================--

-- HELPERS

--========================================================--

local function Corner(obj,radius)

	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0,radius)
	c.Parent = obj
	return c

end

local function Stroke(obj,color,thickness,transparency)

	local s = Instance.new("UIStroke")
	s.Color = color
	s.Thickness = thickness or 1
	s.Transparency = transparency or 0
	s.Parent = obj
	return s

end

local function Label(parent,text,size,pos,textSize,color)

	local l = Instance.new("TextLabel")
	l.BackgroundTransparency = 1
	l.Size = size
	l.Position = pos
	l.Text = text
	l.TextColor3 = color or WHITE
	l.TextSize = textSize or 14
	l.Font = Enum.Font.GothamMedium
	l.TextXAlignment = Enum.TextXAlignment.Left
	l.TextYAlignment = Enum.TextYAlignment.Center
	l.Parent = parent
	return l

end

local function Button(parent,text,size,pos)

	local b = Instance.new("TextButton")
	b.Size = size
	b.Position = pos
	b.BackgroundColor3 = CARD
	b.BorderSizePixel = 0
	b.Text = text
	b.TextColor3 = WHITE
	b.TextSize = 13
	b.Font = Enum.Font.GothamMedium
	b.AutoButtonColor = false
	b.ZIndex = 20
	b.Parent = parent
	Corner(b,9)
	Stroke(
		b,
		Color3.fromRGB(80,40,110),
		1,
		.15
	)
	b.MouseEnter:Connect(function()
		if not b:GetAttribute("Active") then
			b.BackgroundColor3 = CARD2
		end
	end)
	b.MouseLeave:Connect(function()
		if b:GetAttribute("Active") then
			b.BackgroundColor3 =
				Color3.fromRGB(75,25,105)
		else
			b.BackgroundColor3 = CARD
		end
	end)
	return b

end

local function SetActive(button,state)

	button:SetAttribute("Active",state)
	if state then
		button.BackgroundColor3 =
			Color3.fromRGB(75,25,105)
		button.TextColor3 = GREEN
	else
		button.BackgroundColor3 = CARD
		button.TextColor3 = WHITE
	end

end

--========================================================--

-- KEY GUI

--========================================================--

local KeyGui = Instance.new("ScreenGui")

KeyGui.Name = "HaAnhTruong_Key"

KeyGui.ResetOnSpawn = false

KeyGui.IgnoreGuiInset = true

KeyGui.DisplayOrder = 999

KeyGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

KeyGui.Parent = PG

local KeyFrame = Instance.new("Frame")

KeyFrame.Size = UDim2.fromOffset(180,175)

KeyFrame.AnchorPoint = Vector2.new(.5,.5)

KeyFrame.Position = UDim2.fromScale(.5,.5)

KeyFrame.BackgroundColor3 = BG

KeyFrame.BorderSizePixel = 0

KeyFrame.Parent = KeyGui

Corner(KeyFrame,18)

Stroke(KeyFrame,PURPLE,2,0)

local KT = Label(

	KeyFrame,
	"♛  KEY SYSTEM",
	UDim2.new(1,-20,0,28),
	UDim2.fromOffset(10,10),
	17,
	PURPLE3

)

KT.TextXAlignment = Enum.TextXAlignment.Center

local KeyBox = Instance.new("TextBox")

KeyBox.Size = UDim2.new(1,-30,0,38)

KeyBox.Position = UDim2.fromOffset(15,48)

KeyBox.BackgroundColor3 = CARD

KeyBox.BorderSizePixel = 0

KeyBox.PlaceholderText = "Nhập KEY..."

KeyBox.PlaceholderColor3 = GRAY

KeyBox.Text = ""

KeyBox.TextColor3 = WHITE

KeyBox.TextSize = 14

KeyBox.Font = Enum.Font.Gotham

KeyBox.ClearTextOnFocus = false

KeyBox.Parent = KeyFrame

Corner(KeyBox,8)

local KeyOK = Instance.new("TextButton")

KeyOK.Size = UDim2.new(1,-30,0,38)

KeyOK.Position = UDim2.fromOffset(15,96)

KeyOK.BackgroundColor3 = PURPLE2

KeyOK.BorderSizePixel = 0

KeyOK.Text = "ĐỒNG Ý"

KeyOK.TextColor3 = WHITE

KeyOK.TextSize = 14

KeyOK.Font = Enum.Font.GothamBold

KeyOK.AutoButtonColor = false

KeyOK.ZIndex = 50

KeyOK.Parent = KeyFrame

Corner(KeyOK,8)

local KeyError = Label(

	KeyFrame,
	"",
	UDim2.new(1,-20,0,20),
	UDim2.fromOffset(10,142),
	11,
	RED

)

KeyError.TextXAlignment = Enum.TextXAlignment.Center

--========================================================--

-- MAIN

--========================================================--

local Main = Instance.new("Frame")

Main.Name = "Main"

Main.Size = UDim2.fromOffset(720,460)

Main.AnchorPoint = Vector2.new(.5,0)

Main.Position = UDim2.new(.5,0,0,60)

Main.BackgroundColor3 = BG

Main.BorderSizePixel = 0

Main.Visible = false

Main.ClipsDescendants = true

Main.Parent = GUI

Corner(Main,18)

Stroke(Main,PURPLE,2,.05)

--========================================================--

-- HEADER

--========================================================--

local Header = Instance.new("Frame")

Header.Size = UDim2.new(1,0,0,58)

Header.BackgroundColor3 =

	Color3.fromRGB(12,6,21)

Header.BorderSizePixel = 0

Header.Parent = Main

Corner(Header,18)

local HeaderLine = Instance.new("Frame")

HeaderLine.Size = UDim2.new(1,-30,0,1)

HeaderLine.Position = UDim2.fromOffset(15,57)

HeaderLine.BackgroundColor3 = PURPLE

HeaderLine.BackgroundTransparency = .25

HeaderLine.BorderSizePixel = 0

HeaderLine.Parent = Header

Label(

	Header,
	"◈  HÀ ANH TRƯỜNG - TÚ DOG V3",
	UDim2.new(1,-250,1,0),
	UDim2.fromOffset(20,0),
	18,
	WHITE

)

local FPSLabel = Label(

	Header,
	"FPS: 0",
	UDim2.fromOffset(65,30),
	UDim2.new(1,-210,0,14),
	11,
	GREEN

)

FPSLabel.TextXAlignment = Enum.TextXAlignment.Right

local ReadyLabel = Label(

	Header,
	"● READY",
	UDim2.fromOffset(85,30),
	UDim2.new(1,-140,0,14),
	11,
	GREEN

)

ReadyLabel.TextXAlignment = Enum.TextXAlignment.Center

local MinBtn = Button(

	Header,
	"—",
	UDim2.fromOffset(38,38),
	UDim2.new(1,-90,0,10)

)

local CloseBtn = Button(

	Header,
	"×",
	UDim2.fromOffset(38,38),
	UDim2.new(1,-45,0,10)

)

MinBtn.TextSize = 21

CloseBtn.TextSize = 23

CloseBtn.TextColor3 = PURPLE3

--========================================================--

-- DRAG

--========================================================--

local Dragging = false

local DragStart

local StartPosition

Header.InputBegan:Connect(function(input)

	if input.UserInputType ==
		Enum.UserInputType.MouseButton1
		or input.UserInputType ==
		Enum.UserInputType.Touch then
		Dragging = true
		DragStart = input.Position
		StartPosition = Main.Position
	end

end)

Header.InputEnded:Connect(function(input)

	if input.UserInputType ==
		Enum.UserInputType.MouseButton1
		or input.UserInputType ==
		Enum.UserInputType.Touch then
		Dragging = false
	end

end)

UIS.InputChanged:Connect(function(input)

	if not Dragging then
		return
	end
	if input.UserInputType ~=
		Enum.UserInputType.MouseMovement
		and input.UserInputType ~=
		Enum.UserInputType.Touch then
		return
	end
	local delta =
		input.Position - DragStart
	Main.Position =
		UDim2.new(
			StartPosition.X.Scale,
			StartPosition.X.Offset + delta.X,
			StartPosition.Y.Scale,
			StartPosition.Y.Offset + delta.Y
		)

end)

--========================================================--

-- SIDEBAR

--========================================================--

local Sidebar = Instance.new("Frame")

Sidebar.Size = UDim2.fromOffset(160,390)

Sidebar.Position = UDim2.fromOffset(10,65)

Sidebar.BackgroundColor3 =

	Color3.fromRGB(13,7,23)

Sidebar.BorderSizePixel = 0

Sidebar.Parent = Main

Corner(Sidebar,14)

Stroke(

	Sidebar,
	Color3.fromRGB(65,30,90),
	1,
	.2

)

local SideButtons = {}

local function SideButton(name,text,y)

	local b = Button(
		Sidebar,
		text,
		UDim2.new(1,-20,0,47),
		UDim2.fromOffset(10,y)
	)
	b.TextSize = 14
	SideButtons[name] = b
	return b

end

local HomeBtn =

	SideButton("Home","⌂    Home",15)

local PlayerBtn =

	SideButton("Player","●    Player",69)

local VisualBtn =

	SideButton("Visual","◉    Visual",123)

local CombatBtn =

	SideButton("Combat","◎    Combat",177)

local SettingsBtn =

	SideButton("Settings","⚙    Settings",231)

--========================================================--

-- IMAGE

--========================================================--

local AnimeLeft = Instance.new("ImageLabel")

AnimeLeft.Size = UDim2.new(1,-20,0,115)

AnimeLeft.Position = UDim2.fromOffset(10,285)

AnimeLeft.BackgroundColor3 =

	Color3.fromRGB(35,10,55)

AnimeLeft.BorderSizePixel = 0

AnimeLeft.Image = ANIME_IMAGE_ID

AnimeLeft.ImageTransparency =

	ANIME_IMAGE_ID == "" and 1 or .05

AnimeLeft.ScaleType = Enum.ScaleType.Crop

AnimeLeft.Parent = Sidebar

Corner(AnimeLeft,12)

Stroke(AnimeLeft,PURPLE,1,.15)

local AnimeOverlay = Instance.new("Frame")

AnimeOverlay.Size = UDim2.fromScale(1,1)

AnimeOverlay.BackgroundColor3 =

	Color3.fromRGB(35,5,65)

AnimeOverlay.BackgroundTransparency = .35

AnimeOverlay.BorderSizePixel = 0

AnimeOverlay.Parent = AnimeLeft

Corner(AnimeOverlay,12)

local AnimeName = Label(

	AnimeOverlay,
	"HÀ ANH TRƯỜNG",
	UDim2.new(1,-10,0,25),
	UDim2.fromOffset(5,42),
	14,
	WHITE

)

AnimeName.TextXAlignment = Enum.TextXAlignment.Center

local AnimeDog = Label(

	AnimeOverlay,
	"TÚ DOG V3",
	UDim2.new(1,-10,0,25),
	UDim2.fromOffset(5,67),
	15,
	PURPLE3

)

AnimeDog.TextXAlignment = Enum.TextXAlignment.Center

--========================================================--

-- CONTENT

--========================================================--

local Content = Instance.new("Frame")

Content.Size = UDim2.new(1,-180,1,-65)

Content.Position = UDim2.fromOffset(170,65)

Content.BackgroundTransparency = 1

Content.Parent = Main

local Pages = {}

local function NewPage(name)

	local p = Instance.new("Frame")
	p.Name = name
	p.Size = UDim2.fromScale(1,1)
	p.BackgroundTransparency = 1
	p.Visible = false
	p.Parent = Content
	Pages[name] = p
	return p

end

local HomePage = NewPage("Home")

local PlayerPage = NewPage("Player")

local VisualPage = NewPage("Visual")

local CombatPage = NewPage("Combat")

local SettingsPage = NewPage("Settings")

local function OpenPage(name)

	for pageName,page in pairs(Pages) do
		page.Visible =
			pageName == name
	end
	for buttonName,button in pairs(SideButtons) do
		if buttonName == name then
			button.BackgroundColor3 =
				Color3.fromRGB(76,24,110)
			button.TextColor3 = PURPLE3
		else
			button.BackgroundColor3 = CARD
			button.TextColor3 = WHITE
		end
	end

end

HomeBtn.Activated:Connect(function()

	OpenPage("Home")

end)

PlayerBtn.Activated:Connect(function()

	OpenPage("Player")

end)

VisualBtn.Activated:Connect(function()

	OpenPage("Visual")

end)

CombatBtn.Activated:Connect(function()

	OpenPage("Combat")

end)

SettingsBtn.Activated:Connect(function()

	OpenPage("Settings")

end)

--========================================================--

-- HOME

--========================================================--

local Banner = Instance.new("Frame")

Banner.Size = UDim2.new(1,-205,0,150)

Banner.Position = UDim2.fromOffset(5,5)

Banner.BackgroundColor3 =

	Color3.fromRGB(28,10,45)

Banner.BorderSizePixel = 0

Banner.Parent = HomePage

Corner(Banner,14)

Stroke(Banner,PURPLE,1,.15)

local BannerImage = Instance.new("ImageLabel")

BannerImage.Size = UDim2.fromScale(1,1)

BannerImage.BackgroundTransparency = 1

BannerImage.Image = ANIME_IMAGE_ID

BannerImage.ImageTransparency =

	ANIME_IMAGE_ID == "" and 1 or .08

BannerImage.ScaleType = Enum.ScaleType.Crop

BannerImage.Parent = Banner

Corner(BannerImage,14)

local BannerShade = Instance.new("Frame")

BannerShade.Size = UDim2.fromScale(1,1)

BannerShade.BackgroundColor3 =

	Color3.fromRGB(22,4,40)

BannerShade.BackgroundTransparency = .25

BannerShade.BorderSizePixel = 0

BannerShade.Parent = Banner

Corner(BannerShade,14)

Label(

	BannerShade,
	"HÀ ANH TRƯỜNG",
	UDim2.fromOffset(350,38),
	UDim2.fromOffset(20,20),
	24,
	WHITE

)

Label(

	BannerShade,
	"TÚ DOG V3",
	UDim2.fromOffset(350,38),
	UDim2.fromOffset(20,55),
	25,
	PURPLE3

)

Label(

	BannerShade,
	"ROBLOX UTILITY HUB",
	UDim2.fromOffset(250,22),
	UDim2.fromOffset(22,94),
	11,
	PURPLE3

)

Label(

	BannerShade,
	"“Sức mạnh nằm ở sự đơn giản.”",
	UDim2.fromOffset(280,20),
	UDim2.fromOffset(22,118),
	9,
	GRAY

)

local KeyCard = Instance.new("Frame")

KeyCard.Size = UDim2.fromOffset(195,150)

KeyCard.Position = UDim2.new(1,-200,0,5)

KeyCard.BackgroundColor3 = CARD

KeyCard.BorderSizePixel = 0

KeyCard.Parent = HomePage

Corner(KeyCard,14)

Stroke(KeyCard,PURPLE,1,.15)

local KeyTitle = Label(

	KeyCard,
	"♛  KEY SYSTEM",
	UDim2.new(1,-10,0,30),
	UDim2.fromOffset(5,12),
	15,
	PURPLE3

)

KeyTitle.TextXAlignment = Enum.TextXAlignment.Center

local KeyNumber = Label(

	KeyCard,
	"KEY: 2012",
	UDim2.new(1,-10,0,30),
	UDim2.fromOffset(5,48),
	17,
	GREEN

)

KeyNumber.TextXAlignment = Enum.TextXAlignment.Center

local StartButton = Button(

	KeyCard,
	"▶  BẮT ĐẦU SỬ DỤNG",
	UDim2.new(1,-25,0,42),
	UDim2.fromOffset(12,92)

)

StartButton.BackgroundColor3 = PURPLE2

local HomeFlyButton = Button(

	HomePage,
	"✈  FLY : OFF",
	UDim2.fromOffset(115,65),
	UDim2.fromOffset(5,165)

)

local HomeAimButton = Button(

	HomePage,
	"◎  AIM LOCK : OFF",
	UDim2.fromOffset(130,65),
	UDim2.fromOffset(130,165)

)

local SpeedCard = Instance.new("Frame")

SpeedCard.Size = UDim2.fromOffset(120,65)

SpeedCard.Position = UDim2.fromOffset(270,165)

SpeedCard.BackgroundColor3 = CARD

SpeedCard.BorderSizePixel = 0

SpeedCard.Parent = HomePage

Corner(SpeedCard,10)

Label(

	SpeedCard,
	"SPEED",
	UDim2.new(1,-15,0,20),
	UDim2.fromOffset(8,5),
	10,
	GRAY

)

local HomeSpeed = Label(

	SpeedCard,
	"70",
	UDim2.new(1,-15,0,25),
	UDim2.fromOffset(8,27),
	16,
	GREEN

)

--========================================================--

-- COMBAT

--========================================================--

local FlyCard = Instance.new("Frame")

FlyCard.Size = UDim2.new(1,-10,0,145)

FlyCard.Position = UDim2.fromOffset(5,5)

FlyCard.BackgroundColor3 = CARD

FlyCard.BorderSizePixel = 0

FlyCard.Parent = CombatPage

Corner(FlyCard,13)

Stroke(FlyCard,PURPLE,1,.2)

Label(

	FlyCard,
	"✈  FLY",
	UDim2.fromOffset(150,30),
	UDim2.fromOffset(15,10),
	17,
	WHITE

)

local FlyToggle = Button(

	FlyCard,
	"FLY : OFF",
	UDim2.fromOffset(115,38),
	UDim2.new(1,-130,0,8)

)

Label(

	FlyCard,
	"SPEED : 70",
	UDim2.fromOffset(140,25),
	UDim2.fromOffset(15,50),
	13,
	WHITE

)

local Minus = Button(

	FlyCard,
	"-10",
	UDim2.fromOffset(55,31),
	UDim2.fromOffset(15,82)

)

local Plus = Button(

	FlyCard,
	"+10",
	UDim2.fromOffset(55,31),
	UDim2.fromOffset(75,82)

)

local Fast = Button(

	FlyCard,
	"FAST",
	UDim2.fromOffset(60,31),
	UDim2.fromOffset(135,82)

)

local Max = Button(

	FlyCard,
	"MAX",
	UDim2.fromOffset(60,31),
	UDim2.fromOffset(200,82)

)

local CombatSpeed = Label(

	FlyCard,
	"70",
	UDim2.fromOffset(65,30),
	UDim2.new(1,-75,0,82),
	15,
	GREEN

)

CombatSpeed.TextXAlignment = Enum.TextXAlignment.Center

local AimCard = Instance.new("Frame")

AimCard.Size = UDim2.new(1,-10,0,145)

AimCard.Position = UDim2.fromOffset(5,158)

AimCard.BackgroundColor3 = CARD

AimCard.BorderSizePixel = 0

AimCard.Parent = CombatPage

Corner(AimCard,13)

Stroke(AimCard,PURPLE,1,.2)

Label(

	AimCard,
	"◎  AIM LOCK",
	UDim2.fromOffset(180,30),
	UDim2.fromOffset(15,10),
	17,
	WHITE

)

local AimToggle = Button(

	AimCard,
	"AIM : OFF",
	UDim2.fromOffset(115,38),
	UDim2.new(1,-130,0,8)

)

Label(

	AimCard,
	"◉  Vòng trắng 300×300",
	UDim2.fromOffset(250,25),
	UDim2.fromOffset(15,52),
	11,
	PURPLE3

)

Label(

	AimCard,
	"🔒  Khóa cứng mục tiêu",
	UDim2.fromOffset(250,25),
	UDim2.fromOffset(15,77),
	11,
	GRAY

)

Label(

	AimCard,
	"👁  Ra ngoài vòng vẫn tiếp tục khóa",
	UDim2.fromOffset(280,25),
	UDim2.fromOffset(15,102),
	10,
	GRAY

)

local WallToggle = Button(

	CombatPage,
	"WALLHOP : OFF",
	UDim2.new(1,-10,0,45),
	UDim2.fromOffset(5,315)

)

--========================================================--

-- MOBILE FLY

--========================================================--

MobileUp = Button(

	GUI,
	"↑",
	UDim2.fromOffset(55,55),
	UDim2.new(1,-130,1,-205)

)

MobileDown = Button(

	GUI,
	"↓",
	UDim2.fromOffset(55,55),
	UDim2.new(1,-130,1,-140)

)

MobileUp.Visible = false

MobileDown.Visible = false

MobileUp.TextSize = 25

MobileDown.TextSize = 25

MobileUp.ZIndex = 1000

MobileDown.ZIndex = 1000

local function UpdateFlyUI()

	HomeFlyButton.Text =
		FlyOn and "✈  FLY : ON"
		or "✈  FLY : OFF"
	FlyToggle.Text =
		FlyOn and "FLY : ON"
		or "FLY : OFF"
	SetActive(HomeFlyButton,FlyOn)
	SetActive(FlyToggle,FlyOn)
	MobileUp.Visible =
		FlyOn and UIS.TouchEnabled
	MobileDown.Visible =
		FlyOn and UIS.TouchEnabled

end

local function StopFly()

	FlyOn = false
	FlyUp = false
	FlyDown = false
	if FlyBV then
		FlyBV:Destroy()
		FlyBV = nil
	end
	if FlyBG then
		FlyBG:Destroy()
		FlyBG = nil
	end
	if Hum then
		Hum.PlatformStand = false
	end
	if Root then
		Root.AssemblyLinearVelocity =
			Vector3.zero
	end
	MobileUp.Visible = false
	MobileDown.Visible = false
	UpdateFlyUI()

end

local function StartFly()

	if not Root or not Hum then
		return
	end
	if FlyBV then
		FlyBV:Destroy()
	end
	if FlyBG then
		FlyBG:Destroy()
	end
	FlyOn = true
	FlyBV = Instance.new("BodyVelocity")
	FlyBV.MaxForce =
		Vector3.new(1e9,1e9,1e9)
	FlyBV.P = 10000
	FlyBV.Velocity = Vector3.zero
	FlyBV.Parent = Root
	FlyBG = Instance.new("BodyGyro")
	FlyBG.MaxTorque =
		Vector3.new(1e9,1e9,1e9)
	FlyBG.P = 10000
	FlyBG.D = 500
	FlyBG.CFrame = Root.CFrame
	FlyBG.Parent = Root
	Hum.PlatformStand = true
	UpdateFlyUI()

end

local function ToggleFly()

	if FlyOn then
		StopFly()
	else
		StartFly()
	end

end

HomeFlyButton.Activated:Connect(ToggleFly)

FlyToggle.Activated:Connect(ToggleFly)

MobileUp.MouseButton1Down:Connect(function()

	if FlyOn then
		FlyUp = true
	end

end)

MobileUp.MouseButton1Up:Connect(function()

	FlyUp = false

end)

MobileDown.MouseButton1Down:Connect(function()

	if FlyOn then
		FlyDown = true
	end

end)

MobileDown.MouseButton1Up:Connect(function()

	FlyDown = false

end)

local function UpdateSpeedUI()

	HomeSpeed.Text = tostring(FlySpeed)
	CombatSpeed.Text = tostring(FlySpeed)
	HomeSpeed.TextColor3 = GREEN
	CombatSpeed.TextColor3 = GREEN

end

Minus.Activated:Connect(function()

	FlySpeed =
		math.max(10,FlySpeed - 10)
	UpdateSpeedUI()

end)

Plus.Activated:Connect(function()

	FlySpeed =
		math.min(1000,FlySpeed + 10)
	UpdateSpeedUI()

end)

Fast.Activated:Connect(function()

	FlySpeed = 300
	UpdateSpeedUI()

end)

Max.Activated:Connect(function()

	FlySpeed = 1000
	UpdateSpeedUI()

end)

RS.RenderStepped:Connect(function()

	if not FlyOn then
		return
	end
	if not FlyBV or not Root or not Hum then
		return
	end
	local move =
		Hum.MoveDirection
	local velocity =
		Vector3.new(
			move.X,
			0,
			move.Z
		)
	if FlyUp then
		velocity +=
			Vector3.new(0,1,0)
	end
	if FlyDown then
		velocity +=
			Vector3.new(0,-1,0)
	end
	if velocity.Magnitude > 1 then
		velocity =
			velocity.Unit
	end
	FlyBV.Velocity =
		velocity * FlySpeed
	if FlyBG and Cam then
		local look =
			Cam.CFrame.LookVector
		local flat =
			Vector3.new(
				look.X,
				0,
				look.Z
			)
		if flat.Magnitude > .01 then
			FlyBG.CFrame =
				CFrame.lookAt(
					Root.Position,
					Root.Position + flat.Unit
				)
		end
	end

end)

UIS.InputBegan:Connect(function(input,processed)

	if processed or not FlyOn then
		return
	end
	if input.KeyCode == Enum.KeyCode.Space
		or input.KeyCode == Enum.KeyCode.Up then
		FlyUp = true
	end
	if input.KeyCode == Enum.KeyCode.LeftControl
		or input.KeyCode == Enum.KeyCode.C
		or input.KeyCode == Enum.KeyCode.Down then
		FlyDown = true
	end

end)

UIS.InputEnded:Connect(function(input)

	if input.KeyCode == Enum.KeyCode.Space
		or input.KeyCode == Enum.KeyCode.Up then
		FlyUp = false
	end
	if input.KeyCode == Enum.KeyCode.LeftControl
		or input.KeyCode == Enum.KeyCode.C
		or input.KeyCode == Enum.KeyCode.Down then
		FlyDown = false
	end

end)

--========================================================--

-- AIM

--========================================================--

local AimCircle = Instance.new("Frame")

AimCircle.Size = UDim2.fromOffset(300,300)

AimCircle.AnchorPoint = Vector2.new(.5,.5)

AimCircle.Position = UDim2.fromScale(.5,.5)

AimCircle.BackgroundTransparency = 1

AimCircle.Visible = false

AimCircle.ZIndex = 500

AimCircle.Parent = GUI

Corner(AimCircle,150)

Stroke(

	AimCircle,
	Color3.fromRGB(255,255,255),
	2,
	0

)

local function IsAimAlive(player)

	if not player or player == LP then
		return false
	end
	if not player.Character then
		return false
	end
	local hum =
		player.Character:FindFirstChildOfClass(
			"Humanoid"
		)
	local head =
		player.Character:FindFirstChild("Head")
	if not hum or not head then
		return false
	end
	return hum.Health > 0

end

local function CreateAimDot(player)

	if AimDot then
		AimDot:Destroy()
		AimDot = nil
	end
	if not IsAimAlive(player) then
		return
	end
	local head =
		player.Character:FindFirstChild("Head")
	if not head then
		return
	end
	AimDot = Instance.new("BillboardGui")
	AimDot.Name =
		"HaAnhTruong_AimDot"
	AimDot.Size =
		UDim2.fromOffset(30,30)
	AimDot.AlwaysOnTop = true
	AimDot.MaxDistance = 10000
	AimDot.Adornee = head
	AimDot.Parent = head
	local dot = Instance.new("Frame")
	dot.Size = UDim2.fromScale(1,1)
	dot.BackgroundColor3 = RED
	dot.BorderSizePixel = 0
	dot.Parent = AimDot
	Corner(dot,30)

end

local function FindAimTarget()

	if not Cam then
		return nil
	end
	local center =
		Vector2.new(
			Cam.ViewportSize.X/2,
			Cam.ViewportSize.Y/2
		)
	local best = nil
	local bestDistance = 150
	for _,player in ipairs(Players:GetPlayers()) do
		if player ~= LP
			and IsAimAlive(player) then
			local head =
				player.Character:FindFirstChild("Head")
			if head then
				local pos,onScreen =
					Cam:WorldToViewportPoint(
						head.Position
					)
				if onScreen and pos.Z > 0 then
					local distance =
						(
							Vector2.new(pos.X,pos.Y)
							- center
						).Magnitude
					if distance <= 150
						and distance < bestDistance then
						bestDistance = distance
						best = player
					end
				end
			end
		end
	end
	return best

end

local function UpdateAimUI()

	if AimOn then
		HomeAimButton.Text =
			"◎  AIM LOCK : ON"
		AimToggle.Text =
			"AIM : ON"
	else
		HomeAimButton.Text =
			"◎  AIM LOCK : OFF"
		AimToggle.Text =
			"AIM : OFF"
	end
	SetActive(HomeAimButton,AimOn)
	SetActive(AimToggle,AimOn)

end

local function EnableAim()

	AimOn = true
	AimCircle.Visible = true
	AimTarget =
		FindAimTarget()
	if Root and Cam then
		AimCameraOffset =
			Root.CFrame:ToObjectSpace(
				Cam.CFrame
			).Position
	end
	if AimTarget then
		CreateAimDot(AimTarget)
	end
	UpdateAimUI()

end

local function DisableAim()

	AimOn = false
	AimTarget = nil
	AimCameraOffset = nil
	AimCircle.Visible = false
	if AimDot then
		AimDot:Destroy()
		AimDot = nil
	end
	Cam.CameraType =
		Enum.CameraType.Custom
	Cam.CameraSubject = Hum
	UpdateAimUI()

end

local function ToggleAim()

	if AimOn then
		DisableAim()
	else
		EnableAim()
	end

end

HomeAimButton.Activated:Connect(ToggleAim)

AimToggle.Activated:Connect(ToggleAim)

RS:BindToRenderStep(

	"HaAnhTruong_AimLock",
	Enum.RenderPriority.Camera.Value + 1,
	function()
		if not AimOn then
			return
		end
		if not Root or not Cam then
			return
		end
		if AimTarget
			and IsAimAlive(AimTarget) then
			local head =
				AimTarget.Character:FindFirstChild(
					"Head"
				)
			if not head then
				return
			end
			local cameraPosition
			if AimCameraOffset then
				cameraPosition =
					Root.CFrame:PointToWorldSpace(
						AimCameraOffset
					)
			else
				cameraPosition =
					Cam.CFrame.Position
			end
			Cam.CameraType =
				Enum.CameraType.Scriptable
			Cam.CFrame =
				CFrame.lookAt(
					cameraPosition,
					head.Position
				)
			local direction =
				head.Position - Root.Position
			local flat =
				Vector3.new(
					direction.X,
					0,
					direction.Z
				)
			if flat.Magnitude > .01 then
				Root.CFrame =
					CFrame.lookAt(
						Root.Position,
						Root.Position + flat.Unit
					)
			end
			if not AimDot
				or AimDot.Adornee ~= head then
				CreateAimDot(AimTarget)
			end
		else
			AimTarget =
				FindAimTarget()
			if AimTarget then
				CreateAimDot(AimTarget)
			end
		end
	end

)

--========================================================--

-- PLAYER PAGE

--========================================================--

local SelectedLabel = Label(

	PlayerPage,
	"Selected: Chưa chọn",
	UDim2.new(1,-230,0,35),
	UDim2.fromOffset(5,5),
	14,
	GREEN

)

local TeleportButton = Button(

	PlayerPage,
	"➜  TELEPORT TO SELECTED",
	UDim2.fromOffset(215,35),
	UDim2.new(1,-220,0,5)

)

local PlayerList = Instance.new("ScrollingFrame")

PlayerList.Size =

	UDim2.new(1,-10,1,-55)

PlayerList.Position =

	UDim2.fromOffset(5,48)

PlayerList.BackgroundColor3 = CARD

PlayerList.BorderSizePixel = 0

PlayerList.ScrollBarThickness = 3

PlayerList.ScrollBarImageColor3 = PURPLE

PlayerList.CanvasSize = UDim2.new()

PlayerList.Parent = PlayerPage

Corner(PlayerList,11)

local PlayerLayout =

	Instance.new("UIListLayout")

PlayerLayout.Padding =

	UDim.new(0,5)

PlayerLayout.Parent =

	PlayerList

local function RefreshPlayerList()

	for _,child in ipairs(
		PlayerList:GetChildren()
	) do
		if child:IsA("TextButton") then
			child:Destroy()
		end
	end
	local count = 0
	for _,player in ipairs(
		Players:GetPlayers()
	) do
		if player ~= LP then
			count += 1
			local b =
				Button(
					PlayerList,
					player.DisplayName..
						"   @"..
						player.Name,
					UDim2.new(1,-10,0,42),
					UDim2.fromOffset(5,0)
				)
			b.Parent =
				PlayerList
			b.Activated:Connect(function()
				SelectedPlayer =
					player
				SelectedLabel.Text =
					"Selected: "..
					player.DisplayName
				for _,x in ipairs(
					PlayerList:GetChildren()
				) do
					if x:IsA("TextButton") then
						x.BackgroundColor3 =
							CARD
					end
				end
				b.BackgroundColor3 =
					Color3.fromRGB(
						75,
						25,
						105
					)
			end)
		end
	end
	PlayerList.CanvasSize =
		UDim2.fromOffset(
			0,
			count * 47
		)

end

TeleportButton.Activated:Connect(function()

	if not SelectedPlayer then
		return
	end
	if not SelectedPlayer.Character then
		return
	end
	local targetRoot =
		SelectedPlayer.Character:
			FindFirstChild(
				"HumanoidRootPart"
			)
	if targetRoot and Root then
		Root.CFrame =
			targetRoot.CFrame *
			CFrame.new(0,0,4)
	end

end)

Players.PlayerAdded:Connect(function()

	task.wait(.5)
	RefreshPlayerList()

end)

Players.PlayerRemoving:Connect(function(player)

	if SelectedPlayer == player then
		SelectedPlayer = nil
		SelectedLabel.Text =
			"Selected: Chưa chọn"
	end
	task.wait(.2)
	RefreshPlayerList()

end)

RefreshPlayerList()

--========================================================--

-- VISUAL PAGE

--========================================================--

local LocationToggle = Button(

	VisualPage,
	"📍  LOCATION + HP : OFF",
	UDim2.new(1,-10,0,45),
	UDim2.fromOffset(5,5)

)

local InvisibleToggle = Button(

	VisualPage,
	"👻  INVISIBLE : OFF",
	UDim2.new(1,-10,0,45),
	UDim2.fromOffset(5,55)

)

local AntiLagToggle = Button(

	VisualPage,
	"▮▮  ANTI LAG : OFF",
	UDim2.new(1,-10,0,45),
	UDim2.fromOffset(5,105)

)

local NoclipToggle = Button(

	VisualPage,
	"👻  NOCLIP : OFF",
	UDim2.new(1,-10,0,45),
	UDim2.fromOffset(5,155)

)

--========================================================--

-- LOCATION

--========================================================--

local function GetHPColor(percent)

	if percent > 50 then
		return GREEN
	elseif percent > 20 then
		return YELLOW
	else
		return RED
	end

end

local function CreateLocation(player)

	if player == LP then
		return
	end
	if not player.Character then
		return
	end
	local targetRoot =
		player.Character:FindFirstChild(
			"HumanoidRootPart"
		)
	local targetHum =
		player.Character:FindFirstChildOfClass(
			"Humanoid"
		)
	if not targetRoot or not targetHum then
		return
	end
	if LocationGuis[player] then
		LocationGuis[player]:Destroy()
	end
	local bill =
		Instance.new("BillboardGui")
	bill.Name =
		"HaAnhTruong_Location"
	bill.Size =
		UDim2.fromOffset(180,60)
	bill.StudsOffset =
		Vector3.new(0,4,0)
	bill.AlwaysOnTop = true
	bill.MaxDistance = 10000
	bill.Adornee = targetRoot
	bill.Parent = targetRoot
	local name =
		Label(
			bill,
			player.DisplayName,
			UDim2.new(1,0,0,20),
			UDim2.fromOffset(0,0),
			12,
			WHITE
		)
	name.TextXAlignment =
		Enum.TextXAlignment.Center
	local hp =
		Label(
			bill,
			"HP: 100%",
			UDim2.new(1,0,0,20),
			UDim2.fromOffset(0,20),
			11,
			GREEN
		)
	hp.TextXAlignment =
		Enum.TextXAlignment.Center
	local dist =
		Label(
			bill,
			"0 m",
			UDim2.new(1,0,0,20),
			UDim2.fromOffset(0,40),
			10,
			GRAY
		)
	dist.TextXAlignment =
		Enum.TextXAlignment.Center
	LocationGuis[player] = bill
	local connection
	connection =
		RS.RenderStepped:Connect(function()
			if not LocationOn then
				if bill then
					bill:Destroy()
				end
				connection:Disconnect()
				return
			end
			if not targetRoot.Parent
				or not targetHum.Parent
				or not Root then
				return
			end
			local percent = 0
			if targetHum.MaxHealth > 0 then
				percent =
					math.floor(
						math.clamp(
							targetHum.Health /
								targetHum.MaxHealth *
								100,
							0,
							100
						)
					)
			end
			hp.Text =
				"HP: "..percent.."%"
			hp.TextColor3 =
				GetHPColor(percent)
			dist.Text =
				math.floor(
					(
						Root.Position -
							targetRoot.Position
					).Magnitude
				).." m"
		end)

end

local function RemoveLocations()

	for player,gui in pairs(
		LocationGuis
	) do
		if gui then
			gui:Destroy()
		end
		LocationGuis[player] = nil
	end

end

LocationToggle.Activated:Connect(function()

	LocationOn = not LocationOn
	LocationToggle.Text =
		"📍  LOCATION + HP : "..
		(LocationOn and "ON" or "OFF")
	SetActive(
		LocationToggle,
		LocationOn
	)
	if LocationOn then
		RemoveLocations()
		for _,player in ipairs(
			Players:GetPlayers()
		) do
			CreateLocation(player)
		end
	else
		RemoveLocations()
	end

end)

--========================================================--

-- INVISIBLE

--========================================================--

local function ApplyInvisible()

	for _,obj in ipairs(
		Char:GetDescendants()
	) do
		if obj:IsA("BasePart") then
			obj.LocalTransparencyModifier =
				InvisibleOn and 1 or 0
		elseif obj:IsA("Decal")
			or obj:IsA("Texture") then
			obj.Transparency =
				InvisibleOn and 1 or 0
		end
	end

end

InvisibleToggle.Activated:Connect(function()

	InvisibleOn = not InvisibleOn
	InvisibleToggle.Text =
		"👻  INVISIBLE : "..
		(InvisibleOn and "ON" or "OFF")
	SetActive(
		InvisibleToggle,
		InvisibleOn
	)
	ApplyInvisible()

end)

--========================================================--

-- ANTI LAG

--========================================================--

local function DisableEffects(obj)

	if obj:IsA("ParticleEmitter")
		or obj:IsA("Trail")
		or obj:IsA("Beam")
		or obj:IsA("Smoke")
		or obj:IsA("Fire")
		or obj:IsA("Sparkles")
		or obj:IsA("PointLight")
		or obj:IsA("SpotLight")
		or obj:IsA("SurfaceLight") then
		if SavedEffects[obj] == nil then
			SavedEffects[obj] =
				obj.Enabled
		end
		obj.Enabled = false
	end

end

local function MakeDefaultSkin(character)

	if not character then
		return
	end
	if not SavedAppearance[character] then
		SavedAppearance[character] = {}
	end
	for _,obj in ipairs(
		character:GetDescendants()
	) do
		if obj:IsA("Shirt")
			or obj:IsA("Pants")
			or obj:IsA("ShirtGraphic") then
			if SavedAppearance[character][obj] == nil then
				SavedAppearance[character][obj] =
					obj.Parent
			end
			obj.Parent = nil
		end
		if obj:IsA("Accessory") then
			if SavedAppearance[character][obj] == nil then
				SavedAppearance[character][obj] =
					obj.Parent
			end
			obj.Parent = nil
		end
		if obj:IsA("Decal")
			and obj.Name == "face" then
			if SavedAppearance[character][obj] == nil then
				SavedAppearance[character][obj] =
					obj.Parent
			end
			obj.Parent = nil
		end
	end

end

local function StopPlayerAnimations(player)

	local character =
		player.Character
	if not character then
		return
	end
	local humanoid =
		character:FindFirstChildOfClass(
			"Humanoid"
		)
	if not humanoid then
		return
	end
	local animator =
		humanoid:FindFirstChildOfClass(
			"Animator"
		)
	if not animator then
		return
	end
	if not SavedAnimations[character] then
		SavedAnimations[character] = {}
	end
	for _,track in ipairs(
		animator:GetPlayingAnimationTracks()
	) do
		SavedAnimations[character][track] = true
		track:Stop(0)
	end

end

local function EnableAntiLag()

	AntiLagOn = true
	for _,obj in ipairs(
		workspace:GetDescendants()
	) do
		DisableEffects(obj)
	end
	for _,player in ipairs(
		Players:GetPlayers()
	) do
		local character =
			player.Character
		if character then
			MakeDefaultSkin(character)
			StopPlayerAnimations(player)
			for _,obj in ipairs(
				character:GetDescendants()
			) do
				DisableEffects(obj)
			end
			local animate =
				character:FindFirstChild("Animate")
			if animate then
				if not SavedAnimations[character] then
					SavedAnimations[character] = {}
				end
				if SavedAnimations[character].Animate == nil then
					SavedAnimations[character].Animate =
						animate.Disabled
				end
				animate.Disabled = true
			end
		end
	end

end

local function DisableAntiLag()

	AntiLagOn = false
	for obj,state in pairs(
		SavedEffects
	) do
		if obj and obj.Parent then
			obj.Enabled = state
		end
	end
	table.clear(SavedEffects)
	for character,data in pairs(
		SavedAppearance
	) do
		for obj,parent in pairs(data) do
			if obj and parent and parent.Parent then
				obj.Parent = parent
			end
		end
	end
	table.clear(SavedAppearance)
	for character,data in pairs(
		SavedAnimations
	) do
		if character and character.Parent then
			local animate =
				character:FindFirstChild(
					"Animate"
				)
			if animate then
				local oldState =
					data.Animate
				if oldState ~= nil then
					animate.Disabled = oldState
				else
					animate.Disabled = false
				end
			end
		end
	end
	table.clear(SavedAnimations)

end

Players.PlayerAdded:Connect(function(player)

	player.CharacterAdded:Connect(
		function(character)
			if not AntiLagOn then
				return
			end
			task.wait(1)
			if not AntiLagOn then
				return
			end
			MakeDefaultSkin(character)
			StopPlayerAnimations(player)
			for _,obj in ipairs(
				character:GetDescendants()
			) do
				DisableEffects(obj)
			end
			local animate =
				character:FindFirstChild("Animate")
			if animate then
				animate.Disabled = true
			end
		end
	)

end)

workspace.DescendantAdded:Connect(function(obj)

	if not AntiLagOn then
		return
	end
	task.defer(function()
		if not AntiLagOn then
			return
		end
		DisableEffects(obj)
		local character =
			obj:FindFirstAncestorOfClass(
				"Model"
			)
		if character then
			local player =
				Players:GetPlayerFromCharacter(
					character
				)
			if player then
				MakeDefaultSkin(character)
				StopPlayerAnimations(player)
			end
		end
	end)

end)

AntiLagToggle.Activated:Connect(function()

	if AntiLagOn then
		DisableAntiLag()
	else
		EnableAntiLag()
	end
	AntiLagToggle.Text =
		"▮▮  ANTI LAG : "..
		(AntiLagOn and "ON" or "OFF")
	SetActive(
		AntiLagToggle,
		AntiLagOn
	)

end)

--========================================================--

-- NOCLIP

--========================================================--

NoclipToggle.Activated:Connect(function()

	NoclipOn = not NoclipOn
	if NoclipOn then
		NoclipToggle.Text =
			"👻  NOCLIP : ON"
		SetActive(
			NoclipToggle,
			true
		)
	else
		NoclipToggle.Text =
			"👻  NOCLIP : OFF"
		SetActive(
			NoclipToggle,
			false
		)
		if Char then
			for _,v in pairs(
				Char:GetDescendants()
			) do
				if v:IsA("BasePart") then
					v.CanCollide = true
				end
			end
		end
	end

end)

RS.Stepped:Connect(function()

	if NoclipOn and Char then
		for _,v in pairs(
			Char:GetDescendants()
		) do
			if v:IsA("BasePart") then
				v.CanCollide = false
			end
		end
	end

end)

--========================================================--

-- BRIGHTNESS

--========================================================--

local BrightCard = Instance.new("Frame")

BrightCard.Size =

	UDim2.new(1,-10,0,85)

BrightCard.Position =

	UDim2.fromOffset(5,210)

BrightCard.BackgroundColor3 = CARD

BrightCard.BorderSizePixel = 0

BrightCard.Parent = VisualPage

Corner(BrightCard,12)

local BrightLabel =

	Label(
		BrightCard,
		"☀  BRIGHTNESS : 0",
		UDim2.fromOffset(180,25),
		UDim2.fromOffset(12,8),
		13,
		WHITE
	)

local BrightMinus =

	Button(
		BrightCard,
		"-",
		UDim2.fromOffset(40,32),
		UDim2.fromOffset(12,42)
	)

local BrightPlus =

	Button(
		BrightCard,
		"+",
		UDim2.fromOffset(40,32),
		UDim2.fromOffset(57,42)
	)

local BrightMax =

	Button(
		BrightCard,
		"MAX",
		UDim2.fromOffset(55,32),
		UDim2.fromOffset(102,42)
	)

local BrightValue =

	Label(
		BrightCard,
		"0",
		UDim2.fromOffset(50,32),
		UDim2.new(1,-60,0,42),
		14,
		GREEN
	)

BrightValue.TextXAlignment =

	Enum.TextXAlignment.Center

local OriginalLighting = {

	Brightness =
		Lighting.Brightness,
	Exposure =
		Lighting.ExposureCompensation,
	Ambient =
		Lighting.Ambient,
	OutdoorAmbient =
		Lighting.OutdoorAmbient

}

local BrightEffect =

	Instance.new("ColorCorrectionEffect")

BrightEffect.Name =

	"HaAnhTruong_Brightness"

BrightEffect.Parent =

	Lighting

local function ApplyBrightness()

	local alpha =
		math.clamp(
			BrightnessValue / 300,
			0,
			1
		)
	if BrightnessValue <= 0 then
		Lighting.Brightness =
			OriginalLighting.Brightness
		Lighting.ExposureCompensation =
			OriginalLighting.Exposure
		Lighting.Ambient =
			OriginalLighting.Ambient
		Lighting.OutdoorAmbient =
			OriginalLighting.OutdoorAmbient
		BrightEffect.Brightness = 0
	else
		Lighting.Brightness =
			OriginalLighting.Brightness +
			alpha * 10
		Lighting.ExposureCompensation =
			OriginalLighting.Exposure +
			alpha * 3
		Lighting.Ambient =
			OriginalLighting.Ambient:Lerp(
				Color3.fromRGB(
					180,
					180,
					180
				),
				alpha
			)
		Lighting.OutdoorAmbient =
			OriginalLighting.OutdoorAmbient:Lerp(
				Color3.fromRGB(
					180,
					180,
					180
				),
				alpha
			)
		BrightEffect.Brightness =
			alpha * .18
	end
	BrightLabel.Text =
		"☀  BRIGHTNESS : "..
		BrightnessValue
	BrightValue.Text =
		tostring(BrightnessValue)

end

BrightMinus.Activated:Connect(function()

	BrightnessValue =
		math.max(
			0,
			BrightnessValue - 10
		)
	ApplyBrightness()

end)

BrightPlus.Activated:Connect(function()

	BrightnessValue =
		math.min(
			300,
			BrightnessValue + 10
		)
	ApplyBrightness()

end)

BrightMax.Activated:Connect(function()

	BrightnessValue = 300
	ApplyBrightness()

end)

--========================================================--

-- WALLHOP

--========================================================--

WallToggle.Activated:Connect(function()

	WallHopOn = not WallHopOn
	WallToggle.Text =
		"WALLHOP : "..
		(WallHopOn and "ON" or "OFF")
	SetActive(
		WallToggle,
		WallHopOn
	)

end)

UIS.JumpRequest:Connect(function()

	if not WallHopOn then
		return
	end
	if not Root then
		return
	end
	local params =
		RaycastParams.new()
	params.FilterType =
		Enum.RaycastFilterType.Exclude
	params.FilterDescendantsInstances =
		{Char}
	local directions = {
		Vector3.new(2,0,0),
		Vector3.new(-2,0,0),
		Vector3.new(0,0,2),
		Vector3.new(0,0,-2)
	}
	for _,direction in ipairs(
		directions
	) do
		local result =
			workspace:Raycast(
				Root.Position,
				direction,
				params
			)
		if result then
			Root.AssemblyLinearVelocity =
				Vector3.new(
					Root.AssemblyLinearVelocity.X,
					55,
					Root.AssemblyLinearVelocity.Z
				)
			break
		end
	end

end)

--========================================================--

-- SETTINGS

--========================================================--

local ShiftToggle =

	Button(
		SettingsPage,
		"🔒  SHIFT LOCK : OFF",
		UDim2.new(1,-10,0,48),
		UDim2.fromOffset(5,5)
	)

local LanguageToggle =

	Button(
		SettingsPage,
		"🌐  LANGUAGE : TIẾNG VIỆT",
		UDim2.new(1,-10,0,43),
		UDim2.fromOffset(5,58)
	)

local LanguageMenu =

	Instance.new("Frame")

LanguageMenu.Size =

	UDim2.new(1,-10,0,90)

LanguageMenu.Position =

	UDim2.fromOffset(5,106)

LanguageMenu.BackgroundColor3 =

	CARD

LanguageMenu.BorderSizePixel = 0

LanguageMenu.Visible = false

LanguageMenu.ZIndex = 50

LanguageMenu.Parent = SettingsPage

Corner(LanguageMenu,10)

Stroke(

	LanguageMenu,
	PURPLE,
	1,
	.15

)

local VietnamButton =

	Button(
		LanguageMenu,
		"🇻🇳  TIẾNG VIỆT",
		UDim2.new(1,-20,0,34),
		UDim2.fromOffset(10,8)
	)

VietnamButton.ZIndex = 60

local EnglishButton =

	Button(
		LanguageMenu,
		"🇺🇸  ENGLISH",
		UDim2.new(1,-20,0,34),
		UDim2.fromOffset(10,48)
	)

EnglishButton.ZIndex = 60

local AntiAFKCard =

	Instance.new("Frame")

AntiAFKCard.Size =

	UDim2.new(1,-10,0,80)

AntiAFKCard.Position =

	UDim2.fromOffset(5,205)

AntiAFKCard.BackgroundColor3 =

	CARD

AntiAFKCard.BorderSizePixel = 0

AntiAFKCard.Parent =

	SettingsPage

Corner(AntiAFKCard,12)

local AntiAFKTitle =

	Label(
		AntiAFKCard,
		"⚡  ANTI AFK",
		UDim2.fromOffset(200,25),
		UDim2.fromOffset(15,10),
		14,
		WHITE
	)

local AntiAFKStatus =

	Label(
		AntiAFKCard,
		"● Đang hoạt động",
		UDim2.fromOffset(220,25),
		UDim2.fromOffset(15,40),
		11,
		GREEN
	)

local function SetLanguage(lang)

	Language = lang
	if Language == "VI" then
		LanguageToggle.Text =
			"🌐  NGÔN NGỮ : TIẾNG VIỆT"
		SideButtons.Home.Text =
			"⌂    Trang chủ"
		SideButtons.Player.Text =
			"●    Người chơi"
		SideButtons.Visual.Text =
			"◉    Hiển thị"
		SideButtons.Combat.Text =
			"◎    Chiến đấu"
		SideButtons.Settings.Text =
			"⚙    Cài đặt"
		ShiftToggle.Text =
			"🔒  KHÓA SHIFT : "..
			(ShiftLockOn and "BẬT" or "TẮT")
		AntiAFKTitle.Text =
			"⚡  CHỐNG AFK"
		AntiAFKStatus.Text =
			"● Đang hoạt động"
	else
		LanguageToggle.Text =
			"🌐  LANGUAGE : ENGLISH"
		SideButtons.Home.Text =
			"⌂    Home"
		SideButtons.Player.Text =
			"●    Player"
		SideButtons.Visual.Text =
			"◉    Visual"
		SideButtons.Combat.Text =
			"◎    Combat"
		SideButtons.Settings.Text =
			"⚙    Settings"
		ShiftToggle.Text =
			"🔒  SHIFT LOCK : "..
			(ShiftLockOn and "ON" or "OFF")
		AntiAFKTitle.Text =
			"⚡  ANTI AFK"
		AntiAFKStatus.Text =
			"● Active"
	end

end

LanguageToggle.Activated:Connect(function()

	LanguageMenu.Visible =
		not LanguageMenu.Visible

end)

VietnamButton.Activated:Connect(function()

	SetLanguage("VI")
	LanguageMenu.Visible = false

end)

EnglishButton.Activated:Connect(function()

	SetLanguage("EN")
	LanguageMenu.Visible = false

end)

ShiftToggle.Activated:Connect(function()

	ShiftLockOn = not ShiftLockOn
	SetLanguage(Language)
	SetActive(
		ShiftToggle,
		ShiftLockOn
	)

end)

RS.RenderStepped:Connect(function()

	if not ShiftLockOn then
		return
	end
	if not Root or not Hum then
		return
	end
	if Hum.MoveDirection.Magnitude > .05 then
		local look =
			Cam.CFrame.LookVector
		local flat =
			Vector3.new(
				look.X,
				0,
				look.Z
			)
		if flat.Magnitude > .01 then
			Root.CFrame =
				CFrame.lookAt(
					Root.Position,
					Root.Position + flat.Unit
				)
		end
	end

end)

LP.Idled:Connect(function()

	VU:CaptureController()
	VU:ClickButton2(
		Vector2.new(0,0)
	)

end)

--========================================================--

-- FLOAT

--========================================================--

Float =

	Button(
		GUI,
		"✦",
		UDim2.fromOffset(55,55),
		UDim2.new(.5,-27.5,0,75)
	)

Float.TextSize = 25

Float.BackgroundColor3 =

	Color3.fromRGB(25,8,40)

Stroke(

	Float,
	PURPLE,
	2,
	.05

)

Corner(Float,30)

Float.ZIndex = 1000

Float.Activated:Connect(function()

	Main.Visible = true
	Float.Visible = false

end)

--========================================================--

-- MINIMIZE

--========================================================--

local Minimized = false

MinBtn.Activated:Connect(function()

	Minimized = not Minimized
	if Minimized then
		Sidebar.Visible = false
		Content.Visible = false
		Main.Size =
			UDim2.fromOffset(
				360,
				58
			)
	else
		Sidebar.Visible = true
		Content.Visible = true
		Main.Size =
			UDim2.fromOffset(
				720,
				460
			)
	end

end)

--========================================================--

-- CLOSE

--========================================================--

CloseBtn.Activated:Connect(function()

	Main.Visible = false
	Float.Visible = true

end)

--========================================================--

-- FPS

--========================================================--

local Frames = 0

local LastFPS = tick()

RS.RenderStepped:Connect(function()

	Frames += 1
	local now = tick()
	if now - LastFPS >= 1 then
		FPSLabel.Text =
			"FPS: "..Frames
		Frames = 0
		LastFPS = now
	end

end)

--========================================================--

-- KEY CHECK

--========================================================--

local function CheckKey()

	local key =
		tostring(KeyBox.Text)
		:gsub("%s+","")
	if key == "2012" then
		KeyError.Text = ""
		KeyGui.Enabled = false
		Main.Visible = true
		if Float then
			Float.Visible = false
		end
		KeyBox.Text = ""
	else
		KeyBox.Text = ""
		KeyError.Text =
			"KEY SAI!"
	end

end

KeyOK.Activated:Connect(CheckKey)

KeyBox.FocusLost:Connect(

	function(enterPressed)
		if enterPressed then
			CheckKey()
		end
	end

)

--========================================================--

-- START BUTTON

--========================================================--

StartButton.Activated:Connect(function()

	Main.Visible = true
	KeyGui.Enabled = false
	if Float then
		Float.Visible = false
	end

end)

--========================================================--

-- CHARACTER RESPAWN

--========================================================--

LP.CharacterAdded:Connect(function(c)

	task.wait(.5)
	FlyOn = false
	FlyUp = false
	FlyDown = false
	if FlyBV then
		FlyBV:Destroy()
		FlyBV = nil
	end
	if FlyBG then
		FlyBG:Destroy()
		FlyBG = nil
	end
	RefreshCharacter(c)
	-- NOCLIP GIỮ TRẠNG THÁI KHI RESPAWN
	if NoclipOn then
		task.wait(.2)
		for _,v in pairs(
			Char:GetDescendants()
		) do
			if v:IsA("BasePart") then
				v.CanCollide = false
			end
		end
	end
	if MobileUp then
		MobileUp.Visible = false
	end
	if MobileDown then
		MobileDown.Visible = false
	end
	if InvisibleOn then
		task.wait(.2)
		ApplyInvisible()
	end
	if AntiLagOn then
		task.wait(.5)
		MakeDefaultSkin(Char)
		StopPlayerAnimations(LP)
		for _,obj in ipairs(
			Char:GetDescendants()
		) do
			DisableEffects(obj)
		end
		local animate =
			Char:FindFirstChild("Animate")
		if animate then
			animate.Disabled = true
		end
	end
	if AimOn then
		AimTarget = nil
		AimCameraOffset = nil
		if AimDot then
			AimDot:Destroy()
			AimDot = nil
		end
	end

end)

--========================================================--

-- START

--========================================================--

Main.Visible = false

Float.Visible = false

KeyGui.Enabled = true

OpenPage("Home")

UpdateSpeedUI()

UpdateFlyUI()

UpdateAimUI()

SetLanguage("VI")

print("================================")

print("HÀ ANH TRƯỜNG - TÚ DOG V3")

print("MENU V2 PURPLE NEON")

print("LANGUAGE MENU ADDED")

print("NOCLIP ADDED")

print("FLY MOBILE FIXED")

print("ANTI LAG RESTORE FIXED")

print("KEY: 2012")

print("FULL VERSION LOADED")

print("================================")
