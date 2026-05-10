-- PS99 Spin Wheel GUI by Yusuf Arda
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local StartBtn = Instance.new("TextButton")
local Status = Instance.new("TextLabel")

-- GUI'yi Roblox'a ekle
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.Name = "YusufArda_SpinBot"

-- Ana Pencere Tasarımı
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.Position = UDim2.new(0.5, -100, 0.5, -75)
MainFrame.Size = UDim2.new(0, 200, 0, 150)
MainFrame.Active = true
MainFrame.Draggable = true -- Mouse ile sürükleyebilirsin

-- Başlık
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "YUSUF ARDA SPIN BOT"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

-- Durum Yazısı
Status.Parent = MainFrame
Status.Position = UDim2.new(0, 0, 0.7, 0)
Status.Size = UDim2.new(1, 0, 0, 30)
Status.Text = "Bekleniyor..."
Status.TextColor3 = Color3.fromRGB(200, 200, 200)
Status.BackgroundTransparency = 1

-- Başlat/Durdur Butonu
StartBtn.Parent = MainFrame
StartBtn.Position = UDim2.new(0.1, 0, 0.3, 0)
StartBtn.Size = UDim2.new(0.8, 0, 0.3, 0)
StartBtn.Text = "CEVIRMEYE BASLA"
StartBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
StartBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

-- DÖNGÜ VE MANTIK
local running = false
local Network = game:GetService("ReplicatedStorage"):WaitForChild("Network")

StartBtn.MouseButton1Click:Connect(function()
    running = not running
    
    if running then
        StartBtn.Text = "DURDUR"
        StartBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
        Status.Text = "Carklar donuyor..."
        
        task.spawn(function()
            while running do
                -- Sunucuya çevirme isteği gönder (İsimleri PS99 güncel networküne göre ayarlı)
                local success = Network:WaitForChild("SpinnyWheel_RequestSpin"):InvokeServer("Spinny Wheel")
                
                if not success then
                    Status.Text = "Bilet bitti veya Hata!"
                    running = false
                    StartBtn.Text = "CEVIRMEYE BASLA"
                    StartBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
                    break
                end
                task.wait(1.2) -- Hız ayarı
            end
        end)
    else
        StartBtn.Text = "CEVIRMEYE BASLA"
        StartBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        Status.Text = "Durduruldu."
    end
end)
