-- Main Lib

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local Path = game.CoreGui:FindFirstChild("Orion")

-- Orion Window

local Window = OrionLib:MakeWindow({IntroText = "NauHub: Word Bomb", Name = "Nau Hub: Word Bomb", HidePremium = false, SaveConfig = true, ConfigFolder = "Word Bomb"})

-- Variables

local queueonteleport = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
local httprequest = (syn and syn.request) or http and http.request or http_request or (fluxus and fluxus.request) or request
local httpservice = game:GetService('HttpService')
local player = game.Players.LocalPlayer
local workspace = game.Workspace
local RbxAnylytics = game:GetService("RbxAnalyticsService")
local executercheck = identifyexecutor and table.concat({ identifyexecutor() }, " ") or "Unknown";
local LocalizationService = game:GetService("LocalizationService")

print("Successfully Loaded")

hookfunction(error, warn)
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local localplr = Players.LocalPlayer
local PlayerGui = localplr.PlayerGui
local PlayerScripts = localplr.PlayerScripts
local ClientGameScript = PlayerScripts:WaitForChild("ClientGameScript")
local MobileService = require(ClientGameScript:WaitForChild("MobileService"))

-- Values

getgenv().esp = false
getgenv().teamcheck = false
getgenv().Color = Color3.fromRGB(255, 255, 255)

local espLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Sirius/request/library/esp/esp.lua'),true))()

getgenv().Settings = {
    AutoType = true,
    AutoJoin = true,
    LongWords = false,
    breakscript = false,
    TypeTime = 2
}

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


-- Function

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

-- Tab

local HomeTab = Window:MakeTab({
	Name = "Home",
	Icon = "rbxassetid://4370345144",
	PremiumOnly = false

})

local SupportedGameTab = Window:MakeTab({
	Name = "SupportedGame",
	Icon = "rbxassetid://4370344717",
	PremiumOnly = false

})

local PlayerInfomationTab = Window:MakeTab({
	Name = "Player Info",
	Icon = "rbxassetid://4384401919",
	PremiumOnly = false

})

local MainTab = Window:MakeTab({
	Name = "Main",
	Icon = "rbxassetid://4370319235",
	PremiumOnly = false
})

local AutoSection = MainTab:AddSection({
	Name = "Auto Type/Auto Join"
})

local LongSection = MainTab:AddSection({
	Name = "Long Words/Type Delay"
})


-- Orion Paragraph

HomeTab:AddParagraph("Welcome To Nau Hub!","Last updated : 25/10/2022 Executer Does Support Our Script : Synapse-X,Script-Ware,KRNL,Fluxus And Oxygen-U")

-- Orion Label

PlayerInfomationTab:AddLabel("Player Executer: " ..executercheck.."")

PlayerInfomationTab:AddLabel("Player Username: " ..player.Name.."")

PlayerInfomationTab:AddLabel("Player DisplayName: " ..player.DisplayName.."")

PlayerInfomationTab:AddLabel("Player AccountAge: " ..player.AccountAge.."")

PlayerInfomationTab:AddLabel("Player UserID: " ..player.UserId.."")

PlayerInfomationTab:AddLabel("Player SystemLocaleID: " ..LocalizationService.SystemLocaleId.."")

PlayerInfomationTab:AddLabel("Player LocaleID: " ..LocalizationService.RobloxLocaleId.."")


-- Orion Slider


-- Orion Button

SupportedGameTab:AddButton({
	Name = "Tapping Legend",
	Callback = function()
        game:GetService("TeleportService"):Teleport(8750997647) 
  	end    
})

SupportedGameTab:AddButton({
	Name = "Prison Life",
	Callback = function()
        game:GetService("TeleportService"):Teleport(155615604) 
  	end    
})

SupportedGameTab:AddButton({
	Name = "DOORS",
	Callback = function()
        game:GetService("TeleportService"):Teleport(6516141723) 
  	end    
})

SupportedGameTab:AddButton({
	Name = "Evade",
	Callback = function()
        game:GetService("TeleportService"):Teleport(9872472334) 
  	end    
})

SupportedGameTab:AddButton({
	Name = "The Obby Elevator",
	Callback = function()
        game:GetService("TeleportService"):Teleport(7044096177) 
  	end    
})

SupportedGameTab:AddButton({
	Name = "Ninja Legends",
	Callback = function()
        game:GetService("TeleportService"):Teleport(3956818381) 
  	end    
})

SupportedGameTab:AddButton({
	Name = "Mining Simulator 2",
	Callback = function()
        game:GetService("TeleportService"):Teleport(9551640993) 
  	end    
})

HomeTab:AddButton({
	Name = "Script Made By: Nau#4866 ",
	Callback = function()
      		setclipboard("https://discord.gg/XHrQ6DPzcb")
              OrionLib:MakeNotification({
                Name = "Nau Hub Discord ",
                Content = "Copied Invite Link!",
                Image = "rbxassetid://4503342956",
                Time = 5
            })
  	end    
})

-- Orion Notification

OrionLib:MakeNotification({
	Name = "Welcome To Nau Hub! "..player.DisplayName.."",
	Content = "Thanks For Using Nau Hub Enjoy Your Script!!: Word Bomb Last Updated: 25/10/2022",
	Image = "rbxassetid://4335489513",
	Time = 13
})

-- Main Button/Toggles

AutoSection:AddToggle({
	Name = "Auto Type",
	Default = false,
	Callback = function(Value)
		Settings.AutoType = Value
	end    
})

AutoSection:AddToggle({
	Name = "Auto Join",
	Default = false,
	Callback = function(Value)
		Settings.AutoJoin = Value
	end    
})

LongSection:AddToggle({
	Name = "Long Words Only",
	Default = false,
	Callback = function(Value)
		Settings.LongWords = Value
	end    
})

LongSection:AddSlider({
	Name = "Type Delay",
	Min = 0,
	Max = 6,
	Default = 0,
	Color = Color3.fromRGB(255, 0, 0),
	Increment = 1,
	ValueName = "Type Delay Values",
	Callback = function(Value)
		Settings.TypeTime = Value
	end    
})

MainTab:AddLabel("Please Ignore This Thing")

MainTab:AddToggle({
	Name = "Destroy Script",
	Default = false,
	Callback = function(Value)
		Settings.breakscript = Value
	end    
})

while wait(0.5) do
    if Settings.breakscript == true then
        Path:Destroy()
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

OrionLib:Init()