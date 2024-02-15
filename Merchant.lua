if game.PlaceId == 8737899170 then

    local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

    local Window = Rayfield:CreateWindow({
        Name = "PS99 Auto Buy Merchants",
        LoadingTitle = "Rayfield Interface Suite",
        LoadingSubtitle = "by latest_version",
        ConfigurationSaving = {
           Enabled = false,
           FolderName = nil, -- Create a custom folder for your hub/game
           FileName = "PS99Merchant Hub"
        }
     })

     local MainTab = Window:CreateTab("👼Main", nil) -- Title, Image
     local MainSection = MainTab:CreateSection("Main")

     local Toggle = MainTab:CreateToggle({

        Name = "Enabled",
        Enabled = false,
        Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
        Callback = function()
            if Enabled == true then
                Enabled = false
            else
                Enabled = true
            end

            local MerchantUpdated = game:GetService("ReplicatedStorage"):FindFirstChild("Network"):FindFirstChild("Merchant_Updated")



            local players = game:GetService("Players")
            local player = players.LocalPlayer
            local lastPlayerPosition = nil

            local isTeleporting = false

            local MerchantsToBuy = {
                ["RegularMerchant"] = {
                    Name = "RegularMerchant",
                    Pos = CFrame.new(371.919037, 15.3389559, 553.50293, -0.969565988, -7.4697887e-08, -0.244830087, -6.87696939e-08, 1, -3.27620242e-08, 0.244830087, -1.49280552e-08, -0.969565988)
                },
                
                ["AdvancedMerchant"] = {
                    Name = "AdvancedMerchant",
                    Pos = CFrame.new(818.493042, 15.6741753, 1541.24963, -0.995888293, -1.0040635e-08, 0.0905898213, -9.26555987e-09, 1, 8.97642316e-09, -0.0905898213, 8.10014988e-09, -0.995888293)
                }
            }
            for i = 1, 6 do
                for ItemAmount2 = 1, 4 do
                    if isTeleporting == false then
                        isTeleporting = true
                            
                        -- Save current position
                        lastPlayerPosition = player.Character.PrimaryPart.CFrame

                        -- Regular Merchant
                        player.Character:SetPrimaryPartCFrame(MerchantsToBuy["RegularMerchant"].Pos)
                        task.wait(1)
                        requestPurchase(MerchantsToBuy["RegularMerchant"].Name)
                        task.wait(1)

                        -- Advanced Merchant
                        player.Character:SetPrimaryPartCFrame(MerchantsToBuy["AdvancedMerchant"].Pos)
                        task.wait(1)
                        requestPurchase(MerchantsToBuy["AdvancedMerchant"].Name)
                        task.wait(1)

                        -- Teleport to previous position
                        player.Character:SetPrimaryPartCFrame(lastPlayerPosition)
                        isTeleporting = false
                    end
                end
            end


            local function requestPurchase(merchant)
                for i = 1, 6, 1 do
                    for ItemAmount = 1, 4 do
                        game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Merchant_RequestPurchase"):InvokeServer(merchant, i)
                        task.wait(0.1)
                    end
                end

            MerchantUpdated.OnClientEvent:Connect(function()
                if not Enabled then return end
                if isTeleporting == false then
                    isTeleporting = true
                        
                    -- Save current position
                    lastPlayerPosition = player.Character.PrimaryPart.CFrame

                    -- Regular Merchant
                    player.Character:SetPrimaryPartCFrame(MerchantsToBuy["RegularMerchant"].Pos)
                    task.wait(1)
                    requestPurchase(MerchantsToBuy["RegularMerchant"].Name)
                    task.wait(1)

                    -- Advanced Merchant
                    player.Character:SetPrimaryPartCFrame(MerchantsToBuy["AdvancedMerchant"].Pos)
                    task.wait(1)
                    requestPurchase(MerchantsToBuy["AdvancedMerchant"].Name)
                    task.wait(1)

                    -- Teleport to previous position
                    player.Character:SetPrimaryPartCFrame(lastPlayerPosition)
                    isTeleporting = false
                end
            end)
        end,
     })
end
