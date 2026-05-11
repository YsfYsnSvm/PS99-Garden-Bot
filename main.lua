-- PS99 Ultra Force Script
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Network = ReplicatedStorage:WaitForChild("Network")
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- DURDURMAK İÇİN: _G.Durdur = true yazıp tekrar execute et
_G.Durdur = false

print("Yusuf Arda Force Script Yuklendi!")

task.spawn(function()
    while task.wait(0.1) do -- Hız ayarı (0.1 = Saniyede 10 deneme)
        if _G.Durdur then break end
        
        -- 1. ADIM: SPIN AT (Sinyali direkt gönder)
        pcall(function()
            Network.SpinnyWheel_RequestSpin:InvokeServer("Spinny Wheel")
        end)

        -- 2. ADIM: EKRANDAKİ TÜM UI'LARI TEMİZLE (Spam)
        -- Bu döngü ekrandaki "Ok" butonlarını bulur ve tıklar
        for _, v in pairs(PlayerGui:GetDescendants()) do
            if v:IsA("TextButton") and (v.Text == "Ok" or v.Name == "Ok") then
                -- Butona basma sinyalini 3 kez spamla
                for i = 1, 3 do
                    v.MouseButton1Click:Fire()
                end
            end
        end

        -- 3. ADIM: MENÜYÜ GÖRÜNMEZ YAP (Hız kazandırır)
        local sw = PlayerGui:FindFirstChild("SpinnyWheel")
        if sw then 
            sw.Enabled = false 
        end
        
        -- Ekstra: LootView (Ödül ekranı) takılırsa onu da gizle
        local lv = PlayerGui:FindFirstChild("Lootview")
        if lv then 
            lv.Enabled = false 
        end
    end
end)
