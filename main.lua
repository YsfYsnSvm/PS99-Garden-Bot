-- PS99 Ultra Fast Spin by Yusuf Arda
local player = game.Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")
local Network = game:GetService("ReplicatedStorage"):FindFirstChild("Network")

-- Önceki GUI varsa sil (Çakışmasın)
if PlayerGui:FindFirstChild("YusufArda_SpinBot") then
    PlayerGui:FindFirstChild("YusufArda_SpinBot"):Destroy()
end

-- GUI OLUŞTURMA (En Garanti Yöntem)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "YusufArda_SpinBot"
ScreenGui.Parent = PlayerGui -- CoreGui yerine direkt PlayerGui kullanarak hata riskini sıfırladık
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 200, 0, 150)
MainFrame.Position = UDim2.new(0.5, -100, 0.4, -75)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 2
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "YUSUF ARDA SPIN"
Title.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Parent = MainFrame

local StartBtn = Instance.new("TextButton")
StartBtn.Size = UDim2.new(0.8, 0, 0.4, 0)
StartBtn.Position = UDim2.new(0.1, 0, 0.3, 0)
StartBtn.Text = "BASLAT"
StartBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
StartBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
StartBtn.Parent = MainFrame

local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(1, 0, 0, 20)
Status.Position = UDim2.new(0, 0, 0.8, 0)
Status.Text = "Hazir!"
Status.BackgroundTransparency = 1
Status.TextColor3 = Color3.fromRGB(255, 255, 255)
Status.Parent = MainFrame

-- DÖNGÜ MANTIĞI
local running = false

StartBtn.MouseButton1Click:Connect(function()
    running = not running
    if running then
        StartBtn.Text = "DURDUR"
        StartBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
        
        task.spawn(function()
            while running do
                -- 1. SPIN (Çevir)
                if Network then
                    pcall(function()
                        Network:WaitForChild("SpinnyWheel_RequestSpin"):InvokeServer("Spinny Wheel")
                    end)
                end
                
                -- 2. ANIMASYON IPTAL (Kapat)
                local wheelGui = PlayerGui:FindFirstChild("SpinnyWheel")
                if wheelGui then wheelGui.Enabled = false end
                
                -- 3. OK BUTONU (Onayla)
                local loot = PlayerGui:FindFirstChild("Lootview") or PlayerGui:FindFirstChild("Message")
                if loot and loot:FindFirstChild("Frame") and loot.Frame:FindFirstChild("Ok") then
                    pcall(function() loot.Frame.Ok.MouseButton1Click:Fire() end)
                end
                
                Status.Text = "Hizli Cevrim..."
                task.wait(0.2) -- Videodaki hız
            end
        end)
    else
        StartBtn.Text = "BASLAT"
        StartBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        Status.Text = "Durduruldu."
    end
end)
