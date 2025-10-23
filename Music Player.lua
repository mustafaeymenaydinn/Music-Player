local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "MusicPlayer"
gui.Parent = player:WaitForChild("PlayerGui")

-- Ana frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 460, 0, 240)
frame.Position = UDim2.new(0.5, -230, 0.7, -120)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.Parent = gui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = " Roblox Music Player"
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextColor3 = Color3.fromRGB(255,255,255)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame

local currentSongLabel = Instance.new("TextLabel")
currentSongLabel.Size = UDim2.new(1, -20, 0, 25)
currentSongLabel.Position = UDim2.new(0, 10, 0, 40)
currentSongLabel.BackgroundTransparency = 1
currentSongLabel.Font = Enum.Font.GothamBold
currentSongLabel.TextSize = 14
currentSongLabel.TextColor3 = Color3.fromRGB(180,180,180)
currentSongLabel.TextXAlignment = Enum.TextXAlignment.Left
currentSongLabel.Text = "Playing: "
currentSongLabel.Parent = frame

local volumeLabel = Instance.new("TextLabel")
volumeLabel.Size = UDim2.new(0, 60, 0, 20)
volumeLabel.Position = UDim2.new(0, 20, 0, 70)
volumeLabel.BackgroundTransparency = 1
volumeLabel.Text = "Volume"
volumeLabel.Font = Enum.Font.GothamBold
volumeLabel.TextSize = 14
volumeLabel.TextColor3 = Color3.fromRGB(255,255,255)
volumeLabel.Parent = frame

local volumeBox = Instance.new("TextBox")
volumeBox.Size = UDim2.new(0, 80, 0, 20)
volumeBox.Position = UDim2.new(0, 90, 0, 70)
volumeBox.Text = "0.5"
volumeBox.Font = Enum.Font.GothamBold
volumeBox.TextColor3 = Color3.fromRGB(0,0,0)
volumeBox.PlaceholderColor3 = Color3.fromRGB(60,60,60)
volumeBox.BackgroundColor3 = Color3.fromRGB(230,230,230)
volumeBox.TextScaled = true
volumeBox.Parent = frame
Instance.new("UICorner", volumeBox).CornerRadius = UDim.new(0, 8)

local songLabel = Instance.new("TextLabel")
songLabel.Size = UDim2.new(0, 60, 0, 20)
songLabel.Position = UDim2.new(0, 200, 0, 70)
songLabel.BackgroundTransparency = 1
songLabel.Text = "Song ID"
songLabel.Font = Enum.Font.GothamBold
songLabel.TextSize = 14
songLabel.TextColor3 = Color3.fromRGB(255,255,255)
songLabel.Parent = frame

local songBox = Instance.new("TextBox")
songBox.Size = UDim2.new(0, 120, 0, 20)
songBox.Position = UDim2.new(0, 270, 0, 70)
songBox.Text = ""
songBox.Font = Enum.Font.GothamBold
songBox.TextColor3 = Color3.fromRGB(0,0,0)
songBox.PlaceholderColor3 = Color3.fromRGB(60,60,60)
songBox.BackgroundColor3 = Color3.fromRGB(230,230,230)
songBox.TextScaled = true
songBox.Parent = frame
Instance.new("UICorner", songBox).CornerRadius = UDim.new(0, 8)

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
	{Name="BadLiZ – Roblox Theme (2006)", Id="1837465702"}
}

local current = 1
local sound = Instance.new("Sound")
sound.Parent = workspace
sound.Volume = tonumber(volumeBox.Text) or 0.5
sound.SoundId = "rbxassetid://"..songs[current].Id
sound:Play()
currentSongLabel.Text = "Playing: "..songs[current].Name

local function createButton(text, pos)
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(0, 60, 0, 40)
	b.Position = pos
	b.Text = text
	b.Font = Enum.Font.GothamBold
	b.TextScaled = true
	b.TextColor3 = Color3.fromRGB(255,255,255)
	b.BackgroundColor3 = Color3.fromRGB(40,40,40)
	Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
	b.Parent = frame
	-- Hover efektleri
	b.MouseEnter:Connect(function()
		b.BackgroundColor3 = Color3.fromRGB(60,60,60)
	end)
	b.MouseLeave:Connect(function()
		b.BackgroundColor3 = Color3.fromRGB(40,40,40)
	end)
	return b
end

local playBtn = createButton("▶", UDim2.new(0, 20, 0, 100))
local pauseBtn = createButton("⏸", UDim2.new(0, 90, 0, 100))
local stopBtn = createButton("■", UDim2.new(0, 160, 0, 100))
local nextBtn = createButton("⏭", UDim2.new(0, 230, 0, 100))
local prevBtn = createButton("⏮", UDim2.new(0, 300, 0, 100))

playBtn.MouseButton1Click:Connect(function()
	if not sound.IsPlaying then sound:Play() end
end)
pauseBtn.MouseButton1Click:Connect(function()
	if sound.IsPlaying then sound:Pause() end
end)
stopBtn.MouseButton1Click:Connect(function()
	sound:Stop()
end)
nextBtn.MouseButton1Click:Connect(function()
	current = (current % #songs) + 1
	sound.SoundId = "rbxassetid://"..songs[current].Id
	sound:Play()
	currentSongLabel.Text = "Playing: "..songs[current].Name
end)
prevBtn.MouseButton1Click:Connect(function()
	current = (current - 2) % #songs + 1
	sound.SoundId = "rbxassetid://"..songs[current].Id
	sound:Play()
	currentSongLabel.Text = "Playing: "..songs[current].Name
end)

local locale = player.LocaleId
local messages = {}
if string.sub(locale,1,2) == "tr" then
	messages = {
		SongAdded = "✅ Song Added Succsessfully!",
		SongFailed = "❌ Failed to add song!",
		VolumeChanged = "✅ Volume adjusted successfully!",
		VolumeFailed = "❌ Failed to adjust volume!"
	}
else
	messages = {
		SongAdded = "✅ Song added successfully!",
		SongFailed = "❌ Failed to add song!",
		VolumeChanged = "✅ Volume adjusted successfully!",
		VolumeFailed = "❌ Failed to adjust volume!"
	}
end

local function showNotification(text, duration)
	duration = duration or 2
	local notif = Instance.new("Frame")
	notif.Size = UDim2.new(0, 220, 0, 60)
	notif.Position = UDim2.new(1, -230, 1, -80)
	notif.BackgroundColor3 = Color3.fromRGB(30,30,30)
	notif.BackgroundTransparency = 0
	notif.Parent = gui
	Instance.new("UICorner", notif).CornerRadius = UDim.new(0,12)

	local progressBar = Instance.new("Frame")
	progressBar.Size = UDim2.new(1,0,0,5)
	progressBar.Position = UDim2.new(0,0,0,0)
	progressBar.BackgroundColor3 = Color3.fromRGB(0,170,255)
	progressBar.Parent = notif
	Instance.new("UICorner", progressBar).CornerRadius = UDim.new(0,2)

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, -10, 1, -10)
	label.Position = UDim2.new(0, 5, 0, 5)
	label.BackgroundTransparency = 1
	label.Text = text
	label.TextColor3 = Color3.fromRGB(255,255,255)
	label.Font = Enum.Font.GothamBold
	label.TextScaled = true
	label.TextWrapped = true
	label.Parent = notif

	local ts = TweenInfo.new(duration, Enum.EasingStyle.Linear)
	local tween = TweenService:Create(progressBar, ts, {Size = UDim2.new(0,0,0,5)})
	tween:Play()
	tween.Completed:Connect(function()
		local tweenOut = TweenService:Create(notif, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Position = UDim2.new(1, 250, 1, -80)})
		tweenOut:Play()
		tweenOut.Completed:Connect(function()
			notif:Destroy()
		end)
	end)
end

songBox.FocusLost:Connect(function(enter)
	if enter and tonumber(songBox.Text) then
		if math.random() < 0.5 then
			table.insert(songs, {Name="Custom "..#songs+1, Id=songBox.Text})
			songBox.Text = ""
			showNotification(messages.SongAdded,2)
		else
			showNotification(messages.SongFailed,2)
			songBox.Text = ""
		end
	end
end)

volumeBox.FocusLost:Connect(function(enter)
	if enter then
		local vol = tonumber(volumeBox.Text)
		if vol then
			if math.random() < 0.5 then
				sound.Volume = math.clamp(vol,0,1)
				showNotification(messages.VolumeChanged,2)
			else
				showNotification(messages.VolumeFailed,2)
				volumeBox.Text = tostring(sound.Volume)
			end
		end
	end
end)

local progressBarMain = Instance.new("Frame")
progressBarMain.Size = UDim2.new(0, 400, 0, 5)
progressBarMain.Position = UDim2.new(0, 30, 0, 150)
progressBarMain.BackgroundColor3 = Color3.fromRGB(50,50,50)
progressBarMain.Parent = frame
Instance.new("UICorner", progressBarMain).CornerRadius = UDim.new(0,2)

local progress = Instance.new("Frame")
progress.Size = UDim2.new(0,0,1,0)
progress.Position = UDim2.new(0,0,0,0)
progress.BackgroundColor3 = Color3.fromRGB(0,170,255)
progress.Parent = progressBarMain
Instance.new("UICorner", progress).CornerRadius = UDim.new(0,2)

RunService.RenderStepped:Connect(function()
	if sound.TimeLength > 0 then
		local percent = sound.TimePosition / sound.TimeLength
		progress.Size = UDim2.new(percent,0,1,0)
	end
end)

local dragToggle, dragStart, startPos
frame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragToggle = true
		dragStart = input.Position
		startPos = frame.Position
	end
end)
frame.InputChanged:Connect(function(input)
	if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) and dragToggle then
		local delta = input.Position - dragStart
		frame.Position = UDim2.new(
			startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y
		)
	end
end)
frame.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragToggle = false
	end
end)
