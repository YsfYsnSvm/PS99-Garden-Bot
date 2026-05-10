-- PS99 Ultra Fast Spin (Animation Cancel Edition)
-- Created by Yusuf Arda

local Network = game:GetService("ReplicatedStorage"):WaitForChild("Network")
local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local running = false

-- [GUI Tasarımı Buraya Gelecek - Senin Mevcut Menün]

StartBtn.MouseButton1Click:Connect(function()
    running = not running
    if running then
        StartBtn.Text = "DURDUR"
        StartBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
        
        task.spawn(function()
            while running do
                -- 1. ADIM: ÇARKI ÇEVİR (SPIN)
                pcall(function()
                    Network:WaitForChild("SpinnyWheel_RequestSpin"):InvokeServer("Spinny Wheel")
                end)
                
                -- 2. ADIM: ANİMASYONU İPTAL ET (Menüyü Kapatarak)
                -- Çark menüsünü saniyesinde kapatır ki animasyon oynayamasın
                task.spawn(function()
                    local wheelGui = PlayerGui:FindFirstChild("SpinnyWheel")
                    if wheelGui then
                        -- Menüyü kapatma komutu (Çarpı tuşu işlevi)
                        wheelGui.Enabled = false 
                    end
                end)

                -- 3. ADIM: ÖDÜLÜ ONAYLA (OK BUTONU)
                -- "Congratulations" ekranını saniyesinde geçer
                task.spawn(function()
                    task.wait(0.1) -- Sunucunun ödülü tanımlaması için çok kısa bir an
                    local lootGui = PlayerGui:FindFirstChild("Lootview") or PlayerGui:FindFirstChild("Message")
                    if lootGui then
                        pcall(function()
                            -- Ok butonuna direkt sinyal gönderir
                            if lootGui:FindFirstChild("Frame") and lootGui.Frame:FindFirstChild("Ok") then
                                lootGui.Frame.Ok.MouseButton1Click:Fire()
                            end
                        end)
                    end
                end)

                Status.Text = "HIZLI CEVIRIM AKTIF!"
                task.wait(0.3) -- Videodaki o seri hızı sağlayan bekleme süresi
            end
        end)
    else
        StartBtn.Text = "CEVIRMEYE BASLA"
        StartBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        Status.Text = "Durduruldu."
    end
end)
