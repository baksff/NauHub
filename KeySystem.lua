--// Library Setup
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()
local Window = Rayfield:CreateWindow({
    Name = "NauHub: Key System",
    LoadingTitle = "NauHub: Key System",
    LoadingSubtitle = "by NauHub",
    KeySystem = false, -- Set this to true to use our key system
    KeySettings = {
        Title = "NauHub: Key System",
        Subtitle = "by NauHub",
        Note = "Join the discord (https://discord.gg/XHrQ6DPzcb) to get the key",
        Key = "09bc09d570d98c047ec1f70d3cbac8bb06bdf518"
    }
})

--// Values
_G.Key = "09bc09d570d98c047ec1f70d3cbac8bb06bdf518"
_G.KeyInput = "string"

--// Variables
local player = game.Players.LocalPlayer

--// Home Tab
local HTab = Window:CreateTab("Home")
local HSection = HTab:CreateSection("Section Example")
HTab:CreateParagraph({Title = "Welcome To NauHub!", Content = "Last updated : 28/10/2022 Executor Does Support Our Script : Synapse-X, Script-Ware, KRNL, Fluxus And Oxygen-U"})

--// Key Tab
local KTab = Window:CreateTab("Key System")
local PutKeySection = KTab:CreateSection("Put Key")
KTab:CreateInput({
    Name = "Put your key here",
    PlaceholderText = "Put key",
    RemoveTextAfterFocusLost = false,
    Callback = function(Value)
        _G.KeyInput = Value
    end,
})
local CheckKeySection = KTab:CreateSection("Check Key")
KTab:CreateButton({
    Name = "Check key!",
    Callback = function()
        if _G.KeyInput == _G.Key then
            Rayfield:Notify("The key is correct!","Trying To Load NauHub...",3944680095)
            loadstring(game:HttpGet("https://raw.githubusercontent.com/baksff/NauHub/master/Loader.lua"))()
            Rayfield:Destroy()
        else
            Rayfield:Notify("The key is incorrect!","Please check the key and try again.",3944676352)
        end
    end,
})
local GetKeySection = KTab:CreateSection("Get Key")
KTab:CreateButton({
    Name = "Get your key here!",
    Callback = function()
        Rayfield:Notify("Information","The link successfully copied to your clipboard!",3944680095)
        setclipboard("https://discord.gg/XHrQ6DPzcb")
    end,
})
Rayfield:Notify("Welcome To NauHub!" ..player.DisplayName.."","Thanks For Using NauHub Enjoy Your Script! Key System Last Updated: 25/10/2022",4335489513)