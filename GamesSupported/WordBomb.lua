--// getgenv


--// Services

local RbxAnylytics = game:GetService("RbxAnalyticsService")

local LocalizationService = game:GetService("LocalizationService")

hookfunction(error, warn)
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--// Variables

local queueonteleport = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
local httprequest = (syn and syn.request) or http and http.request or http_request or (fluxus and fluxus.request) or request
local httpservice = game:GetService('HttpService')
queueonteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/baksff/NauHub/master/Loader.lua'))()")

local Module = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Discord%20Inviter/Source.lua"))()

local executor = identifyexecutor and table.concat({ identifyexecutor() }, " ") or "Unknown";

local player = game.Players.LocalPlayer
local workspace = game.Workspace

print("Successfully Loaded")

local localplr = Players.LocalPlayer
local PlayerGui = localplr.PlayerGui
local PlayerScripts = localplr.PlayerScripts

local ClientGameScript = PlayerScripts:WaitForChild("ClientGameScript")
local MobileService = require(ClientGameScript:WaitForChild("MobileService"))

local Response = game:HttpGet("https://raw.githubusercontent.com/WordReaper/word-bomb/main/words.txt")
local Words = {}

for line in string.gmatch(Response,"[^\r\n]*") do
    if line ~= "" then
        table.insert(Words, line)
    end
end

local Response = game:HttpGet("https://raw.githubusercontent.com/WordReaper/word-bomb/main/longwords.txt")
local LongWords = {}

for line in string.gmatch(Response,"[^\r\n]*") do
    if line ~= "" then
        table.insert(LongWords, line)
    end
end

--// Tables

getgenv().Settings = {
    AutoType = true,
    AutoJoin = true,
    LongWords = false,
    breakscript = false,
    TypeTime = 2
}

local KeyCodes = {
    A = 0x41,
    B = 0x42,
    C = 0x43,
    D = 0x44,
    E = 0x45,
    F = 0x46,
    G = 0x47,
    H = 0x48,
    I = 0x49,
    J = 0x4A,
    K = 0x4B,
    L = 0x4C,
    M = 0x4D,
    N = 0x4E,
    O = 0x4F,
    P = 0x50,
    Q = 0x51,
    R = 0x52,
    S = 0x53,
    T = 0x54,
    U = 0x55,
    V = 0x56,
    W = 0x57,
    X = 0x58,
    Y = 0x59,
    Z = 0x5B
}

--// Functions

function getPlayers()
    local table1 = {}
    for i, v in pairs(game:GetService("Players"):GetChildren()) do
        table.insert(table1, v.Name)
    end
    game.Players.PlayerAdded:Connect(
        function(a) table.insert(table1, a.Name) end)
    game.Players.PlayerRemoving:Connect(function(a)
        for i, v in pairs(table1) do
            if v == a.Name then table.remove(table1, i) end
        end
    end)
    return table1
end

function CanType()
    local GameSpace = PlayerGui.GameUI.Container.GameSpace
    if GameSpace:FindFirstChild("DefaultUI") and GameSpace.DefaultUI:FindFirstChild("GameContainer") and GameSpace.DefaultUI.GameContainer:FindFirstChild("DesktopContainer") then
        return GameSpace.DefaultUI.GameContainer.DesktopContainer.Typebar.Typebox.Visible
    end
    return false
end

function GetJoinButton()
    local GameSpace = PlayerGui.GameUI.Container.GameSpace
    if GameSpace:FindFirstChild("DefaultUI") and GameSpace.DefaultUI:FindFirstChild("DesktopFrame") then
        return GameSpace.DefaultUI.DesktopFrame:FindFirstChild("JoinButton")
    end
end

function GetCurrentPattern()
    local GameSpace = PlayerGui.GameUI.Container.GameSpace
    if GameSpace:FindFirstChild("DefaultUI") and GameSpace.DefaultUI:FindFirstChild("GameContainer") and GameSpace.DefaultUI.GameContainer:FindFirstChild("DesktopContainer") then
        local Pattern = ""
        for _, LetterFrame in next, GameSpace.DefaultUI.GameContainer.DesktopContainer.InfoFrameContainer.InfoFrame.TextFrame:GetChildren() do
            if LetterFrame:IsA("Frame") and LetterFrame.Visible == true and LetterFrame.Letter.ImageColor3 ~= Color3.new(255, 255, 255) then
                Pattern ..= LetterFrame.Letter.TextLabel.Text
            end
        end
        return Pattern
    end
end
    
function FindWord(Pattern)
    if Settings.LongWords == true then
        local total = {}
        for _, Word in next, LongWords do
            if string.find(Word, Pattern) and not table.find(Used, Word) then
                table.insert(total, Word)
            end
        end
        local theword = total[math.random(1, #total)]
        table.insert(Used, theword)
        return theword
    else
        local total = {}
        for _, Word in next, Words do
            if string.find(Word, Pattern) and not table.find(Used, Word) then
                table.insert(total, Word)
            end
        end
        local theword = total[math.random(1, #total)]
        table.insert(Used, theword)
        return theword
    end
end
    
function Type(Word)
    local Typebox = PlayerGui.GameUI.Container.GameSpace.DefaultUI.GameContainer.DesktopContainer.Typebar.Typebox
    local WaitTime = (Settings.TypeTime / 3) / 10
    if math.random(1, 5) == 1 then
        for _, Letter in next, string.split(Word, "") do
            if math.random(1, 5) == 1 then
                Typebox.Text ..= string.char(math.random(string.byte('A'), string.byte('Z')))
                wait(WaitTime / 1.5)
                Typebox.Text ..= string.char(math.random(string.byte('A'), string.byte('Z')))
                wait(WaitTime * 2.8)
                Typebox.Text = Typebox.Text:sub(0, -2)
                wait(WaitTime / 1.3)
                Typebox.Text = Typebox.Text:sub(0, -2)
                wait(WaitTime / 1.3)
                Typebox.Text ..= Letter
                wait(WaitTime)
            else
                Typebox.Text ..= Letter
                wait(WaitTime)
            end
        end
        firesignal(Typebox.FocusLost, true)
    else
        for _, Letter in next, string.split(Word, "") do
            Typebox.Text ..= Letter
            wait(WaitTime)
        end
        firesignal(Typebox.FocusLost, true)
    end
end
    
function TypeWord(Pattern)
    local Word = FindWord(string.lower(Pattern))
    if Word then
        Type(Word)
    end
    wait(0.25)
    Typing = false
end

--// Library Setup
local gname = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name -- Get Game Name
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

local Window = Rayfield:CreateWindow({
	Name = "NauHub | "..gname,
	LoadingTitle = "Welcome to NauHub Word Bomb, "..plr.Name,
	LoadingSubtitle = "by NauHub",
	ConfigurationSaving = {
		Enabled = true,
		FolderName = "NauHub File", -- Create a custom folder for your hub/game
		FileName = "NauHub Mining Word Bomb"
	},
        Discord = {
        	Enabled = true,
        	Invite = "https://discord.gg/XHrQ6DPzcb", -- The Discord invite code, do not include discord.gg/
        	RememberJoins = true -- Set this to false to make them join the discord every time they load it up
        },
	KeySystem = false, -- Set this to true to use our key system
	KeySettings = {
		Title = "Sirius Hub",
		Subtitle = "Key System",
		Note = "Join the discord (discord.gg/sirius)",
		FileName = "SiriusKey",
		SaveKey = true,
		GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
		Key = "Hello"
	}
})

function CopyLink()
    Rayfield:Notify("Copy Link","Copy Link Added Please Paste It In Your Browser",3944680095)
    end

--// Player Info Tab

local PITab = Window:CreateTab("Player Info",4335480896)
local PISection = PITab:CreateSection("Player Info")
PITab:CreateLabel("Executor: "..executor)
PITab:CreateLabel("Name: "..plr.Name)
PITab:CreateLabel("DisplayName:  "..plr.DisplayName)
PITab:CreateLabel("Account Age: "..plr.AccountAge.." days")
PITab:CreateLabel("UserId: "..plr.UserId)
PITab:CreateLabel("SystemLocaleId: "..LocalizationService.SystemLocaleId)
PITab:CreateLabel("LocaleId: "..LocalizationService.RobloxLocaleId)

--// Main Tab

local MainTab = Window:CreateTab("Main",4370319235)

local AutoSection = MainTab:CreateSection("Auto Type/Auto Join")

--// Credits Tab
local CTab = Window:CreateTab("Credits",3944676934)
local CSection = CTab:CreateSection("Credits")
CTab:CreateButton({
	Name = "Made by Nau#4866 (click to copy)",
	Callback = function()
        CopyLink()
		setclipboard("Nau#4866")
	end,
})
CTab:CreateButton({
	Name = "UI: Rayfield Interface Suite (click to copy)",
	Callback = function()
		setclipboard("https://v3rmillion.net/showthread.php?tid=1191985")
	end,
})
CTab:CreateButton({
	Name = "Our discord server (click to join)",
	Callback = function()
		Module.Join("XHrQ6DPzcb")
	end,
})

--// Supported Game Tab
local SupportedGameTab = Window:CreateTab("Supported Game",4370344717)

local SupportedSection = SupportedGameTab:CreateSection("Supported Game")

SupportedGameTab:CreateButton({
	Name = "Tapping Legends",
	Callback = function()
    game:GetService("TeleportService"):Teleport(8750997647) 
	end,
})

SupportedGameTab:CreateButton({
	Name = "Evade",
	Callback = function()
    game:GetService("TeleportService"):Teleport(9872472334) 
	end,
})

SupportedGameTab:CreateButton({
	Name = "The Obby Elevator",
	Callback = function()
    game:GetService("TeleportService"):Teleport(7044096177) 
    end,
})

SupportedGameTab:CreateButton({
	Name = "Ninja Legends",
	Callback = function()
    game:GetService("TeleportService"):Teleport(3956818381) 
    end,
})

SupportedGameTab:CreateButton({
	Name = "Mining Simulator 2",
	Callback = function()
    game:GetService("TeleportService"):Teleport(9551640993) 
    end,
})


SupportedGameTab:CreateButton({
	Name = "Rarity Factory Tycoon",
	Callback = function()
    game:GetService("TeleportService"):Teleport(10919241870) 
    end,
})

SupportedGameTab:CreateButton({
	Name = "Prison Life",
	Callback = function()
    game:GetService("TeleportService"):Teleport(155615604) 
    end,
})

SupportedGameTab:CreateButton({
	Name = "Tapping Simulator",
	Callback = function()
    game:GetService("TeleportService"):Teleport(9498006165) 
    end,
})

SupportedGameTab:CreateButton({
	Name = "Word Bomb",
	Callback = function()
    game:GetService("TeleportService"):Teleport(2653064683) 
    end,
})

SupportedGameTab:CreateButton({
	Name = "Raise A Floppa 2",
	Callback = function()
    game:GetService("TeleportService"):Teleport(9772878203) 
    end,
})

SupportedGameTab:CreateButton({
	Name = "Tower Of Hell",
	Callback = function()
    game:GetService("TeleportService"):Teleport(1962086868) 
    end,
})

SupportedGameTab:CreateButton({
	Name = "Arsenal",
	Callback = function()
    game:GetService("TeleportService"):Teleport(286090429) 
    end,
})

SupportedGameTab:CreateButton({
	Name = "DOORS",
	Callback = function()
    game:GetService("TeleportService"):Teleport(6516141723) 
    end,
})

SupportedGameTab:CreateButton({
	Name = "Murder Mystery 2",
	Callback = function()
    game:GetService("TeleportService"):Teleport(142823291) 
    end,
})

-- Notification Loaded

Rayfield:Notify({
	Title = "Nau Hub Loaded!",
	Content = "NauHub | "..gname,
	Duration = 4,
	Image = 4384403532,
  })

--// Credits Tab

local CTab = Window:CreateTab("Credits",3944676934)
local CSection = CTab:CreateSection("Credits")
CTab:CreateButton({
	Name = "Made by Nau#4866 (click to copy)",
	Callback = function()
		setclipboard("Nau#4866")
	end,
})
CTab:CreateButton({
	Name = "UI: Rayfield Interface Suite (click to copy)",
	Callback = function()
		setclipboard("https://v3rmillion.net/showthread.php?tid=1191985")
	end,
})
CTab:CreateButton({
	Name = "Our discord server (click to join)",
	Callback = function()
		Module.Join("XHrQ6DPzcb")
	end,
})

CTab:CreateButton({
	Name = "Destroy GUI",
	Callback = function()
        Rayfield:Destroy()
    end,
})

--// MainScript Tab

local AutoTypeToggle = MainTab:CreateToggle({
	Name = "Auto Type",
	CurrentValue = false,
	Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		Settings.AutoType = Value
	end,
})

local AutoTypeToggle = MainTab:CreateToggle({
	Name = "Auto Join",
	CurrentValue = false,
	Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		Settings.AutoJoin = Value
	end,
})

local LongSection = MainTab:CreateSection("Long Words/Type Delay")

local LongWordsToggle = MainTab:CreateToggle({
	Name = "Long Words Only",
	CurrentValue = false,
	Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		Settings.LongWords = Value
	end,
})

local Slider = MainTab:CreateSlider({
	Name = "Type Delay",
	Range = {0, 6},
	Increment = 1,
	Suffix = "Type Delay Set",
	CurrentValue = 0,
	Flag = "Slider1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		Settings.TypeTime = Value
	end,
})

local Label = MainTab:CreateLabel("Please Ignore This Thing")

local LongWordsToggle = MainTab:CreateToggle({
	Name = "Destroy Script",
	CurrentValue = false,
	Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		Settings.breakscript = Value
	end,
})

while wait(0.5) do
    if Settings.breakscript == true then
        Rayfield:Destroy()
        break
    end
    --[[if CanType() then
        if not Typing then
            wait(math.random(1, 6) / 3)
            Typing = true
            TypeWord(GetCurrentPattern())
        end
    end]]--
    local JoinButton = GetJoinButton()
    if JoinButton then
        task.wait(math.random(1, 5))
        Used = {}
        firesignal(JoinButton.MouseButton1Down)
    end
    if Settings.AutoType and CanType() then
        if not Typing then
            wait(math.random(7, 10) / 6)
            Typing = true
            TypeWord(GetCurrentPattern())
        end
    end
    if Settings.AutoJoin then
        local JoinButton = GetJoinButton()
    end
end
