return(function(Managers, Cached, Options, Importer)
    export type Info = { string }
    export type Callback = () -> ()

    local Components = {}

    local Library = Importer('Utils', 'Library.luau')
    local Setting: { [ string ]: any } = Managers.Setting or {}

    do
        Components.Info = {
            Title = "Liquid's Project",
            Description = "© 2026 Liquid. All rights reserved.",
            Logo = 139279406289857,
            Highligh = Color3.fromRGB(255, 255, 255),
            Transparent = true
        }
    end

    Components.Window = function(self)
        return Library:Window(self.Info)
    end

    Components.AddTabs = function(Window, Asset: string | number)
        return Window:Tabs(Asset)
    end

    Components.AddSection = function(Tabs, Info: Info)
        return Tabs:Section({
            Title = Info[1],
            Icon = Info[2]
        })
    end

    Components.AddParagraph = function(Section, Info: Info)
        return Section:Paragraph({
            Title = Info[1],
            Desc = Info[2] or nil
        })
    end
    
    Components.AddCodeBlock = function(Section, Info: Info, Icon: string | number)
        return Section:CodeBlock({
            Header = Info[1],
            Code = Info[2] or "print('Hello, World')",
            Icon = Icon
        })
    end

    Components.AddButton = function(Section, Info: Info, Callback: Callback)
        return Section:Button({
            Title = Info[1],
            Desc = Info[2] or nil,
            Callback = Callback
        })
    end

    Components.AddToggle = function(Section, Info: Info, Flag: string, IsQueueOptions: boolean, Callback: Callback)
        local Thread: thread = nil
        
        local function RunOnParallel(Value, Parallel)
            if IsQueueOptions then
                Options[Flag] = Value
            end
            
            if Value then
                Parallel = task.spawn(function()
                    if Cached[Flag] then Cached[Flag](Setting[Flag]) end
                end)
            else
                if Parallel then task.cancel(Parallel) end;
            end
        end
        
        return Section:Toggle({
            Title = Info[1],
            Desc = Info[2] or nil,
            Value = Setting[Flag] or false,
            Callback = function(self, Value)
                Setting[Flag] = Value
                
                Managers.Save(Flag, Value)
                RunOnParallel(Value, Thread)

                if Callback then Callback(Value) end
            end
        })
    end
    
    Components.AddTextbox = function(Section, Info: Info, Flag: string, Callback: Callback)
        return Section:Textbox({
            Title = Info[1],
            Desc = Info[2] or nil,
            Value = Setting[Flag] or "N/A",
            Callback = function(self, Value)
                Setting[Flag] = Value
                Managers.Save(Flag, Value)

                if Callback then Callback(Value) end
            end
        })
    end
    
    Components.AddSlider = function(Section, Asset: string, Info: Info, Flag: string, Callback: Callback)
        return Section:Slider({
            Icon = Asset,
            Min = Info[1],
            Max = Info[2],
            Rounding = Info[3] or 0,
            Value = Setting[Flag] or Info[1],
            Callback = function(Value)
                Setting[Flag] = Value
                Managers.Save(Flag, Value)

                if Callback then Callback(Value) end
            end,
        })
    end
    
    Components.AddDropdown = function(Section, Info: Info, List: { string }, Flag: string, Callback: Callback)
        return Section:Dropdown({
            Title = Info[1],
            List = List,
            Value = Setting[Flag] or Info[1],
            Multi = typeof(Setting[Flag]) == 'table' and true or false,
            Callback = function(Value)
                Setting[Flag] = Value
                Managers.Save(Flag, Value)

                if Callback then Callback(Value) end
            end,
        })
    end
    
    Components.AddKeybind = function(Section, Info: Info, Enums: Enum.KeyCode, Callback: Callback)
        return Section:Input({
            Title = Info[1],
            Desc = Info[2] or nil,
            Key = Enums,
            Value = false,
            Callback = function(self, Key, Value)
                if Callback then Callback(Value) end
            end,
        })
    end

    return Components
end)
