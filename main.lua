-- PS99 Ultra Fast Spin by Yusuf Arda
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local StartBtn = Instance.new("TextButton")
local Status = Instance.new("TextLabel")

-- GUI'yi Roblox'a ekle
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.Name = "YusufArda_SpinBot"

-- Tasarım
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Position = UDim2.new(0.5, -100, 0.5, -75)
MainFrame.Size = UDim2.new(0, 200, 0, 150)
MainFrame.Active = true
MainFrame.Draggable = true

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "YUSUF ARDA SPIN BOT"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundColor3 = Color3.fromRGB(0, 120, 215)

Status.Parent = MainFrame
Status.Position = UDim2.new(0, 0, 0.7, 0)
Status.Size = UDim2.new(1, 0, 0, 30)
Status.Text = "Sistem Hazir"
Status.TextColor3 = Color3.fromRGB(200, 200, 200)
Status.BackgroundTransparency = 1

StartBtn.Parent = MainFrame
StartBtn.Position = UDim2.new(0.1, 0, 0.35, 0)
StartBtn.Size = UDim2.new(0.8, 0, 0.3, 0)
StartBtn.Text = "CEVIRMEYE BASLA"
StartBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
StartBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

-- LOGIC (MANTIK)
local running = false
local Network = game:GetService("ReplicatedStorage"):WaitForChild("Network")
local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")

StartBtn.MouseButton1Click:Connect(function()
    running = not running
    if running then
        StartBtn.Text = "DURDUR"
        StartBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
        Status.Text = "Hizli Cevrim Aktif!"
        
        task.spawn(function()
            while running do
                -- 1. Çevir komutu gönder (Spin)
                pcall(function()
                    Network:WaitForChild("SpinnyWheel_RequestSpin"):InvokeServer("Spinny Wheel")
                end)
                
                -- 2. Menüyü anında kapat (Videodaki gibi çarpıya basma etkisi)
                task.spawn(function()
                    local wheelGui = PlayerGui:FindFirstChild("SpinnyWheel") or PlayerGui:FindFirstChild("SpinnyWheelGui")
                    if wheelGui then
                        wheelGui.Enabled = false -- Menüyü yok ederek animasyonu iptal eder
                    end
                end)
                
                -- 3. OK Butonuna bas (Congratulations ekranını geç)
                task.spawn(function()
                    for i = 1, 10 do -- Pencere gelene kadar kısa bir süre tara
                        local loot = PlayerGui:FindFirstChild("Lootview") or PlayerGui:FindFirstChild("Message")
                        if loot and loot:FindFirstChild("Frame") and loot.Frame:FindFirstChild("Ok") then
                            loot.Frame.Ok.MouseButton1Click:Fire()
                            break
                        end
                        task.wait(0.05)
                    end
                end)

                task.wait(0.25) -- Videodaki o aşırı hızlı döngü süresi
            end
        end)
    else
        StartBtn.Text = "CEVIRMEYE BASLA"
        StartBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        Status.Text = "Durduruldu."
    end
end)
