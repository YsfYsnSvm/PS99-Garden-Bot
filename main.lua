-- PS99 Ultra Fast Spin by Yusuf Arda
local Network = game:GetService("ReplicatedStorage"):WaitForChild("Network")
local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local running = false

-- [GUI Tasarımı Buraya]
-- ... (Senin mevcut menü kodun) ...

-- DOĞRU KOMUTU BULAN FONKSİYON
local function getSpinRemote()
    -- En yaygın kullanılan isimleri tek tek denetler
    local names = {"SpinnyWheel_RequestSpin", "Spinny Wheel: Request Spin", "SpinnyWheel: Request", "RequestSpin"}
    for _, name in pairs(names) do
        if Network:FindFirstChild(name) then
            return Network[name]
        end
    end
    return nil
end

StartBtn.MouseButton1Click:Connect(function()
    running = not running
    if running then
        StartBtn.Text = "DURDUR"
        StartBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
        
        task.spawn(function()
            while running do
                local remote = getSpinRemote()
                
                if remote then
                    -- 1. ADIM: SPIN (Videonun başı)
                    pcall(function()
                        if remote:IsA("RemoteFunction") then
                            remote:InvokeServer("Spinny Wheel")
                        else
                            remote:FireServer("Spinny Wheel")
                        end
                    end)
                    
                    -- 2. ADIM: MENÜYÜ KAPAT (Çarpıya basma animasyonu)
                    for _, guiName in pairs({"SpinnyWheel", "SpinnyWheelGui", "WheelGui"}) do
                        local gui = PlayerGui:FindFirstChild(guiName)
                        if gui then gui.Enabled = false end
                    end

                    -- 3. ADIM: OK BUTONUNA BAS (Congratulations ekranı)
                    task.delay(0.1, function()
                        local loot = PlayerGui:FindFirstChild("Lootview") or PlayerGui:FindFirstChild("Message")
                        if loot and loot:FindFirstChild("Frame") and loot.Frame:FindFirstChild("Ok") then
                            loot.Frame.Ok.MouseButton1Click:Fire()
                        end
                    end)
                    
                    Status.Text = "BASARILI!"
                else
                    Status.Text = "KOMUT BULUNAMADI!"
                end
                
                task.wait(0.3) -- Videodaki ışık hızı
            end
        end)
    else
        StartBtn.Text = "CEVIRMEYE BASLA"
        StartBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        Status.Text = "Durduruldu."
    end
end)
