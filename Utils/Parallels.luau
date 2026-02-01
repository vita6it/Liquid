return(function(RunService)
    local _ENV = (getgenv or getrenv or getfenv)()
    local Parallels = {}

    do
        local Threads = {}

        local function Whiles(Flag, Callback, Condition, Delay)
            while Flag do
                local Tick = tick()

                if Callback then Callback() end
                if Condition and Condition() then break end

                repeat RunService.Heartbeat:Wait()
                until tick() - Tick >= (Delay or 0.1)
            end
        end

        Parallels.NewOption = function(Flag, Delay, Callback)
            Threads[Flag] = function(Value)
                Whiles(Value, Delay, Callback, function()
                    return not Value
                end)
            end
        end
    end

    do
        local function ShowErrorMessage(ErrorMessage)
            _ENV.ISLOADED = false
            _ENV.OnFarm = false

            local text = (`error [ { _ENV.RunningOption or "Null" } ] { ErrorMessage }`)

            if _ENV.error_message then
                _ENV.error_message.Text ..= `\n\n{ text }`

                return nil
            end

            local Message = Instance.new("Message", workspace) do
                _ENV.error_message = Message
                Message.Text = text
            end
        end

        local function RunQueue(Options)
            local Success, ErrorMessage = pcall(function()
                local function GetQueue()
                    for _, Option in Options do
                        _ENV.RunningOption = Option.Name

                        local Method = Option.Function()

                        if Method then
                            if type(Method) == "string" then
                                _ENV.RunningMethod = Method
                            end

                            return Method
                        end
                    end

                    _ENV.RunningOption, _ENV.RunningMethod = nil, nil
                end

                while task.wait(0) do
                    _ENV.OnFarm = if GetQueue() then true else false
                end
            end)

            ShowErrorMessage(ErrorMessage)
        end

        local Options = {}
        local clonedEnabled = {}
        local Functions = _ENV.FUNCTIONS or {}
        local FarmFunctions = _ENV.FARM_FUNCTIONS or {}

        local Enabled_Toggle_Debounce = false
        local Enabled_New_Values = {}

        local function UpdateEnabledOptions()
            table.clear(FarmFunctions)

            for index, value in pairs(Enabled_New_Values) do
                clonedEnabled[index] = value or nil
                Enabled_New_Values[index] = nil
            end

            for i = 1, #Functions do
                local funcData = Functions[i]
                if clonedEnabled[funcData.Name] then
                    table.insert(FarmFunctions, funcData)
                end
            end
        end

        local Enabled = _ENV.ENABLED_OPTIONS or setmetatable({}, {
            __newindex = function(self, index, value)
                Enabled_New_Values[index] = value or false

                if not Enabled_Toggle_Debounce then
                    Enabled_Toggle_Debounce = false
                    task.spawn(UpdateEnabledOptions)
                end
            end,
            __index = clonedEnabled
        })
        
        do
            _ENV.FUNCTIONS = Functions
            _ENV.ENABLED_OPTIONS = Enabled
            _ENV.FARM_FUNCTIONS = FarmFunctions

            if not _ENV.ISLOADED then
                _ENV.ISLOADED = true

                task.spawn(RunQueue, FarmFunctions)
            end
        end

        do table.clear(Functions) end

        local index = {}

        local function NewOptionQueue(Tag, Function, Confirm)
            if Confirm ~= false then
                local Data = { 
                    ["Name"] = Tag,
                    ["Function"] = Function
                }

                index[ Tag ] = Function
                table.insert(Functions, Data)
            end
        end
        
        Parallels.NewOptionQueue = NewOptionQueue
        Parallels.FullOptions = { Enabled, Options }
    end

    return Parallels
end)
