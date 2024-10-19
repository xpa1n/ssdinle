local version = "v2.5.2"

repeat task.wait() until game:IsLoaded()
repeat task.wait() until game.Workspace:FindFirstChild(game.Players.LocalPlayer.Name)
repeat task.wait() until game:GetService("ReplicatedStorage"):FindFirstChild("ReplicatedStorage"):FindFirstChild("Packages"):FindFirstChild("Knit")

------Save Configuration------
------------------------------
local a = 'Janina' -- 
local b = game:GetService('Players').LocalPlayer.Name .. '_ElementalDungeon.json' 
Settings = {}
function saveSettings()
    local HttpService = game:GetService('HttpService')
    if not isfolder(a) then
        makefolder(a)
    end
    writefile(a .. '/' .. b, HttpService:JSONEncode(Settings))
    Settings = ReadSetting()
    warn("Settings Saved!")
end
function ReadSetting()
    local s, e = pcall(function()
        local HttpService = game:GetService('HttpService')
        if not isfolder(a) then
            makefolder(a)
        end
        return HttpService:JSONDecode(readfile(a .. '/' .. b))
    end)
    if s then
        return e
    else
        saveSettings()
        return ReadSetting()
    end
end
Settings = ReadSetting()
------------------------------
------------------------------

function MainScript()
    local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/xpa1n/library/main/FluentLibrary.lua"))()

    local Window = Fluent:CreateWindow({
        Title = "「Janina 中心 | 元素地牢」",
        SubTitle = version,
        TabWidth = 160,
        Size = UDim2.fromOffset(580, 460),
        Acrylic = true, -- The blur may be detectable, setting this to false disables blur entirely
        Theme = "Dark",
        MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
    })

    --Fluent provides Lucide Icons https://lucide.dev/icons/ for the tabs, icons are optional
    local Tabs = {
        dungeon = Window:AddTab({ Title = "地牢", Icon = "swords" }),
        mastery = Window:AddTab({ Title = "精通", Icon = "star" }),
        lobby = Window:AddTab({ Title = "大厅", Icon = "users" }),
        autoselltab = Window:AddTab({ Title = "自动销售", Icon = "dollar-sign" }),
        misc = Window:AddTab({ Title = "杂项", Icon = "chevron-right" }),
        credits = Window:AddTab({ Title = "学分", Icon = "info" }),
        Settings = Window:AddTab({ Title = "界面设置", Icon = "settings" })
    }
    
    do
        print("Loading Script (2)")

        local RunService = game:GetService("RunService")

        local dungeonsettings = Tabs.dungeon:AddSection("地下城设置")

        dungeonsettings:AddParagraph({Title = "在杂项选项卡中启用“自动加载”以实现自动加载！"})
    
        local AutoNextDungeonToggle = dungeonsettings:AddToggle("AutoNextDungeon", {Title = "自动切换难度", Default = Settings.AutoNextDungeon or false })

        AutoNextDungeonToggle:OnChanged(function()
            Settings.AutoNextDungeon = AutoNextDungeonToggle.Value
            saveSettings()
        end)
        
        coroutine.resume(coroutine.create(function()
            while task.wait() do
                if Settings.AutoNextDungeon and (Settings.AutoRetry == false or Settings.AutoRetry == nil) then
                    autonextdungeonfunction()
                end
            end
        end))

        coroutine.resume(coroutine.create(function()
            while task.wait() do
                if game.PlaceId == 10515146389 then
                    if Settings.AutoNextDungeon and Settings.AutoRetry then
                        autonextdungeonfunction()
                    end
                end
            end
        end))

        function autonextdungeonfunction()
            wait(5)
            if Settings.AutoRetry == false or Settings.AutoRetry == nil then
                if game:GetService("Players").LocalPlayer.PlayerGui.DungeonComplete.Main.Visible == true then
                    wait(2)
                    local args = {[1] = game:GetService("Players").LocalPlayer}
                    game:GetService("ReplicatedStorage").ReplicatedStorage.Packages.Knit.Services.DungeonService.RF.TeleportToLobby:InvokeServer(unpack(args))
                end
            end
            pcall(function()
                local playerGui = game:GetService("Players").LocalPlayer.PlayerGui
                local levelLabel = playerGui.Main.PlayerBar.LevelLabel
                
                local levelText = levelLabel.Text
                local level = tonumber(string.match(levelText, "%d+"))
                
                if level then
                        if level >= 0 and level <= 4 then
                            local args = {[1] = "BeginnersDungeon",[2] = "Medium",[3] = "Private",[4] = "Normal"}                    
                            game:GetService("ReplicatedStorage").ReplicatedStorage.Packages.Knit.Services.PartyService.RF.CreateParty:InvokeServer(unpack(args))                    
                        elseif level >= 5 and level <= 14 then
                            local args = {[1] = "BeginnersDungeon",[2] = "Hard",[3] = "Private",[4] = "Normal"}                    
                            game:GetService("ReplicatedStorage").ReplicatedStorage.Packages.Knit.Services.PartyService.RF.CreateParty:InvokeServer(unpack(args))                                    
                        elseif level >= 15 and level <= 34 then
                            local args = {[1] = "BeginnersDungeon",[2] = "Hell",[3] = "Private",[4] = "Normal"}                    
                            game:GetService("ReplicatedStorage").ReplicatedStorage.Packages.Knit.Services.PartyService.RF.CreateParty:InvokeServer(unpack(args))
                        elseif level >= 35 and level <= 39 then
                            local args = {[1] = "JungleDungeon",[2] = "Medium",[3] = "Private",[4] = "Normal"}                    
                            game:GetService("ReplicatedStorage").ReplicatedStorage.Packages.Knit.Services.PartyService.RF.CreateParty:InvokeServer(unpack(args))
                        elseif level >= 40 and level <= 49 then
                            local args = {[1] = "JungleDungeon",[2] = "Hard",[3] = "Private",[4] = "Normal"}                    
                            game:GetService("ReplicatedStorage").ReplicatedStorage.Packages.Knit.Services.PartyService.RF.CreateParty:InvokeServer(unpack(args))
                        elseif level >= 50 and level <= 69 then
                            local args = {[1] = "JungleDungeon",[2] = "Hell",[3] = "Private",[4] = "Normal"}                    
                            game:GetService("ReplicatedStorage").ReplicatedStorage.Packages.Knit.Services.PartyService.RF.CreateParty:InvokeServer(unpack(args))
                        elseif level >= 70 and level <= 79 then
                            local args = {[1] = "ArcticBastionDungeon",[2] = "Easy",[3] = "Private",[4] = "Normal"}                    
                            game:GetService("ReplicatedStorage").ReplicatedStorage.Packages.Knit.Services.PartyService.RF.CreateParty:InvokeServer(unpack(args))
                        elseif level >= 80 and level <= 89 then
                            local args = {[1] = "ArcticBastionDungeon",[2] = "Medium",[3] = "Private",[4] = "Normal"}                    
                            game:GetService("ReplicatedStorage").ReplicatedStorage.Packages.Knit.Services.PartyService.RF.CreateParty:InvokeServer(unpack(args))
                        elseif level >= 90 and level <= 99 then                            
                            local args = {[1] = "ArcticBastionDungeon",[2] = "Hard",[3] = "Private",[4] = "Normal"}                 
                            game:GetService("ReplicatedStorage").ReplicatedStorage.Packages.Knit.Services.PartyService.RF.CreateParty:InvokeServer(unpack(args))
                        elseif level >= 100 and level <= 114 then                               
                            local args = {[1] = "ArcticBastionDungeon",[2] = "Hell",[3] = "Private",[4] = "Normal"}                    
                            game:GetService("ReplicatedStorage").ReplicatedStorage.Packages.Knit.Services.PartyService.RF.CreateParty:InvokeServer(unpack(args))
                        elseif level >= 115 and level <= 124 then                               
                            local args = {[1] = "UnderwaterDungeon",[2] = "Easy",[3] = "Private",[4] = "Normal"}                    
                            game:GetService("ReplicatedStorage").ReplicatedStorage.Packages.Knit.Services.PartyService.RF.CreateParty:InvokeServer(unpack(args))
                        elseif level >= 125 and level <= 134 then                   
                            local args = {[1] = "UnderwaterDungeon",[2] = "Medium",[3] = "Private",[4] = "Normal"}                    
                            game:GetService("ReplicatedStorage").ReplicatedStorage.Packages.Knit.Services.PartyService.RF.CreateParty:InvokeServer(unpack(args))
                        elseif level >= 135 and level <= 144 then                               
                            local args = {[1] = "UnderwaterDungeon",[2] = "Hard",[3] = "Private",[4] = "Normal"}                    
                            game:GetService("ReplicatedStorage").ReplicatedStorage.Packages.Knit.Services.PartyService.RF.CreateParty:InvokeServer(unpack(args))
                        elseif level >= 145 and level <= 159 then                               
                            local args = {[1] = "UnderwaterDungeon",[2] = "Hell",[3] = "Private",[4] = "Normal"}                    
                            game:GetService("ReplicatedStorage").ReplicatedStorage.Packages.Knit.Services.PartyService.RF.CreateParty:InvokeServer(unpack(args))
                        elseif level >= 160 and level <= 169 then  
                            local args = {[1] = "FireDungeon",[2] = "Easy",[3] = "Private",[4] = "Normal"}                    
                            game:GetService("ReplicatedStorage").ReplicatedStorage.Packages.Knit.Services.PartyService.RF.CreateParty:InvokeServer(unpack(args))
                        elseif level >= 170 and level <= 179 then
                            local args = {[1] = "FireDungeon",[2] = "Medium",[3] = "Private",[4] = "Normal"}                    
                            game:GetService("ReplicatedStorage").ReplicatedStorage.Packages.Knit.Services.PartyService.RF.CreateParty:InvokeServer(unpack(args))
                        elseif level >= 180 and level <= 189 then
                            local args = {[1] = "FireDungeon",[2] = "Hard",[3] = "Private",[4] = "Normal"}                    
                            game:GetService("ReplicatedStorage").ReplicatedStorage.Packages.Knit.Services.PartyService.RF.CreateParty:InvokeServer(unpack(args))
                        elseif level >= 190 and level <= 199 then
                            local args = {[1] = "FireDungeon",[2] = "Hell",[3] = "Private",[4] = "Normal"}                    
                            game:GetService("ReplicatedStorage").ReplicatedStorage.Packages.Knit.Services.PartyService.RF.CreateParty:InvokeServer(unpack(args))
                        elseif level >= 200 and level <= 209 then           
                            local args = {[1] = "CloudDungeon",[2] = "Easy",[3] = "Private",[4] = "Normal"}
                            game:GetService("ReplicatedStorage").ReplicatedStorage.Packages.Knit.Services.PartyService.RF.CreateParty:InvokeServer(unpack(args))
                        elseif level >= 210 and level <= 219 then           
                            local args = {[1] = "CloudDungeon",[2] = "Medium",[3] = "Private",[4] = "Normal"}
                            game:GetService("ReplicatedStorage").ReplicatedStorage.Packages.Knit.Services.PartyService.RF.CreateParty:InvokeServer(unpack(args))
                        elseif level >= 220 and level <= 229 then           
                            local args = {[1] = "CloudDungeon",[2] = "Hard",[3] = "Private",[4] = "Normal"}
                            game:GetService("ReplicatedStorage").ReplicatedStorage.Packages.Knit.Services.PartyService.RF.CreateParty:InvokeServer(unpack(args))
                        elseif level >= 230 then           
                            local args = {[1] = "CloudDungeon",[2] = "Hell",[3] = "Private",[4] = "Normal"}
                            game:GetService("ReplicatedStorage").ReplicatedStorage.Packages.Knit.Services.PartyService.RF.CreateParty:InvokeServer(unpack(args))
                        else
                            print("Unknown level")
                        end
                    else
                end
                wait()
                local BUTTONPATH = game:GetService("Players").LocalPlayer.PlayerGui.Party.Main.AllStuffFrame.PartyMenu.Start
                if BUTTONPATH then
                    local connections = getconnections(BUTTONPATH.Activated)                        
                    for _, connection in pairs(connections) do
                        connection.Function(BUTTONPATH)
                    end
                else
                    warn("Button not found")
                end  
            end)
        end

        local DungeonNameDropdown = dungeonsettings:AddDropdown("DungeonName", {
            Title = "选择地牢",
            Values = {"BeginnersDungeon", "JungleDungeon", "ArcticBastionDungeon", "UnderwaterDungeon", "FireDungeon", "CloudDungeon"},
            Multi = false,
            Default = Settings.DungeonName or "",
        })
    
        DungeonNameDropdown:OnChanged(function(Value)
            Settings.DungeonName = Value
            saveSettings()
        end)
    
        local DungeonDifficultyDropdown = dungeonsettings:AddDropdown("DungeonDifficulty", {
            Title = "选择难度",
            Values = {"Easy", "Medium", "Hard", "Hell", "Hardcore", "Infinite"},
            Multi = false,
            Default = Settings.DungeonDifficulty or "",
        })
    
        DungeonDifficultyDropdown:OnChanged(function(Value)
            Settings.DungeonDifficulty = Value
            saveSettings()
        end)

        local AutoStartToggle = dungeonsettings:AddToggle("AutoStart", {Title = "自动农场选定的地牢", Default = Settings.AutoStart or false })

        AutoStartToggle:OnChanged(function()
            Settings.AutoStart = AutoStartToggle.Value
            saveSettings()
        end)

        coroutine.resume(coroutine.create(function()
            while task.wait() do
                if (Settings.AutoNextDungeon == false or Settings.AutoNextDungeon == nil) and (Settings.AutoRetry == false or Settings.AutoRetry == nil) and Settings.AutoStart then
                    autostartfunction() 
                end
            end
        end))

        function autostartfunction() 
            wait(5)
            if Settings.AutoRetry == false or Settings.AutoRetry == nil then
                if game:GetService("Players").LocalPlayer.PlayerGui.DungeonComplete.Main.Visible == true then
                    wait(2)
                    local args = {[1] = game:GetService("Players").LocalPlayer}
                    game:GetService("ReplicatedStorage").ReplicatedStorage.Packages.Knit.Services.DungeonService.RF.TeleportToLobby:InvokeServer(unpack(args))
                end
            end
            pcall(function()
                wait()
                local args = {
                    [1] = Settings.DungeonName,
                    [2] = Settings.DungeonDifficulty,
                    [3] = "Private",
                    [4] = "Normal"
                }                    
                game:GetService("ReplicatedStorage").ReplicatedStorage.Packages.Knit.Services.PartyService.RF.CreateParty:InvokeServer(unpack(args))
                wait()
    
                local BUTTONPATH = game:GetService("Players").LocalPlayer.PlayerGui.Party.Main.AllStuffFrame.PartyMenu.Start
                if BUTTONPATH then
                    local connections = getconnections(BUTTONPATH.Activated)                        
                    for _, connection in pairs(connections) do
                        connection.Function(BUTTONPATH)
                    end
                else
                    warn("Button not found")
                end                
          end)
        end
    
        coroutine.resume(coroutine.create(function()
            while task.wait() do
                if game.PlaceId == 10515146389 then
                    if Settings.AutoRetry and Settings.AutoStart and not Settings.AutoNextDungeon then
                        autostartfunction()
                    end
                end
            end
        end))

        local AutoRetryToggle = dungeonsettings:AddToggle("AutoRetry", {Title = "自动重试", Default = Settings.AutoRetry or false})

        AutoRetryToggle:OnChanged(function()
            Settings.AutoRetry = AutoRetryToggle.Value
            saveSettings()
        end)

        coroutine.resume(coroutine.create(function()
            while task.wait() do
                if Settings.AutoRetry then
                    if game.PlaceId ~= 10515146389 then
                        if game:GetService("Players").LocalPlayer.PlayerGui.DungeonComplete.Main.Visible == true then
                            wait(2)
                            local args = {[1] = "Retry"}
                            game:GetService("ReplicatedStorage").ReplicatedStorage.Packages.Knit.Services.PartyService.RF.VoteOn:InvokeServer(unpack(args))
                        end
                    end
                end
            end
        end))

        local AutoChallengeToggle = dungeonsettings:AddToggle("AutoChallenge", {Title = "自动挑战", Default = Settings.AutoChallenge or false})

        AutoChallengeToggle:OnChanged(function()
            Settings.AutoChallenge = AutoChallengeToggle.Value
            saveSettings()
        end)

        coroutine.resume(coroutine.create(function()
            while task.wait() do
                if Settings.AutoChallenge then
                    if game.PlaceId == 10515146389 then
                        local plr = game:GetService("Players")
                        local localplr = plr.LocalPlayer
    
                        local dungeons = {"BeginnersDungeon","JungleDungeon", "ArcticBastionDungeon", "UnderwaterDungeon", "FireDungeon"}
                        
                        for i,v in pairs(dungeons) do
                            local args = {[1] = v, [2] = "Nightmare", [3] = "Private", [4] = "Challenges"}
                            game:GetService("ReplicatedStorage").ReplicatedStorage.Packages.Knit.Services.PartyService.RF.CreateParty:InvokeServer(unpack(args))
                    
                            local BUTTONPATH = game:GetService("Players").LocalPlayer.PlayerGui.Party.Main.AllStuffFrame.PartyMenu.Start
                    
                            if BUTTONPATH then
                                local connections = getconnections(BUTTONPATH.Activated)                        
                                for _, connection in pairs(connections) do
                                    connection.Function(BUTTONPATH)
                                end
                            end 
                        end
    
    
                    else
                        if game:GetService("Players").LocalPlayer.PlayerGui.DungeonComplete.Main.Visible == true then
                            wait(2)
                            local args = {[1] = game:GetService("Players").LocalPlayer}
                            game:GetService("ReplicatedStorage").ReplicatedStorage.Packages.Knit.Services.DungeonService.RF.TeleportToLobby:InvokeServer(unpack(args))
                        end
                    end
                end
            end
        end))

        local autofarmsettings = Tabs.dungeon:AddSection("自动农场设置")

        local AutoFarmMobNearest = autofarmsettings:AddToggle("AutoFarmMobNearest", {Title = "自动地牢怪物（传送)", Default = Settings.Nearest or false})

        AutoFarmMobNearest:OnChanged(function()
            Settings.Nearest = AutoFarmMobNearest.Value
            saveSettings()
        end)

        coroutine.resume(coroutine.create(function()
            while task.wait() do
                if Settings.Nearest and game.PlaceId ~= 10515146389 then
                    AutoTeleportMob()
                end
            end
        end))

        local ggfarmmethod = Settings.FarmMethod or "Behind"
        local nearestNPC = nil
        local tweenspeed = Settings.Tween or 35
        local ggfarmstyle = Settings.FarmStyle or "Tween [Safer]"

        function AutoTeleportMob()
            pcall(function()
                if Settings.AutoHide == true then AutoHideee() end
                if Settings.AutoHeal then AutoHeal() end
                if Settings.AutoPickUp then AutoPickUpLoot() end

                AutoDodgeBossS()
                AutoDodgeBossR()

                local function findNearestNPC()
                    if nearestNPC and nearestNPC:FindFirstChild("HumanoidRootPart") and nearestNPC.Humanoid.Health > 0 then
                        -- If nearestNPC is already set and its HP is greater than 0, return it
                        return nearestNPC
                    end

                    local character = game.Players.LocalPlayer.Character
                    if not character then
                        return nil
                    end

                    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                    if not humanoidRootPart then
                        return nil
                    end

                    local mobsFolder = game:GetService("Workspace").Mobs
                    local shortestDistance = math.huge

                    -- Find the nearest NPC
                    for _, npc in pairs(mobsFolder:GetChildren()) do
                        if npc:IsA("Model") and npc:FindFirstChild('HumanoidRootPart') and npc.Humanoid.Health > 0 and npc.Name ~= "Dummy" then
                            if npc.HumanoidRootPart.Anchored ~= true then
                                local npcPosition = npc.HumanoidRootPart.Position
                                local playerPosition = humanoidRootPart.Position
                                local verticalDistance = npcPosition.Y - playerPosition.Y
                                
                                local distance = (npcPosition - playerPosition).Magnitude

                                if distance < shortestDistance then
                                    nearestNPC = npc -- Update the nearestNPC variable
                                    shortestDistance = distance
                                end
                            end
                        end
                    end

                    return nearestNPC
                end

                local nearestNPC = findNearestNPC()

                local player = game.Players.LocalPlayer
                local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
                
                local function MoveHumanoidRootPart(targetCFrame)
                    -- Calculate the distance between the current position and the target position
                    local currentPosition = humanoidRootPart.Position
                    local targetPosition = targetCFrame.Position
                    local distance = (targetPosition - currentPosition).Magnitude
                
                    -- Calculate the time based on the desired speed (e.g., 10 units per second)
                    local desiredSpeed = tweenspeed
                    local time = distance / desiredSpeed
                
                    -- Create a new TweenInfo with the calculated time
                    local tweenInfo = TweenInfo.new(
                        time,                   -- Duration based on distance and speed
                        Enum.EasingStyle.Linear,
                        Enum.EasingDirection.Out,
                        0,                      -- Repeat count (0 means no repeat)
                        false,                  -- Reverses (false means don't reverse)
                        0                       -- Delay between each step (optional)
                    )
                
                    local tween = game:GetService("TweenService"):Create(humanoidRootPart, tweenInfo, {CFrame = targetCFrame})
                    tween:Play()
                
                    tween.Completed:Connect(function()
                        tween:Destroy() -- Clean up the tween after it's completed
                    end)
                end
                
                if nearestNPC then
                    if humanoidRootPart and nearestNPC:FindFirstChild("HumanoidRootPart") then
                        local npcCFrame = nearestNPC.HumanoidRootPart.CFrame
                        local npcPosition = nearestNPC.PrimaryPart.Position
                        if nearestNPC:IsA("Model") and nearestNPC:FindFirstChild('HumanoidRootPart') and nearestNPC.Humanoid.Health > 0 then

                            if ggfarmstyle == "Tween [Safer]" then
                                if ggfarmmethod == "Behind" then
                                    local targetCFrame = npcCFrame * CFrame.new(0, 0, Settings.FarmDistance)
                                    MoveHumanoidRootPart(targetCFrame)
                                elseif ggfarmmethod == "Above" then
                                    local targetCFrame = npcCFrame * CFrame.new(0, Settings.FarmDistance, 0)
                                    MoveHumanoidRootPart(targetCFrame)
                                elseif ggfarmmethod == "Under" then
                                    local targetCFrame = npcCFrame * CFrame.new(0, -Settings.FarmDistance, 0)
                                    MoveHumanoidRootPart(targetCFrame)
                                end
                            end

                         if ggfarmstyle == "Teleport" then
                                if ggfarmmethod == "Behind" then
                                    humanoidRootPart.CFrame = npcCFrame * CFrame.new(0, 0, Settings.FarmDistance) -- Teleport with an offset of 7 units above the NPC

                                    local npcPosition = nearestNPC.PrimaryPart.Position
                                    local direction = (npcPosition - humanoidRootPart.Position).unit
                                    local rotation = CFrame.new(Vector3.new(), direction)
                                    humanoidRootPart.CFrame = CFrame.new(humanoidRootPart.Position) * rotation  
                                elseif ggfarmmethod == "Above" then 

                                    humanoidRootPart.CFrame = npcCFrame * CFrame.new(0, Settings.FarmDistance, 0) -- Teleport with an offset of 7 units above the NPC

                                    local npcPosition = nearestNPC.PrimaryPart.Position
                                    local direction = (npcPosition - humanoidRootPart.Position).unit
                                    local rotation = CFrame.new(Vector3.new(), direction)
                                    humanoidRootPart.CFrame = CFrame.new(humanoidRootPart.Position) * rotation
                                
                                elseif ggfarmmethod == "Under" then
                                    humanoidRootPart.CFrame = npcCFrame * CFrame.new(0, -Settings.FarmDistance, 0) -- Teleport with an offset of 7 units above the NPC
                                    local npcPosition = nearestNPC.PrimaryPart.Position
                                    local direction = (npcPosition - humanoidRootPart.Position).unit
                                    local rotation = CFrame.new(Vector3.new(), direction)
                                    humanoidRootPart.CFrame = CFrame.new(humanoidRootPart.Position) * rotation
                                end
                            end
                        end
                    end
                end
            end)
        end

        local mouseclick = autofarmsettings:AddToggle("mouseclick", {Title = "⚔️  打击怪物", Default = Settings.HitMobs or false})

        mouseclick:OnChanged(function()
            Settings.HitMobs = mouseclick.Value
            saveSettings()
        end)

        coroutine.resume(coroutine.create(function()
            while task.wait() do
                if Settings.HitMobs then
                    hitmobs()
                end
            end
        end))
    
        function hitmobs()
            pcall(function()
                local player = game:GetService("Players").LocalPlayer
                local backpack = player:FindFirstChild("Backpack")
                local mobs = workspace:FindFirstChild("Mobs")
                for x, d in pairs(backpack:GetChildren()) do
                    if d:IsA("Tool") and d:FindFirstChild("Handle") then
                        local button = game:service'VirtualInputManager'
                        button:SendKeyEvent(true, "One", false, game)
                    end
                end
    
                local user = game:GetService("VirtualUser")
                local player = game.Players.LocalPlayer
                local mouse = player:GetMouse()
                user:CaptureController()
                user:ClickButton1(Vector2.new(mouse.x,mouse.y))
            end)
        end

        local FarmStyleDropdown = autofarmsettings:AddDropdown("FarmStyleDropdown", {
            Title = "农场风格",
            Values = {"Tween [Safer]", "Teleport"},
            Multi = false,
            Default = ggfarmstyle,
        })
    
        FarmStyleDropdown:OnChanged(function(Value)
            Settings.FarmStyle = Value
            ggfarmstyle = Settings.FarmStyle
            saveSettings()
        end)

        local FarmMethodDropdown = autofarmsettings:AddDropdown("FarmMethodDropdown", {
            Title = "农场方法",
            Values = {"Behind [Best]","Above", "Under"},
            Multi = false,
            Default = ggfarmmethod,
        })
    
        FarmMethodDropdown:OnChanged(function(Value)
            Settings.FarmMethod = Value
            if Settings.FarmMethod == "Behind [Best]" then Settings.FarmMethod = "Behind" end
            ggfarmmethod = Settings.FarmMethod
            saveSettings()
        end)

        local ggfarmdistance = Settings.FarmDistance or 5

        local FarmDistanceSlider = autofarmsettings:AddSlider("FarmDistanceSlider", {
            Title = "自动农场距离",
            Default = ggfarmdistance,
            Min = 0,
            Max = 60,
            Rounding = 0,
            Callback = function(Value)
                Settings.FarmDistance = Value
                saveSettings()
                ggfarmdistance = Value
            end
        })

        local FarmSpeedSlider = autofarmsettings:AddSlider("FarmSpeedSlider", {
            Title = "农场速度",
            Default = tweenspeed,
            Min = 10,
            Max = 40,
            Rounding = 0,
            Callback = function(Value)
                Settings.Tween = Value
                saveSettings()
                tweenspeed = Settings.Tween
            end
        })
    
        local lootsettings = Tabs.dungeon:AddSection("拾取设置")

        local AutoPickUpLootToggle = lootsettings:AddToggle("AutoPickUpLootToggle", {Title = "⭐  自动拾取战利品", Default = Settings.AutoPickUp or false})

        AutoPickUpLootToggle:OnChanged(function()
            Settings.AutoPickUp = AutoPickUpLootToggle.Value
            saveSettings()
        end)

        coroutine.resume(coroutine.create(function()
            while task.wait() do
                if Settings.AutoPickUp and (Settings.Nearest == false or Settings.Nearest == nil) then
                    RunService.RenderStepped:wait()
                    AutoPickUpLoot()
                end
            end
        end))

        local IgnoreWhiteLoot = Tabs.dungeon:AddToggle("IgnoreWhiteLoot", {Title = "忽略普通战利品", Default = Settings.IgnoreWhite or false})

        IgnoreWhiteLoot:OnChanged(function()
            Settings.IgnoreWhite = IgnoreWhiteLoot.Value
            saveSettings()
        end)

        local IgnoreGreenLoot = Tabs.dungeon:AddToggle("IgnoreGreenLoot", {Title = "忽略普通战利品", Default = Settings.IgnoreGreen or false})

        IgnoreGreenLoot:OnChanged(function()
            Settings.IgnoreGreen = IgnoreGreenLoot.Value
            saveSettings()
        end)
        
        local IgnoreBlueLoot = Tabs.dungeon:AddToggle("IgnoreBlueLoot", {Title = "忽略稀有战利品", Default = Settings.IgnoreBlue or false})

        IgnoreBlueLoot:OnChanged(function()
            Settings.IgnoreBlue = IgnoreBlueLoot.Value
            saveSettings()
        end)

        function AutoPickUpLoot()
            pcall(function()
                local plr = game.Players.LocalPlayer
                local character = plr.Character
            
                if character and character:FindFirstChild("HumanoidRootPart") then
                    local humanoidRootPart = character.HumanoidRootPart
                    local inventory = game:GetService("Players").LocalPlayer.PlayerGui.Inventory.Main.InventoryFrame.ItemsStored.Text
            
                    for i, v in pairs(game:GetService("Workspace").Camera.Drops:GetChildren()) do
                        if v:IsA("Model") and v.Name == "Drop" and not v:FindFirstChild("Potion") then
                            if v:FindFirstChild("Center") then
                                if v.Center:FindFirstChild("ProximityPrompt") then
                                    if inventory ~= "75 / 75 Items Stored" and inventory ~= "100 / 100 Items Stored" and inventory ~= "125 / 125 Items Stored" then

                                        local color = game:GetService("Workspace").Camera.Drops.Drop.Center.A1.PointLight.Color

                                        local r = math.floor(color.R * 255)
                                        local g = math.floor(color.G * 255)
                                        local b = math.floor(color.B * 255)

                                        if r == 110 and g == 255 and b == 108 and (Settings.IgnoreGreen == nil or Settings.IgnoreGreen == false) then
                                            print("pick up green")
                                            humanoidRootPart.CFrame = v.Center.CFrame
                                            local start = tick()
                                            repeat humanoidRootPart.CFrame = v.Center.CFrame RunService.RenderStepped:wait() fireproximityprompt(v.Center.ProximityPrompt) until (tick() - start) >= 5 or not v.Center.ProximityPrompt.Enabled
                                        elseif r == 111 and g == 241 and b == 255 and (Settings.IgnoreBlue == nil or Settings.IgnoreBlue == false) then
                                            print("pick up blue")
                                            humanoidRootPart.CFrame = v.Center.CFrame
                                            local start = tick()
                                            repeat humanoidRootPart.CFrame = v.Center.CFrame RunService.RenderStepped:wait() fireproximityprompt(v.Center.ProximityPrompt) until (tick() - start) >= 5 or not v.Center.ProximityPrompt.Enabled
                                        elseif r == 255 and g == 240 and b == 246 and (Settings.IgnoreWhite == nil or Settings.IgnoreWhite == false) then
                                            print("pick up white")
                                            humanoidRootPart.CFrame = v.Center.CFrame
                                            local start = tick()
                                            repeat humanoidRootPart.CFrame = v.Center.CFrame RunService.RenderStepped:wait() fireproximityprompt(v.Center.ProximityPrompt) until (tick() - start) >= 5 or not v.Center.ProximityPrompt.Enabled
                                        else
                                            if not ((r == 110 and g == 255 and b == 108) or (r == 111 and g == 241 and b == 255) or (r == 255 and g == 240 and b == 246) or (r == 255 and g == 0 and b == 0)) then
                                                print("pick up other")
                                                humanoidRootPart.CFrame = v.Center.CFrame
                                                local start = tick()
                                                repeat 
                                                    humanoidRootPart.CFrame = v.Center.CFrame 
                                                    RunService.RenderStepped:wait() 
                                                    fireproximityprompt(v.Center.ProximityPrompt) 
                                                until (tick() - start) >= 5 or not v.Center.ProximityPrompt.Enabled
                                            end
                                        end                                                                                                                                                                                    
                                    end
                                end
                            end
                        end
                    end
                end
            end)
        end

        local healsettings = Tabs.dungeon:AddSection("治疗设置")

        local gghealhp = Settings.Healer or 40

        local AutoHealToggle = healsettings:AddToggle("AutoHealToggle", {Title = "❤️ 自动治疗（拾取药剂并使用）", Default = Settings.AutoHeal or false})

        AutoHealToggle:OnChanged(function()
            Settings.AutoHeal = AutoHealToggle.Value
            saveSettings()
        end)

        coroutine.resume(coroutine.create(function()
            while task.wait() do
                if Settings.AutoHeal and (Settings.Nearest == false or Settings.Nearest == nil) then
                    AutoHeal()
                end
            end
        end))
    
        function AutoHeal()
            pcall(function()
                local plr = game.Players.LocalPlayer
                local character = plr.Character
                local amount = plr.PlayerGui.Main.PlayerBar.Main.PotionBar.Amount.Text
                local bar = game:GetService("Players").LocalPlayer.PlayerGui.Main.PlayerBar.Main.PotionBar
                if character and character:FindFirstChild("HumanoidRootPart") then
                    local humanoidRootPart = character.HumanoidRootPart
                    local inventory = game:GetService("Players").LocalPlayer.PlayerGui.Inventory.Main.InventoryFrame.ItemsStored.Text
                    for i, v in pairs(game:GetService("Workspace").Camera.Drops:GetChildren()) do
                        if v:IsA("Model") and v.Name == "Drop" and v:FindFirstChild("Potion") then
                            if v:FindFirstChild("Center") then
                                if v.Center:FindFirstChild("ProximityPrompt") then
                                    if amount == "2/2" and bar.Visible == true then
                                    else
                                            humanoidRootPart.CFrame = v.Center.CFrame
                                            local start = tick()
                                            repeat task.wait()
                                                humanoidRootPart.CFrame = v.Center.CFrame
                                                    fireproximityprompt(v.Center.ProximityPrompt)
                                            until (tick() - start) >= 5 or not v.Center.ProximityPrompt.Enabled
                                    end
                                end
                            end
                        end
                    end
                end
            end)
            pcall(function()
                local plr = game.Players.LocalPlayer
                local character = plr.Character
                local humanoid = character:FindFirstChild("Humanoid")
                local currentHealth = humanoid.Health
                local maxHealth = humanoid.MaxHealth
                local healthPercentage = currentHealth / maxHealth
                local HealHealth = gghealhp * 0.01
    
                if healthPercentage < HealHealth then
                    if game:GetService("Players").LocalPlayer.PlayerGui.Main.PlayerBar.Main.PotionBar.Visible then
                        game:GetService("ReplicatedStorage").ReplicatedStorage.Packages.Knit.Services.HealingService.RF.UseHeal:InvokeServer()
                    end
                end
            end)
        end

        local HealAtSlider = healsettings:AddSlider("HealAtSlider", {
            Title = "当HP低于（%）时治疗",
            Default = gghealhp,
            Min = 10,
            Max = 100,
            Rounding = 0,
            Callback = function(Value)
                Settings.Healer = Value
                saveSettings()
                gghealhp = Value
            end
        })

        local swordsettings = Tabs.dungeon:AddSection("剑设置")

        local AutoElementalizeBladeToggle = swordsettings:AddToggle("AutoElementalizeBladeToggle", {Title = "自动元素化刀（需要先购买)", Default = Settings.AutoElementalizeBlade or false})

        AutoElementalizeBladeToggle:OnChanged(function()
            Settings.AutoElementalizeBlade = AutoElementalizeBladeToggle.Value
            saveSettings()
        end)

        coroutine.resume(coroutine.create(function()
            while task.wait() do
                if Settings.AutoElementalizeBlade then
                    pcall(function()
                        for i,v in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
                            if v:IsA("Tool") and not v:FindFirstChild("Part") then
                                wait()
                                game:GetService("ReplicatedStorage").ReplicatedStorage.Packages.Knit.Services.WeaponService.RF.EnchantedBlade:InvokeServer()
                            end
                        end
                    end)
                end
            end
        end))

        local AutoUseSwordSkillToggle = swordsettings:AddToggle("AutoUseSwordSkillToggle", {Title = "自动使用剑技能", Default = Settings.AutoUseSwordSkill or false})

        AutoUseSwordSkillToggle:OnChanged(function()
            Settings.AutoUseSwordSkill = AutoUseSwordSkillToggle.Value
            saveSettings()
        end)

        coroutine.resume(coroutine.create(function()
            while task.wait() do
                if Settings.AutoUseSwordSkill then
                    pcall(function()
                        local player = game:GetService("Players").LocalPlayer
                        local mobs = workspace:FindFirstChild("Mobs")
                        for i,v in pairs(mobs:GetChildren()) do
                            if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0
                            and (player.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude < 50 then
                                local enemyCFrame = v.HumanoidRootPart.Position
                
                                if player then
                                    local args = {
                                        [1] = game:GetService("ReplicatedStorage").ReplicatedStorage.Abilities.Sword:FindFirstChild("Lightning Katana").PlasmaRay,
                                        [2] = {
                                            ["Direction"] = (enemyCFrame - player.Character.HumanoidRootPart.Position).Unit,
                                            ["Position"] = enemyCFrame,
                                            ["Origin"] = player.Character.HumanoidRootPart.Position
                                        }, [3] = "Start"
                                    }
                                                                                game:GetService("ReplicatedStorage").ReplicatedStorage.Abilities.Templates.ToolTemplate:FindFirstChild("RemoteEvent "):FireServer(unpack(args))
    
                                    local args = {
                                        [1] = game:GetService("ReplicatedStorage").ReplicatedStorage.Abilities.Sword:FindFirstChild("Lightning Katana").PlasmaRay,
                                        [2] = {
                                            ["Direction"] = (enemyCFrame - player.Character.HumanoidRootPart.Position).Unit,
                                            ["Position"] = enemyCFrame,
                                            ["Origin"] = player.Character.HumanoidRootPart.Position
                                        }, [3] = "End"
                                    }
                                                                                game:GetService("ReplicatedStorage").ReplicatedStorage.Abilities.Templates.ToolTemplate:FindFirstChild("RemoteEvent "):FireServer(unpack(args))
                                end
    
                                if player then
                                    local args = {
                                        [1] = game:GetService("ReplicatedStorage").ReplicatedStorage.Abilities.Sword:FindFirstChild("Poseidon's Trident").Throw,
                                        [2] = {
                                            ["Direction"] = (enemyCFrame - player.Character.HumanoidRootPart.Position).Unit,
                                            ["Position"] = enemyCFrame,
                                            ["Origin"] = player.Character.HumanoidRootPart.Position
                                        }, [3] = "Start"
                                    }
                                                                                game:GetService("ReplicatedStorage").ReplicatedStorage.Abilities.Templates.ToolTemplate:FindFirstChild("RemoteEvent "):FireServer(unpack(args))
    
                                    local args = {
                                        [1] = game:GetService("ReplicatedStorage").ReplicatedStorage.Abilities.Sword:FindFirstChild("Poseidon's Trident").Throw,
                                        [2] = {
                                            ["Direction"] = (enemyCFrame - player.Character.HumanoidRootPart.Position).Unit,
                                            ["Position"] = enemyCFrame,
                                            ["Origin"] = player.Character.HumanoidRootPart.Position
                                        }, [3] = "End"
                                    }
                                                                                game:GetService("ReplicatedStorage").ReplicatedStorage.Abilities.Templates.ToolTemplate:FindFirstChild("RemoteEvent "):FireServer(unpack(args))
                                end
                            end
                        end
                    end)
                    task.wait(0.5)
                end
            end
        end))

        local bosssettings = Tabs.dungeon:AddSection("老板设置")

        local AutoDodge1 = bosssettings:AddToggle("AutoDodge1", {Title = "自动闪避老板技能", Default = Settings.AutoDodgeSkill or false})

        AutoDodge1:OnChanged(function()
            Settings.AutoDodgeSkill = AutoDodge1.Value
            saveSettings()
        end)

        function AutoDodgeBossS()
            pcall(function() 
                while Settings.AutoDodgeSkill do
                    local char = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    local originalpos = CFrame.new(0,0,0)
                    originalpos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
    
                    local skillfolder = game:GetService("Workspace").Effects
                    while skillfolder:FindFirstChild("RedLines") or skillfolder:FindFirstChild("RedCircles") do
                        task.wait()
                        if char then
                        char.CFrame = CFrame.new(100, 100, 100)
                        end
                    end
                    if char then
                    char.CFrame = originalpos
                    end
                    break
                end
            end)
        end
    
        coroutine.resume(coroutine.create(function()
            while task.wait() do
                if (Settings.Nearest == false or Settings.Nearest == nil) then
                    AutoDodgeBossS()
                else
                    task.wait()
                end
            end
        end))

        local AutoDodge2 = bosssettings:AddToggle("AutoDodge2", {Title = "自动闪避老板愤怒", Default = Settings.AutoDodgeSkillRage or false})

        AutoDodge2:OnChanged(function()
            Settings.AutoDodgeSkillRage = AutoDodge2.Value
            saveSettings()
        end)
        
        function AutoDodgeBossR()
            pcall(function() 
                while Settings.AutoDodgeSkillRage do
                    local char = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    local originalpos = CFrame.new(0,0,0)
                    originalpos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame

                    local skillfolder = game:GetService("Workspace").Effects
                    while skillfolder:FindFirstChild("EngragedExplosion") do
                        task.wait()
                        if char then
                        char.CFrame = CFrame.new(100, 100, 100)
                        end
                    end
                    if char then
                    char.CFrame = originalpos
                    end
                    break
                end
            end)
        end

        coroutine.resume(coroutine.create(function()
            while task.wait() do
                if (Settings.Nearest == false or Settings.Nearest == nil) then
                    AutoDodgeBossR()
                else
                    task.wait()
                end
            end
        end))

        local antidie = Tabs.dungeon:AddSection("反死")

        local AutoHideToggle = antidie:AddToggle("AutoHideToggle", {Title = "反死（仅适用于硬核/无限地牢）", Default = Settings.AutoHide or false})

        AutoHideToggle:OnChanged(function()
            Settings.AutoHide = AutoHideToggle.Value
            saveSettings()
        end)

        coroutine.resume(coroutine.create(function()
            while task.wait() do
                if Settings.AutoHide == true and (Settings.Nearest == false or Settings.Nearest == nil) then 
                    AutoHideee()
                end
            end
        end))

        local gghidelow = Settings.HideLow or 25
        local ggshowup = Settings.ShowUP or 75
    
        function AutoHideee()
            pcall(function()
    
            local player = game.Players.LocalPlayer
            local character = player.Character
            local humanoid = character:WaitForChild("Humanoid")
            local humanoidrtp = character:WaitForChild("HumanoidRootPart")
    
            local originalPosition = humanoidrtp.CFrame
            local hasTeleported = false
    
                if Settings.AutoHide then
                    local healthPercentage = humanoid.Health / humanoid.MaxHealth
                    if healthPercentage < gghidelow * 0.01 then
                        hasTeleported = true
                        repeat
                            healthPercentage = humanoid.Health / humanoid.MaxHealth
                            humanoidrtp.CFrame = CFrame.new(Vector3.new(100, 100, 100))
                            task.wait()
                        until healthPercentage > ggshowup * 0.01
                    end
                    if healthPercentage > ggshowup * 0.01 and hasTeleported then
                        humanoidrtp.CFrame = originalPosition
                        hasTeleported = false
                    end
                end
            end)
        end

        local HideSlider = antidie:AddSlider("HideSlider", {
            Title = "当HP低于（%）时隐藏",
            Default = gghidelow,
            Min = 1,
            Max = 99,
            Rounding = 0,
            Callback = function(Value)
                Settings.HideLow = Value
                saveSettings()
                gghidelow = Value
            end
        })

        local HideShowSlider = antidie:AddSlider("HideShowSlider", {
            Title = "在（%）返回到自动农场",
            Default = ggshowup,
            Min = 1,
            Max = 99,
            Rounding = 0,
            Callback = function(Value)
                Settings.ShowUP = Value
                saveSettings()
                ggshowup = Value
            end
        })

        local infsettings = Tabs.dungeon:AddSection("无限")

        local Input = infsettings:AddInput("Input", {
            Title = "在“X”波重置",
            Default = Settings.Leaveatxwave,
            Placeholder = "输入波数",
            Numeric = true,
            Finished = true,
            Callback = function(Value)
                Settings.Leaveatxwave = Value
                saveSettings()
            end
        })

        local autoleaveatxwavetoggle = infsettings:AddToggle("autoleaveatxwavetoggle", {Title = "切换在“X”波重置", Default = Settings.leaveatwave or false})

        autoleaveatxwavetoggle:OnChanged(function()
            Settings.leaveatwave = autoleaveatxwavetoggle.Value
            saveSettings()
        end)

        coroutine.resume(coroutine.create(function() 
            while task.wait() do
                pcall(function()
                    if Settings.leaveatwave == true and game.PlaceId ~= 10515146389 then
                        local wave = game:GetService("Players").LocalPlayer.PlayerGui.Main.Timers.WaveLabel.Text
                        if string.find(wave, Settings.Leaveatxwave) then
                            player = game.Players.LocalPlayer
                            player.Character.Humanoid.Health = 0
                        end
                    end
                end)
            end
        end))

        local otherdungeonoptions = Tabs.dungeon:AddSection("其他")

        otherdungeonoptions:AddParagraph({Title = "只有在完成地牢后才能收集宝箱！"})

        otherdungeonoptions:AddButton({
            Title = "收集地牢宝箱",
            Callback = function()
                pcall(function()
                    local plr = game.Players.LocalPlayer.Character
                    local hrp = plr:FindFirstChild("HumanoidRootPart")
                    local camera = game.Workspace.CurrentCamera
                    local topDownViewCFrame = CFrame.new(Vector3.new(0, 100, 0), Vector3.new(0, 0, 0))
                    camera.CFrame = topDownViewCFrame
                    local desiredFieldOfView = 80 -- Adjust this value as needed
                    camera.FieldOfView = desiredFieldOfView
                    for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
                        if v.Name == "Gold Chest" or v.Name == "Loot Chest" or v.Name == "Rich Chest" and v:IsA("Model") and v:FindFirstChild("Primary") then
                            hrp.CFrame = v.Primary.CFrame
                            wait()
                            fireproximityprompt(v.Primary.ProximityPrompt)
                        end
                    end
                end)
            end
        })

        otherdungeonoptions:AddButton({
            Title = "传送到机会祭坛（如果可用）",
            Callback = function()
                pcall(function()
                    local plr = game.Players.LocalPlayer.Character
                    local hrp = plr:FindFirstChild("HumanoidRootPart")
                    for i, v in pairs(game:GetService("Workspace"):GetChildren()) do
                        if v.Name == "Chance Altar" and v:IsA("Model") then
                            if v:FindFirstChild("Primary") then
                                hrp.CFrame = v.Primary.CFrame
                            else
                                Fluent:Notify({Title = "Chance Altar Is Available but Didn't Spawn Yet!", Content = "", Duration = 4})
                            end
                            return  -- Exit the loop after processing the altar
                        end
                    end
                    Fluent:Notify({Title = "Chance Altar Is Not Available!", Content = "", Duration = 4})
                end)
            end
        })

        otherdungeonoptions:AddButton({
            Title = "传送到无限Boss祭坛（如果可用）",
            Callback = function()
                pcall(function()
                    local plr = game.Players.LocalPlayer.Character
                    local hrp = plr:FindFirstChild("HumanoidRootPart")
                    for i, v in pairs(game:GetService("Workspace"):GetChildren()) do
                        if v.Name == "Inf Boss Altar" and v:IsA("Model") then
                            if v:FindFirstChild("Primary") then
                                hrp.CFrame = v.Primary.CFrame
                            else
                                Fluent:Notify({Title = "无限Boss祭坛可用但尚未生成！", Content = "", Duration = 4})
                            end
                            return  -- Exit the loop after processing the altar
                        end
                    end
                    Fluent:Notify({Title = "无限Boss祭坛不可用！", Content = "", Duration = 4})
                end)
            end
        })

        local UseElementSkillsNormal = Tabs.mastery:AddSection("-- 技能 --")


            v1 = require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"))
            local u17 = v1.GetController("DataController"):GetReplica()

            local equippedelement
            local abilities
    
            for i,v in pairs(u17.Data.Main.EquippedItems.Elements) do
                if v then equippedelement = v end
            end
    
            if equippedelement == nil then 
                Tabs.mastery:AddParagraph({Title = "你没有元素！"})
                Tabs.mastery:AddParagraph({Title = "首先获得一个元素，然后重新加入/重新执行"})
            end

            if equippedelement ~= nil then 

                local AutoMasteryToggle = Tabs.mastery:AddToggle("AutoMastery", {Title = "⭐  自动使用所有技能", Default = Settings.Mastery or false})
        
                AutoMasteryToggle:OnChanged(function()
                    Settings.Mastery = AutoMasteryToggle.Value
                    saveSettings() 
                end)
        
                coroutine.resume(coroutine.create(function()
                    while task.wait() do
                        if Settings.Mastery then
                            AutoUseAbility()
                            task.wait(1)
                        end
                    end
                end))
            
                function AutoUseAbility()
                    pcall(function()
                        local player = game:GetService("Players").LocalPlayer
                        local mobs = workspace:FindFirstChild("Mobs")
                        for i,v in pairs(mobs:GetChildren()) do
                            if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0
                            and (player.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude < 50 then
                                local enemyCFrame = v.HumanoidRootPart.Position

                                v1 = require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"))
                                local u17 = v1.GetController("DataController"):GetReplica()
                                local equippedelement
                                for i,v in pairs(u17.Data.Main.EquippedItems.Elements) do
                                    equippedelement = v
                                end
            
                                if player then
                                    local abilitiesFolder = game:GetService("ReplicatedStorage").ReplicatedStorage.Abilities.Elements[equippedelement]
                                    if abilitiesFolder then
                                        ---not awakend abilities
                                        for _, v in pairs(abilitiesFolder:GetChildren()) do                        
                                            local args = {
                                                [1] = abilitiesFolder[v.Name],  -- Access element using elementName and v.Name
                                                [2] = {
                                                    ["Direction"] = (enemyCFrame - player.Character.HumanoidRootPart.Position).Unit,
                                                    ["Position"] = enemyCFrame,
                                                    ["Origin"] = player.Character.HumanoidRootPart.Position
                                                },
                                                [3] = "Start"
                                            }
                                            game:GetService("ReplicatedStorage").ReplicatedStorage.Abilities.Templates.ToolTemplate:FindFirstChild("RemoteEvent "):FireServer(unpack(args))
            
                                            if v.Name == "DragonsBreath" then
                                                wait(5)
                                            end
            
                                            local args = {
                                                [1] = abilitiesFolder[v.Name],  -- Access element using elementName and v.Name
                                                [2] = {
                                                    ["Direction"] = (enemyCFrame - player.Character.HumanoidRootPart.Position).Unit,
                                                    ["Position"] = enemyCFrame,
                                                    ["Origin"] = player.Character.HumanoidRootPart.Position
                                                },
                                                [3] = "End"
                                            }
                                            game:GetService("ReplicatedStorage").ReplicatedStorage.Abilities.Templates.ToolTemplate:FindFirstChild("RemoteEvent "):FireServer(unpack(args))
                                        end
                                    end
                                end
                            end
                        end
                    end)
                end
        
                local UseElementSkillsOr = Tabs.mastery:AddSection("Or")

                local abilitiesFolder = game:GetService("ReplicatedStorage").ReplicatedStorage.Abilities.Elements[equippedelement]:GetChildren()

                local holding = {"DragonsBreath", "GravityZone", "MeteorBarrage", "DeathQuake", "Supernova", "GalacticDestruction", "LightRay", "Lux", "LightBarrage"}

                if abilitiesFolder[1] and abilitiesFolder[1]:IsA("ModuleScript") then

                    local ability = abilitiesFolder[1].Name
                        
                    local SkillToggle1 = Tabs.mastery:AddToggle("SkillToggle1", {Title = "使用 " .. ability, Default = Settings["Skill" .. ability] or false})
        
                    SkillToggle1:OnChanged(function()
                        Settings["Skill" .. ability] = SkillToggle1.Value
                        saveSettings()
                    end)
    
                    coroutine.resume(coroutine.create(function()
                        while task.wait() do
                            if Settings["Skill" .. ability] then
                                pcall(function()
                                    local player = game:GetService("Players").LocalPlayer
                                    local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart") 
                                    local mobs = workspace:FindFirstChild("Mobs")
    
                                    if player and game.PlaceId ~= 10515146389 then
                                        for i,v in pairs(mobs:GetChildren()) do
                                            if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0
                                            and (player.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude < 50 then
                                                local enemyCFrame = v.HumanoidRootPart.Position
    
                                                local args = {
                                                    [1] = abilitiesFolder[1], 
                                                    [2] = {
                                                        ["Direction"] = (enemyCFrame - player.Character.HumanoidRootPart.Position).Unit,
                                                        ["Position"] = enemyCFrame,
                                                        ["Origin"] = player.Character.HumanoidRootPart.Position
                                                    }, [3] = "Start"}
                                                game:GetService("ReplicatedStorage").ReplicatedStorage.Abilities.Templates.ToolTemplate:FindFirstChild("RemoteEvent "):FireServer(unpack(args))
                                                
                                                for x, y in pairs(holding) do
                                                    if abilitiesFolder[1].Name == y then wait(5) end
                                                end
                                                
                                                local args = {
                                                    [1] = abilitiesFolder[1],  -- Access element using elementName and v.Name
                                                    [2] = {
                                                        ["Direction"] = (enemyCFrame - player.Character.HumanoidRootPart.Position).Unit,
                                                        ["Position"] = enemyCFrame,
                                                        ["Origin"] = player.Character.HumanoidRootPart.Position
                                                    }, [3] = "End"}
                                                game:GetService("ReplicatedStorage").ReplicatedStorage.Abilities.Templates.ToolTemplate:FindFirstChild("RemoteEvent "):FireServer(unpack(args))
                                            end
                                        end
                                    end
                                end)
                                task.wait(1)
                            end
                        end
                    end))
                end
    
                if abilitiesFolder[2] and abilitiesFolder[2]:IsA("ModuleScript") then
    
                    local ability = abilitiesFolder[2].Name
                        
                    local SkillToggle2 = Tabs.mastery:AddToggle("SkillToggle2", {Title = "使用 " .. ability, Default = Settings["Skill" .. ability] or false})
        
                    SkillToggle2:OnChanged(function()
                        Settings["Skill" .. ability] = SkillToggle2.Value
                        saveSettings()
                    end)
    
                    coroutine.resume(coroutine.create(function()
                        while task.wait() do
                            if Settings["Skill" .. ability] then
                            pcall(function()
                                    local player = game:GetService("Players").LocalPlayer
                                    local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart") 
                                    local mobs = workspace:FindFirstChild("Mobs")
    
                                    if player and game.PlaceId ~= 10515146389 then
                                        for i,v in pairs(mobs:GetChildren()) do
                                            if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0
                                            and (player.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude < 50 then
                                                local enemyCFrame = v.HumanoidRootPart.Position
                                                local args = {
                                                    [1] = abilitiesFolder[2], 
                                                    [2] = {
                                                        ["Direction"] = (enemyCFrame - player.Character.HumanoidRootPart.Position).Unit,
                                                        ["Position"] = enemyCFrame,
                                                        ["Origin"] = player.Character.HumanoidRootPart.Position
                                                    }, [3] = "Start"}
                                                game:GetService("ReplicatedStorage").ReplicatedStorage.Abilities.Templates.ToolTemplate:FindFirstChild("RemoteEvent "):FireServer(unpack(args))
                                                
                                                for x, y in pairs(holding) do
                                                    if abilitiesFolder[2].Name == y then wait(5) end
                                                end
                                                
                                                local args = {
                                                    [1] = abilitiesFolder[2],  -- Access element using elementName and v.Name
                                                    [2] = {
                                                        ["Direction"] = (enemyCFrame - player.Character.HumanoidRootPart.Position).Unit,
                                                        ["Position"] = enemyCFrame,
                                                        ["Origin"] = player.Character.HumanoidRootPart.Position
                                                    }, [3] = "End"}
                                                game:GetService("ReplicatedStorage").ReplicatedStorage.Abilities.Templates.ToolTemplate:FindFirstChild("RemoteEvent "):FireServer(unpack(args))
                                            end
                                        end
                                    end
                            end)
                                task.wait(1)
                            end
                        end
                    end))
                end
    
                if abilitiesFolder[3] and abilitiesFolder[3]:IsA("ModuleScript") then
    
                    local ability = abilitiesFolder[3].Name
                        
                    local SkillToggle3 = Tabs.mastery:AddToggle("SkillToggle3", {Title = "使用 " .. ability, Default = Settings["Skill" .. ability] or false})
        
                    SkillToggle3:OnChanged(function()
                        Settings["Skill" .. ability] = SkillToggle3.Value
                        saveSettings()
                    end)
    
                    coroutine.resume(coroutine.create(function()
                        while task.wait() do
                            if Settings["Skill" .. ability] then
                            pcall(function()
                                    local player = game:GetService("Players").LocalPlayer
                                    local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart") 
                                    local mobs = workspace:FindFirstChild("Mobs")
    
                                    if player and game.PlaceId ~= 10515146389 then
                                        for i,v in pairs(mobs:GetChildren()) do
                                            if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0
                                            and (player.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude < 50 then
                                                local enemyCFrame = v.HumanoidRootPart.Position
    
                                                local args = {
                                                    [1] = abilitiesFolder[3], 
                                                    [2] = {
                                                        ["Direction"] = (enemyCFrame - player.Character.HumanoidRootPart.Position).Unit,
                                                        ["Position"] = enemyCFrame,
                                                        ["Origin"] = player.Character.HumanoidRootPart.Position
                                                    }, [3] = "Start"}
                                                                                            game:GetService("ReplicatedStorage").ReplicatedStorage.Abilities.Templates.ToolTemplate:FindFirstChild("RemoteEvent "):FireServer(unpack(args))
                                                
                                                for x, y in pairs(holding) do
                                                    if abilitiesFolder[3].Name == y then wait(5) end
                                                end
                                                
                                                local args = {
                                                    [1] = abilitiesFolder[3],  -- Access element using elementName and v.Name
                                                    [2] = {
                                                        ["Direction"] = (enemyCFrame - player.Character.HumanoidRootPart.Position).Unit,
                                                        ["Position"] = enemyCFrame,
                                                        ["Origin"] = player.Character.HumanoidRootPart.Position
                                                    }, [3] = "End"}
                                                                                            game:GetService("ReplicatedStorage").ReplicatedStorage.Abilities.Templates.ToolTemplate:FindFirstChild("RemoteEvent "):FireServer(unpack(args))
                                            end
                                        end
                                    end
                            end)
                                task.wait(1)
                            end
                        end
                    end))
                end
    
                if abilitiesFolder[4] and abilitiesFolder[4]:IsA("ModuleScript") then
    
                    local ability = abilitiesFolder[4].Name
                        
                    local SkillToggle4 = Tabs.mastery:AddToggle("SkillToggle4", {Title = "使用 " .. ability, Default = Settings["Skill" .. ability] or false})
        
                    SkillToggle4:OnChanged(function()
                        Settings["Skill" .. ability] = SkillToggle4.Value
                        saveSettings()
                    end)
    
                    coroutine.resume(coroutine.create(function()
                        while task.wait() do
                            if Settings["Skill" .. ability] then
                            pcall(function()
                                    local player = game:GetService("Players").LocalPlayer
                                    local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart") 
                                    local mobs = workspace:FindFirstChild("Mobs")
    
                                    if player and game.PlaceId ~= 10515146389 then
                                        for i,v in pairs(mobs:GetChildren()) do
                                            if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0
                                            and (player.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude < 50 then
                                                local enemyCFrame = v.HumanoidRootPart.Position
    
                                                local args = {
                                                    [1] = abilitiesFolder[4], 
                                                    [2] = {
                                                        ["Direction"] = (enemyCFrame - player.Character.HumanoidRootPart.Position).Unit,
                                                        ["Position"] = enemyCFrame,
                                                        ["Origin"] = player.Character.HumanoidRootPart.Position
                                                    }, [3] = "Start"}
                                                                                            game:GetService("ReplicatedStorage").ReplicatedStorage.Abilities.Templates.ToolTemplate:FindFirstChild("RemoteEvent "):FireServer(unpack(args))
                                                
                                                for x, y in pairs(holding) do
                                                    if abilitiesFolder[4].Name == y then wait(5) end
                                                end
                                                
                                                local args = {
                                                    [1] = abilitiesFolder[4],  -- Access element using elementName and v.Name
                                                    [2] = {
                                                        ["Direction"] = (enemyCFrame - player.Character.HumanoidRootPart.Position).Unit,
                                                        ["Position"] = enemyCFrame,
                                                        ["Origin"] = player.Character.HumanoidRootPart.Position
                                                    }, [3] = "End"}
                                                                                            game:GetService("ReplicatedStorage").ReplicatedStorage.Abilities.Templates.ToolTemplate:FindFirstChild("RemoteEvent "):FireServer(unpack(args))
                                            end
                                        end
                                    end
                            end)
                                task.wait(1)
                            end
                        end
                    end))
                end
    
                if abilitiesFolder[5] and abilitiesFolder[5]:IsA("ModuleScript") then
    
                    local ability = abilitiesFolder[5].Name
                        
                    local SkillToggle5 = Tabs.mastery:AddToggle("SkillToggle5", {Title = "使用 " .. ability, Default = Settings["Skill" .. ability] or false})
        
                    SkillToggle5:OnChanged(function()
                        Settings["Skill" .. ability] = SkillToggle5.Value
                        saveSettings()
                    end)
    
                    coroutine.resume(coroutine.create(function()
                        while task.wait() do
                            if Settings["Skill" .. ability] then
                            pcall(function()
                                    local player = game:GetService("Players").LocalPlayer
                                    local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart") 
                                    local mobs = workspace:FindFirstChild("Mobs")
    
                                    if player and game.PlaceId ~= 10515146389 then
                                        for i,v in pairs(mobs:GetChildren()) do
                                            if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0
                                            and (player.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude < 50 then
                                                local enemyCFrame = v.HumanoidRootPart.Position
    
                                                
                                                local args = {
                                                    [1] = abilitiesFolder[5], 
                                                    [2] = {
                                                        ["Direction"] = (enemyCFrame - player.Character.HumanoidRootPart.Position).Unit,
                                                        ["Position"] = enemyCFrame,
                                                        ["Origin"] = player.Character.HumanoidRootPart.Position
                                                    }, [3] = "Start"}
                                                                                            game:GetService("ReplicatedStorage").ReplicatedStorage.Abilities.Templates.ToolTemplate:FindFirstChild("RemoteEvent "):FireServer(unpack(args))
                                                
                                                for x, y in pairs(holding) do
                                                    if abilitiesFolder[5].Name == y then wait(5) end
                                                end
                                                
                                                local args = {
                                                    [1] = abilitiesFolder[5],  -- Access element using elementName and v.Name
                                                    [2] = {
                                                        ["Direction"] = (enemyCFrame - player.Character.HumanoidRootPart.Position).Unit,
                                                        ["Position"] = enemyCFrame,
                                                        ["Origin"] = player.Character.HumanoidRootPart.Position
                                                    }, [3] = "End"}
                                                                                            game:GetService("ReplicatedStorage").ReplicatedStorage.Abilities.Templates.ToolTemplate:FindFirstChild("RemoteEvent "):FireServer(unpack(args))
                                            end
                                        end
    
                                    end
                            end)
                                task.wait(1)
                            end
                        end
                    end))
                end
    
                if abilitiesFolder[6] and abilitiesFolder[6]:IsA("ModuleScript") then
    
                    local ability = abilitiesFolder[6].Name
                        
                    local SkillToggle6 = Tabs.mastery:AddToggle("SkillToggle6", {Title = "使用 " .. ability, Default = Settings["Skill" .. ability] or false})
        
                    SkillToggle6:OnChanged(function()
                        Settings["Skill" .. ability] = SkillToggle6.Value
                        saveSettings()
                    end)
    
                    coroutine.resume(coroutine.create(function()
                        while task.wait() do
                            if Settings["Skill" .. ability] then
                            pcall(function()
                                    local player = game:GetService("Players").LocalPlayer
                                    local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart") 
                                    local mobs = workspace:FindFirstChild("Mobs")
    
                                    if player and game.PlaceId ~= 10515146389 then
                                        for i,v in pairs(mobs:GetChildren()) do
                                            if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0
                                            and (player.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude < 50 then
                                                local enemyCFrame = v.HumanoidRootPart.Position
    
                                                local args = {
                                                    [1] = abilitiesFolder[6], 
                                                    [2] = {
                                                        ["Direction"] = (enemyCFrame - player.Character.HumanoidRootPart.Position).Unit,
                                                        ["Position"] = enemyCFrame,
                                                        ["Origin"] = player.Character.HumanoidRootPart.Position
                                                    }, [3] = "Start"}
                                                                                            game:GetService("ReplicatedStorage").ReplicatedStorage.Abilities.Templates.ToolTemplate:FindFirstChild("RemoteEvent "):FireServer(unpack(args))
                                                
                                                for x, y in pairs(holding) do
                                                    if abilitiesFolder[6].Name == y then wait(5) end
                                                end
                                                
                                                local args = {
                                                    [1] = abilitiesFolder[6],  -- Access element using elementName and v.Name
                                                    [2] = {
                                                        ["Direction"] = (enemyCFrame - player.Character.HumanoidRootPart.Position).Unit,
                                                        ["Position"] = enemyCFrame,
                                                        ["Origin"] = player.Character.HumanoidRootPart.Position
                                                    }, [3] = "End"}
                                                                                            game:GetService("ReplicatedStorage").ReplicatedStorage.Abilities.Templates.ToolTemplate:FindFirstChild("RemoteEvent "):FireServer(unpack(args))
    
                                            end
                                        end
    
                                    end
                            end)
                                task.wait(1)
                            end
                        end
                    end))
                end
            end

            local UseElementSkillsAwakened = Tabs.mastery:AddSection("-- 觉醒技能 --")

            if not game:GetService("ReplicatedStorage").ReplicatedStorage.Abilities.Elements[equippedelement]:FindFirstChild("AwakenedMoves") then 
                Tabs.mastery:AddParagraph({Title = "未找到觉醒技能！"})
            end

            if game:GetService("ReplicatedStorage").ReplicatedStorage.Abilities.Elements[equippedelement]:FindFirstChild("AwakenedMoves") then 
                if equippedelement ~= nil then 

                    local AutoMasteryToggle2 = Tabs.mastery:AddToggle("AutoMastery", {Title = "⭐ 自动使用所有觉醒技能", Default = Settings.Mastery2 or false})
            
                    AutoMasteryToggle2:OnChanged(function()
                        Settings.Mastery2 = AutoMasteryToggle2.Value
                        saveSettings() 
                    end)
            
                    coroutine.resume(coroutine.create(function()
                        while task.wait() do
                            if Settings.Mastery2 then
                                AutoUseAwakenedAbility()
                                task.wait(1)
                            end
                        end
                    end))
                
                    function AutoUseAwakenedAbility()
                        pcall(function()
                            local player = game:GetService("Players").LocalPlayer
                            local mobs = workspace:FindFirstChild("Mobs")
                            for i,v in pairs(mobs:GetChildren()) do
                                if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0
                                and (player.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude < 50 then
                                    local enemyCFrame = v.HumanoidRootPart.Position
    
                                    v1 = require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"))
                                    local u17 = v1.GetController("DataController"):GetReplica()
                                    local equippedelement
                                    for i,v in pairs(u17.Data.Main.EquippedItems.Elements) do
                                        equippedelement = v
                                    end
                
                                    if player then
                                        local abilitiesFolder = game:GetService("ReplicatedStorage").ReplicatedStorage.Abilities.Elements[equippedelement].AwakenedMoves
                                        if abilitiesFolder then
                                            ---awakend abilities
                                            for _, v in pairs(abilitiesFolder:GetChildren()) do                        
                                                local args = {
                                                    [1] = abilitiesFolder[v.Name],  -- Access element using elementName and v.Name
                                                    [2] = {
                                                        ["Direction"] = (enemyCFrame - player.Character.HumanoidRootPart.Position).Unit,
                                                        ["Position"] = enemyCFrame,
                                                        ["Origin"] = player.Character.HumanoidRootPart.Position
                                                    },
                                                    [3] = "Start"
                                                }
                                                game:GetService("ReplicatedStorage").ReplicatedStorage.Abilities.Templates.ToolTemplate:FindFirstChild("RemoteEvent "):FireServer(unpack(args))
                
                                                if v.Name == "DragonsBreath" then
                                                    wait(5)
                                                end
                
                                                local args = {
                                                    [1] = abilitiesFolder[v.Name],  -- Access element using elementName and v.Name
                                                    [2] = {
                                                        ["Direction"] = (enemyCFrame - player.Character.HumanoidRootPart.Position).Unit,
                                                        ["Position"] = enemyCFrame,
                                                        ["Origin"] = player.Character.HumanoidRootPart.Position
                                                    },
                                                    [3] = "End"
                                                }
                                                game:GetService("ReplicatedStorage").ReplicatedStorage.Abilities.Templates.ToolTemplate:FindFirstChild("RemoteEvent "):FireServer(unpack(args))
                                            end
                                        end
                                    end
                                end
                            end
                        end)
                    end
            
                    local UseElementSkillsOr2 = Tabs.mastery:AddSection("Or")

                    local abilitiesFolderX = game:GetService("ReplicatedStorage").ReplicatedStorage.Abilities.Elements[equippedelement]:FindFirstChild("AwakenedMoves"):GetChildren()
        
                    if abilitiesFolderX[1] and abilitiesFolderX[1]:IsA("ModuleScript") then
        
                        local ability = abilitiesFolderX[1].Name
                            
                        local SkillToggle1 = Tabs.mastery:AddToggle("SkillToggle1", {Title = "使用 " .. ability, Default = Settings["Skill" .. ability] or false})
            
                        SkillToggle1:OnChanged(function()
                            Settings["Skill" .. ability] = SkillToggle1.Value
                            saveSettings()
                        end)
        
                        coroutine.resume(coroutine.create(function()
                            while task.wait() do
                                if Settings["Skill" .. ability] then
                                    pcall(function()
                                        local player = game:GetService("Players").LocalPlayer
                                        local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart") 
                                        local mobs = workspace:FindFirstChild("Mobs")
        
                                        if player and game.PlaceId ~= 10515146389 then
                                            for i,v in pairs(mobs:GetChildren()) do
                                                if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0
                                                and (player.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude < 50 then
                                                    local enemyCFrame = v.HumanoidRootPart.Position
        
                                                    local args = {
                                                        [1] = abilitiesFolderX[1], 
                                                        [2] = {
                                                            ["Direction"] = (enemyCFrame - player.Character.HumanoidRootPart.Position).Unit,
                                                            ["Position"] = enemyCFrame,
                                                            ["Origin"] = player.Character.HumanoidRootPart.Position
                                                        }, [3] = "Start"}
                                                    game:GetService("ReplicatedStorage").ReplicatedStorage.Abilities.Templates.ToolTemplate:FindFirstChild("RemoteEvent "):FireServer(unpack(args))
                                                    
                                                    for x, y in pairs(holding) do
                                                        if abilitiesFolderX[1].Name == y then wait(5) end
                                                    end
                                                    
                                                    local args = {
                                                        [1] = abilitiesFolderX[1],  -- Access element using elementName and v.Name
                                                        [2] = {
                                                            ["Direction"] = (enemyCFrame - player.Character.HumanoidRootPart.Position).Unit,
                                                            ["Position"] = enemyCFrame,
                                                            ["Origin"] = player.Character.HumanoidRootPart.Position
                                                        }, [3] = "End"}
                                                    game:GetService("ReplicatedStorage").ReplicatedStorage.Abilities.Templates.ToolTemplate:FindFirstChild("RemoteEvent "):FireServer(unpack(args))
                                                end
                                            end
                                        end
                                    end)
                                    task.wait(1)
                                end
                            end
                        end))
                    end
        
                    if abilitiesFolderX[2] and abilitiesFolderX[2]:IsA("ModuleScript") then
        
                        local ability = abilitiesFolderX[2].Name
                            
                        local SkillToggle2 = Tabs.mastery:AddToggle("SkillToggle2", {Title = "使用 " .. ability, Default = Settings["Skill" .. ability] or false})
            
                        SkillToggle2:OnChanged(function()
                            Settings["Skill" .. ability] = SkillToggle2.Value
                            saveSettings()
                        end)
        
                        coroutine.resume(coroutine.create(function()
                            while task.wait() do
                                if Settings["Skill" .. ability] then
                                pcall(function()
                                        local player = game:GetService("Players").LocalPlayer
                                        local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart") 
                                        local mobs = workspace:FindFirstChild("Mobs")
        
                                        if player and game.PlaceId ~= 10515146389 then
                                            for i,v in pairs(mobs:GetChildren()) do
                                                if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0
                                                and (player.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude < 50 then
                                                    local enemyCFrame = v.HumanoidRootPart.Position
                                                    local args = {
                                                        [1] = abilitiesFolderX[2], 
                                                        [2] = {
                                                            ["Direction"] = (enemyCFrame - player.Character.HumanoidRootPart.Position).Unit,
                                                            ["Position"] = enemyCFrame,
                                                            ["Origin"] = player.Character.HumanoidRootPart.Position
                                                        }, [3] = "Start"}
                                                    game:GetService("ReplicatedStorage").ReplicatedStorage.Abilities.Templates.ToolTemplate:FindFirstChild("RemoteEvent "):FireServer(unpack(args))
                                                    
                                                    for x, y in pairs(holding) do
                                                        if abilitiesFolderX[2].Name == y then wait(5) end
                                                    end
                                                    
                                                    local args = {
                                                        [1] = abilitiesFolderX[2],  -- Access element using elementName and v.Name
                                                        [2] = {
                                                            ["Direction"] = (enemyCFrame - player.Character.HumanoidRootPart.Position).Unit,
                                                            ["Position"] = enemyCFrame,
                                                            ["Origin"] = player.Character.HumanoidRootPart.Position
                                                        }, [3] = "End"}
                                                    game:GetService("ReplicatedStorage").ReplicatedStorage.Abilities.Templates.ToolTemplate:FindFirstChild("RemoteEvent "):FireServer(unpack(args))
                                                end
                                            end
                                        end
                                end)
                                    task.wait(1)
                                end
                            end
                        end))
                    end
        
                    if abilitiesFolderX[3] and abilitiesFolderX[3]:IsA("ModuleScript") then
        
                        local ability = abilitiesFolderX[3].Name
                            
                        local SkillToggle3 = Tabs.mastery:AddToggle("SkillToggle3", {Title = "使用 " .. ability, Default = Settings["Skill" .. ability] or false})
            
                        SkillToggle3:OnChanged(function()
                            Settings["Skill" .. ability] = SkillToggle3.Value
                            saveSettings()
                        end)

                        coroutine.resume(coroutine.create(function()
                            while task.wait() do
                                if Settings["Skill" .. ability] then
                                pcall(function()
                                        local player = game:GetService("Players").LocalPlayer
                                        local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart") 
                                        local mobs = workspace:FindFirstChild("Mobs")
        
                                        if player and game.PlaceId ~= 10515146389 then
                                            for i,v in pairs(mobs:GetChildren()) do
                                                if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0
                                                and (player.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude < 50 then
                                                    local enemyCFrame = v.HumanoidRootPart.Position
        
                                                    local args = {
                                                        [1] = abilitiesFolderX[3], 
                                                        [2] = {
                                                            ["Direction"] = (enemyCFrame - player.Character.HumanoidRootPart.Position).Unit,
                                                            ["Position"] = enemyCFrame,
                                                            ["Origin"] = player.Character.HumanoidRootPart.Position
                                                        }, [3] = "Start"}
                                                                                                game:GetService("ReplicatedStorage").ReplicatedStorage.Abilities.Templates.ToolTemplate:FindFirstChild("RemoteEvent "):FireServer(unpack(args))
                                                    
                                                    for x, y in pairs(holding) do
                                                        if abilitiesFolderX[3].Name == y then wait(5) end
                                                    end
                                                    
                                                    local args = {
                                                        [1] = abilitiesFolderX[3],  -- Access element using elementName and v.Name
                                                        [2] = {
                                                            ["Direction"] = (enemyCFrame - player.Character.HumanoidRootPart.Position).Unit,
                                                            ["Position"] = enemyCFrame,
                                                            ["Origin"] = player.Character.HumanoidRootPart.Position
                                                        }, [3] = "End"}
                                                                                                game:GetService("ReplicatedStorage").ReplicatedStorage.Abilities.Templates.ToolTemplate:FindFirstChild("RemoteEvent "):FireServer(unpack(args))
                                                end
                                            end
                                        end
                                end)
                                    task.wait(1)
                                end
                            end
                        end))
                    end
        
                    if abilitiesFolderX[4] and abilitiesFolderX[4]:IsA("ModuleScript") then
        
                        local ability = abilitiesFolderX[4].Name
                            
                        local SkillToggle4 = Tabs.mastery:AddToggle("SkillToggle4", {Title = "使用 " .. ability, Default = Settings["Skill" .. ability] or false})
            
                        SkillToggle4:OnChanged(function()
                            Settings["Skill" .. ability] = SkillToggle4.Value
                            saveSettings()
                        end)
        
                        coroutine.resume(coroutine.create(function()
                            while task.wait() do
                                if Settings["Skill" .. ability] then
                                pcall(function()
                                        local player = game:GetService("Players").LocalPlayer
                                        local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart") 
                                        local mobs = workspace:FindFirstChild("Mobs")
        
                                        if player and game.PlaceId ~= 10515146389 then
                                            for i,v in pairs(mobs:GetChildren()) do
                                                if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0
                                                and (player.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude < 50 then
                                                    local enemyCFrame = v.HumanoidRootPart.Position
        
                                                    local args = {
                                                        [1] = abilitiesFolderX[4], 
                                                        [2] = {
                                                            ["Direction"] = (enemyCFrame - player.Character.HumanoidRootPart.Position).Unit,
                                                            ["Position"] = enemyCFrame,
                                                            ["Origin"] = player.Character.HumanoidRootPart.Position
                                                        }, [3] = "Start"}
                                                                                                game:GetService("ReplicatedStorage").ReplicatedStorage.Abilities.Templates.ToolTemplate:FindFirstChild("RemoteEvent "):FireServer(unpack(args))
                                                    
                                                    for x, y in pairs(holding) do
                                                        if abilitiesFolderX[4].Name == y then wait(5) end
                                                    end
                                                    
                                                    local args = {
                                                        [1] = abilitiesFolderX[4],  -- Access element using elementName and v.Name
                                                        [2] = {
                                                            ["Direction"] = (enemyCFrame - player.Character.HumanoidRootPart.Position).Unit,
                                                            ["Position"] = enemyCFrame,
                                                            ["Origin"] = player.Character.HumanoidRootPart.Position
                                                        }, [3] = "End"}
                                                                                                game:GetService("ReplicatedStorage").ReplicatedStorage.Abilities.Templates.ToolTemplate:FindFirstChild("RemoteEvent "):FireServer(unpack(args))
                                                end
                                            end
                                        end
                                end)
                                    task.wait(1)
                                end
                            end
                        end))
                    end
        
                    if abilitiesFolderX[5] and abilitiesFolderX[5]:IsA("ModuleScript") then
        
                        local ability = abilitiesFolderX[5].Name
                            
                        local SkillToggle5 = Tabs.mastery:AddToggle("SkillToggle5", {Title = "使用 " .. ability, Default = Settings["Skill" .. ability] or false})
            
                        SkillToggle5:OnChanged(function()
                            Settings["Skill" .. ability] = SkillToggle5.Value
                            saveSettings()
                        end)
        
                        coroutine.resume(coroutine.create(function()
                            while task.wait() do
                                if Settings["Skill" .. ability] then
                                pcall(function()
                                        local player = game:GetService("Players").LocalPlayer
                                        local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart") 
                                        local mobs = workspace:FindFirstChild("Mobs")
        
                                        if player and game.PlaceId ~= 10515146389 then
                                            for i,v in pairs(mobs:GetChildren()) do
                                                if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0
                                                and (player.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude < 50 then
                                                    local enemyCFrame = v.HumanoidRootPart.Position
        
                                                    
                                                    local args = {
                                                        [1] = abilitiesFolderX[5], 
                                                        [2] = {
                                                            ["Direction"] = (enemyCFrame - player.Character.HumanoidRootPart.Position).Unit,
                                                            ["Position"] = enemyCFrame,
                                                            ["Origin"] = player.Character.HumanoidRootPart.Position
                                                        }, [3] = "Start"}
                                                                                                game:GetService("ReplicatedStorage").ReplicatedStorage.Abilities.Templates.ToolTemplate:FindFirstChild("RemoteEvent "):FireServer(unpack(args))
                                                    
                                                    for x, y in pairs(holding) do
                                                        if abilitiesFolderX[5].Name == y then wait(5) end
                                                    end
                                                    
                                                    local args = {
                                                        [1] = abilitiesFolderX[5],  -- Access element using elementName and v.Name
                                                        [2] = {
                                                            ["Direction"] = (enemyCFrame - player.Character.HumanoidRootPart.Position).Unit,
                                                            ["Position"] = enemyCFrame,
                                                            ["Origin"] = player.Character.HumanoidRootPart.Position
                                                        }, [3] = "End"}
                                                                                                game:GetService("ReplicatedStorage").ReplicatedStorage.Abilities.Templates.ToolTemplate:FindFirstChild("RemoteEvent "):FireServer(unpack(args))
                                                end
                                            end
        
                                        end
                                end)
                                    task.wait(1)
                                end
                            end
                        end))
                    end
        
                    if abilitiesFolderX[6] and abilitiesFolderX[6]:IsA("ModuleScript") then
        
                        local ability = abilitiesFolderX[6].Name
                            
                        local SkillToggle6 = Tabs.mastery:AddToggle("SkillToggle6", {Title = "使用 " .. ability, Default = Settings["Skill" .. ability] or false})
            
                        SkillToggle6:OnChanged(function()
                            Settings["Skill" .. ability] = SkillToggle6.Value
                            saveSettings()
                        end)
        
                        coroutine.resume(coroutine.create(function()
                            while task.wait() do
                                if Settings["Skill" .. ability] then
                                pcall(function()
                                        local player = game:GetService("Players").LocalPlayer
                                        local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart") 
                                        local mobs = workspace:FindFirstChild("Mobs")
        
                                        if player and game.PlaceId ~= 10515146389 then
                                            for i,v in pairs(mobs:GetChildren()) do
                                                if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0
                                                and (player.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude < 50 then
                                                    local enemyCFrame = v.HumanoidRootPart.Position
        
                                                    local args = {
                                                        [1] = abilitiesFolderX[6], 
                                                        [2] = {
                                                            ["Direction"] = (enemyCFrame - player.Character.HumanoidRootPart.Position).Unit,
                                                            ["Position"] = enemyCFrame,
                                                            ["Origin"] = player.Character.HumanoidRootPart.Position
                                                        }, [3] = "Start"}
                                                                                                game:GetService("ReplicatedStorage").ReplicatedStorage.Abilities.Templates.ToolTemplate:FindFirstChild("RemoteEvent "):FireServer(unpack(args))
                                                    
                                                    for x, y in pairs(holding) do
                                                        if abilitiesFolderX[6].Name == y then wait(5) end
                                                    end
                                                    
                                                    local args = {
                                                        [1] = abilitiesFolderX[6],  -- Access element using elementName and v.Name
                                                        [2] = {
                                                            ["Direction"] = (enemyCFrame - player.Character.HumanoidRootPart.Position).Unit,
                                                            ["Position"] = enemyCFrame,
                                                            ["Origin"] = player.Character.HumanoidRootPart.Position
                                                        }, [3] = "End"}
                                                                                                game:GetService("ReplicatedStorage").ReplicatedStorage.Abilities.Templates.ToolTemplate:FindFirstChild("RemoteEvent "):FireServer(unpack(args))
        
                                                end
                                            end
        
                                        end
                                end)
                                    task.wait(1)
                                end
                            end
                        end))
                    end
                end
            end


        local Snipe = Tabs.lobby:AddSection("狙击")

        Snipe:AddButton({
            Title = "打开商人界面",
            Callback = function()
                pcall(function()
                    local player = game:GetService("Players").LocalPlayer
    
                    if game.PlaceId == 10515146389 then
                        if game:GetService("Workspace"):FindFirstChild("NPCs"):FindFirstChild("MerchantNPC") then
                            player.PlayerGui.Merchant.Main.Visible = true
                        else
                            Fluent:Notify({Title = "Merchant NPC Not Found!", Content = "Merchant not found, check back later!", Duration = 4})                            
                        end
                    else
                        Fluent:Notify({Title = "Only Works in Lobby!", Content = "Wrong", Duration = 4})
                    end
                end)
            end
        })

        Snipe:AddButton({
            Title = "打开科学家界面 [索引]",
            Callback = function()
                pcall(function()
                    local player = game:GetService("Players").LocalPlayer
                    if game.PlaceId == 10515146389 then
                        if game:GetService("Workspace"):FindFirstChild("Scientist") then
                            player.PlayerGui.Index.Main.Visible = true
                        end
                    end
                end)
            end
        })

        Snipe:AddButton({
            Title = "打开科学家界面 [高级科技制造]",
            Callback = function()
                pcall(function()
                    local player = game:GetService("Players").LocalPlayer
                    if game.PlaceId == 10515146389 then
                        if game:GetService("Workspace"):FindFirstChild("Scientist") then
                            player.PlayerGui.ScientistCraftingUI.Main.Visible = true
                        end
                    end
                end)
            end
        })

        local snipsustoggle = Snipe:AddToggle("snipsustoggle", {Title = "⛰️  自动从可疑的吸血鬼购买/存储球体", Default = Settings.susvamp or false})

        snipsustoggle:OnChanged(function()
            Settings.susvamp = snipsustoggle.Value
            saveSettings()
        end)

        function sniperssusvamp() 
            pcall(function()
                local player = game:GetService("Players").LocalPlayer
                local backpack = player:FindFirstChild("Backpack")
    
                game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("MiscContentService"):WaitForChild("RF"):WaitForChild("BuyElementForGold"):InvokeServer(LocalPlayer)
                task.wait()
                for i, v in pairs(backpack:GetChildren()) do
                    if v.Name:match("Orb") then
                        local button = game:service'VirtualInputManager'
                        button:SendKeyEvent(true, "Three", false, game)
                        task.wait()
                        game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("MiscContentService"):WaitForChild("RF"):WaitForChild("StoreOrb"):InvokeServer()
                    end
                end
            end)
        end
   
        coroutine.resume(coroutine.create(function()
            while task.wait() do
                if Settings.susvamp and game.PlaceId == 10515146389 then
                    sniperssusvamp() 
                end
            end
        end))

        local Stats = Tabs.lobby:AddSection("属性")

        local UpgradeSwordPower = Stats:AddToggle("UpgradeSwordPower", {Title = "自动升级剑能力", Default = Settings.USP or false})

        UpgradeSwordPower:OnChanged(function()
            Settings.USP = UpgradeSwordPower.Value
            saveSettings()
        end)

        coroutine.resume(coroutine.create(function()
            while task.wait() do
                if Settings.USP then
                    wait()         
                    local args = {[1] = "PhysicalPower",[2] = 1}
                    game:GetService("ReplicatedStorage").ReplicatedStorage.Packages.Knit.Services.InventoryService.RF.UpgradeSkill:InvokeServer(unpack(args))
                end
            end
        end))

        local UpgradeElementPower = Stats:AddToggle("UpgradeElementPower", {Title = "自动升级元素能力", Default = Settings.UEP or false})

        UpgradeElementPower:OnChanged(function()
            Settings.UEP = UpgradeElementPower.Value
            saveSettings()
        end)

        coroutine.resume(coroutine.create(function()
            while task.wait() do
                if Settings.UEP then
                    wait()
                    local args = {[1] = "MagicPower",[2] = 1}
                    game:GetService("ReplicatedStorage").ReplicatedStorage.Packages.Knit.Services.InventoryService.RF.UpgradeSkill:InvokeServer(unpack(args))
                end
            end
        end))

        local UpgradeDefense = Stats:AddToggle("UpgradeElementPower", {Title = "自动升级防御", Default = Settings.UD or false})

        UpgradeDefense:OnChanged(function()
            Settings.UD = UpgradeDefense.Value
            saveSettings()
        end)

        coroutine.resume(coroutine.create(function()
            while task.wait() do
                if Settings.UD then
                    wait()
                    local args = {[1] = "Defense",[2] = 1}
                    game:GetService("ReplicatedStorage").ReplicatedStorage.Packages.Knit.Services.InventoryService.RF.UpgradeSkill:InvokeServer(unpack(args))
                end
            end
        end))

        local Summon = Tabs.lobby:AddSection("召唤")

        local SummonElement1 = Summon:AddToggle("SummonElement1", {Title = "自动召唤元素（1）", Default = Settings.Summon1 or false})

        SummonElement1:OnChanged(function()
            Settings.Summon1 = SummonElement1.Value
            saveSettings()
        end)

        coroutine.resume(coroutine.create(function()
            while task.wait() do
                if Settings.Summon1 then
                    game:GetService("ReplicatedStorage").ReplicatedStorage.Packages.Knit.Services.SummoningService.RF.SummonOnce:InvokeServer()
                end
            end
        end))

        local SummonElement2 = Summon:AddToggle("SummonElement2", {Title = "自动召唤元素（3）", Default = Settings.Summon2 or false})

        SummonElement2:OnChanged(function()
            Settings.Summon2 = SummonElement2.Value
            saveSettings()
        end)

        coroutine.resume(coroutine.create(function()
            while task.wait() do
                if Settings.Summon2 then
                    game:GetService("ReplicatedStorage").ReplicatedStorage.Packages.Knit.Services.SummoningService.RF.SummonThree:InvokeServer()
                end
            end
        end))

        local lobbyother = Tabs.lobby:AddSection("其他")

        lobbyother:AddButton({
            Title = "Redeem All Codes",
            Callback = function()
                local codes = {"10MVISITS","ATLANTIS212", "newcode", "refundsp", "TYFOR20KPLAYERS", "BETA"}
                for i,v in pairs(codes) do
                    local args = {[1] = v} game:GetService("ReplicatedStorage").ReplicatedStorage.Packages.Knit.Services.CodesService.RF.RedeemCode:InvokeServer(unpack(args))
                    wait()
                end
            end
        })

        local AutoFarmChest = lobbyother:AddToggle("AutoFarmChest", {Title = "自动农场宝箱", Default = Settings.AFC or false})

        AutoFarmChest:OnChanged(function()
            Settings.AFC = AutoFarmChest.Value
            saveSettings()
            _G.qweewe = false
        end)

        coroutine.resume(coroutine.create(function()
            while task.wait() do
                local chestsFolder = game:GetService("Workspace"):FindFirstChild("Chests")
    
                if game.PlaceId == 10515146389 then
                    if Settings.AFC and #chestsFolder:GetChildren() ~= 0 then
                        local camera = game.Workspace.CurrentCamera
                        local topDownViewCFrame = CFrame.new(Vector3.new(0, 100, 0), Vector3.new(0, 0, 0))
                        camera.CFrame = topDownViewCFrame
                        local desiredFieldOfView = 80 -- Adjust this value as needed
                        camera.FieldOfView = desiredFieldOfView
                        local plr = game.Players.LocalPlayer.Character.HumanoidRootPart
                        for i, v in pairs(chestsFolder:GetChildren()) do
                            if v.ProximityPrompt then
                                plr.CFrame = v.CFrame
                                wait(1)
                                fireproximityprompt(v.ProximityPrompt)
                            else
                                _G.qweewe = false
                            end
                        end
                    elseif Settings.AFC and #chestsFolder:GetChildren() == 0 and (_G.qweewe == false or _G.qweewe == nil) then
                        _G.qweewe = true
                        Fluent:Notify({Title = "No Chest Found!", Content = "You have already collected all of them!", Duration = 4})
                    end
                end
            end
        end))

        local AutoFarmEvilChest = lobbyother:AddToggle("AutoFarmEvilChest", {Title = "自动农场邪恶宝箱", Default = Settings.AFEC or false})

        AutoFarmEvilChest:OnChanged(function()
            Settings.AFEC = AutoFarmEvilChest.Value
            saveSettings()
        end)

        local notificationSent = false

        coroutine.resume(coroutine.create(function()
            while task.wait() do
                if game.PlaceId == 10515146389 then
                    if Settings.AFEC and not notificationSent then
                        local plr = game.Players.LocalPlayer.Character.HumanoidRootPart
                        local foundChest = false
    
                        for i, v in pairs(game:GetService("Workspace").Map:GetChildren()) do
                            if v.Name == "Chest" then
                                foundChest = true
                                local camera = game.Workspace.CurrentCamera
                                local topDownViewCFrame = CFrame.new(Vector3.new(0, 100, 0), Vector3.new(0, 0, 0))
                                camera.CFrame = topDownViewCFrame
                                local desiredFieldOfView = 80 -- Adjust this value as needed
                                camera.FieldOfView = desiredFieldOfView
                                wait()
                                plr.CFrame = v.CFrame
                                wait(1)
                                fireproximityprompt(v.ProximityPrompt)
                                break  -- Exit the loop after finding the first chest
                            end
                        end
    
                        if not foundChest then
                            notificationSent = true
                            Fluent:Notify({Title = "No Evil Chest Found!", Content = "You have already collected all of them!", Duration = 4})
                        end
                    end
                end
            end
        end))

        lobbyother:AddParagraph({Title = "每个账户只能收集每个宝箱一次!"})

        Tabs.autoselltab:AddParagraph({Title = "只在大厅中起作用！（不会出售已装备/锁定的物品）"})

        local TpLobbyFullItem = Tabs.autoselltab:AddToggle("TpLobbyFullItem", {Title = "如果库存已满则传送到大厅", Default = Settings.TpLobbySellItem or false})

        TpLobbyFullItem:OnChanged(function()
            Settings.TpLobbySellItem = TpLobbyFullItem.Value
            saveSettings()
        end)

        coroutine.resume(coroutine.create(function() 
            while task.wait() do
                if Settings.TpLobbySellItem then
                    if game.PlaceId ~= 10515146389 then
                        local inventory = game:GetService("Players").LocalPlayer.PlayerGui.Inventory.Main.InventoryFrame.ItemsStored.Text
                        if inventory == "75 / 75 Items Stored" or
                            inventory == "80 / 80 Items Stored" or
                            inventory == "85 / 85 Items Stored" or
                            inventory == "90 / 90 Items Stored" or
                            inventory == "95 / 95 Items Stored" or
                            inventory == "100 / 100 Items Stored" or
                            inventory == "105 / 105 Items Stored" or
                            inventory == "110 / 110 Items Stored" or
                            inventory == "115 / 115 Items Stored" or
                            inventory == "120 / 120 Items Stored" or
                            inventory == "125 / 125 Items Stored" or
                            inventory == "130 / 130 Items Stored" or
                            inventory == "135 / 135 Items Stored" or
                            inventory == "140 / 140 Items Stored" or
                            inventory == "145 / 145 Items Stored" or
                            inventory == "150 / 150 Items Stored" 
                           then
                            local args = {[1] = game:GetService("Players").LocalPlayer}
                            game:GetService("ReplicatedStorage").ReplicatedStorage.Packages.Knit.Services.DungeonService.RF.TeleportToLobby:InvokeServer(unpack(args))
                        end
                    end
                end
            end
        end))

        ----------------------------------------------
        -------------- Auto Sell Functions -----------
        ----------------------------------------------

        v1 = require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"))
        local u17 = v1.GetController("DataController"):GetReplica()

        function GetRarity(item, rarity)
            local armormod = require(game:GetService("ReplicatedStorage").ReplicatedStorage.SharedModules.ArmorsModule)
            for i,v in pairs(armormod) do
                if i == item then
                for x,y in pairs(v) do
                        if x == "Rarity" then
                            if y == rarity then
                                return true
                            else 
                                return false
                            end
                        end
                    end
                end
            end
            local weaponmod = require(game:GetService("ReplicatedStorage").ReplicatedStorage.SharedModules.WeaponsModule)
            for i,v in pairs(weaponmod) do
                if i == item then
                for x,y in pairs(v) do
                        if x == "Rarity" then
                            if y == rarity then
                                return true
                            else 
                                return false
                            end
                        end
                    end
                end
            end
            local relicmod = require(game:GetService("ReplicatedStorage").ReplicatedStorage.SharedModules.RelicsModule)
            for i,v in pairs(relicmod) do
                if i == item then
                for x,y in pairs(v) do
                        if x == "Rarity" then
                            if y == rarity then
                                return true
                            else 
                                return false
                            end
                        end
                    end
                end
            end
            local orbmod = require(game:GetService("ReplicatedStorage").ReplicatedStorage.SharedModules.ElementsModule)
            for i,v in pairs(orbmod) do
                if i == item then
                for x,y in pairs(v) do
                        if x == "Rarity" then
                            if y == rarity then
                                return true
                            else 
                                return false
                            end
                        end
                    end
                end
            end
            return false 
        end
        function SellItem(item, rarity)
            if game.PlaceId == 10515146389 then
                for i, v in pairs(u17.Data.Main.Items[item]) do
                    local UUID = i
                    local Name = v.Base
                    local Type = v.Type
                    local Equipped = v.Equipped

                    if not Equipped then
                        if GetRarity(Name, rarity) then
                            local args = {[1] = {[1] = {["Type"] = Type,["UUID"] = UUID}}}
                            game:GetService("ReplicatedStorage").ReplicatedStorage.Packages.Knit.Services.InventoryService.RF.Sell:InvokeServer(unpack(args))
                        end
                    end
                end
            end
        end
        ----------------------------------------------
        ----------------------------------------------
        ----------------------------------------------

        local SellWeapons = Tabs.autoselltab:AddSection("⚔️ 出售武器 ⚔️")

        local SellWeapon1Toggle = SellWeapons:AddToggle("SellWeapon1Toggle", {Title = "⚔️ 出售普通武器", Default = Settings.SellWeapon1 or false})

        SellWeapon1Toggle:OnChanged(function()
            Settings.SellWeapon1 = SellWeapon1Toggle.Value
            saveSettings()
        end)

        coroutine.resume(coroutine.create(function() 
            while task.wait() do
                if Settings.SellWeapon1 == true then SellItem("Weapons", "Common") end
            end
        end))

        local SellWeapon2Toggle = SellWeapons:AddToggle("SellWeapon1Toggle", {Title = "⚔️ 出售非凡武器", Default = Settings.SellWeapon2 or false})

        SellWeapon2Toggle:OnChanged(function()
            Settings.SellWeapon2 = SellWeapon2Toggle.Value
            saveSettings()
        end)

        coroutine.resume(coroutine.create(function() 
            while task.wait() do
                if Settings.SellWeapon2 == true then SellItem("Weapons", "Uncommon") end
            end
        end))

        local SellWeapon3Toggle = SellWeapons:AddToggle("SellWeapon3Toggle", {Title = "⚔️ 出售稀有武器", Default = Settings.SellWeapon3 or false})

        SellWeapon3Toggle:OnChanged(function()
            Settings.SellWeapon3 = SellWeapon3Toggle.Value
            saveSettings()
        end)

        coroutine.resume(coroutine.create(function() 
            while task.wait() do
                if Settings.SellWeapon3 == true then SellItem("Weapons", "Rare") end
            end
        end))

        local SellWeapon4Toggle = SellWeapons:AddToggle("SellWeapon4Toggle", {Title = "⚔️ 出售史诗武器 ⚠️", Default = Settings.SellWeapon4 or false})

        SellWeapon4Toggle:OnChanged(function()
            Settings.SellWeapon4 = SellWeapon4Toggle.Value
            saveSettings()
        end)

        coroutine.resume(coroutine.create(function() 
            while task.wait() do
                if Settings.SellWeapon4 == true then SellItem("Weapons", "Epic") end
            end
        end))

        local SellWeapon5Toggle = SellWeapons:AddToggle("SellWeapon5Toggle", {Title = "⚔️ 出售传说武器 ⚠️", Default = Settings.SellWeapon4 or false})

        SellWeapon5Toggle:OnChanged(function()
            Settings.SellWeapon4 = SellWeapon4Toggle.Value
            saveSettings()
        end)

        coroutine.resume(coroutine.create(function() 
            while task.wait() do
                if Settings.SellWeapon4 == true then SellItem("Weapons", "Epic") end
            end
        end))

        local SellArmors = Tabs.autoselltab:AddSection("⚙️ 出售盔甲 ⚙️")

        local SellArmor1Toggle = SellArmors:AddToggle("SellArmor1Toggle", {Title = "⚙️  出售普通盔甲", Default = Settings.SellArmor1 or false})

        SellArmor1Toggle:OnChanged(function()
            Settings.SellArmor1 = SellArmor1Toggle.Value
            saveSettings()
        end)

        coroutine.resume(coroutine.create(function() 
            while task.wait() do
                if Settings.SellArmor1 == true then SellItem("Armors", "Common") end
            end
        end))

        local SellArmor2Toggle = SellArmors:AddToggle("SellArmor2Toggle", {Title = "⚙️  出售罕见盔甲", Default = Settings.SellArmor2 or false})

        SellArmor2Toggle:OnChanged(function()
            Settings.SellArmor2 = SellArmor2Toggle.Value
            saveSettings()
        end)

        coroutine.resume(coroutine.create(function() 
            while task.wait() do
                if Settings.SellArmor2 == true then SellItem("Armors", "Uncommon") end
            end
        end))

        local SellArmor3Toggle = SellArmors:AddToggle("SellArmor3Toggle", {Title = "⚙️  出售稀有盔甲", Default = Settings.SellArmor3 or false})

        SellArmor3Toggle:OnChanged(function()
            Settings.SellArmor3 = SellArmor3Toggle.Value
            saveSettings()
        end)

        coroutine.resume(coroutine.create(function() 
            while task.wait() do
                if Settings.SellArmor3 == true then SellItem("Armors", "Rare") end
            end
        end))

        local SellArmor4Toggle = SellArmors:AddToggle("SellArmor4Toggle", {Title = "⚙️  出售史诗盔甲 ⚠️", Default = Settings.SellArmor4 or false})

        SellArmor4Toggle:OnChanged(function()
            Settings.SellArmor4 = SellArmor4Toggle.Value
            saveSettings()
        end)

        coroutine.resume(coroutine.create(function() 
            while task.wait() do
                if Settings.SellArmor4 == true then SellItem("Armors", "Epic") end
            end
        end))

        local SellRelics = Tabs.autoselltab:AddSection("⚜️ 出售圣物 ⚜️")

        local SellRelic1Toggle = SellRelics:AddToggle("SellRelic1Toggle", {Title = "⚜️  出售普通圣物", Default = Settings.SellRelic1 or false})

        SellRelic1Toggle:OnChanged(function()
            Settings.SellRelic1 = SellRelic1Toggle.Value
            saveSettings()
        end)

        coroutine.resume(coroutine.create(function() 
            while task.wait() do
                if Settings.SellRelic1 == true then SellItem("Relics", "Common") end
            end
        end))

        local SellRelic2Toggle = SellRelics:AddToggle("SellRelic2Toggle", {Title = "⚜️  出售罕见圣物", Default = Settings.SellRelic2 or false})

        SellRelic2Toggle:OnChanged(function()
            Settings.SellRelic2 = SellRelic2Toggle.Value
            saveSettings()
        end)

        coroutine.resume(coroutine.create(function() 
            while task.wait() do
                if Settings.SellRelic2 == true then SellItem("Relics", "Uncommon") end
            end
        end))

        local SellRelic3Toggle = SellRelics:AddToggle("SellRelic3Toggle", {Title = "⚜️  出售稀有圣物", Default = Settings.SellRelic3 or false})

        SellRelic3Toggle:OnChanged(function()
            Settings.SellRelic3 = SellRelic3Toggle.Value
            saveSettings()
        end)

        coroutine.resume(coroutine.create(function() 
            while task.wait() do
                if Settings.SellRelic3 == true then SellItem("Relics", "Rare") end
            end
        end))

        local SellElements = Tabs.autoselltab:AddSection("⛰️ 出售元素 ⛰️")

        local SellOrb1Toggle = SellElements:AddToggle("SellOrb1Toggle", {Title = "⛰️  出售稀有元素", Default = Settings.SellOrb1 or false})

        SellOrb1Toggle:OnChanged(function()
            Settings.SellOrb1 = SellOrb1Toggle.Value
            saveSettings()
        end)

        coroutine.resume(coroutine.create(function() 
            while task.wait() do
                if Settings.SellOrb1 == true then SellItem("Orbs", "Rare") end
            end
        end))

        local SellOrb2Toggle = SellElements:AddToggle("SellOrb2Toggle", {Title = "⛰️  出售史诗元素 ⚠️", Default = Settings.SellOrb2 or false})

        SellOrb2Toggle:OnChanged(function()
            Settings.SellOrb2 = SellOrb2Toggle.Value
            saveSettings()
        end)

        coroutine.resume(coroutine.create(function() 
            while task.wait() do
                if Settings.SellOrb2 == true then SellItem("Orbs", "Epic") end
            end
        end))

        local loadsection = Tabs.misc:AddSection("加载")

        function autoloadscript()
            queue_on_teleport("repeat task.wait() until game:IsLoaded() print('aaaaaaaaaaaaaaaaaaaaa') task.wait(2) loadstring(game:HttpGet('https://raw.githubusercontent.com/xpa1n/Scripts/main/ElementalDungeons.lua'))()")
        end
    
        coroutine.resume(coroutine.create(function() 
            if Settings.autoload then autoloadscript() end
        end))

        local autoloadscripttoggle = loadsection:AddToggle("autoloadscripttoggle", {Title = "自动加载脚本", Default = Settings.autoload or false})

        autoloadscripttoggle:OnChanged(function()
            Settings.autoload = autoloadscripttoggle.Value
            saveSettings()
            if Settings.autoload then autoloadscript() end
        end)

        function autoreifkicked()
            pcall(function()
                local lp,po,ts = game:GetService('Players').LocalPlayer,game.CoreGui.RobloxPromptGui.promptOverlay,game:GetService('TeleportService')
                po.ChildAdded:connect(function(a)
                    if a.Name == 'ErrorPrompt' then
                        repeat
                            ts:Teleport(10515146389)
                            wait(2)
                        until false
                    end
                end)
            end)
        end
    
        coroutine.resume(coroutine.create(function()
            if Settings.autorejoinifkicked then autoreifkicked() end
        end))

        local autojoinifkicked = loadsection:AddToggle("autojoinifkicked", {Title = "如果被踢出则自动重新加入", Default = Settings.autorejoinifkicked or false})

        autojoinifkicked:OnChanged(function()
            Settings.autorejoinifkicked = autojoinifkicked.Value
            saveSettings()
            if Settings.autorejoinifkicked then autoreifkicked() end
        end)

        function antiafkfunc()
            pcall(function()
                local vu = game:GetService("VirtualUser")
                game:GetService("Players").LocalPlayer.Idled:connect(function()
                vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
                wait(1)
                vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
                end)
            end)
        end
    
        coroutine.resume(coroutine.create(function()
            if Settings.antiafkk then antiafkfunc() end
        end))

        local antiafktoggle = loadsection:AddToggle("antiafktoggle", {Title = "反挂机", Default = Settings.antiafkk or false})

        antiafktoggle:OnChanged(function()
            Settings.antiafkk = antiafktoggle.Value
            saveSettings()
            if Settings.antiafkk then antiafkfunc() end
        end)

        local mixc = Tabs.misc:AddSection("Miscellaneous")
        
        local flying = false
        local flightEnabled = false

        local flytoggle = mixc:AddToggle("flytoggle", {Title = "飞行（按“X”切换", Default = Settings.fly or false})

        flytoggle:OnChanged(function()
            Settings.fly = flytoggle.Value
            saveSettings()
        end)

        coroutine.resume(coroutine.create(function()
            while task.wait() do
                if Settings.fly then 
                    EnableFlight()
                else
                    DisableFlight()
                end
            end
        end))
    
        function EnableFlight()
            local plr = game.Players.LocalPlayer
            local mouse = plr:GetMouse()
            local localplayer = plr
    
            if flightEnabled then
                return
            end
    
            flightEnabled = true
    
            if workspace:FindFirstChild("Core") then
                workspace.Core:Destroy()
            end
    
            local Core = Instance.new("Part")
            Core.Name = "Core"
            Core.Size = Vector3.new(0.05, 0.05, 0.05)
    
            spawn(function()
                Core.Parent = workspace
                local Weld = Instance.new("Weld", Core)
                Weld.Part0 = Core
                Weld.Part1 = localplayer.Character.LowerTorso
                Weld.C0 = CFrame.new(0, 0, 0)
            end)
    
            workspace:WaitForChild("Core")
    
            local torso = workspace.Core
            local speed = 10
            local keys = {a = false, d = false, w = false, s = false}
            local e1
            local e2
    
            function start()
                local pos = Instance.new("BodyPosition", torso)
                local gyro = Instance.new("BodyGyro", torso)
                pos.Name = "EPIXPOS"
                pos.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                pos.Position = torso.Position
                gyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
                gyro.CFrame = torso.CFrame
                repeat
                    wait()
                    localplayer.Character.Humanoid.PlatformStand = true
                    local new = gyro.CFrame - gyro.CFrame.Position + pos.Position
                    if not keys.w and not keys.s and not keys.a and not keys.d then
                        speed = 5
                    end
                    if keys.w then
                        new = new + workspace.CurrentCamera.CFrame.LookVector * speed
                        speed = speed + 0
                    end
                    if keys.s then
                        new = new - workspace.CurrentCamera.CFrame.LookVector * speed
                        speed = speed + 0
                    end
                    if keys.d then
                        new = new * CFrame.new(speed, 0, 0)
                        speed = speed + 0
                    end
                    if keys.a then
                        new = new * CFrame.new(-speed, 0, 0)
                        speed = speed + 0
                    end
                    if speed > 10 then
                        speed = 5
                    end
                    pos.Position = new.Position
                    if keys.w then
                        gyro.CFrame = workspace.CurrentCamera.CFrame * CFrame.Angles(-math.rad(speed * 0), 0, 0)
                    elseif keys.s then
                        gyro.CFrame = workspace.CurrentCamera.CFrame * CFrame.Angles(math.rad(speed * 0), 0, 0)
                    else
                        gyro.CFrame = workspace.CurrentCamera.CFrame
                    end
                until not flying
                if gyro then
                    gyro:Destroy()
                end
                if pos then
                    pos:Destroy()
                end
                localplayer.Character.Humanoid.PlatformStand = false
                speed = 10
            end
    
            e1 = mouse.KeyDown:Connect(function(key)
                if not torso or not torso.Parent then
                    return
                end
                if key == "w" then
                    keys.w = true
                elseif key == "s" then
                    keys.s = true
                elseif key == "a" then
                    keys.a = true
                elseif key == "d" then
                    keys.d = true
                elseif key == "x" then
                    flying = not flying -- Toggle flight on/off
                    if flying then
                        start()
                    end
                end
            end)
    
            e2 = mouse.KeyUp:Connect(function(key)
                if key == "w" then
                    keys.w = false
                elseif key == "s" then
                    keys.s = false
                elseif key == "a" then
                    keys.a = false
                elseif key == "d" then
                    keys.d = false
                end
            end)
        end
    
        function DisableFlight()
            local plr = game.Players.LocalPlayer
            local mouse = plr:GetMouse()
            local localplayer = plr
    
            if not flightEnabled then
                return
            end
    
            flightEnabled = false
    
            if e1 then
                e1:Disconnect()
            end
    
            if e2 then
                e2:Disconnect()
            end
    
            if workspace.Core then
                workspace.Core:Destroy()
            end
    
            localplayer.Character.Humanoid.PlatformStand = false
            flying = false
        end

        local ggwalkspeed = Settings.WalkSpeed or 30

        local WalkSpeed = mixc:AddSlider("WalkSpeed", {
            Title = "步行速度",
            Default = ggwalkspeed,
            Min = 30,
            Max = 200,
            Rounding = 0,
            Callback = function(Value)
                Settings.WalkSpeed = Value
                saveSettings()
                ggwalkspeed = Value
                game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Settings.WalkSpeed
            end
        })

        coroutine.resume(coroutine.create(function()
            while task.wait() do
                if game.Players.LocalPlayer.Character.Humanoid.WalkSpeed ~= ggwalkspeed then
                    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = ggwalkspeed
                end
            end
        end))

        local ggjumppower = Settings.Jumppower or 50

        local JumpxPower = mixc:AddSlider("JumpxPower", {
            Title = "跳跃力",
            Default = ggwalkspeed,
            Min = 50,
            Max = 200,
            Rounding = 0,
            Callback = function(Value)
                Settings.Jumppower = Value
                saveSettings()
                ggjumppower = Value
                game.Players.LocalPlayer.Character.Humanoid.JumpPower = Settings.Jumppower
            end
        })

        coroutine.resume(coroutine.create(function()
            while task.wait() do
                if game.Players.LocalPlayer.Character.Humanoid.JumpPower ~= ggjumppower then
                    game.Players.LocalPlayer.Character.Humanoid.JumpPower = ggjumppower
                end
            end
        end))
        
        local InfiniteJump = mixc:AddToggle("InfiniteJump", {Title = "无限跳跃", Default = Settings.infinjump or false})
            
        InfiniteJump:OnChanged(function()
            Settings.infinjump = InfiniteJump.Value
            saveSettings()
        end)

        function InfJumpFunction()
            pcall(function()
                if _G.infinJumpStarted == nil then
                    --Ensures this only runs once to save resources
                    _G.infinJumpStarted = true
    
                    --The actual infinite jump
                    local plr = game:GetService('Players').LocalPlayer
                    local m = plr:GetMouse()
                    m.KeyDown:connect(function(k)
                        if Settings.infinjump then
                            if k:byte() == 32 then
                            humanoid = game:GetService'Players'.LocalPlayer.Character:FindFirstChildOfClass('Humanoid')
                            humanoid:ChangeState('Jumping')
                            wait()
                            humanoid:ChangeState('Seated')
                            end
                        end
                    end)
                end
            end)
        end

        InfJumpFunction()

        function ESPPlayer() 
            local function createPlayerESP(player)
                local character = player.Character
                if character then
                    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                    if humanoidRootPart then
                        local BillboardGui = Instance.new('BillboardGui')
                        local TextLabel = Instance.new('TextLabel')
            
                        BillboardGui.Parent = humanoidRootPart
                        BillboardGui.AlwaysOnTop = true
                        BillboardGui.Size = UDim2.new(0, 50, 0, 50)
                        BillboardGui.StudsOffset = Vector3.new(0, 2, 0)
            
                        TextLabel.Parent = BillboardGui
                        TextLabel.BackgroundColor3 = Color3.new(1, 0, 0)
                        TextLabel.BackgroundTransparency = 1
                        TextLabel.Size = UDim2.new(1, 0, 1, 0)
                        TextLabel.Text = player.Name -- Display the player's name
                        TextLabel.TextColor3 = Color3.new(2, 2, 2)
                        TextLabel.TextScaled = true
                    end
                end
            end
            
            local function removePlayerESP(player)
                local character = player.Character
                if character then
                    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                    if humanoidRootPart then
                        local BillboardGui = humanoidRootPart:FindFirstChildOfClass("BillboardGui")
                        if BillboardGui then
                            BillboardGui:Destroy()
                        end
                    end
                end
            end
            
            for _, player in ipairs(game.Players:GetPlayers()) do
                if Settings.plrESP then
                    createPlayerESP(player)
                else
                    removePlayerESP(player)
                end
            end
        end
    
        ESPPlayer()

        local ESPPlayers = mixc:AddToggle("ESPPlayers", {Title = "ESP玩家", Default = Settings.plrESP or false})

        ESPPlayers:OnChanged(function()
            Settings.plrESP = ESPPlayers.Value
            saveSettings()
            ESPPlayer()  
        end)

        mixc:AddButton({
            Title = "重新加入",
            Callback = function()
                repeat  task.wait() until game:IsLoaded()
                warn("Rejoinning....") 
                game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
            end
        })

        mixc:AddButton({
            Title = "服务器跳跃",
            Callback = function()
                local Player = game.Players.LocalPlayer    
                local Http = game:GetService("HttpService")
                local TPS = game:GetService("TeleportService")
                local Api = "https://games.roblox.com/v1/games/"
                
                local _place,_id = game.PlaceId, game.JobId
                local _servers = Api.._place.."/servers/Public?sortOrder=Desc&limit=100"
                function ListServers(cursor)
                local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
                return Http:JSONDecode(Raw)
                end
                
                local Next; repeat
                local Servers = ListServers(Next)
                for i,v in next, Servers.data do
                    if v.playing < v.maxPlayers and v.id ~= _id then
                        local s,r = pcall(TPS.TeleportToPlaceInstance,TPS,_place,v.id,Player)
                        if s then break end
                    end
                end
                
                Next = Servers.nextPageCursor
                until not Next
            end
        })

        mixc:AddButton({
            Title = "加入最低服务器",
            Callback = function()
                local Http = game:GetService("HttpService")
                local TPS = game:GetService("TeleportService")
                local Api = "https://games.roblox.com/v1/games/"
                
                local _place = game.PlaceId
                local _servers = Api.._place.."/servers/Public?sortOrder=Asc&limit=100"
                function ListServers(cursor)
                local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
                return Http:JSONDecode(Raw)
                end
                
                local Server, Next; repeat
                local Servers = ListServers(Next)
                Server = Servers.data[1]
                Next = Servers.nextPageCursor
                until Server
                
                TPS:TeleportToPlaceInstance(_place,Server.id,game.Players.LocalPlayer)
            end
        })


        coroutine.resume(coroutine.create(function()
            while task.wait() do
                if game.PlaceId ~= 10515146389 then
                    game:GetService("ReplicatedStorage").ReplicatedStorage.Packages.Knit.Services.DungeonService.RF.StartDungeon:InvokeServer()
                    wait(20)
                end
            end
        end))


        Tabs.credits:AddParagraph({Title = "脚本由pa1n#8015制作", Content = "Thanks a lot to ArponAG & MSDOS for help with some features!"})

        local disc = Tabs.credits:AddSection("Discord")

        disc:AddButton({
            Title = "加入Discord！",
            Callback = function()
                local request = (syn and syn.request) or (http and http.request) or http_request
                local HttpService = game:GetService("HttpService")
                if request then
                request({
                Url = 'http://127.0.0.1:6463/rpc?v=1',
                Method = 'POST',
                Headers = {
                ['Content-Type'] = 'application/json',
                Origin = 'https://discord.com'
                },
                Body = HttpService:JSONEncode({
                cmd = 'INVITE_BROWSER',
                nonce = HttpService:GenerateGUID(false),
                args = {code = "W2XyGrNQUe"}
                })
                })
                end
            end
        })

        local Input = disc:AddInput("Input", {
            Title = "or",
            Default = "discord.gg/W2XyGrNQUe",
            Placeholder = "discord.gg/W2XyGrNQUe",
            Numeric = false,
            Finished = false,
            Callback = function(Value)
                print(Value)
            end
        })

        disc:AddParagraph({Title = "加入Discord以请求新功能并报告错误！"})

        local infox = Tabs.credits:AddSection("信息")

        infox:AddParagraph({Title = "即将添加更多功能"})

        ------------ EXTRA TELEPORT OPTIONS -------------
        local player = game.Players.LocalPlayer
        local character
        local humanoid
        local noclipActive = false
        local function enableNoclip()
            noclipActive = true
            if character then
                for _, part in pairs(character:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end
        local function disableNoclip()
            noclipActive = false
            if character then
                for _, part in pairs(character:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = true
                    end
                end
            end
        end
        coroutine.resume(coroutine.create(function()
            while task.wait() and game.PlaceId ~= 10515146389 do
                pcall(function()
                    if player and player.Character then
                        character = player.Character
                        humanoid = character:FindFirstChild("Humanoid")
                        humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

                        if humanoid and humanoid.Health > 0 then
                            if Settings.Nearest and Settings.FarmStyle == "Tween [Safer]" then 
                                enableNoclip()
                            elseif Settings.Nearest == false or Settings.Nearest == nil then
                                disableNoclip()
                            end
                        else
                            -- Character is dead or humanoid is not found
                            disableNoclip()
                        end
                    else
                        -- Player or character is not found
                        disableNoclip()
                    end
                    wait(1)
                end)
            end
        end))
        coroutine.resume(coroutine.create(function()
            while task.wait() do
                if Settings.Nearest and game.PlaceId ~= 10515146389 then
                    pcall(function()
                        if Settings.FarmStyle == "Tween [Safer]" then
                        localCharacter = game.Players.LocalPlayer.Character 
                        localCharacter:WaitForChild("HumanoidRootPart").Velocity = Vector3.new(0, 1, 0)
                        end
                    end)
                end
            end
        end))
        
        coroutine.resume(coroutine.create(function()
            pcall(function()
                if Workspace.Map.FireDungeon then
                    wait(2)
                    Workspace.Map.FireDungeon.Floor:Destroy()
                    Workspace.Map.FireDungeon.BaseFloor:Destroy()
                else
                    print("othergaymap")
                end
            end)
        end))
     -------- INTERFACE SETTINGS

        local interfacesection = Tabs.Settings:AddSection("Interface")

       ---Settings = {Theme = "Darker", Acrylic = false, Transparency = false, MenuKeybind = "K"}
        Settings.Theme = Settings.Theme or "Darker"
        Settings.MenuKeybind = Settings.MenuKeybind or "K"

        local InterfaceTheme = interfacesection:AddDropdown("InterfaceTheme", {
                Title = "主题",
                Description = "更改界面主题。",
                Values = Fluent.Themes,
                Default = Settings.Theme,
                Callback = function(Value)
                    Fluent:SetTheme(Value)
                    Settings.Theme = Value
                    saveSettings()
                end
            })
        
	        InterfaceTheme:SetValue(Settings.Theme)

            local AcrylicToggle = interfacesection:AddToggle("AcrylicToggle", {Title = "亚克力", Description = "The blurred background requires graphic quality 8+", Default = Settings.Acrylic or false})

            AcrylicToggle:OnChanged(function()
                Settings.Acrylic = AcrylicToggle.Value
                saveSettings()
                Fluent:ToggleAcrylic(Settings.Acrylic)
            end)
            
            Fluent:ToggleAcrylic(Settings.Acrylic)
            local TransparentToggle = interfacesection:AddToggle("TransparentToggle", {Title = "透明度", Description = "Makes the interface transparent.", Default = Settings.Transparency or false})

            TransparentToggle:OnChanged(function()
                Settings.Transparency = TransparentToggle.Value
                saveSettings()
                Fluent:ToggleTransparency(Settings.Transparency)
            end)

            local MenuKeybind = interfacesection:AddKeybind("MenuKeybind", { Title = "最小化绑定", Default = Settings.MenuKeybind})

            MenuKeybind:OnChanged(function()
                Settings.MenuKeybind = MenuKeybind.Value
                saveSettings()
            end)
            Fluent.MinimizeKeybind = MenuKeybind

    end ---------- (THE END OF DO)

    Fluent:Notify({Title = "Janina Hub", Content = "脚本已加载。", Duration = 4})

    Window:SelectTab(1)
    print'Script Loaded!'
end ---------- (THE END OF MAINSCRIPT)

local get_key = "ssdinle"

function NeedKey()
    local UIS = game:GetService("UserInputService")
    function dragify(Frame)
        local dragToggle = nil
        local dragSpeed = 0
        local dragInput = nil
        local dragStart = nil
        local dragPos = nil
        local function updateInput(input)
            local Delta = input.Position - dragStart
            local Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
            game:GetService("TweenService"):Create(Frame, TweenInfo.new(0.25), {Position = Position}):Play()
        end
        Frame.InputBegan:Connect(function(input)
            if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and UIS:GetFocusedTextBox() == nil then
                dragToggle = true
                dragStart = input.Position
                startPos = Frame.Position
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragToggle = false
                    end
                end)
            end
        end)
        Frame.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                dragInput = input
            end
        end)
        game:GetService("UserInputService").InputChanged:Connect(function(input)
            if input == dragInput and dragToggle then
                updateInput(input)
            end
        end)
    end

    local KeyXGUI = Instance.new("ScreenGui")
    local Container = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local Main = Instance.new("Frame")
    local TextLabel = Instance.new("TextLabel")
    local TextButton = Instance.new("TextButton")
    local UICorner_2 = Instance.new("UICorner")
    local TextButton_2 = Instance.new("TextButton")
    local UICorner_3 = Instance.new("UICorner")
    local TextButton_3 = Instance.new("TextButton")
    local UICorner_4 = Instance.new("UICorner")
    local TextBox = Instance.new("TextBox")
    local UICorner_5 = Instance.new("UICorner")
    local Topbar = Instance.new("Frame")
    local UICorner_6 = Instance.new("UICorner")
    local TextButton_4 = Instance.new("TextButton")
    local UICorner_7 = Instance.new("UICorner")
    local TextLabel_2 = Instance.new("TextLabel")
    local TextLabel_3 = Instance.new("TextLabel")
    local ImageLabel = Instance.new("ImageLabel")
    local Bottom = Instance.new("Frame")
    local TextLabel_4 = Instance.new("TextLabel")

    -- Properties:

    KeyXGUI.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    KeyXGUI.IgnoreGuiInset = true -- To ensure the UI stays centered on all platforms
    KeyXGUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    KeyXGUI.Name = "JaninaHubKeyUI"

    Container.Name = "Container"
    Container.Parent = KeyXGUI
    Container.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
    Container.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Container.Size = UDim2.new(0, 335, 0, 260)
    Container.Position = UDim2.new(0.5, -167, 0.5, -130) -- Center the container
    dragify(Container)

    UICorner.CornerRadius = UDim.new(0, 5)
    UICorner.Parent = Container

    Main.Name = "Main"
    Main.Parent = Container
    Main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Main.BackgroundTransparency = 1.000
    Main.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Main.BorderSizePixel = 0
    Main.Size = UDim2.new(1, 0, 1, 0)


    TextLabel.Parent = Main
    TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.BackgroundTransparency = 1.000
    TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TextLabel.BorderSizePixel = 0
    TextLabel.Size = UDim2.new(0, 335, 0, 136)
    TextLabel.Font = Enum.Font.SourceSans
    TextLabel.Text = "Status : Waiting For Key..."
    TextLabel.TextColor3 = Color3.fromRGB(69, 176, 99)
    TextLabel.TextSize = 20.000
    TextLabel.Name = "Status"

    TextButton.Parent = Main
    TextButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    TextButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TextButton.BorderSizePixel = 0
    TextButton.Position = UDim2.new(0.0595238097, 0, 0.57, 0)
    TextButton.Size = UDim2.new(0, 145, 0, 40)
    TextButton.Font = Enum.Font.SourceSans
    TextButton.Text = "Get Key"
    TextButton.TextColor3 = Color3.fromRGB(178, 178, 178)
    TextButton.TextSize = 17.000
    TextButton.Name = "CopyKeybtn"

    UICorner_2.CornerRadius = UDim.new(0, 5)
    UICorner_2.Parent = TextButton

    TextButton_2.Parent = Main
    TextButton_2.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    TextButton_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TextButton_2.BorderSizePixel = 0
    TextButton_2.Position = UDim2.new(0.505952358, 0, 0.57, 0)
    TextButton_2.Size = UDim2.new(0, 145, 0, 40)
    TextButton_2.Font = Enum.Font.SourceSans
    TextButton_2.Text = "Check Key"
    TextButton_2.TextColor3 = Color3.fromRGB(178, 178, 178)
    TextButton_2.TextSize = 17.000
    TextButton_2.Name = "KeyChecker"

    UICorner_3.CornerRadius = UDim.new(0, 5)
    UICorner_3.Parent = TextButton_2

    TextButton_3.Parent = Main
    TextButton_3.BackgroundColor3 = Color3.fromRGB(48, 102, 190)
    TextButton_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TextButton_3.BorderSizePixel = 0
    TextButton_3.Position = UDim2.new(0.28273809, 0, 0.76, 0)
    TextButton_3.Size = UDim2.new(0, 145, 0, 40)
    TextButton_3.Font = Enum.Font.SourceSans
    TextButton_3.Text = "Join Discord"
    TextButton_3.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextButton_3.TextSize = 17.000
    TextButton_3.Name = "JoinDiscord"

    UICorner_4.CornerRadius = UDim.new(0, 5)
    UICorner_4.Parent = TextButton_3

    TextBox.Parent = Main
    TextBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    TextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TextBox.BorderSizePixel = 0
    TextBox.Position = UDim2.new(0.0599999987, 0, 0.38, 0)
    TextBox.Size = UDim2.new(0, 295, 0, 40)
    TextBox.Font = Enum.Font.SourceSans
    TextBox.PlaceholderColor3 = Color3.fromRGB(178, 178, 178)
    TextBox.PlaceholderText = "Enter Your Key Here"
    TextBox.Text = ""
    TextBox.TextColor3 = Color3.fromRGB(178, 178, 178)
    TextBox.TextSize = 17.000
    TextBox.TextStrokeColor3 = Color3.fromRGB(178, 178, 178)
    TextBox.Name = "KeyBox"


    UICorner_5.CornerRadius = UDim.new(0, 5)
    UICorner_5.Parent = TextBox

    Topbar.Name = "Topbar"
    Topbar.Parent = Container
    Topbar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Topbar.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Topbar.BorderSizePixel = 0
    Topbar.Size = UDim2.new(0, 335, 0, 40)

    UICorner_6.CornerRadius = UDim.new(0, 5)
    UICorner_6.Parent = Topbar

    TextButton_4.Parent = Topbar
    TextButton_4.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    TextButton_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TextButton_4.BorderSizePixel = 0
    TextButton_4.Position = UDim2.new(0.899999976, 0, 0.119999997, 0)
    TextButton_4.Size = UDim2.new(0, 30, 0, 30)
    TextButton_4.Font = Enum.Font.Unknown
    TextButton_4.Text = "X"
    TextButton_4.TextColor3 = Color3.fromRGB(129, 129, 129)
    TextButton_4.TextSize = 10.000
    TextButton_4.Name = "CloseButton"

    UICorner_7.CornerRadius = UDim.new(0, 5)
    UICorner_7.Parent = TextButton_4

    TextLabel_2.Parent = Topbar
    TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel_2.BackgroundTransparency = 1.000
    TextLabel_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TextLabel_2.BorderSizePixel = 0
    TextLabel_2.Position = UDim2.new(0, 242, 0, 40)
    TextLabel_2.Size = UDim2.new(0, -50, 0, -40)
    TextLabel_2.Font = Enum.Font.SourceSansBold
    TextLabel_2.Text = "Key System"
    TextLabel_2.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel_2.TextSize = 22.00

    TextLabel_3.Parent = Topbar
    TextLabel_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel_3.BackgroundTransparency = 1.000
    TextLabel_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TextLabel_3.BorderSizePixel = 0
    TextLabel_3.Size = UDim2.new(0, 240, 0, 40)
    TextLabel_3.Font = Enum.Font.SciFi
    TextLabel_3.Text = "Janina Hub —"
    TextLabel_3.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel_3.TextSize = 17.000

    ImageLabel.Parent = Topbar
    ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ImageLabel.BackgroundTransparency = 1.000
    ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
    ImageLabel.BorderSizePixel = 0
    ImageLabel.Position = UDim2.new(0.0900000036, 0, 0.119999997, 0)
    ImageLabel.Size = UDim2.new(0, 30, 0, 30)
    ImageLabel.Image = "rbxassetid://14943357678"

    Bottom.Name = "Bottom"
    Bottom.Parent = Container
    Bottom.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Bottom.BackgroundTransparency = 1.000
    Bottom.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Bottom.BorderSizePixel = 0
    Bottom.Position = UDim2.new(0, 0, 1, 0)
    Bottom.Size = UDim2.new(0, 335, 0, -30)

    TextLabel_4.Parent = Bottom
    TextLabel_4.BackgroundColor3 = Color3.fromRGB(178, 178, 178)
    TextLabel_4.BackgroundTransparency = 1.000
    TextLabel_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TextLabel_4.BorderSizePixel = 0
    TextLabel_4.Size = UDim2.new(1, 0, 0, 30)
    TextLabel_4.Font = Enum.Font.Arial
    TextLabel_4.Text = "If you can't copy: discord.gg/W2XyGrNQUe"
    TextLabel_4.TextColor3 = Color3.fromRGB(178, 178, 178)
    TextLabel_4.TextSize = 11.000
    TextLabel_4.Position = UDim2.new(0, 0, 0, 4)

    local Statusx = Main:FindFirstChild("Status")

    local CloseButtonx = Topbar:FindFirstChild("CloseButton")
    local JoinDiscordbtn = Main:FindFirstChild("JoinDiscord")
    local CopyKeybtn = Main:FindFirstChild("CopyKeybtn")
    local KeyCheckerbtn = Main:FindFirstChild("KeyChecker")
    local Keybox = Main:FindFirstChild("KeyBox")

    CloseButtonx.MouseButton1Click:Connect(function()
        Container:Destroy()
    end)

    JoinDiscordbtn.MouseButton1Click:Connect(function()
        setclipboard(tostring("https://discord.gg/W2XyGrNQUe"))
        JoinDiscordbtn.Text = "Copied Discord Invite"
        task.wait(0.6)
        JoinDiscordbtn.Text = "Join Discord"
    end)

    CopyKeybtn.MouseButton1Click:Connect(function()
        setclipboard(tostring("https://janinahub.com"))
        CopyKeybtn.Text = "Copied Key Link"
        task.wait(0.6)
        CopyKeybtn.Text = "Get Key"
    end)

    KeyCheckerbtn.MouseButton1Click:Connect(function()
        warn('Verifying key...')
        warn('Verifying key...')
        task.wait()
        if Keybox.Text == get_key then
            Settings.Key = Keybox.Text
            saveSettings()
            Statusx.Text = "Status: Checking Key..."
            task.wait(1)
            Statusx.Text = "Status: Key is Correct!"
            task.wait(1)
            Statusx.Text = "Status: Loading GUI!"
            task.wait(1)
            Container:Destroy()
            MainScript()
        else
            Statusx.Text = "Status: Checking Key..."
            task.wait(1)
            Statusx.Text = "Status: Invalid Key :("
            task.wait(1)
            Statusx.Text = "Status: Please get a real key..."
            task.wait(1)
            Statusx.Text = "Status: Waiting for key..."
        end
    end)
end

function keychecker()
    if Settings.Key and Settings.Key == get_key then
        if game.PlaceId == 10515146389 then
            MainScript()
        elseif game.PlaceId ~= 10515146389 then
            repeat task.wait() warn'waitingforshittoload' until game:GetService("Players").LocalPlayer.PlayerGui.Main.StartBtn.Visible == true or game:GetService("Players").LocalPlayer.PlayerGui.Main.BossHealthBars.DungeonTimer.Visible == true
            MainScript()
        end
    else
        NeedKey()
    end
end

local CooldownTime = 5

function canOpenUI()
    if not _G.LastOpenTime then
        return true
    else
        local currentTime = tick()
        if currentTime - _G.LastOpenTime >= CooldownTime then
            return true
        else
            return false
        end
    end
end

if game:GetService("CoreGui"):FindFirstChild("ScreenGui") then
    print("Script Already Running!")
elseif not game:GetService("CoreGui"):FindFirstChild("ScreenGui") and canOpenUI() then
    repeat task.wait() until game:IsLoaded()
    repeat task.wait() until game.Workspace:FindFirstChild(game.Players.LocalPlayer.Name)
    repeat task.wait() until game:GetService("ReplicatedStorage"):FindFirstChild("ReplicatedStorage"):FindFirstChild("Packages"):FindFirstChild("Knit")
    _G.LastOpenTime = tick()
    keychecker()
end
