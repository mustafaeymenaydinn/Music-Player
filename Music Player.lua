local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local songs = {
	{Name="Nostalgia", Id="9038238828"},
	{Name="Morning Mood", Id="1846088038"},
	{Name="The Four Seasons - Spring", Id="9045766074"},
	{Name="Gymnopedie No.1", Id="9045766377"},
	{Name="Clair de Lune", Id="1846315693"},
	{Name="Bach – Toccata & Fugue", Id="564238335"},
	{Name="Beethoven – Fur Elise", Id="450051032"},
	{Name="Beethoven – Moonlight Sonata", Id="445023353"},
	{Name="Imagine Dragons – Believer", Id="444949138"},
	{Name="Lady Gaga – Applause", Id="130964099"},
	{Name="BadLiZ – The Great Strategy", Id="2179404450"}
}

local currentIndex = 1

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "NostalgicMusicPlayer"
screenGui.Parent = playerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 450, 0, 250)
frame.Position = UDim2.new(0.5, -225, 0.6, -125)
frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
frame.BorderSizePixel = 0
frame.Parent = screenGui

local function addUICorner(obj, radius)
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, radius or 10)
	corner.Parent = obj
end

addUICorner(frame, 15)

local dragging
local dragInput
local dragStart
local startPos
local UserInputService = game:GetService("UserInputService")

local function update(input)
	local delta = input.Position - dragStart
	frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
		startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

frame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = frame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

frame.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		update(input)
	end
end)

local sound = Instance.new("Sound")
sound.SoundId = "rbxassetid://"..songs[currentIndex].Id
sound.Volume = 0.5
sound.Looped = false
sound.Parent = frame

local songLabel = Instance.new("TextLabel")
songLabel.Size = UDim2.new(0, 430, 0, 30)
songLabel.Position = UDim2.new(0,10,0,10)
songLabel.BackgroundTransparency = 1
songLabel.TextColor3 = Color3.fromRGB(255,255,255)
songLabel.TextScaled = true
songLabel.Text = songs[currentIndex].Name
songLabel.Parent = frame

local function createButton(name, pos)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0,90,0,40)
	btn.Position = pos
	btn.Text = name
	btn.Parent = frame
	return btn
end

local playButton = createButton("Play", UDim2.new(0.05,0,0.7,0))
local pauseButton = createButton("Pause", UDim2.new(0.25,0,0.7,0))
local stopButton = createButton("Stop", UDim2.new(0.45,0,0.7,0))
local nextButton = createButton("Next", UDim2.new(0.65,0,0.7,0))

local addSongBox = Instance.new("TextBox")
addSongBox.Size = UDim2.new(0, 200, 0, 30)
addSongBox.Position = UDim2.new(0.05,0,0.55,0)
addSongBox.PlaceholderText = "Enter Song ID and press Enter"
addSongBox.Text = ""
addSongBox.ClearTextOnFocus = true
addSongBox.Parent = frame

addSongBox.FocusLost:Connect(function(enterPressed)
	if enterPressed then
		local songId = addSongBox.Text
		if tonumber(songId) then
			local songName = "Custom Song "..(#songs+1)
			table.insert(songs, {Name=songName, Id=songId})
			print("Added song:", songName, songId)
			addSongBox.Text = ""
		else
			print("Invalid ID!")
		end
	end
end)

local volumeBar = Instance.new("Frame")
volumeBar.Size = UDim2.new(0,250,0,10)
volumeBar.Position = UDim2.new(0.05,0,0.45,0)
volumeBar.BackgroundColor3 = Color3.fromRGB(100,100,100)
volumeBar.Parent = frame
addUICorner(volumeBar, 5)

local volumeFill = Instance.new("Frame")
volumeFill.Size = UDim2.new(sound.Volume,0,1,0)
volumeFill.BackgroundColor3 = Color3.fromRGB(0,200,0)
volumeFill.Parent = volumeBar
addUICorner(volumeFill, 5)

volumeBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		local function updateVolume()
			local mouse = player:GetMouse()
			local relativeX = math.clamp(mouse.X - volumeBar.AbsolutePosition.X, 0, volumeBar.AbsoluteSize.X)
			local volume = relativeX / volumeBar.AbsoluteSize.X
			sound.Volume = volume
			volumeFill.Size = UDim2.new(volume,0,1,0)
		end
		updateVolume()
		local conn
		conn = UserInputService.InputChanged:Connect(function()
			updateVolume()
		end)
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				conn:Disconnect()
			end
		end)
	end
end)

playButton.MouseButton1Click:Connect(function()
	sound:Play()
end)

pauseButton.MouseButton1Click:Connect(function()
	sound:Pause()
end)

stopButton.MouseButton1Click:Connect(function()
	sound:Stop()
end)

nextButton.MouseButton1Click:Connect(function()
	sound:Stop()
	currentIndex = currentIndex + 1
	if currentIndex > #songs then currentIndex = 1 end
	sound.SoundId = "rbxassetid://"..songs[currentIndex].Id
	songLabel.Text = songs[currentIndex].Name
	sound:Play()
end)

sound.Ended:Connect(function()
	nextButton.MouseButton1Click:Fire()
end)
