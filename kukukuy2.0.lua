---@diagnostic disable: undefined-global, lowercase-global, deprecated, undefined-field, ambiguity-1, unbalanced-assignments, redundant-parameter, cast-local-type
-- ใช้เอง ############################################
task.wait(2)
repeat task.wait() until game:IsLoaded()
if game.PlaceId == 8304191830 then
	repeat task.wait() until game.Workspace:FindFirstChild(game.Players.LocalPlayer.Name)
	repeat task.wait() until game.Players.LocalPlayer.PlayerGui:FindFirstChild("collection"):FindFirstChild("grid"):FindFirstChild("List"):FindFirstChild("Outer"):FindFirstChild("UnitFrames")
else
	repeat task.wait() until game.Workspace:FindFirstChild(game.Players.LocalPlayer.Name)
	game:GetService("ReplicatedStorage").endpoints.client_to_server.vote_start:InvokeServer()
	getgenv().start_time = os.time()
	repeat task.wait() until game:GetService("Workspace")["_waves_started"].Value == true
end

-- --// WHITELIST //--
--#region WhiteList


-- local HWIDTable = loadstring(game:HttpGet("https://www.project-hub.shop/whilelistmember.php"))()
-- local HWID = game:GetService("RbxAnalyticsService"):GetClientId()
-- HWIDCHECK = false

-- for i, v in pairs(HWIDTable) do
-- 	if v == HWID then
-- 		HWIDCHECK = true
-- 		task.wait(2)
-- 		break
-- 	else
-- 		print("Step 1")
-- 	end
-- end

-- if HWIDCHECK == true then
-- 	print("Successfully!!")
-- else
-- 	local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()
-- 	OrionLib:MakeNotification({
-- 		Name = "API ERROR!",
-- 		Content = "ไม่พบ API. ของคุณในระบบ. นี่คือเลข API ของคุณ : "
-- 			.. HWID
-- 			.. " [AUTO COPY]",
-- 		Image = "rbxassetid://2795966663",
-- 		Time = 5,
-- 	})
-- 	setclipboard(HWID)
-- 	task.wait(6)
-- 	game.Players.LocalPlayer:Kick("API Not match. Plase Connact Support.." .. "[API] : " .. HWID)
-- 	task.wait(99)
-- end

--#endregion
-----------------

--#region Setting in Game PlayerID And WorkSpace

local versionx = "1.3.9 Entertainment" 
local map_dun1 = "_lobbytemplate_event222"
local key_dun1 = "key_jjk_finger"
local map_dun2 = "_lobbytemplate_event428"
local key_dun2 = "key_yamamoto"
local map_dun3 = "_lobbytemplate_event21"
local key_dun3 = "key_jjk_map"
-----------------------------------------------------------------
local plr = game:GetService("Players").LocalPlayer
local players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = game:GetService("Players").LocalPlayer
local PlaceId = 8304191830
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Mouse = LocalPlayer:GetMouse()
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local playerGui = LocalPlayer:WaitForChild("PlayerGui")

httprequest = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
JobId = game.JobId

-----------------------------------------------------------------

--#endregion

--#region Main Loaded --

function olionLib()
	--@diagnostic disable: undefined-global, redundant-parameter, undefined-field, deprecated, unbalanced-assignments, lowercase-global
	local OrionLib = {
		Elements = {},
		ThemeObjects = {},
		Connections = {},
		Flags = {},
		Themes = {
			Default = {
				Main = Color3.fromRGB(25, 25, 25),
				Second = Color3.fromRGB(32, 32, 32),
				Stroke = Color3.fromRGB(60, 60, 60),
				Divider = Color3.fromRGB(60, 60, 60),
				Text = Color3.fromRGB(240, 240, 240),
				TextDark = Color3.fromRGB(150, 150, 150)
			}
		},
		SelectedTheme = "Default",
		Folder = nil,
		SaveCfg = false
	}

	--Feather Icons https://github.com/evoincorp/lucideblox/tree/master/src/modules/util - Created by 7kayoh
	local Icons = {}

	local Success, Response = pcall(function()
		Icons = HttpService:JSONDecode(game:HttpGetAsync("https://raw.githubusercontent.com/evoincorp/lucideblox/master/src/modules/util/icons.json")).icons
	end)

	if not Success then
		warn("\nOrion Library - Failed to load Feather Icons. Error code: " .. Response .. "\n")
	end	

	local function GetIcon(IconName)
		if Icons[IconName] ~= nil then
			return Icons[IconName]
		else
			return nil
		end
	end   

	local Orion = Instance.new("ScreenGui")
	Orion.Name = "Orion"
	if syn then
		syn.protect_gui(Orion)
		Orion.Parent = game.CoreGui
	else
		Orion.Parent = gethui() or game.CoreGui
	end

	if gethui then
		for _, Interface in ipairs(gethui():GetChildren()) do
			if Interface.Name == Orion.Name and Interface ~= Orion then
				Interface:Destroy()
			end
		end
	else
		for _, Interface in ipairs(game.CoreGui:GetChildren()) do
			if Interface.Name == Orion.Name and Interface ~= Orion then
				Interface:Destroy()
			end
		end
	end

	function OrionLib:IsRunning()
		if gethui then
			return Orion.Parent == gethui()
		else
			return Orion.Parent == game:GetService("CoreGui")
		end

	end

	local function AddConnection(Signal, Function)
		if (not OrionLib:IsRunning()) then
			return
		end
		local SignalConnect = Signal:Connect(Function)
		table.insert(OrionLib.Connections, SignalConnect)
		return SignalConnect
	end

	task.spawn(function()
		while (OrionLib:IsRunning()) do
			wait()
		end

		for _, Connection in next, OrionLib.Connections do
			Connection:Disconnect()
		end
	end)

	local function MakeDraggable(DragPoint, Main)
		pcall(function()
			local Dragging, DragInput, MousePos, FramePos = false
			AddConnection(DragPoint.InputBegan, function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 then
					Dragging = true
					MousePos = Input.Position
					FramePos = Main.Position

					Input.Changed:Connect(function()
						if Input.UserInputState == Enum.UserInputState.End then
							Dragging = false
						end
					end)
				end
			end)
			AddConnection(DragPoint.InputChanged, function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseMovement then
					DragInput = Input
				end
			end)
			AddConnection(UserInputService.InputChanged, function(Input)
				if Input == DragInput and Dragging then
					local Delta = Input.Position - MousePos
					--TweenService:Create(Main, TweenInfo.new(0.05, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position  = UDim2.new(FramePos.X.Scale,FramePos.X.Offset + Delta.X, FramePos.Y.Scale, FramePos.Y.Offset + Delta.Y)}):Play()
					Main.Position  = UDim2.new(FramePos.X.Scale,FramePos.X.Offset + Delta.X, FramePos.Y.Scale, FramePos.Y.Offset + Delta.Y)
				end
			end)
		end)
	end    

	local function Create(Name, Properties, Children)
		local Object = Instance.new(Name)
		for i, v in next, Properties or {} do
			Object[i] = v
		end
		for i, v in next, Children or {} do
			v.Parent = Object
		end
		return Object
	end

	local function CreateElement(ElementName, ElementFunction)
		OrionLib.Elements[ElementName] = function(...)
			return ElementFunction(...)
		end
	end

	local function MakeElement(ElementName, ...)
		local NewElement = OrionLib.Elements[ElementName](...)
		return NewElement
	end

	local function SetProps(Element, Props)
		table.foreach(Props, function(Property, Value)
			Element[Property] = Value
		end)
		return Element
	end

	local function SetChildren(Element, Children)
		table.foreach(Children, function(_, Child)
			Child.Parent = Element
		end)
		return Element
	end

	local function Round(Number, Factor)
		local Result = math.floor(Number/Factor + (math.sign(Number) * 0.5)) * Factor
		if Result < 0 then Result = Result + Factor end
		return Result
	end

	local function ReturnProperty(Object)
		if Object:IsA("Frame") or Object:IsA("TextButton") then
			return "BackgroundColor3"
		end 
		if Object:IsA("ScrollingFrame") then
			return "ScrollBarImageColor3"
		end 
		if Object:IsA("UIStroke") then
			return "Color"
		end 
		if Object:IsA("TextLabel") or Object:IsA("TextBox") then
			return "TextColor3"
		end   
		if Object:IsA("ImageLabel") or Object:IsA("ImageButton") then
			return "ImageColor3"
		end   
	end

	local function AddThemeObject(Object, Type)
		if not OrionLib.ThemeObjects[Type] then
			OrionLib.ThemeObjects[Type] = {}
		end    
		table.insert(OrionLib.ThemeObjects[Type], Object)
		Object[ReturnProperty(Object)] = OrionLib.Themes[OrionLib.SelectedTheme][Type]
		return Object
	end    

	local function SetTheme()
		for Name, Type in pairs(OrionLib.ThemeObjects) do
			for _, Object in pairs(Type) do
				Object[ReturnProperty(Object)] = OrionLib.Themes[OrionLib.SelectedTheme][Name]
			end    
		end    
	end

	local function PackColor(Color)
		return {R = Color.R * 255, G = Color.G * 255, B = Color.B * 255}
	end    

	local function UnpackColor(Color)
		return Color3.fromRGB(Color.R, Color.G, Color.B)
	end

	local function LoadCfg(Config)
		local Data = HttpService:JSONDecode(Config)
		table.foreach(Data, function(a,b)
			if OrionLib.Flags[a] then
				spawn(function() 
					if OrionLib.Flags[a].Type == "Colorpicker" then
						OrionLib.Flags[a]:Set(UnpackColor(b))
					else
						OrionLib.Flags[a]:Set(b)
					end    
				end)
			else
				warn("Orion Library Config Loader - Could not find ", a ,b)
			end
		end)
	end

	local function SaveCfg(Name)
		local Data = {}
		for i,v in pairs(OrionLib.Flags) do
			if v.Save then
				if v.Type == "Colorpicker" then
					Data[i] = PackColor(v.Value)
				else
					Data[i] = v.Value
				end
			end	
		end
		writefile(OrionLib.Folder .. "/" .. Name .. ".txt", tostring(HttpService:JSONEncode(Data)))
	end

	local WhitelistedMouse = {Enum.UserInputType.MouseButton1, Enum.UserInputType.MouseButton2,Enum.UserInputType.MouseButton3}
	local BlacklistedKeys = {Enum.KeyCode.Unknown,Enum.KeyCode.W,Enum.KeyCode.A,Enum.KeyCode.S,Enum.KeyCode.D,Enum.KeyCode.Up,Enum.KeyCode.Left,Enum.KeyCode.Down,Enum.KeyCode.Right,Enum.KeyCode.Slash,Enum.KeyCode.Tab,Enum.KeyCode.Backspace,Enum.KeyCode.Escape}

	local function CheckKey(Table, Key)
		for _, v in next, Table do
			if v == Key then
				return true
			end
		end
	end

	CreateElement("Corner", function(Scale, Offset)
		local Corner = Create("UICorner", {
			CornerRadius = UDim.new(Scale or 0, Offset or 10)
		})
		return Corner
	end)

	CreateElement("Stroke", function(Color, Thickness)
		local Stroke = Create("UIStroke", {
			Color = Color or Color3.fromRGB(255, 255, 255),
			Thickness = Thickness or 1
		})
		return Stroke
	end)

	CreateElement("List", function(Scale, Offset)
		local List = Create("UIListLayout", {
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(Scale or 0, Offset or 0)
		})
		return List
	end)

	CreateElement("Padding", function(Bottom, Left, Right, Top)
		local Padding = Create("UIPadding", {
			PaddingBottom = UDim.new(0, Bottom or 4),
			PaddingLeft = UDim.new(0, Left or 4),
			PaddingRight = UDim.new(0, Right or 4),
			PaddingTop = UDim.new(0, Top or 4)
		})
		return Padding
	end)

	CreateElement("TFrame", function()
		local TFrame = Create("Frame", {
			BackgroundTransparency = 1
		})
		return TFrame
	end)

	CreateElement("Frame", function(Color)
		local Frame = Create("Frame", {
			BackgroundColor3 = Color or Color3.fromRGB(255, 255, 255),
			BorderSizePixel = 0
		})
		return Frame
	end)

	CreateElement("RoundFrame", function(Color, Scale, Offset)
		local Frame = Create("Frame", {
			BackgroundColor3 = Color or Color3.fromRGB(255, 255, 255),
			BorderSizePixel = 0
		}, {
			Create("UICorner", {
				CornerRadius = UDim.new(Scale, Offset)
			})
		})
		return Frame
	end)

	CreateElement("Button", function()
		local Button = Create("TextButton", {
			Text = "",
			AutoButtonColor = false,
			BackgroundTransparency = 1,
			BorderSizePixel = 0
		})
		return Button
	end)

	CreateElement("ScrollFrame", function(Color, Width)
		local ScrollFrame = Create("ScrollingFrame", {
			BackgroundTransparency = 1,
			MidImage = "rbxassetid://7445543667",
			BottomImage = "rbxassetid://7445543667",
			TopImage = "rbxassetid://7445543667",
			ScrollBarImageColor3 = Color,
			BorderSizePixel = 0,
			ScrollBarThickness = Width,
			CanvasSize = UDim2.new(0, 0, 0, 0)
		})
		return ScrollFrame
	end)

	CreateElement("Image", function(ImageID)
		local ImageNew = Create("ImageLabel", {
			Image = ImageID,
			BackgroundTransparency = 1
		})

		if GetIcon(ImageID) ~= nil then
			ImageNew.Image = GetIcon(ImageID)
		end	

		return ImageNew
	end)

	CreateElement("ImageButton", function(ImageID)
		local Image = Create("ImageButton", {
			Image = ImageID,
			BackgroundTransparency = 1
		})
		return Image
	end)

	CreateElement("Label", function(Text, TextSize, Transparency)
		local Label = Create("TextLabel", {
			Text = Text or "",
			TextColor3 = Color3.fromRGB(240, 240, 240),
			TextTransparency = Transparency or 0,
			TextSize = TextSize or 15,
			Font = Enum.Font.Gotham,
			RichText = true,
			BackgroundTransparency = 1,
			TextXAlignment = Enum.TextXAlignment.Left
		})
		return Label
	end)

	local NotificationHolder = SetProps(SetChildren(MakeElement("TFrame"), {
		SetProps(MakeElement("List"), {
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			SortOrder = Enum.SortOrder.LayoutOrder,
			VerticalAlignment = Enum.VerticalAlignment.Bottom,
			Padding = UDim.new(0, 5)
		})
	}), {
		Position = UDim2.new(1, -25, 1, -25),
		Size = UDim2.new(0, 300, 1, -25),
		AnchorPoint = Vector2.new(1, 1),
		Parent = Orion
	})

	function OrionLib:MakeNotification(NotificationConfig)
		spawn(function()
			NotificationConfig.Name = NotificationConfig.Name or "Notification"
			NotificationConfig.Content = NotificationConfig.Content or "Test"
			NotificationConfig.Image = NotificationConfig.Image or "rbxassetid://4384403532"
			NotificationConfig.Time = NotificationConfig.Time or 15

			local NotificationParent = SetProps(MakeElement("TFrame"), {
				Size = UDim2.new(1, 0, 0, 0),
				AutomaticSize = Enum.AutomaticSize.Y,
				Parent = NotificationHolder
			})

			local NotificationFrame = SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(25, 25, 25), 0, 10), {
				Parent = NotificationParent, 
				Size = UDim2.new(1, 0, 0, 0),
				Position = UDim2.new(1, -55, 0, 0),
				BackgroundTransparency = 0,
				AutomaticSize = Enum.AutomaticSize.Y
			}), {
				MakeElement("Stroke", Color3.fromRGB(93, 93, 93), 1.2),
				MakeElement("Padding", 12, 12, 12, 12),
				SetProps(MakeElement("Image", NotificationConfig.Image), {
					Size = UDim2.new(0, 20, 0, 20),
					ImageColor3 = Color3.fromRGB(240, 240, 240),
					Name = "Icon"
				}),
				SetProps(MakeElement("Label", NotificationConfig.Name, 15), {
					Size = UDim2.new(1, -30, 0, 20),
					Position = UDim2.new(0, 30, 0, 0),
					Font = Enum.Font.GothamBold,
					Name = "Title"
				}),
				SetProps(MakeElement("Label", NotificationConfig.Content, 14), {
					Size = UDim2.new(1, 0, 0, 0),
					Position = UDim2.new(0, 0, 0, 25),
					Font = Enum.Font.GothamSemibold,
					Name = "Content",
					AutomaticSize = Enum.AutomaticSize.Y,
					TextColor3 = Color3.fromRGB(200, 200, 200),
					TextWrapped = true
				})
			})

			TweenService:Create(NotificationFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Position = UDim2.new(0, 0, 0, 0)}):Play()

			wait(NotificationConfig.Time - 0.88)
			TweenService:Create(NotificationFrame.Icon, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {ImageTransparency = 1}):Play()
			TweenService:Create(NotificationFrame, TweenInfo.new(0.8, Enum.EasingStyle.Quint), {BackgroundTransparency = 0.6}):Play()
			wait(0.3)
			TweenService:Create(NotificationFrame.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Transparency = 0.9}):Play()
			TweenService:Create(NotificationFrame.Title, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {TextTransparency = 0.4}):Play()
			TweenService:Create(NotificationFrame.Content, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {TextTransparency = 0.5}):Play()
			wait(0.05)

			NotificationFrame:TweenPosition(UDim2.new(1, 20, 0, 0),'In','Quint',0.8,true)
			wait(1.35)
			NotificationFrame:Destroy()
		end)
	end    

	function OrionLib:Init()
		if OrionLib.SaveCfg then	
			pcall(function()
				if isfile(OrionLib.Folder .. "/" .. game.GameId .. ".txt") then
					LoadCfg(readfile(OrionLib.Folder .. "/" .. game.GameId .. ".txt"))
					OrionLib:MakeNotification({
						Name = "Configuration",
						Content = "Auto-loaded configuration for the game " .. game.GameId .. ".",
						Time = 5
					})
				end
			end)		
		end	
	end	

	function OrionLib:MakeWindow(WindowConfig)
		local FirstTab = true
		local Minimized = false
		local Loaded = false
		local UIHidden = false

		WindowConfig = WindowConfig or {}
		WindowConfig.Name = WindowConfig.Name or "Orion Library"
		WindowConfig.ConfigFolder = WindowConfig.ConfigFolder or WindowConfig.Name
		WindowConfig.SaveConfig = WindowConfig.SaveConfig or false
		WindowConfig.HidePremium = WindowConfig.HidePremium or false
		if WindowConfig.IntroEnabled == nil then
			WindowConfig.IntroEnabled = true
		end
		WindowConfig.IntroText = WindowConfig.IntroText or "Orion Library"
		WindowConfig.CloseCallback = WindowConfig.CloseCallback or function() end
		WindowConfig.ShowIcon = WindowConfig.ShowIcon or false
		WindowConfig.Icon = WindowConfig.Icon or "rbxassetid://8834748103"
		WindowConfig.IntroIcon = WindowConfig.IntroIcon or "rbxassetid://8834748103"
		WindowConfig.AutoHideUI = WindowConfig.AutoHideUI or false
		WindowConfig.AutoMinimizeUI = WindowConfig.AutoMinimizeUI or false
		OrionLib.Folder = WindowConfig.ConfigFolder
		OrionLib.SaveCfg = WindowConfig.SaveConfig

		if WindowConfig.SaveConfig then
			if not isfolder(WindowConfig.ConfigFolder) then
				makefolder(WindowConfig.ConfigFolder)
			end	
		end

		local TabHolder = AddThemeObject(SetChildren(SetProps(MakeElement("ScrollFrame", Color3.fromRGB(255, 255, 255), 4), {
			Size = UDim2.new(1, 0, 1, -50)
		}), {
			MakeElement("List"),
			MakeElement("Padding", 8, 0, 0, 8)
		}), "Divider")

		AddConnection(TabHolder.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
			TabHolder.CanvasSize = UDim2.new(0, 0, 0, TabHolder.UIListLayout.AbsoluteContentSize.Y + 16)
		end)

		local CloseBtn = SetChildren(SetProps(MakeElement("Button"), {
			Size = UDim2.new(0.5, 0, 1, 0),
			Position = UDim2.new(0.5, 0, 0, 0),
			BackgroundTransparency = 1
		}), {
			AddThemeObject(SetProps(MakeElement("Image", "rbxassetid://7072725342"), {
				Position = UDim2.new(0, 9, 0, 6),
				Size = UDim2.new(0, 18, 0, 18)
			}), "Text")
		})

		local MinimizeBtn = SetChildren(SetProps(MakeElement("Button"), {
			Size = UDim2.new(0.5, 0, 1, 0),
			BackgroundTransparency = 1
		}), {
			AddThemeObject(SetProps(MakeElement("Image", "rbxassetid://7072719338"), {
				Position = UDim2.new(0, 9, 0, 6),
				Size = UDim2.new(0, 18, 0, 18),
				Name = "Ico"
			}), "Text")
		})

		local DragPoint = SetProps(MakeElement("TFrame"), {
			Size = UDim2.new(1, 0, 0, 50)
		})

		local WindowStuff = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 10), {
			Size = UDim2.new(0, 150, 1, -50),
			Position = UDim2.new(0, 0, 0, 50)
		}), {
			AddThemeObject(SetProps(MakeElement("Frame"), {
				Size = UDim2.new(1, 0, 0, 10),
				Position = UDim2.new(0, 0, 0, 0)
			}), "Second"), 
			AddThemeObject(SetProps(MakeElement("Frame"), {
				Size = UDim2.new(0, 10, 1, 0),
				Position = UDim2.new(1, -10, 0, 0)
			}), "Second"), 
			AddThemeObject(SetProps(MakeElement("Frame"), {
				Size = UDim2.new(0, 1, 1, 0),
				Position = UDim2.new(1, -1, 0, 0)
			}), "Stroke"), 
			TabHolder,
			SetChildren(SetProps(MakeElement("TFrame"), {
				Size = UDim2.new(1, 0, 0, 50),
				Position = UDim2.new(0, 0, 1, -50)
			}), {
				AddThemeObject(SetProps(MakeElement("Frame"), {
					Size = UDim2.new(1, 0, 0, 1)
				}), "Stroke"), 
				AddThemeObject(SetChildren(SetProps(MakeElement("Frame"), {
					AnchorPoint = Vector2.new(0, 0.5),
					Size = UDim2.new(0, 32, 0, 32),
					Position = UDim2.new(0, 10, 0.5, 0)
				}), {
					SetProps(MakeElement("Image", "https://www.roblox.com/headshot-thumbnail/image?userId=".. LocalPlayer.UserId .."&width=420&height=420&format=png"), {
						Size = UDim2.new(1, 0, 1, 0)
					}),
					AddThemeObject(SetProps(MakeElement("Image", "rbxassetid://4031889928"), {
						Size = UDim2.new(1, 0, 1, 0),
					}), "Second"),
					MakeElement("Corner", 1)
				}), "Divider"),
				SetChildren(SetProps(MakeElement("TFrame"), {
					AnchorPoint = Vector2.new(0, 0.5),
					Size = UDim2.new(0, 32, 0, 32),
					Position = UDim2.new(0, 10, 0.5, 0)
				}), {
					AddThemeObject(MakeElement("Stroke"), "Stroke"),
					MakeElement("Corner", 1)
				}),
				AddThemeObject(SetProps(MakeElement("Label", LocalPlayer.Name, WindowConfig.HidePremium and 14 or 13), {
					Size = UDim2.new(1, -60, 0, 13),
					Position = WindowConfig.HidePremium and UDim2.new(0, 50, 0, 19) or UDim2.new(0, 50, 0, 12),
					Font = Enum.Font.GothamBold,
					ClipsDescendants = true
				}), "Text"),
				AddThemeObject(SetProps(MakeElement("Label", "", 12), {
					Size = UDim2.new(1, -60, 0, 12),
					Position = UDim2.new(0, 50, 1, -25),
					Visible = not WindowConfig.HidePremium
				}), "TextDark")
			}),
		}), "Second")

		local WindowName = AddThemeObject(SetProps(MakeElement("Label", WindowConfig.Name, 14), {
			Size = UDim2.new(1, -30, 2, 0),
			Position = UDim2.new(0, 25, 0, -24),
			Font = Enum.Font.GothamBlack,
			TextSize = 20
		}), "Text")

		local WindowTopBarLine = AddThemeObject(SetProps(MakeElement("Frame"), {
			Size = UDim2.new(1, 0, 0, 1),
			Position = UDim2.new(0, 0, 1, -1)
		}), "Stroke")

		local MainWindow = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 10), {
			Parent = Orion,
			Position = UDim2.new(0.5, -307, 0.5, -172),
			Size = UDim2.new(0, 615, 0, 344),
			ClipsDescendants = true
		}), {
			--SetProps(MakeElement("Image", "rbxassetid://3523728077"), {
			--	AnchorPoint = Vector2.new(0.5, 0.5),
			--	Position = UDim2.new(0.5, 0, 0.5, 0),
			--	Size = UDim2.new(1, 80, 1, 320),
			--	ImageColor3 = Color3.fromRGB(33, 33, 33),
			--	ImageTransparency = 0.7
			--}),
			SetChildren(SetProps(MakeElement("TFrame"), {
				Size = UDim2.new(1, 0, 0, 50),
				Name = "TopBar"
			}), {
				WindowName,
				WindowTopBarLine,
				AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 7), {
					Size = UDim2.new(0, 70, 0, 30),
					Position = UDim2.new(1, -90, 0, 10)
				}), {
					AddThemeObject(MakeElement("Stroke"), "Stroke"),
					AddThemeObject(SetProps(MakeElement("Frame"), {
						Size = UDim2.new(0, 1, 1, 0),
						Position = UDim2.new(0.5, 0, 0, 0)
					}), "Stroke"), 
					CloseBtn,
					MinimizeBtn
				}), "Second"), 
			}),
			DragPoint,
			WindowStuff
		}), "Main")

		if WindowConfig.ShowIcon then
			WindowName.Position = UDim2.new(0, 50, 0, -24)
			local WindowIcon = SetProps(MakeElement("Image", WindowConfig.Icon), {
				Size = UDim2.new(0, 20, 0, 20),
				Position = UDim2.new(0, 25, 0, 15)
			})
			WindowIcon.Parent = MainWindow.TopBar
		end	

		MakeDraggable(DragPoint, MainWindow)

		AddConnection(CloseBtn.MouseButton1Up, function()
			MainWindow.Visible = false
			UIHidden = true
			OrionLib:MakeNotification({
				Name = "Interface Hidden",
				Content = "Tap RightShift to reopen the interface",
				Time = 5
			})
			WindowConfig.CloseCallback()
		end)

		local Hidden = false
		UserInputService.InputBegan:Connect(function(input, processed)
			if (input.KeyCode == Enum.KeyCode.RightShift and not processed) then
				--if Debounce then return end
				if UIHidden then
					MainWindow.Visible = true
					OrionLib:MakeNotification({
						Name = "Open Interface",
						Content = "Tap RightShift to reopen the interface",
						Time = 5
					})
					UIHidden = false
					return
				end
				if Hidden then
					Hidden = false
					MainWindow.Visible = true
					OrionLib:MakeNotification({
						Name = "Open Interface",
						Content = "Tap RightShift to reopen the interface",
						Time = 5
					})
				else
					Hidden = true
					MainWindow.Visible = false
					OrionLib:MakeNotification({
						Name = "Hide Interface",
						Content = "Tap RightShift to reopen the interface",
						Time = 5
					})
				end
			end
		end)

		-- AddConnection(UserInputService.InputBegan, function(Input)
		-- 	if Input.KeyCode == Enum.KeyCode.RightShift and UIHidden then
		-- 		MainWindow.Visible = true
		-- 	end
		-- end)

		
		AddConnection(MinimizeBtn.MouseButton1Up, function()
			if Minimized then
				TweenService:Create(MainWindow, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0, 615, 0, 344)}):Play()
				MinimizeBtn.Ico.Image = "rbxassetid://7072719338"
				wait(.02)
				MainWindow.ClipsDescendants = false
				WindowStuff.Visible = true
				WindowTopBarLine.Visible = true
			else
				MainWindow.ClipsDescendants = true
				WindowTopBarLine.Visible = false
				MinimizeBtn.Ico.Image = "rbxassetid://7072720870"

				TweenService:Create(MainWindow, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0, WindowName.TextBounds.X + 140, 0, 50)}):Play()
				wait(0.1)
				WindowStuff.Visible = false	
			end
			Minimized = not Minimized    
		end)

		local function LoadSequence()
			MainWindow.Visible = false
			local LoadSequenceLogo = SetProps(MakeElement("Image", WindowConfig.IntroIcon), {
				Parent = Orion,
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.new(0.5, 0, 0.4, 0),
				Size = UDim2.new(0, 28, 0, 28),
				ImageColor3 = Color3.fromRGB(255, 255, 255),
				ImageTransparency = 1
			})

			local LoadSequenceText = SetProps(MakeElement("Label", WindowConfig.IntroText, 14), {
				Parent = Orion,
				Size = UDim2.new(1, 0, 1, 0),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.new(0.5, 19, 0.5, 0),
				TextXAlignment = Enum.TextXAlignment.Center,
				Font = Enum.Font.GothamBold,
				TextTransparency = 1
			})

			TweenService:Create(LoadSequenceLogo, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 0, Position = UDim2.new(0.5, 0, 0.5, 0)}):Play()
			wait(0.8)
			TweenService:Create(LoadSequenceLogo, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, -(LoadSequenceText.TextBounds.X/2), 0.5, 0)}):Play()
			wait(0.3)
			TweenService:Create(LoadSequenceText, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
			wait(2)
			TweenService:Create(LoadSequenceText, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 1}):Play()
			MainWindow.Visible = true
			LoadSequenceLogo:Destroy()
			LoadSequenceText:Destroy()
		end 

		if WindowConfig.IntroEnabled then
			LoadSequence()
		end	
		
		if WindowConfig.AutoHideUI then
			MainWindow.Visible = false
			UIHidden = true
			OrionLib:MakeNotification({
				Name = "Interface Hidden",
				Content = "Tap RightShift to reopen the interface",
				Time = 5
			})
			WindowConfig.CloseCallback()
		end

		if WindowConfig.AutoMinimizeUI then
			if Minimized then
				TweenService:Create(MainWindow, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0, 615, 0, 344)}):Play()
				MinimizeBtn.Ico.Image = "rbxassetid://7072719338"
				wait(.02)
				MainWindow.ClipsDescendants = false
				WindowStuff.Visible = true
				WindowTopBarLine.Visible = true
			else
				MainWindow.ClipsDescendants = true
				WindowTopBarLine.Visible = false
				MinimizeBtn.Ico.Image = "rbxassetid://7072720870"

				TweenService:Create(MainWindow, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0, WindowName.TextBounds.X + 140, 0, 50)}):Play()
				wait(0.1)
				WindowStuff.Visible = false	
			end
			Minimized = not Minimized
		end

		local TabFunction = {}
		function TabFunction:MakeTab(TabConfig)
			TabConfig = TabConfig or {}
			TabConfig.Name = TabConfig.Name or "Tab"
			TabConfig.Icon = TabConfig.Icon or ""
			TabConfig.PremiumOnly = TabConfig.PremiumOnly or false

			local TabFrame = SetChildren(SetProps(MakeElement("Button"), {
				Size = UDim2.new(1, 0, 0, 30),
				Parent = TabHolder
			}), {
				AddThemeObject(SetProps(MakeElement("Image", TabConfig.Icon), {
					AnchorPoint = Vector2.new(0, 0.5),
					Size = UDim2.new(0, 18, 0, 18),
					Position = UDim2.new(0, 10, 0.5, 0),
					ImageTransparency = 0.4,
					Name = "Ico"
				}), "Text"),
				AddThemeObject(SetProps(MakeElement("Label", TabConfig.Name, 14), {
					Size = UDim2.new(1, -35, 1, 0),
					Position = UDim2.new(0, 35, 0, 0),
					Font = Enum.Font.GothamSemibold,
					TextTransparency = 0.4,
					Name = "Title"
				}), "Text")
			})

			if GetIcon(TabConfig.Icon) ~= nil then
				TabFrame.Ico.Image = GetIcon(TabConfig.Icon)
			end	

			local Container = AddThemeObject(SetChildren(SetProps(MakeElement("ScrollFrame", Color3.fromRGB(255, 255, 255), 5), {
				Size = UDim2.new(1, -150, 1, -50),
				Position = UDim2.new(0, 150, 0, 50),
				Parent = MainWindow,
				Visible = false,
				Name = "ItemContainer"
			}), {
				MakeElement("List", 0, 6),
				MakeElement("Padding", 15, 10, 10, 15)
			}), "Divider")

			AddConnection(Container.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
				Container.CanvasSize = UDim2.new(0, 0, 0, Container.UIListLayout.AbsoluteContentSize.Y + 30)
			end)

			if FirstTab then
				FirstTab = false
				TabFrame.Ico.ImageTransparency = 0
				TabFrame.Title.TextTransparency = 0
				TabFrame.Title.Font = Enum.Font.GothamBlack
				Container.Visible = true
			end    

			AddConnection(TabFrame.MouseButton1Click, function()
				for _, Tab in next, TabHolder:GetChildren() do
					if Tab:IsA("TextButton") then
						Tab.Title.Font = Enum.Font.GothamSemibold
						TweenService:Create(Tab.Ico, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {ImageTransparency = 0.4}):Play()
						TweenService:Create(Tab.Title, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {TextTransparency = 0.4}):Play()
					end    
				end
				for _, ItemContainer in next, MainWindow:GetChildren() do
					if ItemContainer.Name == "ItemContainer" then
						ItemContainer.Visible = false
					end    
				end  
				TweenService:Create(TabFrame.Ico, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {ImageTransparency = 0}):Play()
				TweenService:Create(TabFrame.Title, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
				TabFrame.Title.Font = Enum.Font.GothamBlack
				Container.Visible = true   
			end)

			local function GetElements(ItemParent)
				local ElementFunction = {}
				function ElementFunction:AddLabel(Text)
					local LabelFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
						Size = UDim2.new(1, 0, 0, 30),
						BackgroundTransparency = 0.7,
						Parent = ItemParent
					}), {
						AddThemeObject(SetProps(MakeElement("Label", Text, 15), {
							Size = UDim2.new(1, -12, 1, 0),
							Position = UDim2.new(0, 12, 0, 0),
							Font = Enum.Font.GothamBold,
							Name = "Content"
						}), "Text"),
						AddThemeObject(MakeElement("Stroke"), "Stroke")
					}), "Second")

					local LabelFunction = {}
					function LabelFunction:Set(ToChange)
						LabelFrame.Content.Text = ToChange
					end
					return LabelFunction
				end
				function ElementFunction:AddParagraph(Text, Content)
					Text = Text or "Text"
					Content = Content or "Content"

					local ParagraphFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
						Size = UDim2.new(1, 0, 0, 30),
						BackgroundTransparency = 0.7,
						Parent = ItemParent
					}), {
						AddThemeObject(SetProps(MakeElement("Label", Text, 15), {
							Size = UDim2.new(1, -12, 0, 14),
							Position = UDim2.new(0, 12, 0, 10),
							Font = Enum.Font.GothamBold,
							Name = "Title"
						}), "Text"),
						AddThemeObject(SetProps(MakeElement("Label", "", 13), {
							Size = UDim2.new(1, -24, 0, 0),
							Position = UDim2.new(0, 12, 0, 26),
							Font = Enum.Font.GothamSemibold,
							Name = "Content",
							TextWrapped = true
						}), "TextDark"),
						AddThemeObject(MakeElement("Stroke"), "Stroke")
					}), "Second")

					AddConnection(ParagraphFrame.Content:GetPropertyChangedSignal("Text"), function()
						ParagraphFrame.Content.Size = UDim2.new(1, -24, 0, ParagraphFrame.Content.TextBounds.Y)
						ParagraphFrame.Size = UDim2.new(1, 0, 0, ParagraphFrame.Content.TextBounds.Y + 35)
					end)

					ParagraphFrame.Content.Text = Content

					local ParagraphFunction = {}
					function ParagraphFunction:Set(ToChange)
						ParagraphFrame.Content.Text = ToChange
					end
					return ParagraphFunction
				end    
				function ElementFunction:AddButton(ButtonConfig)
					ButtonConfig = ButtonConfig or {}
					ButtonConfig.Name = ButtonConfig.Name or "Button"
					ButtonConfig.Callback = ButtonConfig.Callback or function() end
					ButtonConfig.Icon = ButtonConfig.Icon or "rbxassetid://3944703587"

					local Button = {}

					local Click = SetProps(MakeElement("Button"), {
						Size = UDim2.new(1, 0, 1, 0)
					})

					local ButtonFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
						Size = UDim2.new(1, 0, 0, 33),
						Parent = ItemParent
					}), {
						AddThemeObject(SetProps(MakeElement("Label", ButtonConfig.Name, 15), {
							Size = UDim2.new(1, -12, 1, 0),
							Position = UDim2.new(0, 12, 0, 0),
							Font = Enum.Font.GothamBold,
							Name = "Content"
						}), "Text"),
						AddThemeObject(SetProps(MakeElement("Image", ButtonConfig.Icon), {
							Size = UDim2.new(0, 20, 0, 20),
							Position = UDim2.new(1, -30, 0, 7),
						}), "TextDark"),
						AddThemeObject(MakeElement("Stroke"), "Stroke"),
						Click
					}), "Second")

					AddConnection(Click.MouseEnter, function()
						TweenService:Create(ButtonFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255 + 3)}):Play()
					end)

					AddConnection(Click.MouseLeave, function()
						TweenService:Create(ButtonFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = OrionLib.Themes[OrionLib.SelectedTheme].Second}):Play()
					end)

					AddConnection(Click.MouseButton1Up, function()
						TweenService:Create(ButtonFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255 + 3)}):Play()
						spawn(function()
							ButtonConfig.Callback()
						end)
					end)

					AddConnection(Click.MouseButton1Down, function()
						TweenService:Create(ButtonFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255 + 6, OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255 + 6, OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255 + 6)}):Play()
					end)

					function Button:Set(ButtonText)
						ButtonFrame.Content.Text = ButtonText
					end	

					return Button
				end    
				function ElementFunction:AddToggle(ToggleConfig)
					ToggleConfig = ToggleConfig or {}
					ToggleConfig.Name = ToggleConfig.Name or "Toggle"
					ToggleConfig.Default = ToggleConfig.Default or false
					ToggleConfig.Callback = ToggleConfig.Callback or function() end
					ToggleConfig.Color = ToggleConfig.Color or Color3.fromRGB(9, 99, 195)
					ToggleConfig.Flag = ToggleConfig.Flag or nil
					ToggleConfig.Save = ToggleConfig.Save or false

					local Toggle = {Value = ToggleConfig.Default, Save = ToggleConfig.Save}

					local Click = SetProps(MakeElement("Button"), {
						Size = UDim2.new(1, 0, 1, 0)
					})

					local ToggleBox = SetChildren(SetProps(MakeElement("RoundFrame", ToggleConfig.Color, 0, 4), {
						Size = UDim2.new(0, 24, 0, 24),
						Position = UDim2.new(1, -24, 0.5, 0),
						AnchorPoint = Vector2.new(0.5, 0.5)
					}), {
						SetProps(MakeElement("Stroke"), {
							Color = ToggleConfig.Color,
							Name = "Stroke",
							Transparency = 0.5
						}),
						SetProps(MakeElement("Image", "rbxassetid://3944680095"), {
							Size = UDim2.new(0, 20, 0, 20),
							AnchorPoint = Vector2.new(0.5, 0.5),
							Position = UDim2.new(0.5, 0, 0.5, 0),
							ImageColor3 = Color3.fromRGB(255, 255, 255),
							Name = "Ico"
						}),
					})

					local ToggleFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
						Size = UDim2.new(1, 0, 0, 38),
						Parent = ItemParent
					}), {
						AddThemeObject(SetProps(MakeElement("Label", ToggleConfig.Name, 15), {
							Size = UDim2.new(1, -12, 1, 0),
							Position = UDim2.new(0, 12, 0, 0),
							Font = Enum.Font.GothamBold,
							Name = "Content"
						}), "Text"),
						AddThemeObject(MakeElement("Stroke"), "Stroke"),
						ToggleBox,
						Click
					}), "Second")

					function Toggle:Set(Value)
						Toggle.Value = Value
						TweenService:Create(ToggleBox, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Toggle.Value and ToggleConfig.Color or OrionLib.Themes.Default.Divider}):Play()
						TweenService:Create(ToggleBox.Stroke, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Color = Toggle.Value and ToggleConfig.Color or OrionLib.Themes.Default.Stroke}):Play()
						TweenService:Create(ToggleBox.Ico, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {ImageTransparency = Toggle.Value and 0 or 1, Size = Toggle.Value and UDim2.new(0, 20, 0, 20) or UDim2.new(0, 8, 0, 8)}):Play()
						ToggleConfig.Callback(Toggle.Value)
					end    

					Toggle:Set(Toggle.Value)

					AddConnection(Click.MouseEnter, function()
						TweenService:Create(ToggleFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255 + 3)}):Play()
					end)

					AddConnection(Click.MouseLeave, function()
						TweenService:Create(ToggleFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = OrionLib.Themes[OrionLib.SelectedTheme].Second}):Play()
					end)

					AddConnection(Click.MouseButton1Up, function()
						TweenService:Create(ToggleFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255 + 3)}):Play()
						SaveCfg(game.GameId)
						Toggle:Set(not Toggle.Value)
					end)

					AddConnection(Click.MouseButton1Down, function()
						TweenService:Create(ToggleFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255 + 6, OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255 + 6, OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255 + 6)}):Play()
					end)

					if ToggleConfig.Flag then
						OrionLib.Flags[ToggleConfig.Flag] = Toggle
					end	
					return Toggle
				end  
				function ElementFunction:AddSlider(SliderConfig)
					SliderConfig = SliderConfig or {}
					SliderConfig.Name = SliderConfig.Name or "Slider"
					SliderConfig.Min = SliderConfig.Min or 0
					SliderConfig.Max = SliderConfig.Max or 100
					SliderConfig.Increment = SliderConfig.Increment or 1
					SliderConfig.Default = SliderConfig.Default or 50
					SliderConfig.Callback = SliderConfig.Callback or function() end
					SliderConfig.ValueName = SliderConfig.ValueName or ""
					SliderConfig.Color = SliderConfig.Color or Color3.fromRGB(9, 149, 98)
					SliderConfig.Flag = SliderConfig.Flag or nil
					SliderConfig.Save = SliderConfig.Save or false

					local Slider = {Value = SliderConfig.Default, Save = SliderConfig.Save}
					local Dragging = false

					local SliderDrag = SetChildren(SetProps(MakeElement("RoundFrame", SliderConfig.Color, 0, 5), {
						Size = UDim2.new(0, 0, 1, 0),
						BackgroundTransparency = 0.3,
						ClipsDescendants = true
					}), {
						AddThemeObject(SetProps(MakeElement("Label", "value", 13), {
							Size = UDim2.new(1, -12, 0, 14),
							Position = UDim2.new(0, 12, 0, 6),
							Font = Enum.Font.GothamBold,
							Name = "Value",
							TextTransparency = 0
						}), "Text")
					})

					local SliderBar = SetChildren(SetProps(MakeElement("RoundFrame", SliderConfig.Color, 0, 5), {
						Size = UDim2.new(1, -24, 0, 26),
						Position = UDim2.new(0, 12, 0, 30),
						BackgroundTransparency = 0.9
					}), {
						SetProps(MakeElement("Stroke"), {
							Color = SliderConfig.Color
						}),
						AddThemeObject(SetProps(MakeElement("Label", "value", 13), {
							Size = UDim2.new(1, -12, 0, 14),
							Position = UDim2.new(0, 12, 0, 6),
							Font = Enum.Font.GothamBold,
							Name = "Value",
							TextTransparency = 0.8
						}), "Text"),
						SliderDrag
					})

					local SliderFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 4), {
						Size = UDim2.new(1, 0, 0, 65),
						Parent = ItemParent
					}), {
						AddThemeObject(SetProps(MakeElement("Label", SliderConfig.Name, 15), {
							Size = UDim2.new(1, -12, 0, 14),
							Position = UDim2.new(0, 12, 0, 10),
							Font = Enum.Font.GothamBold,
							Name = "Content"
						}), "Text"),
						AddThemeObject(MakeElement("Stroke"), "Stroke"),
						SliderBar
					}), "Second")

					SliderBar.InputBegan:Connect(function(Input)
						if Input.UserInputType == Enum.UserInputType.MouseButton1 then 
							Dragging = true 
						end 
					end)
					SliderBar.InputEnded:Connect(function(Input) 
						if Input.UserInputType == Enum.UserInputType.MouseButton1 then 
							Dragging = false 
						end 
					end)

					UserInputService.InputChanged:Connect(function(Input)
						if Dragging and Input.UserInputType == Enum.UserInputType.MouseMovement then 
							local SizeScale = math.clamp((Input.Position.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
							Slider:Set(SliderConfig.Min + ((SliderConfig.Max - SliderConfig.Min) * SizeScale)) 
							SaveCfg(game.GameId)
						end
					end)

					function Slider:Set(Value)
						self.Value = math.clamp(Round(Value, SliderConfig.Increment), SliderConfig.Min, SliderConfig.Max)
						TweenService:Create(SliderDrag,TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{Size = UDim2.fromScale((self.Value - SliderConfig.Min) / (SliderConfig.Max - SliderConfig.Min), 1)}):Play()
						SliderBar.Value.Text = tostring(self.Value) .. " " .. SliderConfig.ValueName
						SliderDrag.Value.Text = tostring(self.Value) .. " " .. SliderConfig.ValueName
						SliderConfig.Callback(self.Value)
					end      

					Slider:Set(Slider.Value)
					if SliderConfig.Flag then				
						OrionLib.Flags[SliderConfig.Flag] = Slider
					end
					return Slider
				end  
				function ElementFunction:AddDropdown(DropdownConfig)
					DropdownConfig = DropdownConfig or {}
					DropdownConfig.Name = DropdownConfig.Name or "Dropdown"
					DropdownConfig.Options = DropdownConfig.Options or {}
					DropdownConfig.Default = DropdownConfig.Default or ""
					DropdownConfig.Callback = DropdownConfig.Callback or function() end
					DropdownConfig.Flag = DropdownConfig.Flag or nil
					DropdownConfig.Save = DropdownConfig.Save or false

					local Dropdown = {Value = DropdownConfig.Default, Options = DropdownConfig.Options, Buttons = {}, Toggled = false, Type = "Dropdown", Save = DropdownConfig.Save}
					local MaxElements = 5

					if not table.find(Dropdown.Options, Dropdown.Value) then
						Dropdown.Value = "..."
					end

					local DropdownList = MakeElement("List")

					local DropdownContainer = AddThemeObject(SetProps(SetChildren(MakeElement("ScrollFrame", Color3.fromRGB(40, 40, 40), 4), {
						DropdownList
					}), {
						Parent = ItemParent,
						Position = UDim2.new(0, 0, 0, 38),
						Size = UDim2.new(1, 0, 1, -38),
						ClipsDescendants = true
					}), "Divider")

					local Click = SetProps(MakeElement("Button"), {
						Size = UDim2.new(1, 0, 1, 0)
					})

					local DropdownFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
						Size = UDim2.new(1, 0, 0, 38),
						Parent = ItemParent,
						ClipsDescendants = true
					}), {
						DropdownContainer,
						SetProps(SetChildren(MakeElement("TFrame"), {
							AddThemeObject(SetProps(MakeElement("Label", DropdownConfig.Name, 15), {
								Size = UDim2.new(1, -12, 1, 0),
								Position = UDim2.new(0, 12, 0, 0),
								Font = Enum.Font.GothamBold,
								Name = "Content"
							}), "Text"),
							AddThemeObject(SetProps(MakeElement("Image", "rbxassetid://7072706796"), {
								Size = UDim2.new(0, 20, 0, 20),
								AnchorPoint = Vector2.new(0, 0.5),
								Position = UDim2.new(1, -30, 0.5, 0),
								ImageColor3 = Color3.fromRGB(240, 240, 240),
								Name = "Ico"
							}), "TextDark"),
							AddThemeObject(SetProps(MakeElement("Label", "Selected", 13), {
								Size = UDim2.new(1, -40, 1, 0),
								Font = Enum.Font.Gotham,
								Name = "Selected",
								TextXAlignment = Enum.TextXAlignment.Right
							}), "TextDark"),
							AddThemeObject(SetProps(MakeElement("Frame"), {
								Size = UDim2.new(1, 0, 0, 1),
								Position = UDim2.new(0, 0, 1, -1),
								Name = "Line",
								Visible = false
							}), "Stroke"), 
							Click
						}), {
							Size = UDim2.new(1, 0, 0, 38),
							ClipsDescendants = true,
							Name = "F"
						}),
						AddThemeObject(MakeElement("Stroke"), "Stroke"),
						MakeElement("Corner")
					}), "Second")

					AddConnection(DropdownList:GetPropertyChangedSignal("AbsoluteContentSize"), function()
						DropdownContainer.CanvasSize = UDim2.new(0, 0, 0, DropdownList.AbsoluteContentSize.Y)
					end)  

					local function AddOptions(Options)
						for _, Option in pairs(Options) do
							local OptionBtn = AddThemeObject(SetProps(SetChildren(MakeElement("Button", Color3.fromRGB(40, 40, 40)), {
								MakeElement("Corner", 0, 6),
								AddThemeObject(SetProps(MakeElement("Label", Option, 13, 0.4), {
									Position = UDim2.new(0, 8, 0, 0),
									Size = UDim2.new(1, -8, 1, 0),
									Name = "Title"
								}), "Text")
							}), {
								Parent = DropdownContainer,
								Size = UDim2.new(1, 0, 0, 28),
								BackgroundTransparency = 1,
								ClipsDescendants = true
							}), "Divider")

							AddConnection(OptionBtn.MouseButton1Click, function()
								Dropdown:Set(Option)
								SaveCfg(game.GameId)
							end)

							Dropdown.Buttons[Option] = OptionBtn
						end
					end	

					function Dropdown:Refresh(Options, Delete)
						if Delete then
							for _,v in pairs(Dropdown.Buttons) do
								v:Destroy()
							end    
							table.clear(Dropdown.Options)
							table.clear(Dropdown.Buttons)
						end
						Dropdown.Options = Options
						AddOptions(Dropdown.Options)
					end  

					function Dropdown:Set(Value)
						if not table.find(Dropdown.Options, Value) then
							Dropdown.Value = "..."
							DropdownFrame.F.Selected.Text = Dropdown.Value
							for _, v in pairs(Dropdown.Buttons) do
								TweenService:Create(v,TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{BackgroundTransparency = 1}):Play()
								TweenService:Create(v.Title,TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{TextTransparency = 0.4}):Play()
							end	
							return
						end

						Dropdown.Value = Value
						DropdownFrame.F.Selected.Text = Dropdown.Value

						for _, v in pairs(Dropdown.Buttons) do
							TweenService:Create(v,TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{BackgroundTransparency = 1}):Play()
							TweenService:Create(v.Title,TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{TextTransparency = 0.4}):Play()
						end	
						TweenService:Create(Dropdown.Buttons[Value],TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{BackgroundTransparency = 0}):Play()
						TweenService:Create(Dropdown.Buttons[Value].Title,TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{TextTransparency = 0}):Play()
						return DropdownConfig.Callback(Dropdown.Value)
					end

					AddConnection(Click.MouseButton1Click, function()
						Dropdown.Toggled = not Dropdown.Toggled
						DropdownFrame.F.Line.Visible = Dropdown.Toggled
						TweenService:Create(DropdownFrame.F.Ico,TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{Rotation = Dropdown.Toggled and 180 or 0}):Play()
						if #Dropdown.Options > MaxElements then
							TweenService:Create(DropdownFrame,TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{Size = Dropdown.Toggled and UDim2.new(1, 0, 0, 38 + (MaxElements * 28)) or UDim2.new(1, 0, 0, 38)}):Play()
						else
							TweenService:Create(DropdownFrame,TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{Size = Dropdown.Toggled and UDim2.new(1, 0, 0, DropdownList.AbsoluteContentSize.Y + 38) or UDim2.new(1, 0, 0, 38)}):Play()
						end
					end)

					Dropdown:Refresh(Dropdown.Options, false)
					Dropdown:Set(Dropdown.Value)
					if DropdownConfig.Flag then				
						OrionLib.Flags[DropdownConfig.Flag] = Dropdown
					end
					return Dropdown
				end
				function ElementFunction:AddBind(BindConfig)
					BindConfig.Name = BindConfig.Name or "Bind"
					BindConfig.Default = BindConfig.Default or Enum.KeyCode.Unknown
					BindConfig.Hold = BindConfig.Hold or false
					BindConfig.Callback = BindConfig.Callback or function() end
					BindConfig.Flag = BindConfig.Flag or nil
					BindConfig.Save = BindConfig.Save or false

					local Bind = {Value, Binding = false, Type = "Bind", Save = BindConfig.Save}
					local Holding = false

					local Click = SetProps(MakeElement("Button"), {
						Size = UDim2.new(1, 0, 1, 0)
					})

					local BindBox = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 4), {
						Size = UDim2.new(0, 24, 0, 24),
						Position = UDim2.new(1, -12, 0.5, 0),
						AnchorPoint = Vector2.new(1, 0.5)
					}), {
						AddThemeObject(MakeElement("Stroke"), "Stroke"),
						AddThemeObject(SetProps(MakeElement("Label", BindConfig.Name, 14), {
							Size = UDim2.new(1, 0, 1, 0),
							Font = Enum.Font.GothamBold,
							TextXAlignment = Enum.TextXAlignment.Center,
							Name = "Value"
						}), "Text")
					}), "Main")

					local BindFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
						Size = UDim2.new(1, 0, 0, 38),
						Parent = ItemParent
					}), {
						AddThemeObject(SetProps(MakeElement("Label", BindConfig.Name, 15), {
							Size = UDim2.new(1, -12, 1, 0),
							Position = UDim2.new(0, 12, 0, 0),
							Font = Enum.Font.GothamBold,
							Name = "Content"
						}), "Text"),
						AddThemeObject(MakeElement("Stroke"), "Stroke"),
						BindBox,
						Click
					}), "Second")

					AddConnection(BindBox.Value:GetPropertyChangedSignal("Text"), function()
						--BindBox.Size = UDim2.new(0, BindBox.Value.TextBounds.X + 16, 0, 24)
						TweenService:Create(BindBox, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0, BindBox.Value.TextBounds.X + 16, 0, 24)}):Play()
					end)

					AddConnection(Click.InputEnded, function(Input)
						if Input.UserInputType == Enum.UserInputType.MouseButton1 then
							if Bind.Binding then return end
							Bind.Binding = true
							BindBox.Value.Text = ""
						end
					end)

					AddConnection(UserInputService.InputBegan, function(Input)
						if UserInputService:GetFocusedTextBox() then return end
						if (Input.KeyCode.Name == Bind.Value or Input.UserInputType.Name == Bind.Value) and not Bind.Binding then
							if BindConfig.Hold then
								Holding = true
								BindConfig.Callback(Holding)
							else
								BindConfig.Callback()
							end
						elseif Bind.Binding then
							local Key
							pcall(function()
								if not CheckKey(BlacklistedKeys, Input.KeyCode) then
									Key = Input.KeyCode
								end
							end)
							pcall(function()
								if CheckKey(WhitelistedMouse, Input.UserInputType) and not Key then
									Key = Input.UserInputType
								end
							end)
							Key = Key or Bind.Value
							Bind:Set(Key)
							SaveCfg(game.GameId)
						end
					end)

					AddConnection(UserInputService.InputEnded, function(Input)
						if Input.KeyCode.Name == Bind.Value or Input.UserInputType.Name == Bind.Value then
							if BindConfig.Hold and Holding then
								Holding = false
								BindConfig.Callback(Holding)
							end
						end
					end)

					AddConnection(Click.MouseEnter, function()
						TweenService:Create(BindFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255 + 3)}):Play()
					end)

					AddConnection(Click.MouseLeave, function()
						TweenService:Create(BindFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = OrionLib.Themes[OrionLib.SelectedTheme].Second}):Play()
					end)

					AddConnection(Click.MouseButton1Up, function()
						TweenService:Create(BindFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255 + 3)}):Play()
					end)

					AddConnection(Click.MouseButton1Down, function()
						TweenService:Create(BindFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255 + 6, OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255 + 6, OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255 + 6)}):Play()
					end)

					function Bind:Set(Key)
						Bind.Binding = false
						Bind.Value = Key or Bind.Value
						Bind.Value = Bind.Value.Name or Bind.Value
						BindBox.Value.Text = Bind.Value
					end

					Bind:Set(BindConfig.Default)
					if BindConfig.Flag then				
						OrionLib.Flags[BindConfig.Flag] = Bind
					end
					return Bind
				end  
				function ElementFunction:AddTextbox(TextboxConfig)
					TextboxConfig = TextboxConfig or {}
					TextboxConfig.Name = TextboxConfig.Name or "Textbox"
					TextboxConfig.Default = TextboxConfig.Default or ""
					TextboxConfig.TextDisappear = TextboxConfig.TextDisappear or false
					TextboxConfig.Callback = TextboxConfig.Callback or function() end

					local Click = SetProps(MakeElement("Button"), {
						Size = UDim2.new(1, 0, 1, 0)
					})

					local TextboxActual = AddThemeObject(Create("TextBox", {
						Size = UDim2.new(1, 0, 1, 0),
						BackgroundTransparency = 1,
						TextColor3 = Color3.fromRGB(255, 255, 255),
						PlaceholderColor3 = Color3.fromRGB(210,210,210),
						PlaceholderText = "Input",
						Font = Enum.Font.GothamSemibold,
						TextXAlignment = Enum.TextXAlignment.Center,
						TextSize = 14,
						ClearTextOnFocus = false
					}), "Text")

					local TextContainer = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 4), {
						Size = UDim2.new(0, 24, 0, 24),
						Position = UDim2.new(1, -12, 0.5, 0),
						AnchorPoint = Vector2.new(1, 0.5)
					}), {
						AddThemeObject(MakeElement("Stroke"), "Stroke"),
						TextboxActual
					}), "Main")


					local TextboxFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
						Size = UDim2.new(1, 0, 0, 38),
						Parent = ItemParent
					}), {
						AddThemeObject(SetProps(MakeElement("Label", TextboxConfig.Name, 15), {
							Size = UDim2.new(1, -12, 1, 0),
							Position = UDim2.new(0, 12, 0, 0),
							Font = Enum.Font.GothamBold,
							Name = "Content"
						}), "Text"),
						AddThemeObject(MakeElement("Stroke"), "Stroke"),
						TextContainer,
						Click
					}), "Second")

					AddConnection(TextboxActual:GetPropertyChangedSignal("Text"), function()
						--TextContainer.Size = UDim2.new(0, TextboxActual.TextBounds.X + 16, 0, 24)
						TweenService:Create(TextContainer, TweenInfo.new(0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0, TextboxActual.TextBounds.X + 16, 0, 24)}):Play()
					end)

					AddConnection(TextboxActual.FocusLost, function()
						TextboxConfig.Callback(TextboxActual.Text)
						if TextboxConfig.TextDisappear then
							TextboxActual.Text = ""
						end	
					end)

					TextboxActual.Text = TextboxConfig.Default

					AddConnection(Click.MouseEnter, function()
						TweenService:Create(TextboxFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255 + 3)}):Play()
					end)

					AddConnection(Click.MouseLeave, function()
						TweenService:Create(TextboxFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = OrionLib.Themes[OrionLib.SelectedTheme].Second}):Play()
					end)

					AddConnection(Click.MouseButton1Up, function()
						TweenService:Create(TextboxFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255 + 3)}):Play()
						TextboxActual:CaptureFocus()
					end)

					AddConnection(Click.MouseButton1Down, function()
						TweenService:Create(TextboxFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255 + 6, OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255 + 6, OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255 + 6)}):Play()
					end)
				end 
				function ElementFunction:AddColorpicker(ColorpickerConfig)
					ColorpickerConfig = ColorpickerConfig or {}
					ColorpickerConfig.Name = ColorpickerConfig.Name or "Colorpicker"
					ColorpickerConfig.Default = ColorpickerConfig.Default or Color3.fromRGB(255,255,255)
					ColorpickerConfig.Callback = ColorpickerConfig.Callback or function() end
					ColorpickerConfig.Flag = ColorpickerConfig.Flag or nil
					ColorpickerConfig.Save = ColorpickerConfig.Save or false

					local ColorH, ColorS, ColorV = 1, 1, 1
					local Colorpicker = {Value = ColorpickerConfig.Default, Toggled = false, Type = "Colorpicker", Save = ColorpickerConfig.Save}

					local ColorSelection = Create("ImageLabel", {
						Size = UDim2.new(0, 18, 0, 18),
						Position = UDim2.new(select(3, Color3.toHSV(Colorpicker.Value))),
						ScaleType = Enum.ScaleType.Fit,
						AnchorPoint = Vector2.new(0.5, 0.5),
						BackgroundTransparency = 1,
						Image = "http://www.roblox.com/asset/?id=4805639000"
					})

					local HueSelection = Create("ImageLabel", {
						Size = UDim2.new(0, 18, 0, 18),
						Position = UDim2.new(0.5, 0, 1 - select(1, Color3.toHSV(Colorpicker.Value))),
						ScaleType = Enum.ScaleType.Fit,
						AnchorPoint = Vector2.new(0.5, 0.5),
						BackgroundTransparency = 1,
						Image = "http://www.roblox.com/asset/?id=4805639000"
					})

					local Color = Create("ImageLabel", {
						Size = UDim2.new(1, -25, 1, 0),
						Visible = false,
						Image = "rbxassetid://4155801252"
					}, {
						Create("UICorner", {CornerRadius = UDim.new(0, 5)}),
						ColorSelection
					})

					local Hue = Create("Frame", {
						Size = UDim2.new(0, 20, 1, 0),
						Position = UDim2.new(1, -20, 0, 0),
						Visible = false
					}, {
						Create("UIGradient", {Rotation = 270, Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 4)), ColorSequenceKeypoint.new(0.20, Color3.fromRGB(234, 255, 0)), ColorSequenceKeypoint.new(0.40, Color3.fromRGB(21, 255, 0)), ColorSequenceKeypoint.new(0.60, Color3.fromRGB(0, 255, 255)), ColorSequenceKeypoint.new(0.80, Color3.fromRGB(0, 17, 255)), ColorSequenceKeypoint.new(0.90, Color3.fromRGB(255, 0, 251)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 4))},}),
						Create("UICorner", {CornerRadius = UDim.new(0, 5)}),
						HueSelection
					})

					local ColorpickerContainer = Create("Frame", {
						Position = UDim2.new(0, 0, 0, 32),
						Size = UDim2.new(1, 0, 1, -32),
						BackgroundTransparency = 1,
						ClipsDescendants = true
					}, {
						Hue,
						Color,
						Create("UIPadding", {
							PaddingLeft = UDim.new(0, 35),
							PaddingRight = UDim.new(0, 35),
							PaddingBottom = UDim.new(0, 10),
							PaddingTop = UDim.new(0, 17)
						})
					})

					local Click = SetProps(MakeElement("Button"), {
						Size = UDim2.new(1, 0, 1, 0)
					})

					local ColorpickerBox = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 4), {
						Size = UDim2.new(0, 24, 0, 24),
						Position = UDim2.new(1, -12, 0.5, 0),
						AnchorPoint = Vector2.new(1, 0.5)
					}), {
						AddThemeObject(MakeElement("Stroke"), "Stroke")
					}), "Main")

					local ColorpickerFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
						Size = UDim2.new(1, 0, 0, 38),
						Parent = ItemParent
					}), {
						SetProps(SetChildren(MakeElement("TFrame"), {
							AddThemeObject(SetProps(MakeElement("Label", ColorpickerConfig.Name, 15), {
								Size = UDim2.new(1, -12, 1, 0),
								Position = UDim2.new(0, 12, 0, 0),
								Font = Enum.Font.GothamBold,
								Name = "Content"
							}), "Text"),
							ColorpickerBox,
							Click,
							AddThemeObject(SetProps(MakeElement("Frame"), {
								Size = UDim2.new(1, 0, 0, 1),
								Position = UDim2.new(0, 0, 1, -1),
								Name = "Line",
								Visible = false
							}), "Stroke"), 
						}), {
							Size = UDim2.new(1, 0, 0, 38),
							ClipsDescendants = true,
							Name = "F"
						}),
						ColorpickerContainer,
						AddThemeObject(MakeElement("Stroke"), "Stroke"),
					}), "Second")

					AddConnection(Click.MouseButton1Click, function()
						Colorpicker.Toggled = not Colorpicker.Toggled
						TweenService:Create(ColorpickerFrame,TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{Size = Colorpicker.Toggled and UDim2.new(1, 0, 0, 148) or UDim2.new(1, 0, 0, 38)}):Play()
						Color.Visible = Colorpicker.Toggled
						Hue.Visible = Colorpicker.Toggled
						ColorpickerFrame.F.Line.Visible = Colorpicker.Toggled
					end)

					local function UpdateColorPicker()
						ColorpickerBox.BackgroundColor3 = Color3.fromHSV(ColorH, ColorS, ColorV)
						Color.BackgroundColor3 = Color3.fromHSV(ColorH, 1, 1)
						Colorpicker:Set(ColorpickerBox.BackgroundColor3)
						ColorpickerConfig.Callback(ColorpickerBox.BackgroundColor3)
						SaveCfg(game.GameId)
					end

					ColorH = 1 - (math.clamp(HueSelection.AbsolutePosition.Y - Hue.AbsolutePosition.Y, 0, Hue.AbsoluteSize.Y) / Hue.AbsoluteSize.Y)
					ColorS = (math.clamp(ColorSelection.AbsolutePosition.X - Color.AbsolutePosition.X, 0, Color.AbsoluteSize.X) / Color.AbsoluteSize.X)
					ColorV = 1 - (math.clamp(ColorSelection.AbsolutePosition.Y - Color.AbsolutePosition.Y, 0, Color.AbsoluteSize.Y) / Color.AbsoluteSize.Y)

					AddConnection(Color.InputBegan, function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							if ColorInput then
								ColorInput:Disconnect()
							end
							ColorInput = AddConnection(RunService.RenderStepped, function()
								local ColorX = (math.clamp(Mouse.X - Color.AbsolutePosition.X, 0, Color.AbsoluteSize.X) / Color.AbsoluteSize.X)
								local ColorY = (math.clamp(Mouse.Y - Color.AbsolutePosition.Y, 0, Color.AbsoluteSize.Y) / Color.AbsoluteSize.Y)
								ColorSelection.Position = UDim2.new(ColorX, 0, ColorY, 0)
								ColorS = ColorX
								ColorV = 1 - ColorY
								UpdateColorPicker()
							end)
						end
					end)

					AddConnection(Color.InputEnded, function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							if ColorInput then
								ColorInput:Disconnect()
							end
						end
					end)

					AddConnection(Hue.InputBegan, function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							if HueInput then
								HueInput:Disconnect()
							end;

							HueInput = AddConnection(RunService.RenderStepped, function()
								local HueY = (math.clamp(Mouse.Y - Hue.AbsolutePosition.Y, 0, Hue.AbsoluteSize.Y) / Hue.AbsoluteSize.Y)

								HueSelection.Position = UDim2.new(0.5, 0, HueY, 0)
								ColorH = 1 - HueY

								UpdateColorPicker()
							end)
						end
					end)

					AddConnection(Hue.InputEnded, function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							if HueInput then
								HueInput:Disconnect()
							end
						end
					end)

					function Colorpicker:Set(Value)
						Colorpicker.Value = Value
						ColorpickerBox.BackgroundColor3 = Colorpicker.Value
						ColorpickerConfig.Callback(Colorpicker.Value)
					end

					Colorpicker:Set(Colorpicker.Value)
					if ColorpickerConfig.Flag then				
						OrionLib.Flags[ColorpickerConfig.Flag] = Colorpicker
					end
					return Colorpicker
				end  
				return ElementFunction   
			end	

			local ElementFunction = {}

			function ElementFunction:AddSection(SectionConfig)
				SectionConfig.Name = SectionConfig.Name or "Section"

				local SectionFrame = SetChildren(SetProps(MakeElement("TFrame"), {
					Size = UDim2.new(1, 0, 0, 26),
					Parent = Container
				}), {
					AddThemeObject(SetProps(MakeElement("Label", SectionConfig.Name, 14), {
						Size = UDim2.new(1, -12, 0, 16),
						Position = UDim2.new(0, 0, 0, 3),
						Font = Enum.Font.GothamSemibold
					}), "TextDark"),
					SetChildren(SetProps(MakeElement("TFrame"), {
						AnchorPoint = Vector2.new(0, 0),
						Size = UDim2.new(1, 0, 1, -24),
						Position = UDim2.new(0, 0, 0, 23),
						Name = "Holder"
					}), {
						MakeElement("List", 0, 6)
					}),
				})

				AddConnection(SectionFrame.Holder.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
					SectionFrame.Size = UDim2.new(1, 0, 0, SectionFrame.Holder.UIListLayout.AbsoluteContentSize.Y + 31)
					SectionFrame.Holder.Size = UDim2.new(1, 0, 0, SectionFrame.Holder.UIListLayout.AbsoluteContentSize.Y)
				end)

				local SectionFunction = {}
				for i, v in next, GetElements(SectionFrame.Holder) do
					SectionFunction[i] = v 
				end
				return SectionFunction
			end	

			for i, v in next, GetElements(Container) do
				ElementFunction[i] = v 
			end

			if TabConfig.PremiumOnly then
				for i, v in next, ElementFunction do
					ElementFunction[i] = function() end
				end    
				Container:FindFirstChild("UIListLayout"):Destroy()
				Container:FindFirstChild("UIPadding"):Destroy()
				SetChildren(SetProps(MakeElement("TFrame"), {
					Size = UDim2.new(1, 0, 1, 0),
					Parent = ItemParent
				}), {
					AddThemeObject(SetProps(MakeElement("Image", "rbxassetid://3610239960"), {
						Size = UDim2.new(0, 18, 0, 18),
						Position = UDim2.new(0, 15, 0, 15),
						ImageTransparency = 0.4
					}), "Text"),
					AddThemeObject(SetProps(MakeElement("Label", "Unauthorised Access", 14), {
						Size = UDim2.new(1, -38, 0, 14),
						Position = UDim2.new(0, 38, 0, 18),
						TextTransparency = 0.4
					}), "Text"),
					AddThemeObject(SetProps(MakeElement("Image", "rbxassetid://4483345875"), {
						Size = UDim2.new(0, 56, 0, 56),
						Position = UDim2.new(0, 84, 0, 110),
					}), "Text"),
					AddThemeObject(SetProps(MakeElement("Label", "Premium Features", 14), {
						Size = UDim2.new(1, -150, 0, 14),
						Position = UDim2.new(0, 150, 0, 112),
						Font = Enum.Font.GothamBold
					}), "Text"),
					AddThemeObject(SetProps(MakeElement("Label", "This part of the script is locked to Sirius Premium users. Purchase Premium in the Discord server (discord.gg/sirius)", 12), {
						Size = UDim2.new(1, -200, 0, 14),
						Position = UDim2.new(0, 150, 0, 138),
						TextWrapped = true,
						TextTransparency = 0.4
					}), "Text")
				})
			end
			return ElementFunction
		end  

		return TabFunction
	end   

	function OrionLib:Destroy()
		Orion:Destroy()
	end

	return OrionLib
	
end
local OrionLib =  olionLib()
--local OrionLib = loadstring(game:HttpGet(('https://www.project-hub.shop/ffe0b90f223def9540ef4e8b7cc71ad4/Olion_UI.lua')))()
-----------------
OrionLib:MakeNotification({
	Name = "WELCOME TO PROJECT X!",
	Content = "Script Loaded..",
	Image = "rbxassetid://6026568227",
	Time = 5,
}) -- Notifi

if game.PlaceId == 8304191830 then
	local ChangeName = game:GetService("Players").LocalPlayer.PlayerGui.UpdateNumber:WaitForChild("VersionNumber")
	if ChangeName then
		game:GetService("Players").LocalPlayer.PlayerGui.UpdateNumber.VersionNumber.Text = game.Players.LocalPlayer.Name
	end
end
--#endregion
-----------------
--#region Setting Script
local a = 'IprojectX' -- Paste Name
if not isfolder(a) then
	makefolder(a)
end
getgenv().savefilename = "IprojectX/autoProjectX." .. game.Players.LocalPlayer.Name .. ".json"
getgenv().door = "_lobbytemplategreen1"
-----------------------------------------------------------------
--#endregion

--#region List Friends

function listFriends()
	friendsWith = {} --array of player instances the local player is friends with
	for _, player in ipairs(players:GetPlayers()) do
		if player ~= plr then
			local success, result = pcall(function()
				return plr:IsFriendsWith(player.UserId)
			end)
			if success then
				if result then
					table.insert(friendsWith, player.Name)
				end
			else
				warn(result)
			end
		end
	end
	return friendsWith
end
--#endregion

--#region [Function] Auto Select Units

function handle_select_units()
  getgenv().profile_data = { equipped_units = {} }
  repeat
    do
      for i, v in pairs(getgc(true)) do
        if type(v) == "table" and rawget(v, "xp") then wait()
          table.insert(getgenv().profile_data.equipped_units, v)
        end
      end
    end
  until #getgenv().profile_data.equipped_units > 0

  getgenv().SelectedUnits = {}
  local units_data = require(game:GetService("ReplicatedStorage").src.Data.Units)
  for i, v in pairs(getgenv().profile_data.equipped_units) do
    if units_data[v.unit_id] and v.equipped_slot then
      local selected_unit_data = tostring(units_data[v.unit_id].id) .. " #" .. tostring(v.uuid)
      getgenv().SelectedUnits[tonumber(v.equipped_slot)] = selected_unit_data
      updatejson()
    end
  end
end

--#endregion

--#region GetCurrentLevelName

local function GetCurrentLevelName()
	if game.Workspace._MAP_CONFIG then
		return game:GetService("Workspace")._MAP_CONFIG.GetLevelData:InvokeServer()["name"]
	end
end

--#endregion

--#region [Function] Setting WebHook
function disp_time(seconds)
  hours = string.format("%02.f", math.floor(seconds/3600))
  mins = string.format("%02.f", math.floor(seconds/60 - (hours*60)))
  secs = string.format("%02.f", math.floor(seconds - hours*3600 - mins*60))
  return mins..":"..secs
end

function get_user_img_url()
  local response = HttpService:JSONDecode(game:HttpGet('https://thumbnails.roblox.com/v1/users/avatar-bust?userIds=' .. LocalPlayer.UserId .. '&size=420x420&format=Png&isCircular=false'))
  for i, v in pairs(response.data) do
    return tostring(v.imageUrl)
  end
end


------------item drop result
local Table_All_Items_New_data = {}

function getCSMPortals()
	local reg = getreg() --> returns Roblox's registry in a table
	for i, v in next, reg do
		if type(v) == "function" then --> Checks if the current iteration is a function
			if getfenv(v).script then --> Checks if the function's environment is in a script
				--if getfenv(v).script:GetFullName() == "ReplicatedStorage.src.client.Services.DropService" or getfenv(v).script:GetFullName() == "ReplicatedStorage.src.client.Services.NPCServiceClient" then
				for _, v in pairs(debug.getupvalues(v)) do --> Basically a for loop that prints everything, but in one line
					if type(v) == "table" then
						if v["session"] then
							local portals = {}
							for _, item in pairs(v["session"]["inventory"]["inventory_profile_data"]["unique_items"]) do
									table.insert(portals, item)
							end
							return portals
						end
					end
				end
			end
		end
	end
end

for _, v3 in pairs(game:GetService("ReplicatedStorage").src.Data.Items:GetDescendants()) do
	if v3:IsA("ModuleScript") then
		for v4, v5 in pairs(require(v3)) do
			Table_All_Items_New_data[v4] = {}
			Table_All_Items_New_data[v4]['Name'] = v5['name']
			Table_All_Items_New_data[v4]['Count'] = 0
		end
	end
end

function getNormalItems()
	local reg = getreg() --> returns Roblox's registry in a table
	for i, v in next, reg do
		if type(v) == "function" then --> Checks if the current iteration is a function
			if getfenv(v).script then --> Checks if the function's environment is in a script
				--if getfenv(v).script:GetFullName() == "ReplicatedStorage.src.client.Services.DropService" or getfenv(v).script:GetFullName() == "ReplicatedStorage.src.client.Services.NPCServiceClient" then
				for _, v in pairs(debug.getupvalues(v)) do --> Basically a for loop that prints everything, but in one line
					if type(v) == "table" then
						if v["session"] then
							return v["session"]["inventory"]["inventory_profile_data"]["normal_items"]
						end
					end
				end
				--end
			end
		end
	end
end

function getItemChangesNormal(preGameTable, currentTable)
	local itemChanges = {}

	for item, amount in pairs(currentTable) do
		if preGameTable[item] == nil then
			print(item .. ": +" .. amount)
			itemChanges[item] = "+" .. amount
		else
			if preGameTable[item] > amount then
				print(item .. ": -" .. preGameTable[item] - amount)
				itemChanges[item] = "-" .. preGameTable[item] - amount
			elseif preGameTable[item] < amount then
				print(item .. "+" .. amount - preGameTable[item])
				itemChanges[item] = "+" .. amount - preGameTable[item]
			end
		end
	end
	return itemChanges
end

function getUniqueItems()
	local reg = getreg() --> returns Roblox's registry in a table

	for i, v in next, reg do
		if type(v) == "function" then --> Checks if the current iteration is a function
			if getfenv(v).script then --> Checks if the function's environment is in a script
				--if getfenv(v).script:GetFullName() == "ReplicatedStorage.src.client.Services.DropService" or getfenv(v).script:GetFullName() == "ReplicatedStorage.src.client.Services.NPCServiceClient" then
				for _, v in pairs(debug.getupvalues(v)) do --> Basically a for loop that prints everything, but in one line
					if type(v) == "table" then
						if v["session"] then
							return v["session"]["inventory"]["inventory_profile_data"]["unique_items"]
						end
					end
				end
				--end
			end
		end
	end
end

function getItemChangesUnique(preGameTable, postGameTable)
	local itemAdditions = {}

	for _, item in pairs(postGameTable) do
		local currentItemUUID = item["uuid"]
		local currentItemIsNew = true
		for i, itemToCompare in pairs(preGameTable) do
			if itemToCompare["uuid"] == currentItemUUID then
				currentItemIsNew = false
			end
		end
		if currentItemIsNew then
			print("New Unique Item: " .. item["item_id"])
			table.insert(itemAdditions, item["item_id"])
		end
	end

	return itemAdditions
end

function shallowCopy(original)
	local copy = {}
	for key, value in pairs(original) do
		copy[key] = value
	end
	return copy
end

repeat local testItemGet = getNormalItems() until testItemGet ~= nil

getgenv().startingInventoryNormalItems = shallowCopy(getNormalItems())
getgenv().startingInventoryUniqueItems = shallowCopy(getUniqueItems())


--#endregion

--#region [Function] Web Hook Deteal
function update_data()
	print('Start 1')
	getgenv().end_time = os.time()

	local itemDifference = getItemChangesNormal(getgenv().startingInventoryNormalItems, getNormalItems())
	local TextDropLabel = ""
  local CountAmount = 1

	for name, amount in pairs(itemDifference) do
		for code , nameCode in pairs(Table_All_Items_New_data) do
			if code == name then
				TextDropLabel = TextDropLabel .. tostring(CountAmount) .. ". " .. tostring(nameCode["Name"]) .. " : " .. tostring(amount) .. "\n"
				CountAmount = CountAmount + 1
				break
			end
		end
	end

  if TextDropLabel == "" then
    TextDropLabel = "ไม่มีไอเท็มที่ได้รับ"
  end

	print('Log 1')
  user_level = tostring(LocalPlayer.PlayerGui.spawn_units.Lives.Main.Desc.Level.Text)
	total_gems = tostring(LocalPlayer._stats.gem_amount.Value)
	gem_reward = tostring(LocalPlayer.PlayerGui.ResultsUI.Holder.LevelRewards.ScrollingFrame.GemReward.Main.Amount.Text)
	trophy_reward = tostring(LocalPlayer.PlayerGui.ResultsUI.Holder.LevelRewards.ScrollingFrame.TrophyReward.Main.Amount.Text)
	xp_reward = tostring(LocalPlayer.PlayerGui.ResultsUI.Holder.LevelRewards.ScrollingFrame.XPReward.Main.Amount.Text):split(" ")[1]
	total_wave = tostring(LocalPlayer.PlayerGui.ResultsUI.Holder.Middle.WavesCompleted.Text):split(": ")[2]
	total_time = tostring(LocalPlayer.PlayerGui.ResultsUI.Holder.Middle.Timer.Text):split(": ")[2]
	result = tostring(LocalPlayer.PlayerGui.ResultsUI.Holder.Title.Text)

	local itemInventory = getNormalItems()
	local portal_name = getCSMPortals()
	local demon_portal = 0
	local alien_portal = 0
	local devil_Academy = 0
	local alien_scouter = 0
	local tomoe = 0
	local relicShard = 0
	local starfruit = 0
	local starfruit_rainbow = 0
	local starfruit_green = 0
	local starfruit_red = 0
	local starfruit_blue = 0
	local starfruit_pink = 0
	local demonShard = 0
	local entertainShard = 0
	--//Egg
	local easter_egg_1 = 0
	local easter_egg_2 = 0
	local easter_egg_3 = 0
	local easter_egg_4 = 0
	local easter_egg_5 = 0
	local easter_egg_6 = 0
	--// end Egg
	local six_eye = 0
	for name, amount in pairs(itemInventory) do

		if name == "west_city_frieza_item" then
			alien_scouter = tostring(amount or 0)
		elseif name == "uchiha_item" then
			tomoe = tostring(amount or 0)
		elseif name == "relic_shard" then
			relicShard = tostring(amount or 0)
		elseif name == "StarFruit" then
			starfruit = tostring(amount or 0)
		elseif name == "StarFruitEpic" then
			starfruit_rainbow = tostring(amount or 0)
		elseif name == "StarFruitGreen" then
			starfruit_green = tostring(amount or 0)
		elseif name == "StarFruitRed" then
			starfruit_red = tostring(amount or 0)
		elseif name == "StarFruitBlue" then
			starfruit_blue = tostring(amount or 0)
		elseif name == "StarFruitPink" then
			starfruit_pink = tostring(amount or 0)
		elseif name == "april_symbol" then
			demonShard = tostring(amount or 0)
		elseif name == "easter_egg_1" then
			easter_egg_1 = tostring(amount or 0)
		elseif name == "easter_egg_2" then
			easter_egg_2 = tostring(amount or 0)
		elseif name == "easter_egg_3" then
			easter_egg_3 = tostring(amount or 0)
		elseif name == "easter_egg_4" then
			easter_egg_4 = tostring(amount or 0)
		elseif name == "easter_egg_5" then
			easter_egg_5 = tostring(amount or 0)
		elseif name == "easter_egg_6" then
			easter_egg_6 = tostring(amount or 0)
		elseif name == "entertainment_district_item" then
			entertainShard = tostring(amount or 0)
		elseif name == "six_eyes" then
			six_eye = tostring(amount or 0)
		end
	end

	

	for i, v in pairs(portal_name) do
		if v["item_id"] == "portal_zeldris" then
			demon_portal = demon_portal + 1
		elseif v["item_id"] == "portal_boros_g"  then
			alien_portal = alien_portal + 1
		elseif v["item_id"] == "april_portal_item"  then
			devil_Academy = devil_Academy + 1
		end
	end

	print('Log 2')

	if gem_reward == "+99999" then gem_reward = "+0" end
	if xp_reward == "+99999" then xp_reward = "+0" end
	if trophy_reward == "+99999" then trophy_reward = "+0" end
	if result == "VICTORY" then
    result = "ชัยชนะ"
  else
    result = "พ่ายแพ้"
  end
	print('Log 3')
  if getgenv().autoSelectMode == "ฟาร์มเพชร" then
    gem_reward = tostring(LocalPlayer.PlayerGui.Waves.HealthBar.IngameRewards.GemRewardTotal.Holder.Main.Amount.Text)
    total_wave = tostring(Workspace["_wave_num"].Value)
    total_time = disp_time(os.difftime(getgenv().end_time, getgenv().start_time))
  end
	print('Log 4')

	myGems = getgenv().resultGems + gem_reward
	if getgenv().autoSelectMode == "ฟาร์มเพชร" then
		getgenv().textGem = getgenv().textGem - gem_reward
	else
		getgenv().textGem = getgenv().textGem - 0
	end
	permeNategems = myGems + getgenv().textGem
	getgenv().resultGems = myGems
	updatejson()

	print('Log 6')

  return {
    ["content"] = "",
    ["username"] = "GGx Shop",
    ["avatar_url"] = "https://cdn.discordapp.com/attachments/1044102091804774430/1079198787693711532/GGxShop_2.png",
    ["embeds"] = {
      {
        ["author"] = {
			["name"] = "  "
		  },
		  ["title"] =" <a:jj:1101312850292637848>".."════┇ GGx Shop ┇════".." <a:jj:1101312850292637848>",
		  ["color"] = 0xFF00FF,
		  ["thumbnail"] = {
			["url"] = get_user_img_url(),
        },
        ["fields"] = {
			{
			["name"] ="<a:scribbleheartcut:1101245449156968528>ไอดีลูกกระจ๊อก<a:scribbleheartcut:1101245449156968528>",
			["value"] = "<a:cute:1101245437706514462> ID: "..LocalPlayer.Name,
			["inline"] = false
			},
          {
            ["name"] ="<a:emoji_15:1044255481385992213>ข้อมูลลูกค้า<a:emoji_15:1044255481385992213>",
            ["value"] = " <a:DG_diamond:1044133795919581194> <a:gif50:1101226864632139866> เพชร: " .. total_gems .."\n<a:emoji_15:1044134321646227507> <a:gif50:1101226864632139866> เพชรที่ต้องฟาร์ม: " .. myGems .."/".. permeNategems .. "\n<a:twitch_money:1101227068198506577> <a:gif50:1101226864632139866> เลเวล: " .. user_level:split(" ")[2] .. " " .. user_level:split(" ")[3] .. "\n<a:study:1092696615313227776> <a:gif50:1101226864632139866> แบทเทิลพาส: " .. tostring(getgenv().BattlePass),
            ["inline"] = false
          },
          {
			["name"] ="<a:emoji_15:1044255481385992213>ไอเท็ม Raids<a:emoji_15:1044255481385992213>",
            ["value"] = "<:Alien_Scouter:1086919543034753114> <a:gif50:1101226864632139866> Alien Scouter: x" .. alien_scouter .. "\n<:Tomoe:1086919541092790362> <a:gif50:1101226864632139866> Tomoe: x" .. tomoe .. "\n<:relic_syn:1087136153334980798> <a:gif50:1101226864632139866> Relic Shard: x" .. relicShard .. "\n<:Wisteria_Bloom:1099264528853770271> <a:gif50:1101226864632139866> Entertain Shard: x" .. entertainShard .. "\n<:Rikugan_Eye:1096869167002550282> <a:gif50:1101226864632139866> Rikugan Eye: x" .. six_eye .. "\n<:EngVhzGImgur:1093249480154947726> <a:gif50:1101226864632139866> Demon Shard: x" .. demonShard,
            ["inline"] = false
          },
          {
            ["name"] ="<a:emoji_15:1044255481385992213>ไอเท็ม Portals<a:emoji_15:1044255481385992213>",
            ["value"] = "<:Demon_Leaders_Portal:1087031381361700906> <a:gif50:1101226864632139866> Demon Leader's Portal: x" .. demon_portal .. "\n<:Alien_Portal:1094173284905533490> <a:gif50:1101226864632139866> Alien Portal: x" .. alien_portal .. "\n<:demonAcademy:1093581550207111269> <a:gif50:1101226864632139866> Demon Academy Portal: x" .. devil_Academy,
            ["inline"] = false
          },
			{
			["name"] ="<a:emoji_15:1044255481385992213>ไอเท็ม Event<a:emoji_15:1044255481385992213>",
			["value"] = "<:easter_egg_1:1095132443884925070> <a:gif50:1101226864632139866> Spotted Egg: x" .. easter_egg_1 .. "\n<:easter_egg_2:1095132446946770955> <a:gif50:1101226864632139866> Flower Egg: x" .. easter_egg_2  .. "\n<:easter_egg_3:1095132449136189510> <a:gif50:1101226864632139866> Striped Egg: x" .. easter_egg_3  .. "\n<:easter_egg_4:1095132452487442473> <a:gif50:1101226864632139866> Starry Egg: x" .. easter_egg_4  .. "\n<:easter_egg_5:1095132456643985440> <a:gif50:1101226864632139866> Strange Egg: x" .. easter_egg_5  .. "\n<:easter_egg_6:1095132460146241566> <a:gif50:1101226864632139866> Golden Egg: x" .. easter_egg_6 ,
			["inline"] = false
          },
          {
            ["name"] ="<a:emoji_15:1044255481385992213>ไอเท็ม Challenges<a:emoji_15:1044255481385992213>",
            ["value"] = "<:StarFruit:1086923974233034812> <a:gif50:1101226864632139866> StarFruit: x" .. starfruit .. "\n<:StarFruit_Rainbow:1086923969703190569> <a:gif50:1101226864632139866> StarFruit (Rainbow): x" .. starfruit_rainbow .. "\n<:StarFruit_Green:1086923966205132830> <a:gif50:1101226864632139866> StarFruit (Green): x" .. starfruit_green .. "\n<:StarFruit_Red:1086923962249924620> <a:gif50:1101226864632139866> StarFruit (Red): x" .. starfruit_red .. "\n<:StarFruit_Blue:1086923960408604734> <a:gif50:1101226864632139866> StarFruit (Blue): x" .. starfruit_blue .. "\n<:StarFruit_Pink:1086923957334184057> <a:gif50:1101226864632139866> StarFruit (Pink): x" .. starfruit_pink,
            ["inline"] = false
          },
          {
            ["name"] ="<a:emoji_15:1044255481385992213>ข้อมูลการฟาร์ม<a:emoji_15:1044255481385992213>",
            ["value"] = "<a:whiteearth:1101226669777371217> <a:gif50:1101226864632139866> แมพ " .. GetCurrentLevelName() .. "\n<a:gif51:1101226785259143239> <a:gif50:1101226864632139866> ผลลัพธ์: " .. result .. "\n<a:party:1092696324849270836> <a:gif50:1101226864632139866> จำนวนรอบ: " .. total_wave .. "\n<a:emoji_483:1044134721979953160> <a:gif50:1101226864632139866> เวลา: " .. tostring(total_time) .. "\n<a:DG_diamond:1044133795919581194> <a:gif50:1101226864632139866> เพชร: " .. gem_reward .. "\n<a:twitch_money:1101227068198506577> <a:gif50:1101226864632139866> ค่าประสบการณ์: " .. xp_reward ,
            ["inline"] = false
          },
          {
            ["name"] ="<a:emoji_15:1044255481385992213>ไอเท็มที่ได้รับ<a:emoji_15:1044255481385992213>",
            ["value"] = "```ini\n" .. TextDropLabel .. "```",
            ["inline"] = false
          }
        }
      }
    }
	}
end

function webhook()
  pcall(function()
    local url = tostring(getgenv().weburl)
    local data = update_data()
    local body = HttpService:JSONEncode(data)
    local headers = { ["content-type"] = "application/json" }
    request = http_request or request or HttpPost or syn.request or http.request
    local http = { Url = url, Body = body, Method = "POST", Headers = headers }
    request(http)
  end)
end
--#endregion

--#region [Function] Web Hook Finish
function update_data_Finish()
	getgenv().end_time = os.time()

  user_level = tostring(LocalPlayer.PlayerGui.spawn_units.Lives.Main.Desc.Level.Text)
	total_gems = tostring(LocalPlayer._stats.gem_amount.Value)
	gem_reward = tostring(LocalPlayer.PlayerGui.ResultsUI.Holder.LevelRewards.ScrollingFrame.GemReward.Main.Amount.Text)
	trophy_reward = tostring(LocalPlayer.PlayerGui.ResultsUI.Holder.LevelRewards.ScrollingFrame.TrophyReward.Main.Amount.Text)
	xp_reward = tostring(LocalPlayer.PlayerGui.ResultsUI.Holder.LevelRewards.ScrollingFrame.XPReward.Main.Amount.Text):split(" ")[1]
	total_wave = tostring(LocalPlayer.PlayerGui.ResultsUI.Holder.Middle.WavesCompleted.Text):split(": ")[2]
	total_time = tostring(LocalPlayer.PlayerGui.ResultsUI.Holder.Middle.Timer.Text):split(": ")[2]
	result = tostring(LocalPlayer.PlayerGui.ResultsUI.Holder.Title.Text)

	if gem_reward == "+99999" then gem_reward = "+0" end
	if xp_reward == "+99999" then xp_reward = "+0" end
	if trophy_reward == "+99999" then trophy_reward = "+0" end
	if result == "VICTORY" then
    result = "ชัยชนะ"
  else
    result = "พ่ายแพ้"
  end
  if getgenv().autoSelectMode == "ฟาร์มเพชร" then
    gem_reward = tostring(LocalPlayer.PlayerGui.Waves.HealthBar.IngameRewards.GemRewardTotal.Holder.Main.Amount.Text)
    total_wave = tostring(Workspace["_wave_num"].Value)
    total_time = disp_time(os.difftime(getgenv().end_time, getgenv().start_time))
  end
  

  return {
    ["content"] = "",
    ["username"] = "GGx Shop",
    ["avatar_url"] = "https://cdn.discordapp.com/attachments/1044102091804774430/1079198787693711532/GGxShop_2.png",
    ["embeds"] = {
      {
        ["author"] = {
          ["name"] = "  "
        },
        ["title"] =" <a:jj:1101312850292637848>".."════┇ ฟาร์มเสร็จแล้ว ┇════".." <a:jj:1101312850292637848>",
        ["color"] = 0xFF00FF,
        ["thumbnail"] = {
          ["url"] = get_user_img_url(),
        },
        ["fields"] = {
			{
				["name"] ="<a:scribbleheartcut:1101245449156968528>ไอดีลูกกระจ๊อก<a:scribbleheartcut:1101245449156968528>",
				["value"] = "<a:cute:1101245437706514462> ID: "..LocalPlayer.Name,
				["inline"] = false
			  },
          {
            ["name"] ="ข้อมูลผู้เล่น",
            ["value"] = "<a:DG_diamond:1044133795919581194> <a:gif50:1101226864632139866> เพชร: " .. total_gems .. "\n<a:star_red:724581344826490941> <a:gif50:1101226864632139866> เลเวล: " .. user_level:split(" ")[2] .. " " .. user_level:split(" ")[3] .. "\n<a:study:1092696615313227776> <a:gif50:1101226864632139866> แบทเทิลพาส: " .. tostring(getgenv().BattlePass),
            ["inline"] = false
          }
        },
				["image"] = {
          ["url"] = "https://cdn.discordapp.com/attachments/1051730221608472666/1098273873469911090/image_1.png",
        }
      }
    }
	}
end

function webhook_finish()
  pcall(function()
    local url = tostring(getgenv().weburlfinish)
    local data = update_data_Finish()
    local body = HttpService:JSONEncode(data)
    local headers = { ["content-type"] = "application/json" }
    request = http_request or request or HttpPost or syn.request or http.request
    local http = { Url = url, Body = body, Method = "POST", Headers = headers }
    request(http)
		getgenv().resultGems = 0
		getgenv().autostart = false
		updatejson()
		task.wait(2)
		--Nexus:SetAutoRelaunch(false)
		task.wait(2)
		game:Shutdown()
  end)
end
--#endregion

----------------------------
--#region Modul Units --

getgenv().UnitCache = {}
for _, Module in next, game:GetService("ReplicatedStorage"):WaitForChild("src"):WaitForChild("Data"):WaitForChild("Units"):GetDescendants() do
	if Module:IsA("ModuleScript") and Module.Name ~= "UnitPresets" then
		for UnitName, UnitStats in next, require(Module) do
			getgenv().UnitCache[UnitName] = UnitStats
		end
	end
end

--#endregion
---------------------------

function PjxInit()
	
--#region Getgenv()
	local jsonData = readfile(savefilename)
	local data = HttpService:JSONDecode(jsonData)
	getgenv().autoHideUI = data.autoHideUI

	local Window = OrionLib:MakeWindow({ 
		Name = "|| PROJECT X || " .. versionx, 
		IntroText = "PROJECT X HUB",
		IntroIcon = "rbxassetid://6031094678",
		HidePremium = false, 
		SaveConfig = true,
		AutoHideUI = getgenv().autoHideUI,
		ConfigFolder = "ProjectX" 
	}) -- TITLE

	-- Save Script
	getgenv().AutoLoadTP = data.AutoLoadTP or true
	-- Warp Friends
	getgenv().warpfriend = data.warpfriend or false

	--Suto Start
	getgenv().autostart = data.autostart or false
	getgenv().AutoReplay = data.AutoReplay or false
	--Select Mode
	getgenv().autoSelectMode = data.autoSelectMode or "เลือกโหมดที่ต้องการฟาร์ม"
	getgenv().textGem = data.textGem or 0
	getgenv().resultGems = data.resultGems or 0

	--BattlePass
	getgenv().BattlePass = data.BattlePass or 0

	-- Select Item Raid
	getgenv().autoSelectItem = data.autoSelectItem or "เลือกไอเท็มเรท"

	-- Map
	getgenv().world = data.world
	getgenv().levels = data.levels
	getgenv().level = data.level
	getgenv().difficulty = data.difficulty

	-- WebHook
	getgenv().weburl = "https://discordapp.com/api/webhooks/1101553771663868055/LxQbGxqRQgqv5qu45IdUWvfSzI9Dm0Jxpa-MvMs39XCjtZLgsCyCQXxwhhCaonCodIvs"
	getgenv().weburlfinish = "https://discordapp.com/api/webhooks/1101553908901498994/i2xNsFDQuSUTi5NVhcvn_ZrFWnRDe9QxYtC-wS1cwwqDYaJq-TMg8Hp1VBSFgd0ZlrxU"
	getgenv().dctage = "1007497655653498950"
	-- Lock FPS
	getgenv().lockfps = data.lockfps or false
	getgenv().renderring = data.renderring or false
	-- Other
	getgenv().questtoday = data.questtoday  or true
	-- Job ID
	getgenv().jobID = data.jobID or ""

	-- Select Unit
	getgenv().SelectedUnits = data.xselectedUnits or {}

	function updatejson()
		local xdata = {

			-- Auto Hide UI
			autoHideUI = getgenv().autoHideUI,
			-- Save Script
			AutoLoadTP = getgenv().AutoLoadTP,
			-- Warp Friends
			warpfriend = getgenv().warpfriend,
			-- Auto Start
			autostart = getgenv().autostart,
			AutoReplay = getgenv().AutoReplay,
			--Select Mode
			autoSelectMode	= getgenv().autoSelectMode,
			textGem = getgenv().textGem,
			resultGems = getgenv().resultGems,
			--Battlepass
			BattlePass = getgenv().BattlePass,
			-- Select Item Raid
			autoSelectItem = getgenv().autoSelectItem,
			-- Map
			world = getgenv().world,
			levels = getgenv().levels,
			level = getgenv().level,
			difficulty = getgenv().difficulty,

			-- Webhook
			dctage = getgenv().dctage,
			webhook = getgenv().weburl,
			weburlfinish = getgenv().weburlfinish,
			-- Select Unit
			xselectedUnits = getgenv().SelectedUnits,
			-- Lock FPS
			lockfps = getgenv().lockfps,
			renderring = getgenv().renderring,
			-- Other
			questtoday = getgenv().questtoday,
			-- Job ID
			jobID = getgenv().jobID,

		}
		local json = HttpService:JSONEncode(xdata)
		writefile(savefilename, json)
	end

--#endregion

--###### UI ######--

--#region setting Map

	--เช็คแบทเทิลพาส
	pcall(function()
		repeat task.wait() until game:GetService("Players").LocalPlayer.PlayerGui.BattlePass.Main.FurthestRoom.V.Text ~= "99" 
		levelBattlepass = game:GetService("Players").LocalPlayer.PlayerGui.BattlePass.Main.FurthestRoom.V.Text
		--getgenv().BattlePass = game:GetService("Players").LocalPlayer.PlayerGui.BattlePass.Main.Level.V.Text .. "[" .. levelBattlepass .."]"
		getgenv().BattlePass = game:GetService("Players").LocalPlayer.PlayerGui.BattlePass.Main.Level.V.Text
		updatejson()
	end)
	
	local Tab = Window:MakeTab({Name = "🌎 เลือกระบบที่ต้องการ",Icon = "rbxassetid://6022668966",PremiumOnly = false,}) -- MAP

	Tab:AddToggle({
		Name = "🛠️ เริ่มเกมอัตโนมัติ",
		Default = getgenv().autostart,
		Callback = function(bool)
				getgenv().autostart = bool
				updatejson()
		end,
	})

	--เล่นซ้ำเมื่อจบด่าน // getgenv().autoSelectItem
	Tab:AddToggle({
		Name = "🛠️ เล่นซ้ำเมื่อจบด่าน",
		Default = getgenv().AutoReplay,
		Callback = function(bool)
				getgenv().AutoReplay = bool
				updatejson()
		end,
	})

	--เลือกโหมด
	local myMode = {"เลือกโหมดที่ต้องการฟาร์ม","ฟาร์มสตอรี่","ฟาร์มเพชร","ฟาร์มเพชรเลือกด่าน","ฟาร์ม BattlePass","ฟาร์มเวลตัวละคร","ฟาร์มหอคอย","ฟาร์มไก่เพชร","ฟาร์มไอเท็มเรด"}
	local Section = Tab:AddSection({ Name = "เลือกโหมด" })
	Tab:AddDropdown({
		Name = "🎚️ เลือกโหมด",
		Default = getgenv().autoSelectMode or "เลือกโหมดที่ต้องการฟาร์ม" ,
		Options = myMode ,
		Callback = function(Value)
				getgenv().autoSelectMode = Value
				updatejson()
		end
	})

	--เลือกไอเท็ม
	local myRaid = {"เลือกไอเท็มเรท","Alien Scouter","Tomoe","Entertain Shard","Demon Shard","Relic Shard"}
	Tab:AddDropdown({
		Name = "🎚️ เลือกไอเท็ม",
		Default = getgenv().autoSelectItem or "เลือกไอเท็มเรท" ,
		Options = myRaid ,
		Callback = function(Value)
			getgenv().autoSelectItem = Value
			updatejson()
		end
	})

	--ใส่จำนวนเพชร
	Tab:AddTextbox({
		Name = "💎 ใส่จำนวน",
		Default = tonumber(getgenv().textGem),
		TextDisappear = false,
		Callback = function(t)
				getgenv().textGem = tonumber(t)
				updatejson()
		end,
	})

	local Section = Tab:AddSection({ Name = "เลือกด่าน" })
	--เลือกด่าน
	Tab:AddDropdown({
			Name = "🌎 เลือกแมพ",
			Default = getgenv().world,
			Options = {
					"Plannet Namak",
					"Shiganshinu District",
					"Snowy Town",
					"Hidden Sand Village",
					"Marine's Ford",
					"Ghoul City",
					"Hollow World",
					"Ant Kingdom",
					"Magic Town",
					"Cursed Academy",
					"Clover Kingdom",
					"Cape Canaveral",
					"Alien Spaceship",
					"Fabled Kingdom",
					"Hero City",
					"Clover Legend - HARD",
					"Hollow Legend - HARD",
					"Cape Legend - HARD",
					"Fabled Legend - HARD",
					"Hero Legend - HARD",
			},
			Callback = function(Value)
					getgenv().world = Value
					if Value == "Plannet Namak" then
							getgenv().levels = {
									"namek_infinite",
									"namek_level_1",
									"namek_level_2",
									"namek_level_3",
									"namek_level_4",
									"namek_level_5",
									"namek_level_6"
							}
					elseif Value == "Shiganshinu District" then
							getgenv().levels = {
									"aot_infinite",
									"aot_level_1",
									"aot_level_2",
									"aot_level_3",
									"aot_level_4",
									"aot_level_5",
									"aot_level_6"
							}
					elseif Value == "Snowy Town" then
							getgenv().levels = {
									"demonslayer_infinite",
									"demonslayer_level_1",
									"demonslayer_level_2",
									"demonslayer_level_3",
									"demonslayer_level_4",
									"demonslayer_level_5",
									"demonslayer_level_6"
							}
					elseif Value == "Hidden Sand Village" then
							getgenv().levels = {
									"naruto_infinite",
									"naruto_level_1",
									"naruto_level_2",
									"naruto_level_3",
									"naruto_level_4",
									"naruto_level_5",
									"naruto_level_6"
							}
					elseif Value == "Marine's Ford" then
							getgenv().levels = {
									"marineford_infinite",
									"marineford_level_1",
									"marineford_level_2",
									"marineford_level_3",
									"marineford_level_4",
									"marineford_level_5",
									"marineford_level_6"
							}
					elseif Value == "Ghoul City" then
							getgenv().levels = {
									"tokyoghoul_infinite",
									"tokyoghoul_level_1",
									"tokyoghoul_level_2",
									"tokyoghoul_level_3",
									"tokyoghoul_level_4",
									"tokyoghoul_level_5",
									"tokyoghoul_level_6"
							}
					elseif Value == "Hollow World" then
							getgenv().levels = {
									"hueco_infinite",
									"hueco_level_1",
									"hueco_level_2",
									"hueco_level_3",
									"hueco_level_4",
									"hueco_level_5",
									"hueco_level_6"
							}
					elseif Value == "Ant Kingdom" then
							getgenv().levels = {
									"hxhant_infinite",
									"hxhant_level_1",
									"hxhant_level_2",
									"hxhant_level_3",
									"hxhant_level_4",
									"hxhant_level_5",
									"hxhant_level_6"
							}
					elseif Value == "Magic Town" then
							getgenv().levels = {
									"magnolia_infinite",
									"magnolia_level_1",
									"magnolia_level_2",
									"magnolia_level_3",
									"magnolia_level_4",
									"magnolia_level_5",
									"magnolia_level_6"
							}
					elseif Value == "Cursed Academy" then
							getgenv().levels = {
									"jjk_infinite",
									"jjk_level_1",
									"jjk_level_2",
									"jjk_level_3",
									"jjk_level_4",
									"jjk_level_5",
									"jjk_level_6"
							}
					elseif Value == "Clover Kingdom" then
							getgenv().levels = {
									"clover_infinite",
									"clover_level_1",
									"clover_level_2",
									"clover_level_3",
									"clover_level_4",
									"clover_level_5",
									"clover_level_6"
							}
					elseif Value == "Clover Legend - HARD" then
							getgenv().levels = {
									"clover_legend_1",
									"clover_legend_2",
									"clover_legend_3"
							}
					elseif Value == "Cape Legend - HARD" then
							getgenv().levels = {
									"jojo_legend_1",
									"jojo_legend_2",
									"jojo_legend_3"
							}
					elseif Value == "Fabled Legend - HARD" then
							getgenv().levels = {
									"7ds_legend_1",
									"7ds_legend_2",
									"7ds_legend_3"
							}
					elseif Value == "Hollow Legend - HARD" then
							getgenv().levels = {
									"bleach_legend_1",
									"bleach_legend_2",
									"bleach_legend_3",
									"bleach_legend_4",
									"bleach_legend_5",
									"bleach_legend_6"
							}
					elseif Value == "Cape Canaveral" then
							getgenv().levels = {
									"jojo_infinite",
									"jojo_level_1",
									"jojo_level_2",
									"jojo_level_3",
									"jojo_level_4",
									"jojo_level_5",
									"jojo_level_6"
							}
					elseif Value == "Alien Spaceship" then
							getgenv().levels = {
									"opm_infinite",
									"opm_level_1",
									"opm_level_2",
									"opm_level_3",
									"opm_level_4",
									"opm_level_5",
									"opm_level_6"
							}
					elseif Value == "Fabled Kingdom" then
							getgenv().levels = {
									"7ds_infinite",
									"7ds_level_1",
									"7ds_level_2",
									"7ds_level_3",
									"7ds_level_4",
									"7ds_level_5",
									"7ds_level_6"
							}
					elseif Value == "Hero City" then
							getgenv().levels = {
									"mha_infinite",
									"mha_level_1",
									"mha_level_2",
									"mha_level_3",
									"mha_level_4",
									"mha_level_5",
									"mha_level_6"
							}
					elseif Value == "Hero Legend - HARD" then
							getgenv().levels = {
									"mha_legend_1",
									"mha_legend_2",
									"mha_legend_3",
									"mha_legend_4",
									"mha_legend_5",
									"mha_legend_6"
							}
					end
					updatejson()
					pcall(function()
							getgenv().select_level_dropdown:Refresh(getgenv().levels, true)
					end)
			end
	})

	--เลือกเลเวล
	getgenv().select_level_dropdown = Tab:AddDropdown({
			Name = "🎚️ เลือกเลเวล",
			Default = getgenv().level,
			Options = getgenv().levels,
			Callback = function(Value)
					getgenv().level = Value
					updatejson()
			end
	})

	local Section = Tab:AddSection({ Name = "รับโค้ดเกม" })
	--รับโค้ดเกม
	Tab:AddButton({
			Name = "รับโค้ดทั้งหมด",
			Callback = function()
		if game.PlaceId == 8304191830 then
			local redeem_code = {
				"ENTERTAINMENT",
				"HAPPYEASTER",
				"VIGILANTE",
				"GOLDEN",
				"SINS2",
				"SINS",
				"HERO",
				"UCHIHA",
				"CLOUD",
				"CHAINSAW",
				"NEWYEAR2023",
				"kingluffy",
				"toadboigaming",
				"noclypso",
				"fictionthefirst",
				"subtomaokuma",
				"subtokelvingts",
				"subtoblamspot",
			}
			for i, v in ipairs(redeem_code) do
				local args = {
					[1] = tostring(v),
				}
				game:GetService("ReplicatedStorage").endpoints.client_to_server.redeem_code:InvokeServer(unpack(args))
			end
		end
			end,
	})

	--///////////////////////////////////////////////////////////////////////////////////////////////////--
  
--#endregion


--#region setting SettingScript
		local Tab = Window:MakeTab({ Name = "⚙️ การตั้งค่าสคริป", Icon = "rbxassetid://6022668966", PremiumOnly = false, }) -- SETTING SCRIPT
		local Section = Tab:AddSection({ Name = "ซ่อน UI เมื่อเริ่มเกมส์" })
		--ซ่อน UI
		Tab:AddToggle({
			Name = "⚙️ ซ่อน UI เมื่อเริ่มเกมส์",
			Default = getgenv().autoHideUI,
			Callback = function(bool)
					getgenv().autoHideUI = bool
					updatejson()
			end,
		})

		local Section = Tab:AddSection({ Name = "ตั้งค่า" })

		--บันทึก/โหลด สคริปต์อัตโนมัติเมื่อเปิดใช้งาน
		Tab:AddToggle({
				Name = "⚙️ บันทึก/โหลด สคริปต์อัตโนมัติเมื่อเปิดใช้งาน",
				Default = getgenv().AutoLoadTP,
				Callback = function(bool)
						getgenv().AutoLoadTP = bool
						updatejson()
				end,
		})
		--รับเควสอัตโนมัติ
		Tab:AddToggle({
				Name = "⚙️ รับเควสอัตโนมัติ",
				Default = getgenv().questtoday,
				Callback = function(x)
						getgenv().questtoday = true
						updatejson()
						if game.PlaceId == 8304191830 then
							if getgenv().questtoday then
								game:GetService("ReplicatedStorage").endpoints.client_to_server.claim_daily_reward:InvokeServer() --รับเควสประจำวัน
								local questStory = game:GetService("Players").LocalPlayer.PlayerGui.QuestsUI.Main.Main.Main.Content.story.Scroll:GetChildren()
								local questEvent = game:GetService("Players").LocalPlayer.PlayerGui.QuestsUI.Main.Main.Main.Content.event.Scroll:GetChildren()
								local questDaily = game:GetService("Players").LocalPlayer.PlayerGui.QuestsUI.Main.Main.Main.Content.daily.Scroll:GetChildren()
								local questInfinity = game:GetService("Players").LocalPlayer.PlayerGui.QuestsUI.Main.Main.Main.Content.infinite.Scroll:GetChildren()
								for i , v in pairs(questStory) do
									if v.Name ~= "UIListLayout" and v.Name ~= "RefreshFrame" then
										pcall(function()
											local args = {
												[1] = tostring(v.Name)
											}
											game:GetService("ReplicatedStorage").endpoints.client_to_server.redeem_quest:InvokeServer(unpack(args))
										end)
									end
								end
								for i , v in pairs(questEvent) do
									if v.Name ~= "UIListLayout" and v.Name ~= "RefreshFrame" then
										pcall(function()
											local args = {
												[1] = tostring(v.Name)
											}
											game:GetService("ReplicatedStorage").endpoints.client_to_server.redeem_quest:InvokeServer(unpack(args))
										end)
									end
								end
								
								for i , v in pairs(questDaily) do
									if v.Name ~= "UIListLayout" and v.Name ~= "RefreshFrame" then
										pcall(function()
											local args = {
												[1] = tostring(v.Name)
											}
											game:GetService("ReplicatedStorage").endpoints.client_to_server.redeem_quest:InvokeServer(unpack(args))
										end)
									end
								end
								for i , v in pairs(questInfinity) do
									if v.Name ~= "UIListLayout" and v.Name ~= "RefreshFrame" then
										pcall(function()
											local args = {
												[1] = tostring(v.Name)
											}
											game:GetService("ReplicatedStorage").endpoints.client_to_server.redeem_quest:InvokeServer(unpack(args))
										end)
									end
								end
							end
						end
				end,
		})

		--ลบแมพ
		Tab:AddToggle({
			Name = "⚙️ ลบแมพ",
			Default = true,
			Callback = function(x)
				getgenv().deleteMap = x
				if game.PlaceId ~= 8304191830 then
					if deleteMap then
						local removeMap = game:GetService("Workspace")["_map"]:GetChildren()
						local removeTerrain = game:GetService("Workspace")["_terrain"].terrain:GetChildren()
						for i , v in pairs(removeMap) do
							if v.Name ~= "Union" 
							and v.Name ~= "houses_new"
							and v.Name ~= "namek mushroom model"
							and v.Name ~= "Snow Particles"
							and v.Name ~= "sand_gate"
							and v.Name ~= "icebergs"
							and v.Name ~= "Helicopter Pad"
							and v.Name ~= "castle top"
							and v.Name ~= "Village Path"
							and v.Name ~= "wooden stacks"
							and v.Name ~= "skeleton"
							and v.Name ~= "SpaceCenter"
							and v.Name ~= "boat and bus"
							and v.Name ~= "LanternsGround"
							and v.Name ~= "ThreeDTextObject"
							and v.Name ~= "misc nonocollide obstacles"
							and v.Name ~= "parking spots"
							and v.Name ~= "vegetation"
							and v.Name ~= "crashed spaceships"
							and v.Name ~= "bridge nocollide"
							and v.Name ~= "Support_Beam"
							then
								v:Destroy()
							end
						end
						for i , v in pairs(removeTerrain) do
								v:Destroy()
						end
					end
				end
			end,
		})

		--เปิดจอขาว(ลดCPU)
		Tab:AddToggle({
				Name = "⚙️ เปิดจอขาว(ลดCPU)",
				Default = getgenv().renderring,
				Callback = function(x)
					getgenv().renderring = x
					updatejson()
					if getgenv().renderring then
						game:GetService("RunService"):Set3dRenderingEnabled(false)
					else
						game:GetService("RunService"):Set3dRenderingEnabled(true)
					end
				end,
		})

		--ตั้งค่าล็อค FPS
		Tab:AddToggle({
				Name = "⚙️ ตั้งค่าล็อค FPS",
				Default = getgenv().lockfps,
				Callback = function(x)
						getgenv().lockfps = x
						updatejson()
				end,
		})

		local Section = Tab:AddSection({ Name = "ตั้งค่าเกม" })
		--รีสตาทเกม
		Tab:AddButton({
				Name = "🚨 รีสตาร์ทเกม",
				Callback = function()
						task.wait(2)
						game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
				end,
		})
		--ปุ่มรีเกมส์
		Tab:AddBind({
			Name = "ปุ่มรีเกมส์ [กด F5 เพื่อรีเกมส์]",
			Default = Enum.KeyCode.F5,
			Hold = false,
			Callback = function()
				OrionLib:MakeNotification({
					Name = "ระบบกำลังรีเกมส์!",
					Content = "ในอีก 5 4 3 2 1..",
					Image = "rbxassetid://6026568227",
					Time = 5,
				}) -- Notifi	
				task.wait(2)			
				game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
			end
		})

		--ลบไฟล์
		Tab:AddButton({
			Name = "🚨 Fix แก้บัค",
			Callback = function()
					pcall(function()
						delfile(getgenv().savefilename)
					end)
					OrionLib:MakeNotification({
						Name = "ระบบกำลังรีเกมส์!",
						Content = "แก้ไขบัคเรียบร้อยแล้ว..",
						Image = "rbxassetid://6026568227",
						Time = 5,
					}) -- Notifi	
					task.wait(2)			
					game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
			end,
		})
		-- ปุ่มกด จอขาว
		Tab:AddBind({
			Name = "ปุ่มเปิด-ปิด จอขาว [F1 White Screen]",
			Default = Enum.KeyCode.F1,
			Hold = false,
			Callback = function(x)
				game:GetService("RunService"):Set3dRenderingEnabled(getgenv().renderring)
				getgenv().renderring = not getgenv().renderring
				updatejson()
			end
		})
--#endregion

--#region setting Webhook
		local Tab = Window:MakeTab({ Name = "📌 webhook", Icon = "rbxassetid://6022668966", PremiumOnly = false }) -- WEBHOOK
		local Section = Tab:AddSection({ Name = "แจ้งผลการฟาร์ม" })
		Tab:AddTextbox({
				Name = "📌 ใส่ webhook แจ้งเตือนเพรช",
				Default = tostring(getgenv().weburl),
				TextDisappear = false,
				Callback = function(web_url)
						getgenv().weburl = web_url
						updatejson()
				end,
		})
		local Section = Tab:AddSection({ Name = "แจ้งผลเมื่อฟาร์มเสร็จ" })
		Tab:AddTextbox({
				Name = "📌 ใส่ webhook แจ้งเตือนเมื่อฟาร์มเสร็จ",
				Default = tostring(getgenv().weburlfinish),
				TextDisappear = false,
				Callback = function(web_url)
						getgenv().weburlfinish = web_url
						updatejson()
				end,
		})
		local Section = Tab:AddSection({ Name = "Discord" })
		Tab:AddTextbox({
				Name = "📌 ใส่ ID Discord",
				Default = tostring(getgenv().dctage),
				TextDisappear = false,
				Callback = function(t)
						getgenv().dctage = t
						updatejson()
				end,
		})
		Tab:AddButton({
					Name = "ทดสอบเว็บฮุก",
					Callback = function()
							webhook()
					end,
		})
		Tab:AddButton({
			Name = "ทดสอบเว็บฮุกจบงาน",
			Callback = function()
					webhook_finish()
			end,
		})
--#endregion

--#region setting TPFriend
		local Tab = Window:MakeTab({Name = "🏝️ ตามเพื่อน", Icon = "rbxassetid://6022668966",  PremiumOnly = false, }) -- FRIENDS
		local Section = Tab:AddSection({ Name = "เข้าวาร์ปเพื่อน" })
		-- เข้าวาร์ปเพื่อนเท่านั้น
		Tab:AddToggle({
					Name = "⚙️ เข้าวาร์ปเพื่อนเท่านั้น",
					Default = getgenv().warpfriend,
					Callback = function(x)
							getgenv().warpfriend = x
							updatejson()
					end,
		})
		local Section = Tab:AddSection({ Name = "เข้าแมพตามเพื่อน" })
		-- ใส่เลขห้อง
		Tab:AddTextbox({
					Name = "📌 ใส่เลขห้อง",
					Default = tostring(getgenv().jobID),
					TextDisappear = false,
					Callback = function(t)
							getgenv().jobID = t
							updatejson()
					end,
		})
		--เข้าแมพ
		Tab:AddButton({
				Name = "เข้าแมพ",
				Callback = function()
						if getgenv().jobID ~= nil then
								OrionLib:MakeNotification({
									Name = "TELEPORT SUCCESS!",
									Content = "ระบบกำลังวาร์ป..",
									Image = "rbxassetid://6026568227",
									Time = 5,
								})
								game:GetService("TeleportService"):TeleportToPlaceInstance(8304191830, getgenv().jobID,  game.Players.LocalPlayer)
						else
								OrionLib:MakeNotification({
									Name = "ERROR!",
									Content = "วาร์ปไม่สำเร็จ..",
									Image = "rbxassetid://2795966663",
									Time = 5,
								})
						end
				end,
		})
		local Section = Tab:AddSection({ Name = "เลขห้อง" })
		--ก็อปเลขห้อง
		Tab:AddButton({
					Name = "ก็อปเลขห้อง",
					Callback = function()
							OrionLib:MakeNotification({
								Name = "COPY SUCCESS!",
								Content = "ก็อปปี้สำเร็จแล้ว..",
								Image = "rbxassetid://6026568227",
								Time = 5,
							})
							setclipboard(game.JobId)
					end,
		})
--#endregion

--#region SELL BUY
		local Tab = Window:MakeTab({Name = "💵 ซื้อ / ขาย ตัวละคร",Icon = "rbxassetid://6022668966",PremiumOnly = false,}) -- SELL BUY
		getgenv().UnitSellTog = false
		getgenv().autosummontickets = false
		getgenv().autosummongem = false
		getgenv().autosummongem10 = false
		getgenv().autosummonticketse = false
		getgenv().autosummongeme = false
		getgenv().autosummongem10e = false
		local function autobuyfunc(xx, item)
			task.wait()
			local args = {
				[1] = xx,
				[2] = item,
			}
			game:GetService("ReplicatedStorage").endpoints.client_to_server.buy_from_banner:InvokeServer(unpack(args))
		end
		local Section = Tab:AddSection({ Name = "Special - 2x Mythic" })
		Tab:AddToggle({
				Name = "💵 ซื้อตัวอัตโนมัติ [ใช้ Ticket 1]",
				Default = getgenv().autosummonticketse,
				Callback = function(bool)
						getgenv().autosummonticketse = bool
						if game.PlaceId == 8304191830 then
							while getgenv().autosummonticketse do
								autobuyfunc("EventClover", "ticket")
							end
						end
						updatejson()
				end,
		})
		Tab:AddToggle({
				Name = "💴 ซื้อตัวอัตโนมัติ [ทีละ 1ตัว]",
				Default = getgenv().autosummongeme,
				Callback = function(bool)
						getgenv().autosummongeme = bool
						if game.PlaceId == 8304191830 then
							while getgenv().autosummongeme do
								autobuyfunc("EventClover", "gems")
							end
						end
						updatejson()
				end,
		})
		Tab:AddToggle({
				Name = "💶 ซื้อตัวอัตโนมัติ [ทีละ 10 ตัว]",
				Default = getgenv().autosummongem10e,
				Callback = function(bool)
						getgenv().autosummongem10 = bool
						if game.PlaceId == 8304191830 then
							while getgenv().autosummongem10 do
									autobuyfunc("EventClover", "gems10")
							end
						end
						updatejson()
				end,
		})
		local Section = Tab:AddSection({ Name = "ซื้อ Standard" })
		Tab:AddToggle({
				Name = "💷 ซื้อตัวอัตโนมัติ [ใช้ Ticket 1]",
				Default = getgenv().autosummontickets,
				Callback = function(bool)
						getgenv().autosummontickets = bool
						if game.PlaceId == 8304191830 then
							while getgenv().autosummontickets do
								autobuyfunc("Standard", "ticket")
							end
						end
						updatejson()
				end,
		})
		Tab:AddToggle({
				Name = "💶 ซื้อตัวอัตโนมัติ [ทีละ 1ตัว]",
				Default = getgenv().autosummongem,
				Callback = function(bool)
						getgenv().autosummongem = bool
						if game.PlaceId == 8304191830 then
							while getgenv().autosummongem do
								autobuyfunc("Standard", "gems")
							end
						end
						updatejson()
				end,
		})
		Tab:AddToggle({
				Name = "💵 ซื้อตัวอัตโนมัติ [ทีละ 10 ตัว]",
				Default = getgenv().autosummongem10,
				Callback = function(bool)
						getgenv().autosummongem10 = bool
						if game.PlaceId == 8304191830 then
							while getgenv().autosummongem10 do
								autobuyfunc("Standard", "gems10")
							end
						end
						updatejson()
				end,
		})
		local Section = Tab:AddSection({Name = "ตั้งค่าการขายตัวละครอัตโนมัติ", })
		Tab:AddToggle({
				Name = "🗿 เริ่มการขายตัวละคร [Rare,Epic]",
				Default = getgenv().UnitSellTog,
				Callback = function(bool)
						getgenv().UnitSellTog = bool
				end,
		})
		local Section = Tab:AddSection({Name = "คีย์ลัด กการซื้อ-ขาย อัตโนมัติ", })
		Tab:AddBind({
			Name = "Buy Mythic x2 [F7 Auto Buy]",
			Default = Enum.KeyCode.F7,
			Hold = false,
			Callback = function()
				if getgenv().autosummongem10 then
					getgenv().autosummongem10 = false
					OrionLib:MakeNotification({
						Name = "ปิดการซื้อออโต้แล้ว!",
						Content = "Auto Buy Close..",
						Image = "rbxassetid://6026568227",
						Time = 5,
					}) -- Notifi
				else
					getgenv().autosummongem10 = true
					OrionLib:MakeNotification({
						Name = "กำลังทำการซื้อออโต้!",
						Content = "Auto Buy Loaded..",
						Image = "rbxassetid://6026568227",
						Time = 5,
					}) -- Notifi
					if game.PlaceId == 8304191830 then
						while getgenv().autosummongem10 do
								autobuyfunc("EventClover", "gems10")
						end
					end
				end
			end
		})
		Tab:AddBind({
			Name = "Sell Rare-Epic [F8 Auto Sell]",
			Default = Enum.KeyCode.F8,
			Hold = false,
			Callback = function()
				if getgenv().UnitSellTog then
					getgenv().UnitSellTog = false
				else
					getgenv().UnitSellTog = true
				end
			end
		})
--#endregion

--###### END UI ######--
end

--###### Function ######--
--------------------------------------------------
--#region Check File JSon WorkSpace

if isfile(savefilename) then
	pcall(function()
		local jsonData = readfile(savefilename)
		local data = HttpService:JSONDecode(jsonData)
	end)
	PjxInit()
else
	local xdata = {

		-- Save Script
		AutoLoadTP = true,
		-- Warp Friends
		warpfriend = false,
		-- Auto Start
		autostart = false,
		AutoReplay = false,
		-- Select Mode
		autoSelectMode = "เลือกโหมดที่ต้องการฟาร์ม",
		textGem = 0,
		resultGems = 0,
		-- BattlePass
		BattlePass = 0,
		-- Select Item Raid
		autoSelectItem = "เลือกไอเท็มเรท",
		-- Map
		world = "nil",
		level = "nil",
		difficulty = "nil",
		levels = {},
		door = "nil",
		-- Lock FPS
		lockfps = false,
		renderring = false,
		autoHideUI = false,
		-- Other
		questtoday = true,

		-- Webhook
		webhook = "",
		weburlfinish = "",
		webportal = "",
		dctage = "",

		-- Job ID
		jobID = "",

		--Select Unit
		xselectedUnits = {},

	}
	local json = HttpService:JSONEncode(xdata)
	writefile(savefilename, json)
	PjxInit()
end

--#endregion
--------------------------------------------------

-- [[ ฟั่งชั่น วางมอน เลือกมอน อัพเกรด ]] --

--#region Plate Unit

function auto_place_units(position)
	math.randomseed(os.time())
	for i = 1, 6 do
			local unit_data = getgenv().SelectedUnits[i]
			if unit_data ~= nil then
				local unit_id = unit_data:split(" #")[2]
				local unit_name = unit_data:split(" #")[1]
				if unit_name ~= "metal_knight_evolved" then
					-- place ground unit
					unitPostion = math.random(2,3)
					randomSpaw = math.random(-5,5)
					local args = {
						[1] = unit_id,
						[2] = CFrame.new(position[1].x + randomSpaw, position[1].y, position[1].z + randomSpaw) * CFrame.Angles(0, -0, -0)
					}
					game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
					game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
					-- place hill unit
					local args = {
						[1] = unit_id,
						[2] = CFrame.new(position[unitPostion].x + randomSpaw, position[unitPostion].y, position[unitPostion].z + randomSpaw) * CFrame.Angles(0, -0, -0)
					}
					game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
					game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

				elseif unit_name == "metal_knight_evolved" then
					-- place hill unit
					unitPostion = math.random(2,3)
					randomSpaw = math.random(-5,5)
					task.spawn(function()
						local args = {
							[1] = unit_id,
							[2] = CFrame.new(position[unitPostion].x + randomSpaw, position[unitPostion].y, position[unitPostion].z + randomSpaw) * CFrame.Angles(0, -0, -0)
						}
						game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
					end)
				end
			end
	end
end
coroutine.resume(coroutine.create(function()
	while task.wait(1) do
		local _wave = game:GetService("Workspace"):WaitForChild("_wave_num")
		if game.PlaceId ~= 8304191830 then
			for i, v in ipairs(game.Workspace["_UNITS"]:GetChildren()) do
				if v:FindFirstChild("_stats") then
					if v._stats.player.Value == nil then
						pos_x = v.HumanoidRootPart.Position.X
						pos_z = v.HumanoidRootPart.Position.Z
						break
					end
				end
			end
			if game.Workspace._map:FindFirstChild("namek mushroom model") then -- Plannet Namak
				auto_place_units({
					[1] = { x = pos_x, y = 91.80, z = pos_z }, -- ground unit position
					[2] = { x = -2959.61, y = 94.53, z = -696.83 }, -- hill unit position
					[3] = { x = -2952.06, y = 94.41, z = -721.40 }, -- hill unit position
				})
				elseif game.Workspace._map:FindFirstChild("bridge nocollide") then  -- MY HERO
				auto_place_units({
					[1] = { x = pos_x, y = -13.24, z = pos_z }, -- ground unit position
					[2] = { x = -31.49, y = -10.02, z = 21.95 }, -- hill unit position
					[3] = { x = -54.03, y = -8.89, z = 3.62 }, -- hill unit position
				})
				elseif game.Workspace._map:FindFirstChild("houses_new") then -- Shiganshinu District
				auto_place_units({
					[1] = { x = pos_x, y = 33.74, z = pos_z }, -- ground unit position
					[2] = { x = -3026.78, y = 38.41, z = -677.81 }, -- hill unit position
					[3] = { x = -3019.03, y = 38.41, z = -689.49 }, -- hill unit position
				})
				elseif game.Workspace._map:FindFirstChild("Snow Particles") then -- Snowy Town
				auto_place_units({
					[1] = { x = pos_x, y = 34.34, z = pos_z }, -- ground unit position
					[2] = { x = -2876.02, y = 37.24, z = -150.81 }, -- hill unit position
					[3] = { x = -2879.09, y = 39.57, z = -124.25 }, -- hill unit position
				})
				elseif game.Workspace._map:FindFirstChild("sand_gate") then -- Hidden Sand Village
				auto_place_units({
					[1] = { x = pos_x, y = 25.28, z = pos_z }, -- ground unit position
					[2] = { x = -910.64, y = 33.14, z = 294.41 }, -- hill unit position
					[3] = { x = -893.90, y = 29.56, z = 318.74 }, -- hill unit position
				})
				elseif game.Workspace._map:FindFirstChild("icebergs") then -- Marine's Ford
				auto_place_units({
					[1] = { x = pos_x, y = 25.21, z = pos_z }, -- ground unit position
					[2] = { x = -2571.46, y = 29.50, z = -49.31 }, -- hill unit position
					[3] = { x = -2581.62, y = 28.35, z = -66.97 }, -- hill unit position
				})
				elseif game.Workspace._map:FindFirstChild("Helicopter Pad") then -- Ghoul City
				auto_place_units({
					[1] = { x = pos_x, y = 58.58, z = pos_z }, -- ground unit position
					[2] = { x = -2985.60, y = 66.70, z = -54.09 }, -- hill unit position
					[3] = { x = -2956.22, y = 62.82, z = -49.40 }, -- hill unit position
				})
				elseif game.Workspace._map:FindFirstChild("castle top") then -- Hollow World
				auto_place_units({
					[1] = { x = pos_x, y = 132.66, z = pos_z }, -- ground unit position
					[2] = { x = -184.33, y = 136.34, z = -757.71 }, -- hill unit position
					[3] = { x = -174.58, y = 136.34, z = -710.48 }, -- hill unit position
				})
				elseif game.Workspace._map:FindFirstChild("Village Path") then -- Ant Kingdom
				auto_place_units({
					[1] = { x = pos_x, y = 23.01, z = pos_z }, -- ground unit position
					[2] = { x = -145.86, y = 26.72, z = 2965.56 }, -- hill unit position
					[3] = { x = -191.47, y = 27.20, z = 2952.01 }, -- hill unit position
				})
				elseif game.Workspace._map:FindFirstChild("wooden stacks") then -- Magic Town
				auto_place_units({
					[1] = { x = pos_x, y = 6.74, z = pos_z }, -- ground unit position
					[2] = { x = -596.36, y = 13.99, z = -824.33 }, -- hill unit position
					[3] = { x = -586.75, y = 13.88, z = -824.23 }, -- hill unit position
				})
				elseif game.Workspace._map:FindFirstChild("skeleton") then -- Cursed Academy
				auto_place_units({
					[1] = { x = pos_x, y = 1.23, z = pos_z }, -- ground unit position
					[2] = { x = -167.89, y = 5.03, z = -41.00 }, -- hill unit position
					[3] = { x = -124.5, y = 4.86, z = -44.06 }, -- hill unit position
				})
				elseif game.Workspace._map:FindFirstChild("SpaceCenter") then -- Clover Kingdom
				auto_place_units({
					[1] = { x = pos_x, y = 15.25, z = pos_z }, -- ground unit position
					[2] = { x = -107.81, y = 19.62, z = -526.78 }, -- hill unit position
					[3] = { x = -111.71, y = 19.62, z = -502.85 }, -- hill unit position
				})
				elseif game.Workspace._map:FindFirstChild("boat and bus") then  -- Devil Portal
				auto_place_units({
					[1] = { x = pos_x, y = 1, z = pos_z }, -- ground unit position
					[2] = { x = -361.46, y = 3.91, z = -544.41 }, -- hill unit position
					[3] = { x = -385.43, y = 5.86, z = -559.16 }, -- hill unit position
				})
				elseif game.Workspace._map:FindFirstChild("LanternsGround") then 
				auto_place_units({
					[1] = { x = pos_x, y = 122.06, z = pos_z }, -- ground unit position
					[2] = { x = 394.85, y = 124.44, z = -74.23 }, -- hill unit position
					[3] = { x = 365.35, y = 125.39, z = -95.78 }, -- hill unit position
				})
				elseif game.Workspace:FindFirstChild("opm_1") then -- Alien Spaceship
				auto_place_units({
					[1] = { x = pos_x, y = 361.21, z = pos_z }, -- ground unit position
					[2] = { x = -336.19, y = 365.26, z = 1389.11 }, -- hill unit position
					[3] = { x = -336.18, y = 365.26, z = 1391.78 }, -- hill unit position
				})
				elseif game.Workspace._map:FindFirstChild("ThreeDTextObject") then -- RAID UCHIHA
				auto_place_units({
					[1] = { x = pos_x, y = 536.89, z = pos_z }, -- ground unit position
					[2] = { x = 304.59, y = 539.89, z = -588.45 }, -- hill unit position
					[3] = { x = 267.66, y = 539.89, z = -560.54 }, -- hill unit position
				})
				elseif game.Workspace._map:FindFirstChild("misc nonocollide obstacles") then -- 7DPS
				auto_place_units({
					[1] = { x = pos_x, y = 212.96, z = pos_z }, -- ground unit position
					[2] = { x = -87.39, y = 216.99, z = -214.06 }, -- hill unit position
					[3] = { x = -102.37, y = 219.20, z = -204.66 }, -- hill unit position
				})
				elseif game.Workspace._map:FindFirstChild("parking spots") then
				auto_place_units({
					[1] = { x = pos_x, y = 36.04, z = pos_z }, -- ground unit position
					[2] = { x = -188.33, y = 46.76, z = 552.44 }, -- hill unit position
					[3] = { x = -179.47, y = 46.63, z = 552.69 }, -- hill unit position
				})
				elseif game.Workspace._map:FindFirstChild("vegetation") then  -- RAID WESTCITY
				auto_place_units({
					[1] = { x = pos_x, y = 19.76, z = pos_z }, -- ground unit position
					[2] = { x = -2334.15, y = 31.41, z = -79.33 }, -- hill unit position
					[3] = { x = -2339.57, y = 32.03, z = -90.32 }, -- hill unit position
				})
				elseif game.Workspace._map:FindFirstChild("crashed spaceships") then  -- RAID Freeze
				auto_place_units({
					[1] = { x = pos_x, y = 19.76, z = pos_z }, -- ground unit position
					[2] = { x = -2334.15, y = 31.41, z = -79.33 }, -- hill unit position
					[3] = { x = -2339.57, y = 32.03, z = -90.32 }, -- hill unit position
				})
				elseif game.Workspace._map:FindFirstChild("Support_Beam") then  -- RAID Gyegoro
				auto_place_units({
					[1] = { x = pos_x, y = 495.600, z = pos_z }, -- ground unit position 
					[2] = { x = -130.05, y = 504.78, z = -93.73 }, -- hill unit position -130.05752563476562, 504.7899169921875, -93.732666015625
					[3] = { x = -97.27, y = -97.27, z = -92.03 }, -- hill unit position -97.27552032470703, 500.6242980957031, -92.03937530517578
				})
			end
		end
	end
end))

--#endregion 

--#region Auto Upgrade
coroutine.resume(coroutine.create(function()
	while task.wait(0) do
		local _wave = game:GetService("Workspace"):WaitForChild("_wave_num")
		if _wave.Value >= 6 then
			pcall(function() --///
				repeat task.wait() until game:GetService("Workspace"):WaitForChild("_UNITS")
				for i, v in ipairs(game:GetService("Workspace")["_UNITS"]:GetChildren()) do
					if v:FindFirstChild("_stats") then
						if tostring(v["_stats"].player.Value) == game.Players.LocalPlayer.Name and v["_stats"].xp.Value >= 0 then
							if v.Name == "wendy" or v.Name == "wendy:shiny" or v.Name == "sakura" then
								-- print(v.Name)
							else
								game:GetService("ReplicatedStorage").endpoints.client_to_server.upgrade_unit_ingame:InvokeServer(v)
							end
						end
					end
				end
			end)
		end
	end
end))

--#endregion 

--#region Auto Abilities
getgenv().autoabilityerr = false
function autoabilityfunc()
	pcall(function() --///
		repeat task.wait() until game:GetService("Workspace"):WaitForChild("_UNITS")
		for i, v in ipairs(game:GetService("Workspace")["_UNITS"]:GetChildren()) do
			if v:FindFirstChild("_stats") then
				if v._stats:FindFirstChild("player") and v._stats:FindFirstChild("xp") then
					if v.Name == "ichigo_mugetsu_evolved" or v.Name == "ichigo_mugetsu" then
						print('ichigo')
					elseif v.Name == "gojo_evolved" or v.Name == "kisuke_evolved" then
						game:GetService("ReplicatedStorage").endpoints.client_to_server.use_active_attack:InvokeServer(v)
					elseif v.Name == "wendy" or v.Name == "erwin" then
						game:GetService("ReplicatedStorage").endpoints.client_to_server.use_active_attack:InvokeServer(v)
						task.wait(11)
					end
				end
			end
		end
	end)
end
coroutine.resume(coroutine.create(function()
	while task.wait(2) do
		if game.PlaceId ~= 8304191830 then
			pcall(function()
				autoabilityfunc()
			end)
		end
	end
end))
--#endregion

--#region SelectUnit

coroutine.resume(coroutine.create(function()
  if game.PlaceId == 8304191830 then
    handle_select_units()
    local collection = plr.PlayerGui:WaitForChild("collection")
    collection:GetPropertyChangedSignal("Enabled"):Connect(function()
      if collection.Enabled == false then
        handle_select_units()
      end
    end)
  end
end))
--#endregion

-- [[ จบฟั่งชั่นอัพเกรด + วางมอน ]] --
--------------------------------------------------


-- [[ ฟังชั่นสำหรับวาปเข้าแมพ ]] --

--#region FarmGem

function farmGem()
	if game.PlaceId == 8304191830 then
		local cpos = plr.Character.HumanoidRootPart.CFrame
		if tostring(Workspace._LOBBIES.Story[getgenv().door].Owner.Value) ~= plr.Name then
			for _, v in pairs(game:GetService("Workspace")["_LOBBIES"].Story:GetDescendants()) do
				if v.Name == "Owner" and v.Value == nil then
					local args = {
						[1] = tostring(v.Parent.Name),
					}
					game:GetService("ReplicatedStorage").endpoints.client_to_server.request_join_lobby:InvokeServer(unpack(args))
					task.wait(4)
					local args = {
						[1] = tostring(v.Parent.Name), -- Lobby
						[2] = "namek_infinite", -- World
						[3] = false, -- Friends Only or not
						[4] = "Hard",
					}
					game:GetService("ReplicatedStorage").endpoints.client_to_server.request_lock_level:InvokeServer(unpack(args))
					task.wait(2)
					local args = {
						[1] = tostring(v.Parent.Name),
					}
					game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_game:InvokeServer(unpack(args))
					game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_game:InvokeServer(unpack(args))
					getgenv().door = v.Parent.Name
					plr.Character.HumanoidRootPart.CFrame = v.Parent.Door.CFrame
					break
				end
			end
		end
		task.wait()
		plr.Character.HumanoidRootPart.CFrame = cpos
	end
end

--#endregion

--#region Farm Pass

function farmPass()
	if game.PlaceId == 8304191830 then
		local cpos = plr.Character.HumanoidRootPart.CFrame
		if tostring(Workspace._LOBBIES.Story[getgenv().door].Owner.Value) ~= plr.Name then
			for _, v in pairs(game:GetService("Workspace")["_LOBBIES"].Story:GetDescendants()) do
				if v.Name == "Owner" and v.Value == nil then
					local args = {
						[1] = tostring(v.Parent.Name),
					}
					game:GetService("ReplicatedStorage").endpoints.client_to_server.request_join_lobby:InvokeServer(unpack(args))
					task.wait(4)
					local args = {
						[1] = tostring(v.Parent.Name), -- Lobby
						[2] = "aot_infinite", -- World
						[3] = false, -- Friends Only or not
						[4] = "Hard",
					}
					game:GetService("ReplicatedStorage").endpoints.client_to_server.request_lock_level:InvokeServer(unpack(args))
					task.wait(2)
					local args = {
						[1] = tostring(v.Parent.Name),
					}
					game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_game:InvokeServer(unpack(args))
					game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_game:InvokeServer(unpack(args))
					getgenv().door = v.Parent.Name
					plr.Character.HumanoidRootPart.CFrame = v.Parent.Door.CFrame
					break
				end
			end
		end
		task.wait()
		plr.Character.HumanoidRootPart.CFrame = cpos
	end
end

--#endregion

--#region FarmLevel

function farmLevel()
	if game.PlaceId == 8304191830 then
		local cpos = plr.Character.HumanoidRootPart.CFrame
		if tostring(Workspace._LOBBIES.Story[getgenv().door].Owner.Value) ~= plr.Name then
			for _, v in pairs(game:GetService("Workspace")["_LOBBIES"].Story:GetDescendants()) do
				if v.Name == "Owner" and v.Value == nil then
					local args = {
						[1] = tostring(v.Parent.Name),
					}
					game:GetService("ReplicatedStorage").endpoints.client_to_server.request_join_lobby:InvokeServer(unpack(args))
					task.wait(4)
					if getgenv().autoSelectMode == "ฟาร์มเพชร" then
						local args = {
							[1] = tostring(v.Parent.Name), -- Lobby
							[2] = "namek_level_1", -- World
							[3] = false, -- Friends Only or not
							[4] = "Normal",
						}
						game:GetService("ReplicatedStorage").endpoints.client_to_server.request_lock_level:InvokeServer(unpack(args))
					end
					task.wait(2)
					local args = {
						[1] = tostring(v.Parent.Name),
					}
					game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_game:InvokeServer(unpack(args))
					game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_game:InvokeServer(unpack(args))
					getgenv().door = v.Parent.Name
					plr.Character.HumanoidRootPart.CFrame = v.Parent.Door.CFrame
					break
				end
			end
		end
		task.wait()
		plr.Character.HumanoidRootPart.CFrame = cpos
	end
end

--#endregion

--#region Farm Clstel

function farmCaltans()

	if getgenv().autoSelectMode == "ฟาร์มหอคอย" then
		if game.PlaceId == 8304191830 then
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new( 12423.1855, 155.24025, 3198.07593, -1.34111269e-06, -2.02512282e-08, 1, 3.91705386e-13, 1, 2.02512282e-08, -1, 4.18864542e-13, -1.34111269e-06 )
			getgenv().infinityroom = 0
			for i, v in pairs( game:GetService("Players")[game.Players.LocalPlayer.Name].PlayerGui.InfiniteTowerUI.LevelSelect.InfoFrame.LevelButtons :GetChildren() ) do
				if v.Name == "FloorButton" then
					if v.clear.Visible == false and v.Locked.Visible == false then
						local room = string.split(v.Main.text.Text, " ")
						local args = {
							[1] = tonumber(room[2]),
						}
						game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_infinite_tower :InvokeServer(unpack(args))
						getgenv().infinityroom = tonumber(room[2])
						break
					end
				end
			end
			task.wait(6)
		end
	elseif getgenv().autoSelectMode == "ฟาร์มหอคอย" then
		if game.PlaceId == 8304191830 then
			local args = {
				[1] = "_lobbytemplate_event330",
			}
			game:GetService("ReplicatedStorage").endpoints.client_to_server.request_join_lobby :InvokeServer(unpack(args))
			task.wait(5)
		end
	end

end

--#endregion

--#region story and Chicken

tp_check = true
function storyFarm()
	if getgenv().autoSelectMode == "ฟาร์มสตอรี่" or getgenv().autoSelectMode == "ฟาร์มไก่เพชร"  then
		if game.PlaceId == 8304191830 then
			task.wait(5)
			local cpos = plr.Character.HumanoidRootPart.CFrame
			if tp_check then
				for _, v in pairs(game:GetService("Workspace")["_LOBBIES"].Story:GetChildren()) do
					check_door = tostring(game:GetService("Workspace")["_LOBBIES"].Story[v.Name].Owner.Value)
					if check_door == "nil"  then
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace")["_LOBBIES"].Story[v.Name].Door.CFrame * CFrame.new(0, 0, 1)
						wait(1)
						--// Check ShickenFram
						local checkNaamek = game:GetService("Players").LocalPlayer.PlayerGui.LevelSelectGui.MapSelect.Main.Wrapper.Container.namek.Main.Container.LevelsCleared.V.Text
						if checkNaamek == "6/6" and getgenv().autoSelectMode == "ฟาร์มไก่เพชร" then
							getgenv().autoSelectMode = "ฟาร์มเพชร"
							updatejson()
							wait(2)
							game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
						end
						--//---------------------
						broke = false
						for g, j in ipairs(game:GetService("Players").LocalPlayer.PlayerGui.LevelSelectGui.MapSelect.Main.Wrapper.Container :GetChildren()) do
							if j:IsA("ImageButton") then
								if j.Name == "ComingSoon" then
								else
									local ClearStory = j.Main.Container.LevelsCleared:GetChildren()
									for l, s in pairs(ClearStory) do
										if s.Name == "V" then
											chLevel = s.Text
											waves = chLevel:split("/")
											if waves[1] == "6" then
												wait(1)
											else
												
												st_farm = j.Name .. "_level_" .. waves[1] + 1
												broke = true
												wait(1)
												local args = {
													[1] = tostring(v.Name), -- Lobby
													[2] = tostring(st_farm), -- World
													[3] = false, -- Friends Only or not
													[4] = "Normal",
												}
												game:GetService("ReplicatedStorage").endpoints.client_to_server.request_lock_level:InvokeServer(unpack(args))
												task.wait(5)
												local args = {
													[1] = tostring(v.Name),
												}
												game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_game:InvokeServer(unpack(args))
												break
											end
										end
									end
								end
							end
							if broke then
								break
							end
						end
						tp_check = false
						break
					end
				end
			end
			wait(2)
		end
	end
end

--#endregion

--#region FarmGem in MapSelect

function farmGMAP()
	if game.PlaceId == 8304191830 then
		local cpos = plr.Character.HumanoidRootPart.CFrame
		if tostring(Workspace._LOBBIES.Story[getgenv().door].Owner.Value) ~= plr.Name then
			for _, v in pairs(game:GetService("Workspace")["_LOBBIES"].Story:GetDescendants()) do
				if v.Name == "Owner" and v.Value == nil then
					local args = {
						[1] = tostring(v.Parent.Name),
					}
					game:GetService("ReplicatedStorage").endpoints.client_to_server.request_join_lobby:InvokeServer(unpack(args))
					task.wait(4)
					local args = {
						[1] = tostring(v.Parent.Name), -- Lobby
						[2] = getgenv().level, -- World
						[3] = false, -- Friends Only or not
						[4] = getgenv().difficulty,
					}
					game:GetService("ReplicatedStorage").endpoints.client_to_server.request_lock_level:InvokeServer(unpack(args))
					task.wait(2)
					local args = {
						[1] = tostring(v.Parent.Name),
					}
					game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_game:InvokeServer(unpack(args))
					game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_game:InvokeServer(unpack(args))
					getgenv().door = v.Parent.Name
					plr.Character.HumanoidRootPart.CFrame = v.Parent.Door.CFrame
					break
				end
			end
		end
		task.wait()
		plr.Character.HumanoidRootPart.CFrame = cpos
	end
end

--#endregion

------ [[ เลือกโหมดที่ต้องการฟาร์ม ]] ------

--#region Functions SelectMode
function modefarm()
	if getgenv().autoSelectMode == "ฟาร์มเพชร" then
		farmGem()
		task.wait(30)
	end

	if getgenv().autoSelectMode == "ฟาร์ม BattlePass" then
		farmPass()
		task.wait(30)
	end

	if getgenv().autoSelectMode == "ฟาร์มเวลตัวละคร" then
		farmLevel()
		task.wait(30)
	end

	if getgenv().autoSelectMode == "ฟาร์มหอคอย" then
		farmCaltans()
		task.wait(30)
	end

	if getgenv().autoSelectMode == "ฟาร์มสตอรี่" or getgenv().autoSelectMode == "ฟาร์มไก่เพชร" then
		storyFarm()
		task.wait(30)
	end

	if getgenv().autoSelectMode == "ฟาร์มเพชรเลือกด่าน" then
		farmGMAP()
		task.wait(30)
	end

end
--#endregion

--#region Auto Starts

coroutine.resume(coroutine.create(function()
	while wait(3) do
		if getgenv().autostart then
			modefarm()
		end
	end
end))

--#endregion

-- [[ จบฟังชั่นเข้าแมพ ]] --
--------------------------------------------------


-- [[ ฟังชั่นเมื่อจบเกมส์ ]] --

--#region Check TP Wave Battlepass

coroutine.resume(coroutine.create(function()
	while task.wait() do
		if game.PlaceId ~= 8304191830 then
			local _wave = game:GetService("Workspace"):WaitForChild("_wave_num")
			if getgenv().autoSelectMode == "ฟาร์ม BattlePass" and tonumber(_wave.Value) >= tonumber(40)		then
				task.wait(2)
				if tonumber(getgenv().BattlePass) >= tonumber(getgenv().textGem)  then
					pcall(function () webhook_finish()  end)
				else
					pcall(function () webhook()  end)
				end
				task.wait(2)
				game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
			end
		end
	end
end))

--#endregion

--#region Check Farm Gem
function amReplay()
	while task.wait() do
		if game.PlaceId ~= 8304191830 then
			if getgenv().AutoReplay then
				-- sell unit
				repeat task.wait() until game:GetService("Workspace"):WaitForChild("_UNITS")
				for i, v in ipairs(game:GetService("Workspace")["_UNITS"]:GetChildren()) do
					repeat task.wait() until v:WaitForChild("_stats")
					if tostring(v["_stats"].player.Value) == game.Players.LocalPlayer.Name then
						repeat task.wait() until v:WaitForChild("_stats"):WaitForChild("upgrade")
						game:GetService("ReplicatedStorage").endpoints.client_to_server.sell_unit_ingame:InvokeServer(v)
					end
				end
				--
			end
		end
	end
end

coroutine.resume(coroutine.create(function()
	while task.wait() do
		if game.PlaceId ~= 8304191830 then
			--#region Teleport Gem
			local _wave = game:GetService("Workspace"):WaitForChild("_wave_num")
			if getgenv().autoSelectMode == "ฟาร์มเพชร" and  _wave.Value >= 25 then
				if tonumber(getgenv().textGem) <= 1 then
					pcall(function () webhook_finish()  end)
					task.wait(3)
					break
				else
					if getgenv().AutoReplay then
						amReplay()
						break
					end
				end
			end
			--#endregion
		end
	end
end))

--#endregion

--#region Check Gamefinish
function gameisFinishAuto()
	task.wait(4)
	local resultx = tostring(LocalPlayer.PlayerGui.ResultsUI.Holder.Title.Text)
	
	-- // Replay Everthing // --
	if getgenv().AutoReplay and  getgenv().autoSelectMode == "เลือกโหมดที่ต้องการฟาร์ม"  then
		task.wait()
		pcall(function() webhook() end)
		local a = { [1] = "replay" }
		game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(a))
		game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(a))
		task.wait(300)
		game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
		task.wait(100)
		game:Shutdown()
	end

	-- // Raid // --
	if getgenv().autoSelectMode == "ฟาร์มไอเท็มเรด" then
		task.wait(3)

		if resultx == "VICTORY" then
			print('Victory')
		else
			if getgenv().AutoReplay then
				local a = { [1] = "replay" }
				game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(a))
				game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(a))
				task.wait(300)
				game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
				task.wait(100)
				game:Shutdown()
			else
				game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
				task.wait(300)
				game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
				task.wait(100)
				game:Shutdown()
			end
		end

		local itemDifference = getItemChangesNormal(getgenv().startingInventoryNormalItems, getNormalItems())
		for name, amount in pairs(itemDifference) do
			if getgenv().autoSelectMode == "ฟาร์มไอเท็มเรด" and getgenv().autoSelectItem == "Alien Scouter" and name == "west_city_frieza_item" then
				getgenv().textGem = tonumber(getgenv().textGem) - amount
				if tonumber(getgenv().textGem) <= 1 then
					pcall(function () webhook_finish() end)
					updatejson()
					wait(99)
				else
					pcall(function() webhook() end)
				end
				updatejson()
				task.wait(1)
				break
			elseif getgenv().autoSelectMode == "ฟาร์มไอเท็มเรด" and getgenv().autoSelectItem == "Tomoe" and name == "uchiha_item" then
				getgenv().textGem = tonumber(getgenv().textGem) - amount
				if tonumber(getgenv().textGem) <= 1 then
					pcall(function () webhook_finish() end)
					updatejson()
					wait(99)
				else
					pcall(function() webhook() end)
				end
				updatejson()
				task.wait(1)
				break
			elseif getgenv().autoSelectMode == "ฟาร์มไอเท็มเรด" and getgenv().autoSelectItem == "Entertain Shard" and name == "entertainment_district_item" then
				getgenv().textGem = tonumber(getgenv().textGem) - amount
				if tonumber(getgenv().textGem) <= 1 then
					pcall(function () webhook_finish() end)
					updatejson()
					wait(99)
				else
					pcall(function() webhook() end)
				end
				updatejson()
				task.wait(1)
				break
			elseif getgenv().autoSelectMode == "ฟาร์มไอเท็มเรด" and getgenv().autoSelectItem == "Demon Shard" and name == "april_symbol" then
				getgenv().textGem = tonumber(getgenv().textGem) - amount
				if tonumber(getgenv().textGem) <= 1 then
					pcall(function () webhook_finish() end)
					updatejson()
					wait(99)
				else
					pcall(function() webhook() end)
				end
				updatejson()
				task.wait(1)
				break
			elseif getgenv().autoSelectMode == "ฟาร์มไอเท็มเรด" and getgenv().autoSelectItem == "Relic Shard" and name == "relic_shard" then
				getgenv().textGem = tonumber(getgenv().textGem) - amount
				if tonumber(getgenv().textGem) <= 0 then
					pcall(function () webhook_finish() end)
					updatejson()
					wait(99)
				else
					pcall(function() webhook() end) 
				end
				updatejson()
				task.wait(1)
				break
			end
		end

		if getgenv().AutoReplay then
			local a = { [1] = "replay" }
			game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(a))
			game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(a))
			wait(99)
		else
			game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
			task.wait(300)
			game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
			task.wait(100)
			game:Shutdown()
		end
	end

	-- // Story --
	if getgenv().autoSelectMode == "ฟาร์มสตอรี่" then
		pcall(function() webhook() end)
		if resultx == "VICTORY" then
			local args = {
				[1] = "next_story"
			}
			game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(args))
			game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(args))
			wait(99)
		else
			local a = { [1] = "replay" }
			game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(a))
			game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(a))
			wait(99)
		end
	end

	-- // Farm Gem and Farm Gem in Map Select --
	if getgenv().autoSelectMode == "ฟาร์มเพชร" or getgenv().autoSelectMode == "ฟาร์มเพชรเลือกด่าน" then
		task.wait(2)
		pcall(function() webhook() end)
		if getgenv().AutoReplay then
			local a = { [1] = "replay" }
			game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(a))
			game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(a))
			task.wait(300)
			game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
			task.wait(100)
			game:Shutdown()
		else
			task.wait(2)
			game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
			task.wait(100)
			game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
			task.wait(300)
			game:Shutdown()
		end
	end

	-- // infinityTower --
	if getgenv().autoSelectMode == "ฟาร์มหอคอย" then
		task.wait(5)
		local resultx = tostring(LocalPlayer.PlayerGui.ResultsUI.Holder.Title.Text)
		infTower_check = game:GetService("Players").LocalPlayer.PlayerGui.ResultsUI.Holder.LevelName.Text
		infinityTower = infTower_check:split(" ")
		
		if resultx == "VICTORY" then
			if tonumber(infinityTower[4]) >= tonumber(getgenv().textGem) then
				pcall(function() webhook_finish() end)
			else
				pcall(function() webhook() end)
				game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_infinite_tower_from_game:InvokeServer()
				game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_infinite_tower_from_game:InvokeServer()
				wait(99)
			end
		else
			local a = { [1] = "replay" }
			game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(a))
			game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(a))
			wait(99)
		end
	end

	--// Level Players --//
	if getgenv().autoSelectMode == "ฟาร์มเวลตัวละคร" then
		levePlayers = LocalPlayer.PlayerGui.spawn_units.Lives.Main.Desc.Level.Text
		levelCheck = levePlayers:split(" ")
		if tonumber(levelCheck[2]) >= tonumber(getgenv().textGem) then
			pcall(function() webhook_finish() end)
			task.wait(3)
			wait(99)
		else
			pcall(function() webhook() end)
			local a = { [1] = "replay" }
			game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(a))
			game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(a))
			wait(99)
		end
	end

	--// Farm Chickent --//
	if getgenv().autoSelectMode == "ฟาร์มไก่เพชร" then
		pcall(function() webhook() end)
		while task.wait(5) do
			local checkMAp = game:GetService("Workspace")._map:FindFirstChild("namek mushroom model")
			local aceCheck = game:GetService("Players").LocalPlayer.PlayerGui.ResultsUI.Holder.LevelName			
			if checkMAp then
				if aceCheck == "Act 6 - The Purple Tyrant" then
					if resultx == "VICTORY" then
						getgenv().autoSelectMode = "ฟาร์มเพชร" 
						updatejson()
						game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
					else
						local a = { [1] = "replay" }
						game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(a))
						game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(a))
						wait(99)
					end
				else
					if resultx == "VICTORY" then
						local args = {
							[1] = "next_story"
						}
						game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(args))
						game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(args))
					else
						local a = { [1] = "replay" }
						game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(a))
						game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(a))
						wait(99)
					end
				end
			else
				getgenv().autoSelectMode = "ฟาร์มเพชร" 
				updatejson()
				game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
			end
		end
		wait(99)
	end

end

coroutine.resume(coroutine.create(function()
	local GameFinished = game:GetService("Workspace"):WaitForChild("_DATA"):WaitForChild("GameFinished")
	GameFinished:GetPropertyChangedSignal("Value"):Connect(function()
		if GameFinished.Value == true then
			gameisFinishAuto()
		end
	end)
end))

--#endregion

-- [[ จบฟังชั่นจบเกมส์ ]] --
--------------------------------------------------

-- [[ ฟังชั่นทั่วไป ]] --

--#region Lock FPS

coroutine.resume(coroutine.create(function()
	while task.wait() do
		if getgenv().lockfps then
			setfpscap(5)
		else
			setfpscap(15)
		end
	end
end))

--#endregion

--#region Anti AFK

coroutine.resume(coroutine.create(function()
	while task.wait(60) do
		pcall(function()
			local vu = game:GetService("VirtualUser")
			game:GetService("Players").LocalPlayer.Idled:connect(function()
				vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
				wait(1)
				vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
			end)
		end)
	end
end))

--#endregion

--#region Teleport to Unit

coroutine.resume(coroutine.create(function()
	while task.wait() do
		local _waitUnit = game:GetService("Workspace"):FindFirstChild("_UNITS")
		local ckUnit = game:GetService("Workspace")["_UNITS"]:GetChildren()
		if _waitUnit then
			task.wait(3)
			for _, v in pairs(ckUnit) do
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace")["_UNITS"][v.Name].HumanoidRootPart.CFrame * CFrame.new(0, 0, 1)
				break
			end
		end
		break
	end
end))

--#endregion

--#region Auto Sell Units Shop Mystick

coroutine.resume(coroutine.create(function()
	while task.wait() do
		if getgenv().UnitSellTog then
			for i, v in ipairs(game:GetService("ReplicatedStorage")["_FX_CACHE"]:GetChildren()) do
				if v.Name == "CollectionUnitFrame" then
					repeat task.wait() until v:FindFirstChild("name")
					for _, Info in next, getgenv().UnitCache do
						if Info.name == v.name.Text and Info.rarity == "Rare" or Info.name == v.name.Text and Info.rarity == "Epic" then
							if getgenv().UnitSellTog then
								local args = {
									[1] = {
										[1] = tostring(v._uuid.Value),
									},
								}
								game:GetService("ReplicatedStorage").endpoints.client_to_server.sell_units:InvokeServer(unpack(args))
							end
						end
						if getgenv().UnitSellTog == false then
							break
						end
					end
				end
				if getgenv().UnitSellTog == false then
					break
				end
			end
		end
	end
end))

--#endregion

--#region setting Hidden Error

coroutine.resume(coroutine.create(function()
	while task.wait() do
		if game.PlaceId ~= 8304191830 then
			--// Disble Error in game
			game.Players.LocalPlayer.PlayerGui.MessageGui.Enabled = false
			game:GetService("ReplicatedStorage").packages.assets["ui_sfx"].error.Volume = 0
			game:GetService("ReplicatedStorage").packages.assets["ui_sfx"].error_old.Volume = 0
			--// AUTO SETTING LOW POLYGON
			local args = {
					[1] = "low_quality",
					[2] = true
			}
			game:GetService("ReplicatedStorage").endpoints.client_to_server.toggle_setting:InvokeServer(unpack(args))
			local args = {
					[1] = "disable_kill_fx",
					[2] = true
			}
			game:GetService("ReplicatedStorage").endpoints.client_to_server.toggle_setting:InvokeServer(unpack(args))
			local args = {
					[1] = "disable_other_fx",
					[2] = true
			}
			game:GetService("ReplicatedStorage").endpoints.client_to_server.toggle_setting:InvokeServer(unpack(args))
			local args = {
					[1] = "disable_effects",
					[2] = true
			}
			game:GetService("ReplicatedStorage").endpoints.client_to_server.toggle_setting:InvokeServer(unpack(args))
			local args = {
					[1] = "low_quality_shadows",
					[2] = true
			}
			game:GetService("ReplicatedStorage").endpoints.client_to_server.toggle_setting:InvokeServer(unpack(args))
			local args = {
					[1] = "low_quality_textures",
					[2] = true
			}
			game:GetService("ReplicatedStorage").endpoints.client_to_server.toggle_setting:InvokeServer(unpack(args))
			local args = {
					[1] = "autoskip_waves",
					[2] = true
			}
			game:GetService("ReplicatedStorage").endpoints.client_to_server.toggle_setting:InvokeServer(unpack(args))
			local args = {
					[1] = "disable_auto_open_overhead",
					[2] = true
			}
			game:GetService("ReplicatedStorage").endpoints.client_to_server.toggle_setting:InvokeServer(unpack(args))
			--///////////////////////////////////////////////////////////////////////////////////////////////////--
		end
		break
	end
end))

-- function autoload()
-- 		pcall(function()
-- 				if exec == "Synapse X" then
-- 						syn.queue_on_teleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/iwhiteiwhite/iwhiteiwhite/main/ldScr.lua'))()")
-- 					else
-- 						queue_on_teleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/iwhiteiwhite/iwhiteiwhite/main/ldScr.lua'))()")
-- 				end
-- 		end)
-- end
-- autoload()


--#endregion 

--#region reconnect
function auto_reconnect()
  repeat task.wait() until game.CoreGui:FindFirstChild('RobloxPromptGui')
  game.CoreGui.RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(e)
    if e.Name == 'ErrorPrompt' then
      warn("Trying to Reconnect")
      repeat
        TeleportService:Teleport(game.PlaceId)
        task.wait(3)
      until false
    end
  end)
end
auto_reconnect()
--#endregion

-- [[ จบฟังชั่นทั่วไป ]] --
--------------------------------------------------

--###### End Function ######--

print("Project X Successfully Loaded!!")
---------------------------------------------------------------------

