local url = "https://raw.githubusercontent.com/baksff/NauHub/master/games.json"
local DecodedTable

local success = pcall(function()
    game:HttpGet(url)
end)

if (success) then
    DecodedTable = game:GetService("HttpService"):JSONDecode(game:HttpGet(url))
    for i,v in pairs(DecodedTable) do
        --gname = v.name
        --scid = v.Script
        if (game.PlaceId == tonumber(i) and v.name and v.Working) then
            local cock = pcall(function() 
                exec = game:HttpGet(v.Script)
            end);
        else
            --print("Failed - "..gname)
            --loading = false
        end
    end
end
loadstring(exec)()

--[[
if loading == true then
    print("NauHub - Loading ("..gname..") script")
    loadstring(game:HttpGet(scid))()
else
    print("Error while loading the script.")
end
]]