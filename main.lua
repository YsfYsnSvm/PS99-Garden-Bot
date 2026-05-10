-- PS99 Ultra Hızlı Spin (Basitleştirilmiş Versiyon)
local Player = game.Players.LocalPlayer
local PlayerGui = Player.PlayerGui
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Eski GUI varsa temizle
if PlayerGui:FindFirstChild("YusufArda_Spin") then
    PlayerGui:FindFirstChild("YusufArda_Spin"):Destroy()
end

-- ANA GUI KATMANI
local sg = Instance.new("ScreenGui")
sg.Name = "YusufArda_Spin"
sg.Parent = PlayerGui
sg.IgnoreGuiInset = true

-- BUTON (Ekranın sol üstünde duracak, hata riskini azaltmak için frame koymadım)
local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0, 150, 0, 50)
btn.Position = UDim2.new(0.1, 0, 0.1, 0)
btn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
btn.Text = "BASLAT (Yusuf Arda)"
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.TextSize = 18
btn.Parent = sg

-- MANTIK
local aktif = false

btn.MouseButton1Click:Connect(function()
    aktif = not aktif
    if aktif then
        btn.Text = "DURDUR"
        btn.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
        
        -- Hızlı Döngü
        task.spawn(function()
            while aktif do
                -- 1. Çevir
                local net = ReplicatedStorage:FindFirstChild("Network")
                if net then
                    local rf = net:FindFirstChild("SpinnyWheel_RequestSpin")
                    if rf then
                        task.spawn(function() rf:InvokeServer("Spinny Wheel") end)
                    end
                end
                
                -- 2. Menüyü ve Onay Kutusunu Kapat (Saniyede 10 kez tarar)
                task.spawn(function()
                    -- Çark menüsünü kapat
                    local sw = PlayerGui:FindFirstChild("SpinnyWheel")
                    if sw then sw.Enabled = false end
                    
                    -- "Congratulations" (Lootview) kapat
                    local lv = PlayerGui:FindFirstChild("Lootview")
                    if lv and lv:FindFirstChild("Frame") and lv.Frame:FindFirstChild("Ok") then
                        lv.Frame.Ok.MouseButton1Click:Fire()
                    end
                end)
                
                task.wait(0.2) -- Hız ayarı (0.2 videodaki hıza en yakınıdır)
            end
        end)
    else
        btn.Text = "BASLAT (Yusuf Arda)"
        btn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
    end
end)
