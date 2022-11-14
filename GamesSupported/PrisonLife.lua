--// getgenv



--// Services

local RbxAnylytics = game:GetService("RbxAnalyticsService")

local LocalizationService = game:GetService("LocalizationService")

--// Variables

local Module = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Discord%20Inviter/Source.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/naufalafif080419/NauHub-WebHook/main/WebHook.lua"))()

local executor = identifyexecutor and table.concat({ identifyexecutor() }, " ") or "Unknown";

local player = game.Players.LocalPlayer
local workspace = game.Workspace
local plr = game.Players.LocalPlayer

local queueonteleport = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
local httprequest = (syn and syn.request) or http and http.request or http_request or (fluxus and fluxus.request) or request
local httpservice = game:GetService('HttpService')
queueonteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/baksff/NauHub/master/Loader.lua'))()")

--// Tables



--// Functions


--// Library Setup
local gname = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name -- Get Game Name
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

local Window = Rayfield:CreateWindow({
	Name = "NauHub | "..gname,
	LoadingTitle = "Welcome to NauHub Prison Life, "..plr.Name,
	LoadingSubtitle = "by NauHub",
	ConfigurationSaving = {
		Enabled = true,
		FolderName = "NauHub File", -- Create a custom folder for your hub/game
		FileName = "NauHub Prison Life"
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

--// Item Giver Tab

local ItemGiverTab = Window:CreateTab("Item Giver",4483364327)

local ItemGiverSection = ItemGiverTab:CreateSection("Gun")

local Dropdown = ItemGiverTab:CreateDropdown({
	Name = "Choose Your Gun",
	Options = {"M9", "Remington 870", "AK-47"},
	CurrentOption = "1",
	Flag = "Dropdown1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(v)
        local A_1 = game:GetService("Workspace")["Prison_ITEMS"].giver[v].ITEMPICKUP
        local Event = game:GetService("Workspace").Remote.ItemHandler
        Event:InvokeServer(A_1)
	end,
})

local Dropdown = ItemGiverTab:CreateDropdown({
	Name = "Choose Your Modded Gun",
	Options = {"M9", "Remington 870", "AK-47"},
	CurrentOption = "1",
	Flag = "Dropdown1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(v)
        local module = nil
        if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(v) then
            module = require(game:GetService("Players").LocalPlayer.Backpack[v].GunStates)
        elseif game:GetService("Players").LocalPlayer.Character:FindFirstChild(v) then
            module = require(game:Getservice("Players").LocalPlayer.Character[v].GunStates)     
        end
        if module ~= nil then
            module["MaxAmmo"] = math.huge
            module["CurrentAmmo"] = math.huge
            module["StoredAmmo"] = math.huge
            module["FireRate"] = 0.000001
            module["Spread"] = 0
            module["Range"] = math.huge
            module["Bullets"] = 10
            module["Reload Time"] = 0.000001
            module["AutoFire"] = true
         end
	end,
})

--// Team Changer Tab

local TeamChangerTab = Window:CreateTab("Team Changer",3944688398)

local TeamChangerSection = TeamChangerTab:CreateSection("Team")

local Button = TeamChangerTab:CreateButton({
	Name = "Guards",
	Callback = function()
        local ohString1 = "Bright blue"
        workspace.Remote.TeamEvent:FireServer(ohString1)
	end,
})

local Button = TeamChangerTab:CreateButton({
	Name = "Inmates",
	Callback = function()
        local ohString1 = "Bright orange"
        workspace.Remote.TeamEvent:FireServer(ohString1)
	end,
})

local Button = TeamChangerTab:CreateButton({
	Name = "Neutral",
	Callback = function()
        local ohString1 = "Medium stone grey"
        workspace.Remote.TeamEvent:FireServer(ohString1)
	end,
})

local Button = TeamChangerTab:CreateButton({
	Name = "Criminal",
	Callback = function()
        local ohString1 = "Really red"
        workspace.Remote.TeamEvent:FireServer(ohString1)
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
