-- HÀ ANH TRƯỜNG - TÚ DOG
-- Full Roblox Lua script
-- Key: 2012

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local Character, Humanoid, Root
local Flying = false
local Speed = 70
local MAX_SPEED = 1000
local ShiftLock = false
local PlayerLocation = false
local WallHop = false
local Invisible = false
local Aim = false
local SelectedPlayer = nil

local FlightConnection
local LocationObjects = {}
local WallHopTime = 0
local InvisibleMarker = nil

local function SetupCharacter()
	Character = Player.Character or Player.CharacterAdded:Wait()
	Humanoid = Character:WaitForChild("Humanoid")
	Root = Character:WaitForChild("HumanoidRootPart")
end
SetupCharacter()

local OldGui = PlayerGui:FindFirstChild("HaAnhTruong")
if OldGui then OldGui:Destroy() end

local OldKeyGui = PlayerGui:FindFirstChild("KeySystem")
if OldKeyGui then OldKeyGui:Destroy() end

local Gui = Instance.new("ScreenGui")
Gui.Name = "HaAnhTruong"
Gui.ResetOnSpawn = false
Gui.IgnoreGuiInset = true
Gui.Parent = PlayerGui

local Main = Instance.new("Frame")
Main.Size = UDim2.fromOffset(600, 290)
Main.Position = UDim2.new(0.5, -300, 0.5, -145)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Main.BorderSizePixel = 0
Main.Active = true
Main.Visible = false
Main.Parent = Gui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 14)
MainCorner.Parent = Main

local Border = Instance.new("UIStroke")
Border.Color = Color3.fromRGB(0, 255, 200)
Border.Thickness = 2
Border.Parent = Main

local function CreateButton(Parent, Text, Position, Size)
	local Button = Instance.new("TextButton")
	Button.Size = Size
	Button.Position = Position
	Button.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
	Button.Text = Text
	Button.TextColor3 = Color3.fromRGB(230, 230, 230)
	Button.TextSize = 11
	Button.Font = Enum.Font.GothamBold
	Button.Parent = Parent

	local Corner = Instance.new("UICorner")
	Corner.CornerRadius = UDim.new(0, 8)
	Corner.Parent = Button
	return Button
end

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -100, 0, 38)
Title.Position = UDim2.fromOffset(15, 3)
Title.BackgroundTransparency = 1
Title.Text = "HÀ ANH TRƯỜNG - TÚ DOG"
Title.TextColor3 = Color3.fromRGB(0, 255, 200)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Main

local MinButton = CreateButton(Main, "-", UDim2.new(1, -70, 0, 6), UDim2.fromOffset(30, 28))
MinButton.TextColor3 = Color3.fromRGB(0, 255, 200)
MinButton.TextSize = 17

local CloseButton = CreateButton(Main, "X", UDim2.new(1, -36, 0, 6), UDim2.fromOffset(30, 28))
CloseButton.BackgroundColor3 = Color3.fromRGB(70, 25, 35)
CloseButton.TextColor3 = Color3.fromRGB(255, 80, 90)

local Left = Instance.new("Frame")
Left.Size = UDim2.fromOffset(280, 235)
Left.Position = UDim2.fromOffset(15, 45)
Left.BackgroundColor3 = Color3.fromRGB(22, 22, 29)
Left.BorderSizePixel = 0
Left.Parent = Main

local LeftCorner = Instance.new("UICorner")
LeftCorner.CornerRadius = UDim.new(0, 10)
LeftCorner.Parent = Left

local FlyButton = CreateButton(Left, "FLY : OFF", UDim2.fromOffset(10, 10), UDim2.new(1, -20, 0, 38))
FlyButton.TextColor3 = Color3.fromRGB(255, 70, 80)
FlyButton.TextSize = 14

local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(1, -20, 0, 22)
SpeedLabel.Position = UDim2.fromOffset(10, 54)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "Speed: " .. Speed
SpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedLabel.TextSize = 13
SpeedLabel.Font = Enum.Font.GothamBold
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
SpeedLabel.Parent = Left

local MinusButton = CreateButton(Left, "-", UDim2.fromOffset(10, 80), UDim2.fromOffset(55, 34))
local PlusButton = CreateButton(Left, "+", UDim2.fromOffset(72, 80), UDim2.fromOffset(55, 34))
local FastButton = CreateButton(Left, "FAST", UDim2.fromOffset(134, 80), UDim2.fromOffset(65, 34))
local MaxButton = CreateButton(Left, "MAX", UDim2.fromOffset(206, 80), UDim2.fromOffset(64, 34))

PlusButton.TextColor3 = Color3.fromRGB(0, 255, 200)
FastButton.TextColor3 = Color3.fromRGB(255, 220, 70)
MaxButton.TextColor3 = Color3.fromRGB(255, 70, 90)

local ShiftButton = CreateButton(Left, "SHIFT LOCK : OFF", UDim2.fromOffset(10, 125), UDim2.fromOffset(125, 32))
local LocationButton = CreateButton(Left, "LOCATION : OFF", UDim2.fromOffset(145, 125), UDim2.fromOffset(125, 32))
local InvisibleButton = CreateButton(Left, "INVISIBLE : OFF", UDim2.fromOffset(10, 164), UDim2.fromOffset(125, 32))
local WallHopButton = CreateButton(Left, "WALLHOP : OFF", UDim2.fromOffset(145, 164), UDim2.fromOffset(125, 32))

local FPSLabel = Instance.new("TextLabel")
FPSLabel.Size = UDim2.fromOffset(125, 25)
FPSLabel.Position = UDim2.fromOffset(10, 202)
FPSLabel.BackgroundTransparency = 1
FPSLabel.Text = "FPS: --"
FPSLabel.TextColor3 = Color3.fromRGB(0, 255, 200)
FPSLabel.TextSize = 12
FPSLabel.Font = Enum.Font.GothamBold
FPSLabel.TextXAlignment = Enum.TextXAlignment.Left
FPSLabel.Parent = Left

local AimButton = CreateButton(Left, "AIM : OFF", UDim2.fromOffset(145, 202), UDim2.fromOffset(125, 25))
AimButton.TextSize = 10

local Right = Instance.new("Frame")
Right.Size = UDim2.fromOffset(285, 235)
Right.Position = UDim2.fromOffset(305, 45)
Right.BackgroundColor3 = Color3.fromRGB(22, 22, 29)
Right.BorderSizePixel = 0
Right.Parent = Main

local RightCorner = Instance.new("UICorner")
RightCorner.CornerRadius = UDim.new(0, 10)
RightCorner.Parent = Right

local PlayerTitle = Instance.new("TextLabel")
PlayerTitle.Size = UDim2.new(1, -20, 0, 22)
PlayerTitle.Position = UDim2.fromOffset(10, 8)
PlayerTitle.BackgroundTransparency = 1
PlayerTitle.Text = "PLAYERS IN SERVER"
PlayerTitle.TextColor3 = Color3.fromRGB(0, 255, 200)
PlayerTitle.TextSize = 12
PlayerTitle.Font = Enum.Font.GothamBold
PlayerTitle.TextXAlignment = Enum.TextXAlignment.Left
PlayerTitle.Parent = Right

local PlayerList = Instance.new("ScrollingFrame")
PlayerList.Size = UDim2.new(1, -20, 0, 125)
PlayerList.Position = UDim2.fromOffset(10, 32)
PlayerList.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
PlayerList.BorderSizePixel = 0
PlayerList.ScrollBarThickness = 3
PlayerList.AutomaticCanvasSize = Enum.AutomaticSize.Y
PlayerList.Parent = Right

local ListCorner = Instance.new("UICorner")
ListCorner.CornerRadius = UDim.new(0, 8)
ListCorner.Parent = PlayerList

local Layout = Instance.new("UIListLayout")
Layout.Padding = UDim.new(0, 3)
Layout.SortOrder = Enum.SortOrder.Name
Layout.Parent = PlayerList

local Padding = Instance.new("UIPadding")
Padding.PaddingTop = UDim.new(0, 4)
Padding.PaddingBottom = UDim.new(0, 4)
Padding.PaddingLeft = UDim.new(0, 4)
Padding.PaddingRight = UDim.new(0, 4)
Padding.Parent = PlayerList

local SelectedLabel = Instance.new("TextLabel")
SelectedLabel.Size = UDim2.new(1, -20, 0, 22)
SelectedLabel.Position = UDim2.fromOffset(10, 162)
SelectedLabel.BackgroundTransparency = 1
SelectedLabel.Text = "Selected: NONE"
SelectedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SelectedLabel.TextSize = 11
SelectedLabel.Font = Enum.Font.GothamBold
SelectedLabel.TextXAlignment = Enum.TextXAlignment.Left
SelectedLabel.Parent = Right

local TeleportButton = CreateButton(Right, "TELEPORT TO SELECTED", UDim2.fromOffset(10, 190), UDim2.new(1, -20, 0, 35))
TeleportButton.TextColor3 = Color3.fromRGB(0, 255, 200)

local FloatButton = CreateButton(Gui, "FLY", UDim2.new(0.5, -27.5, 0, 75), UDim2.fromOffset(55, 55))
FloatButton.BackgroundColor3 = Color3.fromRGB(18, 25, 28)
FloatButton.TextColor3 = Color3.fromRGB(0, 255, 200)
FloatButton.TextSize = 15
FloatButton.Visible = false

local FloatCorner = Instance.new("UICorner")
FloatCorner.CornerRadius = UDim.new(1, 0)
FloatCorner.Parent = FloatButton

local function UpdatePlayerList()
	for _, Object in ipairs(PlayerList:GetChildren()) do
		if Object:IsA("TextButton") then
			Object:Destroy()
		end
	end

	for _, Target in ipairs(Players:GetPlayers()) do
		if Target ~= Player then
			local Button = CreateButton(
				PlayerList,
				Target.DisplayName .. "  @" .. Target.Name,
				UDim2.new(),
				UDim2.new(1, -8, 0, 27)
			)
			Button.TextSize = 10

			Button.Activated:Connect(function()
				SelectedPlayer = Target
				SelectedLabel.Text = "Selected: " .. Target.Name

				for _, Other in ipairs(PlayerList:GetChildren()) do
					if Other:IsA("TextButton") then
						Other.BackgroundColor3 = Color3.fromRGB(38, 38, 48)
					end
				end

				Button.BackgroundColor3 = Color3.fromRGB(0, 120, 100)
			end)
		end
	end
end

UpdatePlayerList()

Players.PlayerAdded:Connect(function()
	task.wait(0.2)
	UpdatePlayerList()
end)

Players.PlayerRemoving:Connect(function(Target)
	if SelectedPlayer == Target then
		SelectedPlayer = nil
		SelectedLabel.Text = "Selected: NONE"
	end
	UpdatePlayerList()
end)

TeleportButton.Activated:Connect(function()
	if not SelectedPlayer then
		TeleportButton.Text = "SELECT A PLAYER"
		task.delay(1, function()
			if TeleportButton.Parent then
				TeleportButton.Text = "TELEPORT TO SELECTED"
			end
		end)
		return
	end

	local TargetCharacter = SelectedPlayer.Character
	local TargetRoot = TargetCharacter and TargetCharacter:FindFirstChild("HumanoidRootPart")

	if not TargetRoot then
		TeleportButton.Text = "PLAYER NOT READY"
		task.delay(1, function()
			if TeleportButton.Parent then
				TeleportButton.Text = "TELEPORT TO SELECTED"
			end
		end)
		return
	end

	SetupCharacter()
	Root.CFrame = TargetRoot.CFrame * CFrame.new(0, 0, 4)

	TeleportButton.Text = "TELEPORTED"
	task.delay(1, function()
		if TeleportButton.Parent then
			TeleportButton.Text = "TELEPORT TO SELECTED"
		end
	end)
end)

local function MakeDraggable(Object)
	local Dragging = false
	local StartPosition
	local StartInput

	Object.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.Touch
			or Input.UserInputType == Enum.UserInputType.MouseButton1 then

			Dragging = true
			StartInput = Input.Position
			StartPosition = Object.Position

			Input.Changed:Connect(function()
				if Input.UserInputState == Enum.UserInputState.End then
					Dragging = false
				end
			end)
		end
	end)

	UIS.InputChanged:Connect(function(Input)
		if not Dragging then return end

		if Input.UserInputType ~= Enum.UserInputType.Touch
			and Input.UserInputType ~= Enum.UserInputType.MouseMovement then
			return
		end

		local Delta = Input.Position - StartInput

		Object.Position = UDim2.new(
			StartPosition.X.Scale,
			StartPosition.X.Offset + Delta.X,
			StartPosition.Y.Scale,
			StartPosition.Y.Offset + Delta.Y
		)
	end)
end

MakeDraggable(Main)

local Frames = 0
local FPSTime = os.clock()

RunService.RenderStepped:Connect(function()
	Frames += 1

	if os.clock() - FPSTime >= 1 then
		FPSLabel.Text = "FPS: " .. Frames
		Frames = 0
		FPSTime = os.clock()
	end
end)

local function RemoveLocation(Target)
	if LocationObjects[Target] then
		LocationObjects[Target]:Destroy()
		LocationObjects[Target] = nil
	end
end

local function AddPlayerMarker(Target)
	if Target == Player or LocationObjects[Target] then return end

	local Char = Target.Character
	if not Char then return end

	local TargetRoot = Char:FindFirstChild("HumanoidRootPart")
	if not TargetRoot then return end

	local Billboard = Instance.new("BillboardGui")
	Billboard.Name = "PlayerLocation"
	Billboard.Size = UDim2.fromOffset(170, 45)
	Billboard.StudsOffset = Vector3.new(0, 4, 0)
	Billboard.AlwaysOnTop = true
	Billboard.MaxDistance = 10000
	Billboard.Adornee = TargetRoot
	Billboard.Parent = TargetRoot

	local Text = Instance.new("TextLabel")
	Text.Size = UDim2.fromScale(1, 1)
	Text.BackgroundTransparency = 1
	Text.Text = Target.Name .. " | 0 m"
	Text.TextColor3 = Color3.fromRGB(255, 255, 255)
	Text.TextStrokeTransparency = 0
	Text.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Text.TextSize = 13
	Text.Font = Enum.Font.GothamBold
	Text.Parent = Billboard

	LocationObjects[Target] = Billboard
end

local function ClearLocations()
	for Target, Billboard in pairs(LocationObjects) do
		if Billboard then Billboard:Destroy() end
		LocationObjects[Target] = nil
	end
end

RunService.RenderStepped:Connect(function()
	if not PlayerLocation or not Root then return end

	for _, Target in ipairs(Players:GetPlayers()) do
		if Target ~= Player then
			local Char = Target.Character
			local TargetRoot = Char and Char:FindFirstChild("HumanoidRootPart")

			if TargetRoot then
				if not LocationObjects[Target] then
					AddPlayerMarker(Target)
				end

				local Billboard = LocationObjects[Target]

				if Billboard and Billboard.Parent then
					local Text = Billboard:FindFirstChildOfClass("TextLabel")

					if Text then
						local Distance = (Root.Position - TargetRoot.Position).Magnitude
						Text.Text = Target.Name .. " | " .. math.floor(Distance + 0.5) .. " m"
					end
				end
			else
				RemoveLocation(Target)
			end
		end
	end
end)

Players.PlayerAdded:Connect(function(Target)
	Target.CharacterAdded:Connect(function()
		task.wait(1)
		if PlayerLocation then
			AddPlayerMarker(Target)
		end
	end)
end)

Players.PlayerRemoving:Connect(RemoveLocation)

local function StopFly()
	Flying = false

	if FlightConnection then
		FlightConnection:Disconnect()
		FlightConnection = nil
	end

	if Humanoid then Humanoid.AutoRotate = true end
	if Root then Root.AssemblyLinearVelocity = Vector3.zero end

	FlyButton.Text = "FLY : OFF"
	FlyButton.TextColor3 = Color3.fromRGB(255, 70, 80)
end

local function StartFly()
	SetupCharacter()

	if not Humanoid or not Root then return end
	if FlightConnection then FlightConnection:Disconnect() end

	Flying = true
	Humanoid.AutoRotate = false

	FlyButton.Text = "FLY : ON"
	FlyButton.TextColor3 = Color3.fromRGB(0, 255, 150)

	FlightConnection = RunService.RenderStepped:Connect(function()
		if not Flying or not Root or not Root.Parent then return end

		local Camera = workspace.CurrentCamera
		if not Camera then return end

		local Move = Humanoid.MoveDirection

		if Move.Magnitude < 0.01 then
			Root.AssemblyLinearVelocity = Vector3.zero
			return
		end

		local Forward = Camera.CFrame.LookVector
		local Right = Camera.CFrame.RightVector

		local Direction =
			Forward * Move:Dot(Forward)
			+ Right * Move:Dot(Right)

		if Direction.Magnitude > 0.01 then
			Direction = Direction.Unit
			Root.AssemblyLinearVelocity = Direction * Speed

			if ShiftLock then
				Root.CFrame = CFrame.lookAt(
					Root.Position,
					Root.Position + Direction
				)
			end
		else
			Root.AssemblyLinearVelocity = Vector3.zero
		end
	end)
end

MinusButton.Activated:Connect(function()
	Speed = math.max(10, Speed - 10)
	SpeedLabel.Text = "Speed: " .. Speed
end)

PlusButton.Activated:Connect(function()
	Speed = math.min(MAX_SPEED, Speed + 10)
	SpeedLabel.Text = "Speed: " .. Speed
end)

FastButton.Activated:Connect(function()
	Speed = 120
	SpeedLabel.Text = "Speed: 120"
end)

MaxButton.Activated:Connect(function()
	Speed = MAX_SPEED
	SpeedLabel.Text = "Speed: " .. MAX_SPEED
end)

FlyButton.Activated:Connect(function()
	if Flying then
		StopFly()
	else
		StartFly()
	end
end)

ShiftButton.Activated:Connect(function()
	ShiftLock = not ShiftLock

	if ShiftLock then
		ShiftButton.Text = "SHIFT LOCK : ON"
		ShiftButton.TextColor3 = Color3.fromRGB(0, 255, 200)
	else
		ShiftButton.Text = "SHIFT LOCK : OFF"
		ShiftButton.TextColor3 = Color3.fromRGB(230, 230, 230)
	end
end)

LocationButton.Activated:Connect(function()
	PlayerLocation = not PlayerLocation

	if PlayerLocation then
		LocationButton.Text = "LOCATION : ON"
		LocationButton.TextColor3 = Color3.fromRGB(0, 255, 200)

		for _, Target in ipairs(Players:GetPlayers()) do
			if Target ~= Player then
				AddPlayerMarker(Target)
			end
		end
	else
		LocationButton.Text = "LOCATION : OFF"
		LocationButton.TextColor3 = Color3.fromRGB(230, 230, 230)
		ClearLocations()
	end
end)

local function CreateInvisibleMarker()
	if InvisibleMarker then
		InvisibleMarker:Destroy()
		InvisibleMarker = nil
	end

	if not Root then return end

	InvisibleMarker = Instance.new("BillboardGui")
	InvisibleMarker.Name = "InvisibleMarker"
	InvisibleMarker.Size = UDim2.fromOffset(5, 5)
	InvisibleMarker.StudsOffset = Vector3.zero
	InvisibleMarker.AlwaysOnTop = true
	InvisibleMarker.MaxDistance = 10000
	InvisibleMarker.Adornee = Root
	InvisibleMarker.Parent = Root

	local Dot = Instance.new("Frame")
	Dot.Size = UDim2.fromScale(1, 1)
	Dot.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	Dot.BorderSizePixel = 0
	Dot.Parent = InvisibleMarker

	local Corner = Instance.new("UICorner")
	Corner.CornerRadius = UDim.new(1, 0)
	Corner.Parent = Dot
end

local function RemoveInvisibleMarker()
	if InvisibleMarker then
		InvisibleMarker:Destroy()
		InvisibleMarker = nil
	end
end

local function SetInvisible(State)
	Invisible = State
	if not Character then return end

	for _, Object in ipairs(Character:GetDescendants()) do
		if Object:IsA("BasePart") then
			if Object.Name ~= "HumanoidRootPart" then
				Object.LocalTransparencyModifier = State and 1 or 0
			end
		elseif Object:IsA("Decal") or Object:IsA("Texture") then
			Object.Transparency = State and 1 or 0
		elseif Object:IsA("ParticleEmitter")
			or Object:IsA("Trail")
			or Object:IsA("Beam") then
			Object.Enabled = not State
		end
	end

	if Humanoid then
		Humanoid.DisplayDistanceType =
			State and Enum.HumanoidDisplayDistanceType.None
			or Enum.HumanoidDisplayDistanceType.Viewer
	end

	if State then
		CreateInvisibleMarker()
		InvisibleButton.Text = "INVISIBLE : ON"
		InvisibleButton.TextColor3 = Color3.fromRGB(0, 255, 200)
	else
		RemoveInvisibleMarker()
		InvisibleButton.Text = "INVISIBLE : OFF"
		InvisibleButton.TextColor3 = Color3.fromRGB(230, 230, 230)
	end
end

InvisibleButton.Activated:Connect(function()
	SetInvisible(not Invisible)
end)

WallHopButton.Activated:Connect(function()
	WallHop = not WallHop

	if WallHop then
		WallHopButton.Text = "WALLHOP : ON"
		WallHopButton.TextColor3 = Color3.fromRGB(0, 255, 200)
	else
		WallHopButton.Text = "WALLHOP : OFF"
		WallHopButton.TextColor3 = Color3.fromRGB(230, 230, 230)
	end
end)

local function DoWallHop()
	if not WallHop then return end
	if not Character or not Humanoid or not Root then return end
	if os.clock() - WallHopTime < 0.15 then return end

	local Move = Humanoid.MoveDirection
	if Move.Magnitude < 0.05 then return end

	local Params = RaycastParams.new()
	Params.FilterType = Enum.RaycastFilterType.Exclude
	Params.FilterDescendantsInstances = {Character}

	local Directions = {
		Move.Unit,
		Root.CFrame.RightVector,
		-Root.CFrame.RightVector
	}

	for _, Direction in ipairs(Directions) do
		local Hit = workspace:Raycast(
			Root.Position,
			Direction * 3.5,
			Params
		)

		if Hit then
			local Normal = Hit.Normal
			local Velocity = Root.AssemblyLinearVelocity

			Root.AssemblyLinearVelocity =
				Vector3.new(
					Velocity.X * 0.25,
					55,
					Velocity.Z * 0.25
				) + Normal * 28

			Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
			WallHopTime = os.clock()
			break
		end
	end
end

UIS.JumpRequest:Connect(function()
	if WallHop then
		task.defer(DoWallHop)
	end
end)

-- AIM: giữ camera bình thường, chọn người gần tâm màn hình
local function GetClosestPlayerToCenter()
	local Camera = workspace.CurrentCamera
	if not Camera then return nil end

	local ViewportSize = Camera.ViewportSize
	local ScreenCenter = Vector2.new(
		ViewportSize.X / 2,
		ViewportSize.Y / 2
	)

	local ClosestPlayer = nil
	local ClosestDistance = math.huge

	for _, Target in ipairs(Players:GetPlayers()) do
		if Target ~= Player then
			local TargetCharacter = Target.Character

			if TargetCharacter then
				local TargetHumanoid =
					TargetCharacter:FindFirstChildOfClass("Humanoid")
				local Head =
					TargetCharacter:FindFirstChild("Head")

				if TargetHumanoid
					and TargetHumanoid.Health > 0
					and Head then

					local ScreenPosition, OnScreen =
						Camera:WorldToViewportPoint(Head.Position)

					if OnScreen and ScreenPosition.Z > 0 then
						local ScreenPoint = Vector2.new(
							ScreenPosition.X,
							ScreenPosition.Y
						)

						local Distance =
							(ScreenPoint - ScreenCenter).Magnitude

						if Distance < ClosestDistance then
							ClosestDistance = Distance
							ClosestPlayer = Target
						end
					end
				end
			end
		end
	end

	return ClosestPlayer
end

AimButton.Activated:Connect(function()
	Aim = not Aim

	if Aim then
		AimButton.Text = "AIM : ON"
		AimButton.TextColor3 = Color3.fromRGB(0, 255, 200)
	else
		AimButton.Text = "AIM : OFF"
		AimButton.TextColor3 = Color3.fromRGB(230, 230, 230)
	end
end)

RunService.RenderStepped:Connect(function()
	if not Aim then return end
	if not Character or not Humanoid or not Root then return end

	local Camera = workspace.CurrentCamera
	if not Camera then return end

	Camera.CameraType = Enum.CameraType.Custom
	Camera.CameraSubject = Humanoid

	local Target = GetClosestPlayerToCenter()
	if not Target then return end

	local TargetCharacter = Target.Character
	if not TargetCharacter then return end

	local Head = TargetCharacter:FindFirstChild("Head")
	if not Head then return end

	local Direction = Head.Position - Root.Position

	local FlatDirection = Vector3.new(
		Direction.X,
		0,
		Direction.Z
	)

	if FlatDirection.Magnitude > 0.1 then
		Root.CFrame = CFrame.lookAt(
			Root.Position,
			Root.Position + FlatDirection
		)
	end
end)

MinButton.Activated:Connect(function()
	Main.Visible = false
	FloatButton.Visible = true
	FloatButton.Position = UDim2.new(0.5, -27.5, 0, 75)
end)

FloatButton.Activated:Connect(function()
	Main.Visible = true
	FloatButton.Visible = false
end)

CloseButton.Activated:Connect(function()
	StopFly()
	ClearLocations()
	RemoveInvisibleMarker()

	local Camera = workspace.CurrentCamera
	if Camera and Humanoid then
		Camera.CameraType = Enum.CameraType.Custom
		Camera.CameraSubject = Humanoid
	end

	Gui:Destroy()
end)

Player.CharacterAdded:Connect(function()
	task.wait(1)
	SetupCharacter()

	if Flying then
		StartFly()
	end

	if Invisible then
		task.wait(0.2)
		SetInvisible(true)
	end
end)

-- KEY SYSTEM
local CorrectKey = "2012"

local KeyGui = Instance.new("ScreenGui")
KeyGui.Name = "KeySystem"
KeyGui.ResetOnSpawn = false
KeyGui.IgnoreGuiInset = true
KeyGui.DisplayOrder = 999
KeyGui.Parent = PlayerGui

local KeyFrame = Instance.new("Frame")
KeyFrame.Size = UDim2.fromOffset(150, 150)
KeyFrame.Position = UDim2.new(0.5, -75, 0.5, -75)
KeyFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
KeyFrame.BorderSizePixel = 0
KeyFrame.Parent = KeyGui

local KeyCorner = Instance.new("UICorner")
KeyCorner.CornerRadius = UDim.new(0, 12)
KeyCorner.Parent = KeyFrame

local KeyStroke = Instance.new("UIStroke")
KeyStroke.Color = Color3.fromRGB(0, 255, 200)
KeyStroke.Thickness = 2
KeyStroke.Parent = KeyFrame

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Size = UDim2.new(1, -20, 0, 25)
KeyTitle.Position = UDim2.fromOffset(10, 8)
KeyTitle.BackgroundTransparency = 1
KeyTitle.Text = "NHẬP KEY"
KeyTitle.TextColor3 = Color3.fromRGB(0, 255, 200)
KeyTitle.TextSize = 14
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.Parent = KeyFrame

local KeyBox = Instance.new("TextBox")
KeyBox.Size = UDim2.fromOffset(120, 32)
KeyBox.Position = UDim2.fromOffset(15, 42)
KeyBox.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
KeyBox.PlaceholderText = "KEY..."
KeyBox.Text = ""
KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyBox.PlaceholderColor3 = Color3.fromRGB(130, 130, 130)
KeyBox.TextSize = 13
KeyBox.Font = Enum.Font.GothamBold
KeyBox.ClearTextOnFocus = false
KeyBox.TextXAlignment = Enum.TextXAlignment.Center
KeyBox.Parent = KeyFrame

local BoxCorner = Instance.new("UICorner")
BoxCorner.CornerRadius = UDim.new(0, 7)
BoxCorner.Parent = KeyBox

local CheckButton = Instance.new("TextButton")
CheckButton.Size = UDim2.fromOffset(120, 32)
CheckButton.Position = UDim2.fromOffset(15, 82)
CheckButton.BackgroundColor3 = Color3.fromRGB(0, 150, 120)
CheckButton.BorderSizePixel = 0
CheckButton.Text = "ĐỒNG Ý"
CheckButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CheckButton.TextSize = 12
CheckButton.Font = Enum.Font.GothamBold
CheckButton.AutoButtonColor = true
CheckButton.ZIndex = 10
CheckButton.Parent = KeyFrame

local CheckCorner = Instance.new("UICorner")
CheckCorner.CornerRadius = UDim.new(0, 7)
CheckCorner.Parent = CheckButton

local ErrorLabel = Instance.new("TextLabel")
ErrorLabel.Size = UDim2.fromOffset(120, 20)
ErrorLabel.Position = UDim2.fromOffset(15, 120)
ErrorLabel.BackgroundTransparency = 1
ErrorLabel.Text = ""
ErrorLabel.TextColor3 = Color3.fromRGB(255, 70, 80)
ErrorLabel.TextSize = 10
ErrorLabel.Font = Enum.Font.GothamBold
ErrorLabel.TextXAlignment = Enum.TextXAlignment.Center
ErrorLabel.Parent = KeyFrame

local function CheckKey()
	if KeyBox.Text == CorrectKey then
		KeyGui:Destroy()
		Main.Visible = true
	else
		KeyBox.Text = ""
		ErrorLabel.Text = "KEY SAI!"

		task.delay(1, function()
			if ErrorLabel and ErrorLabel.Parent then
				ErrorLabel.Text = ""
			end
		end)
	end
end

CheckButton.Activated:Connect(CheckKey)

KeyBox.FocusLost:Connect(function(EnterPressed)
	if EnterPressed then
		CheckKey()
	end
end)
