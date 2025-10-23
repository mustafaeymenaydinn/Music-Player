local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "MusicPlayer"
gui.Parent = player:WaitForChild("PlayerGui")

-- Ana frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 460, 0, 400)
frame.Position = UDim2.new(0.5, -230, 0.5, -200)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.Parent = gui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

-- Başlık
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = "Roblox Music Player"
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextColor3 = Color3.fromRGB(255,255,255)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame

-- Çalan şarkı
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

-- Volume
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

-- Song ID
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

-- Şarkılar
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

-- Butonlar (play, pause, stop, next, prev)
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
	b.MouseEnter:Connect(function() b.BackgroundColor3 = Color3.fromRGB(60,60,60) end)
	b.MouseLeave:Connect(function() b.BackgroundColor3 = Color3.fromRGB(40,40,40) end)
	return b
end

local playBtn = createButton("▶", UDim2.new(0, 20, 0, 100))
local pauseBtn = createButton("⏸", UDim2.new(0, 90, 0, 100))
local stopBtn = createButton("■", UDim2.new(0, 160, 0, 100))
local nextBtn = createButton("⏭", UDim2.new(0, 230, 0, 100))
local prevBtn = createButton("⏮", UDim2.new(0, 300, 0, 100))

playBtn.MouseButton1Click:Connect(function() if not sound.IsPlaying then sound:Play() end end)
pauseBtn.MouseButton1Click:Connect(function() if sound.IsPlaying then sound:Pause() end end)
stopBtn.MouseButton1Click:Connect(function() sound:Stop() end)
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

-- Bildirim fonksiyonu
local function showNotification(text,duration)
	duration = duration or 2
	local notif = Instance.new("Frame")
	notif.Size = UDim2.new(0,220,0,60)
	notif.Position = UDim2.new(1,-230,1,-80)
	notif.BackgroundColor3 = Color3.fromRGB(30,30,30)
	notif.Parent = gui
	Instance.new("UICorner",notif).CornerRadius = UDim.new(0,12)

	local progressBar = Instance.new("Frame")
	progressBar.Size = UDim2.new(1,0,0,5)
	progressBar.Position = UDim2.new(0,0,0,0)
	progressBar.BackgroundColor3 = Color3.fromRGB(0,170,255)
	progressBar.Parent = notif
	Instance.new("UICorner",progressBar).CornerRadius=UDim.new(0,2)

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1,-10,1,-10)
	label.Position = UDim2.new(0,5,0,5)
	label.BackgroundTransparency = 1
	label.Text = text
	label.TextColor3 = Color3.fromRGB(255,255,255)
	label.Font = Enum.Font.GothamBold
	label.TextScaled = true
	label.TextWrapped = true
	label.Parent = notif

	local ts = TweenInfo.new(duration,Enum.EasingStyle.Linear)
	local tween = TweenService:Create(progressBar,ts,{Size=UDim2.new(0,0,0,5)})
	tween:Play()
	tween.Completed:Connect(function()
		local tweenOut = TweenService:Create(notif,TweenInfo.new(0.3,Enum.EasingStyle.Quad),{Position=UDim2.new(1,250,1,-80)})
		tweenOut:Play()
		tweenOut.Completed:Connect(function() notif:Destroy() end)
	end)
end

-- Dil tespiti
local locale = player.LocaleId
local messages = {}
if string.sub(locale,1,2) == "tr" then
	messages = {SongAdded="✅ Şarkı başarıyla eklendi!",SongFailed="❌ Şarkı eklenemedi!",VolumeChanged="✅ Ses başarıyla ayarlandı!",VolumeFailed="❌ Ses ayarlanamadı!"}
else
	messages = {SongAdded="✅ Song added successfully!",SongFailed="❌ Failed to add song!",VolumeChanged="✅ Volume adjusted successfully!",VolumeFailed="❌ Failed to adjust volume!"}
end

-- Song ekleme
songBox.FocusLost:Connect(function(enter)
	if enter and tonumber(songBox.Text) then
		if math.random()<0.5 then
			table.insert(songs,{Name="Custom "..#songs+1,Id=songBox.Text})
			songBox.Text=""
			showNotification(messages.SongAdded,2)
		else
			showNotification(messages.SongFailed,2)
			songBox.Text=""
		end
	end
end)

-- Volume ayarı
volumeBox.FocusLost:Connect(function(enter)
	if enter then
		local vol=tonumber(volumeBox.Text)
		if vol then
			if math.random()<0.5 then
				sound.Volume=math.clamp(vol,0,1)
				showNotification(messages.VolumeChanged,2)
			else
				showNotification(messages.VolumeFailed,2)
				volumeBox.Text=tostring(sound.Volume)
			end
		end
	end
end)

-- Progress bar
local progressBarMain=Instance.new("Frame")
progressBarMain.Size=UDim2.new(0,400,0,5)
progressBarMain.Position=UDim2.new(0,30,0,150)
progressBarMain.BackgroundColor3=Color3.fromRGB(50,50,50)
progressBarMain.Parent = frame
Instance.new("UICorner",progressBarMain).CornerRadius = UDim.new(0,2)

local progress=Instance.new("Frame")
progress.Size=UDim2.new(0,0,1,0)
progress.Position=UDim2.new(0,0,0,0)
progress.BackgroundColor3=Color3.fromRGB(0,170,255)
progress.Parent = progressBarMain
Instance.new("UICorner",progress).CornerRadius = UDim.new(0,2)

RunService.RenderStepped:Connect(function()
	if sound.TimeLength>0 then
		progress.Size=UDim2.new(sound.TimePosition/sound.TimeLength,0,1,0)
	end
end)

-- Şarkı listesi ana GUI içine
local listFrame = Instance.new("Frame")
listFrame.Size = UDim2.new(1,-20,0,180)
listFrame.Position = UDim2.new(0,10,0,180)
listFrame.BackgroundColor3 = Color3.fromRGB(35,35,35)
listFrame.Parent = frame
Instance.new("UICorner", listFrame).CornerRadius = UDim.new(0,12)

local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1,0,1,0)
scroll.CanvasSize = UDim2.new(0,0,#songs*40)
scroll.ScrollBarThickness = 8
scroll.BackgroundTransparency = 1
scroll.Parent = listFrame

for i,song in ipairs(songs) do
	local item = Instance.new("TextButton")
	item.Size = UDim2.new(1,-10,0,35)
	item.Position = UDim2.new(0,5,0,(i-1)*40)
	item.Text = ""
	item.BackgroundColor3 = Color3.fromRGB(50,50,50)
	item.Parent = scroll
	Instance.new("UICorner", item).CornerRadius = UDim.new(0,6)

	local icon = Instance.new("TextLabel")
	icon.Size = UDim2.new(0,30,0,30)
	icon.Position = UDim2.new(0,5,0,2)
	icon.BackgroundTransparency = 1
	icon.Text = "🎵"
	icon.TextScaled = true
	icon.TextColor3 = Color3.fromRGB(200,200,200)
	icon.Parent = item

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1,-40,1,0)
	label.Position = UDim2.new(0,40,0,0)
	label.BackgroundTransparency = 1
	label.Text = song.Name
	label.Font = Enum.Font.GothamBold
	label.TextSize = 14
	label.TextColor3 = Color3.fromRGB(255,255,255)
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = item

	item.MouseEnter:Connect(function()
		TweenService:Create(item, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(0,170,255)}):Play()
		TweenService:Create(icon, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {TextColor3 = Color3.fromRGB(255,255,255)}):Play()
		TweenService:Create(label, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {TextColor3 = Color3.fromRGB(255,255,255)}):Play()
	end)
	item.MouseLeave:Connect(function()
		TweenService:Create(item, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(50,50,50)}):Play()
		TweenService:Create(icon, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {TextColor3 = Color3.fromRGB(200,200,200)}):Play()
		TweenService:Create(label, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {TextColor3 = Color3.fromRGB(255,255,255)}):Play()
	end)

	item.MouseButton1Click:Connect(function()
		current = i
		sound.SoundId = "rbxassetid://"..song.Id
		sound:Play()
		currentSongLabel.Text = "Playing: "..song.Name
	end)
end

-- Kapat ve mini buton
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0,30,0,30)
closeBtn.Position = UDim2.new(1,-40,0,10)
closeBtn.BackgroundColor3 = Color3.fromRGB(180,30,30)
closeBtn.Text = "×"
closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextScaled = true
closeBtn.Parent = frame
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0,5)

local miniBtn = Instance.new("TextButton")
miniBtn.Size = UDim2.new(0,50,0,50)
miniBtn.Position = UDim2.new(0.5,-25,1,-60)
miniBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
miniBtn.Text = "🎵"
miniBtn.TextColor3 = Color3.fromRGB(255,255,255)
miniBtn.Visible = false
miniBtn.Parent = gui
Instance.new("UICorner", miniBtn).CornerRadius = UDim.new(0,25)

local isMinimized = false
closeBtn.MouseButton1Click:Connect(function()
	if not isMinimized then
		isMinimized = true
		miniBtn.Visible = true
		TweenService:Create(miniBtn,TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Position=UDim2.new(0.9,-60,0.9,-60)}):Play()
		TweenService:Create(frame,TweenInfo.new(0.4,Enum.EasingStyle.Quad),{Position=UDim2.new(0.5,-230,1,20)}):Play()
		wait(0.4)
		frame.Visible=false
	end
end)

miniBtn.MouseButton1Click:Connect(function()
	if isMinimized then
		isMinimized = false
		frame.Visible=true
		TweenService:Create(frame,TweenInfo.new(0.4,Enum.EasingStyle.Quad),{Position=UDim2.new(0.5,-230,0.5,-200)}):Play()
		wait(0.4)
		miniBtn.Visible=false
	end
end)

-- Frame sürükleme
local dragToggle, dragStart, startPos
frame.InputBegan:Connect(function(input)
	if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
		dragToggle=true
		dragStart=input.Position
		startPos=frame.Position
	end
end)
frame.InputChanged:Connect(function(input)
	if (input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch) and dragToggle then
		local delta=input.Position-dragStart
		frame.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+delta.X,startPos.Y.Scale,startPos.Y.Offset+delta.Y)
	end
end)
frame.InputEnded:Connect(function(input)
	if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
		dragToggle=false
	end
end)

-- Mini buton sürükleme
local dragToggleMini, dragStartMini, startPosMini
miniBtn.InputBegan:Connect(function(input)
	if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
		dragToggleMini = true
		dragStartMini = input.Position
		startPosMini = miniBtn.Position
	end
end)
miniBtn.InputChanged:Connect(function(input)
	if (input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch) and dragToggleMini then
		local delta = input.Position - dragStartMini
		local targetPos = UDim2.new(startPosMini.X.Scale,startPosMini.X.Offset+delta.X,startPosMini.Y.Scale,startPosMini.Y.Offset+delta.Y)
		TweenService:Create(miniBtn,TweenInfo.new(0.1,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Position=targetPos}):Play()
	end
end)
miniBtn.InputEnded:Connect(function(input)
	if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
		dragToggleMini = false
	end
end)
