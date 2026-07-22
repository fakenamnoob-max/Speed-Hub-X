-- ============================================================
-- GROW A GARDEN 2 - PREMIUM DETECTOR & SERVER HOPPER UI
-- ============================================================

local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

local DELAY_HOP = 8 -- Thời gian đếm ngược trước khi đổi server (Giây)

getgenv().VisitedServers = getgenv().VisitedServers or {}
table.insert(getgenv().VisitedServers, game.JobId)

-- 🌟 DANH SÁCH PET, MỨC ĐỘ ƯU TIÊN VÀ GIÁ TRỊ THAM KHẢO
local TargetPets = {
    ["Unicorn"]          = {IsTarget = true,  Price = "50M Shekels", Rarity = "Legendary"},
    ["Golden Dragonfly"] = {IsTarget = true,  Price = "35M Shekels", Rarity = "Legendary"},
    ["Firefly"]          = {IsTarget = true,  Price = "15M Shekels", Rarity = "Rare"},
    ["Raccoon"]          = {IsTarget = true,  Price = "20M Shekels", Rarity = "Epic"},
    ["Deer"]             = {IsTarget = true,  Price = "8M Shekels",  Rarity = "Rare"},
    ["Big Deer"]         = {IsTarget = true,  Price = "18M Shekels", Rarity = "Epic"},
    ["Huge Deer"]        = {IsTarget = true,  Price = "45M Shekels", Rarity = "Legendary"},
    ["Big Turtle"]       = {IsTarget = true,  Price = "12M Shekels", Rarity = "Rare"},
    ["Huge Turtle"]      = {IsTarget = true,  Price = "30M Shekels", Rarity = "Legendary"},
    ["Bald Eagle"]       = {IsTarget = true,  Price = "10M Shekels", Rarity = "Rare"},
    ["Big Bald Eagle"]   = {IsTarget = true,  Price = "25M Shekels", Rarity = "Epic"},
    ["Huge Bald Eagle"]  = {IsTarget = true,  Price = "60M Shekels", Rarity = "Mythic"},
}

-- ============================================================
-- 🖥️ TẠO GIAO DIỆN PREMIUM (UI CREATION)
-- ============================================================
local function CreatePremiumUI(detectedPetsList, hasTargetPet)
    if CoreGui:FindFirstChild("SpeedHubPremiumUI") then
        CoreGui.SpeedHubPremiumUI:Destroy()
    end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "SpeedHubPremiumUI"
    ScreenGui.Parent = CoreGui

    -- Khung chính
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 300, 0, 240)
    MainFrame.Position = UDim2.new(0.03, 0, 0.25, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Parent = ScreenGui

    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 10)
    MainCorner.Parent = MainFrame

    local MainStroke = Instance.new("UIStroke")
    MainStroke.Color = Color3.fromRGB(50, 50, 70)
    MainStroke.Thickness = 1.2
    MainStroke.Parent = MainFrame

    -- Thanh Header
    local Header = Instance.new("Frame")
    Header.Size = UDim2.new(1, 0, 0, 35)
    Header.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    Header.BorderSizePixel = 0
    Header.Parent = MainFrame

    local HeaderCorner = Instance.new("UICorner")
    HeaderCorner.CornerRadius = UDim.new(0, 10)
    HeaderCorner.Parent = Header

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -10, 1, 0)
    Title.Position = UDim2.new(0, 10, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = "⚡ SPEED HUB X • PET FINDER"
    Title.TextColor
    
