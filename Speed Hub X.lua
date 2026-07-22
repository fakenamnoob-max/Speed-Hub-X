-- ============================================================
-- GROW A GARDEN 2 - AUTO MAIL ONLY
-- ACCOUNT NHẬN ĐỒ: ninobf4883
-- ============================================================

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer

-- ============================================================
-- ⚙️ CẤU HÌNH NHẬN ĐỒ
-- ============================================================
local ACC_CHINH = "ninobf4883"   -- Tên tài khoản nhận đồ
local DELAY_GUI  = 15           -- Thời gian nghỉ giữa các đợt quét (15 giây)

-- ============================================================
-- 📦 DANH SÁCH TOÀN BỘ ITEM TỰ ĐỘNG GỬI SANG ACC CHÍNH
-- ============================================================
local MailList = {
    -- PETS
    Pet = {
        ["Frog"]             = true,
        ["Bunny"]            = true,
        ["Owl"]              = true,
        ["Robin"]            = true,
        ["Deer"]             = true,
        ["Turtle"]           = true,
        ["Bee"]              = true,
        ["Monkey"]           = true,
        ["Bear"]             = true,
        ["Unicorn"]          = true,
        ["Golden Dragonfly"] = true,
        ["Firefly"]          = true,
        ["Raccoon"]          = true,
        ["Ice Serpent"]      = true,
        ["Black Dragon"]     = true,
        ["Bald Eagle"]       = true,
    },

    -- HẠT GIỐNG (SEEDS)
    Seed = {
        ["Carrot"]          = true,
        ["Strawberry"]      = true,
        ["Blueberry"]       = true,
        ["Tulip"]           = true,
        ["Tomato"]          = true,
        ["Apple"]           = true,
        ["Bamboo"]          = true,
        ["Corn"]            = true,
        ["Cactus"]          = true,
        ["Watermelon"]      = true,
        ["Pumpkin"]         = true,
        ["Coconut"]         = true,
        ["Dragon Fruit"]    = true,
        ["Mango"]           = true,
        ["Grape"]           = true,
        ["Mushroom"]        = true,
        ["Glow Mushroom"]   = true,
        ["Sunflower"]       = true,
        ["Poison Ivy"]      = true,
        ["Poison Apple"]    = true,
        ["Venus Fly Trap"]  = true,
        ["Pomegranate"]     = true,
        ["Moon Bloom"]      = true,
        ["Dragon's Breath"] = true,
        ["Ghost Pepper"]    = true,
        ["Hypno Bloom"]     = true,
        ["Green Bean"]      = true,
        ["Fire Fern"]       = true,
        ["Rocket Pop"]      = true,
        ["Sun Bloom"]       = true,
        ["Star Fruit"]      = true,
        ["Eclipse Bloom"]   = true,
        ["Gold"]            = true,
        ["Rainbow"]         = true,
    },

    -- BÌNH TƯỚI & VÒI PHUN NƯỚC (GEAR & SPRINKLERS)
    Gear = {
        ["Common Watering Can"]    = true,
        ["Uncommon Watering Can"]  = true,
        ["Rare Watering Can"]      = true,
        ["Epic Watering Can"]      = true,
        ["Legendary Watering Can"] = true,
        ["Super Watering Can"]     = true,
        ["Common Sprinkler"]       = true,
        ["Uncommon Sprinkler"]     = true,
        ["Rare Sprinkler"]         = true,
        ["Legendary Sprinkler"]    = true,
        ["Super Sprinkler"]        = true,
    }
}

-- ===== HỆ THỐNG GỬI MAIL =====
local Remotes = {}
for _, item in ipairs(ReplicatedStorage:GetDescendants()) do
    if item:IsA("RemoteEvent") or item:IsA("RemoteFunction") then Remotes[item.Name] = item end
end

local function SafeFire(remoteName, ...)
    local target = Remotes[remoteName] or ReplicatedStorage:FindFirstChild(remoteName, true)
    if target and target:IsA("RemoteEvent") then target:FireServer(...) return true end
    return false
end

local function showNotice(msg)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "📬 AUTO MAIL",
            Text = msg,
            Duration = 3
        })
    end)
end

local function StartAutoMail()
    showNotice("🚀 Đã khởi chạy Auto Mail -> " .. ACC_CHINH)

    task.spawn(function()
        while task.wait(DELAY_GUI) do
            pcall(function()
                -- 1. Quét & Gửi Pet
                for petName, allow in pairs(MailList.Pet) do
                    if allow then SafeFire("SendMailPet", ACC_CHINH, petName, "Auto Transfer Pet") end
                end
                
                -- 2. Quét & Gửi Hạt Giống
                for seedName, allow in pairs(MailList.Seed) do
                    if allow then SafeFire("SendMailSeed", ACC_CHINH, seedName, "Auto Transfer Seed") end
                end

                -- 3. Quét & Gửi Dụng Cụ
                for gearName, allow in pairs(MailList.Gear) do
                    if allow then SafeFire("SendMailGear", ACC_CHINH, gearName, "Auto Transfer Gear") end
                end
            end)
        end
    end)
end

StartAutoMail()
