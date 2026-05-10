-- PS99 Spin Bot v2 by Yusuf Arda
local running = false
local Network = game:GetService("ReplicatedStorage"):WaitForChild("Network")

-- [GUI KODU AYNI KALIYOR, SADECE MANTIK KISMINI GÜNCELLEDİM]
-- ... (Yukarıdaki GUI tasarımı kısmını buraya dahil edebilirsin) ...

StartBtn.MouseButton1Click:Connect(function()
    running = not running
    if running then
        StartBtn.Text = "DURDUR"
        StartBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
        
        task.spawn(function()
            while running do
                Status.Text = "Komutlar gonderiliyor..."
                
                -- PS99'un kullandığı tüm olası isimleri aynı anda deniyoruz
                local remotes = {
                    "SpinnyWheel_RequestSpin",
                    "Spinny Wheel: Request Spin",
                    "SpinnyWheel: Request Spin",
                    "SpinnyWheel_Spin"
                }
                
                for _, remoteName in pairs(remotes) do
                    local remote = Network:FindFirstChild(remoteName)
                    if remote then
                        pcall(function()
                            if remote:IsA("RemoteFunction") then
                                remote:InvokeServer("Spinny Wheel")
                            else
                                remote:FireServer("Spinny Wheel")
                            end
                        end)
                    end
                end
                
                Status.Text = "Döngü Aktif"
                task.wait(2) -- Sunucudan atılmamak için güvenli süre
            end
        end)
    else
        StartBtn.Text = "CEVIRMEYE BASLA"
        StartBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        Status.Text = "Durduruldu."
    end
end)
