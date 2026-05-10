-- PS99 ULTRA INSTANT GARDEN
local Network = game:GetService("ReplicatedStorage"):WaitForChild("Network")

local SEED = "Diamond Seed"
local CAPSULE = "Insta-Plant Capsule"

print("Sistem Yuklendi! Hiz: Maksimum")

while true do
    for i = 1, 30 do
        task.spawn(function()
            -- Bu 3 komut saniyenin onda biri hizinda sunucuya gider
            Network:FindFirstChild("Garden: Plant"):FireServer(i, SEED)
            Network:FindFirstChild("Garden: Use Capsule"):FireServer(i, CAPSULE)
            Network:FindFirstChild("Garden: Claim"):FireServer(i)
        end)
    end
    task.wait(0.1) 
end
