-- PS99 Xeno Ultra Fast & No-Fail Script
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Network = ReplicatedStorage:WaitForChild("Network")

-- AYARLAR (Python'daki gibi milisaniye cinsinden)
local SPIN_DELAY = 0.10 -- Spin sonrası bekleme
local CANCEL_DELAY = 0.15 -- İptal (F/X) sonrası bekleme

_G.Running = true -- Durdurmak istersen false yaparsın

print("Yusuf Arda Xeno Script Baslatildi!")

task.spawn(function()
    while _G.Running do
        -- 1. ADIM: Sunucuya "Spin At" emri gönder (Koordinat derdi yok!)
        local rf = Network:FindFirstChild("SpinnyWheel_RequestSpin")
        if rf then
            task.spawn(function() rf:InvokeServer("Spinny Wheel") end)
        end
        
        task.wait(SPIN_DELAY)
        
        -- 2. ADIM: Menüleri ve Animasyonları Saniyede 20 Kez Kapat (Spam)
        task.spawn(function()
            -- Çark Menüsü (X basma efektini simüle eder)
            local sw = PlayerGui:FindFirstChild("SpinnyWheel")
            if sw then sw.Enabled = false end
            
            -- Ödül Ekranı (OK butonunu otomatik onaylar)
            local lv = PlayerGui:FindFirstChild("Lootview")
            if lv and lv:FindFirstChild("Frame") and lv.Frame:FindFirstChild("Ok") then
                -- Butona basma sinyali gönderir
                local okBtn = lv.Frame.Ok
                for i = 1, 5 do -- 5 kez spamla
                    okBtn.MouseButton1Click:Fire()
                end
            end
        end)
        
        task.wait(CANCEL_DELAY)
        
        -- 3. ADIM: Bir sonraki tur için kısa es
        task.wait(0.5) 
    end
end)
