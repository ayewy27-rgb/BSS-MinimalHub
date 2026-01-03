--// BSS Minimal Hub | Public
--// Clean • Minimal • Powerful
--// PlaceId: Bee Swarm Simulator

if game.PlaceId ~= 1537690962 then
    warn("This hub works only in Bee Swarm Simulator")
    return
end

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- Anti AFK (разрешённый)
for _,v in pairs(getconnections(player.Idled)) do
    v:Disable()
end

-- UI Library (Rayfield)
local Rayfield = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/shlexware/Rayfield/main/source"
))()

local Window = Rayfield:CreateWindow({
    Name = "BSS Minimal Hub",
    LoadingTitle = "Bee Swarm Simulator",
    LoadingSubtitle = "Public Hub • Minimalism",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "BSSMinimalHub",
        FileName = "Config"
    }
})

-- Tabs
local FarmTab = Window:CreateTab("🌾 Farm", 4483362458)
local MiscTab = Window:CreateTab("⚙️ Misc", 4483362458)

-- Variables
local AutoFarm = false

-- Autofarm (простая, чистая логика)
local function StartAutoFarm()
    task.spawn(function()
        while AutoFarm do
            pcall(function()
                local char = player.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.CFrame = hrp.CFrame * CFrame.new(0, 0, -2)
                end
            end)
            task.wait(0.2)
        end
    end)
end

FarmTab:CreateToggle({
    Name = "Auto Farm (Simple)",
    CurrentValue = false,
    Flag = "AutoFarm",
    Callback = function(Value)
        AutoFarm = Value
        if Value then
            StartAutoFarm()
        end
    end
})

-- FPS Boost
MiscTab:CreateButton({
    Name = "FPS Boost",
    Callback = function()
        for _,v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") then
                v.Material = Enum.Material.SmoothPlastic
                v.Reflectance = 0
            elseif v:IsA("Decal") or v:IsA("Texture") then
                v:Destroy()
            end
        end
        Rayfield:Notify({
            Title = "FPS Boost",
            Content = "Optimization applied",
            Duration = 4
        })
    end
})

-- Notification
Rayfield:Notify({
    Title = "BSS Minimal Hub",
    Content = "Loaded successfully",
    Duration = 5
})
