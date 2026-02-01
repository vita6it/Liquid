export type Info = { string }
export type Callback = () -> ()

export type ParallelsType = {
    NewOption: (Flag: string, Delay: number, Callback: () -> ()) -> (),
    NewOptionQueue: (Tag: string, Function: () -> (string | boolean)?, Confirm: boolean?) -> (),
}

export type ManagersType = {
    Default: (index: string, value: any?) -> (),
    Save: (index: string, value: any?) -> (),
    Load: () -> { [string]: any },
    GetPath: () -> string,
}

export type ComponentsType = {
    Window: (self: ComponentsType) -> {},
    AddTabs: (Window: {}, Asset: string | number) -> {},
    AddSection: (Tabs: {}, Info: Info) -> {},
    AddParagraph: (Section: {}, Info: Info) -> {},
    AddCodeBlock: (Section: {}, Info: Info, Icon: string | number) -> {},
    AddButton: (Section: {}, Info: Info, Callback: Callback) -> {},
    AddToggle: (Section: {}, Info: Info, Flag: string, IsQueueOptions: boolean, Callback: Callback) -> {},
    AddTextbox: (Section: {}, Info: Info, Flag: string, Callback: Callback) -> {},
    AddSlider: (Section: {}, Asset: string, Info: Info, Flag: string, Callback: Callback) -> {},
    AddDropdown: (Section: {}, Info: Info, List: { string }, Flag: string, Callback: Callback) -> {},
    AddKeybind: (Section: {}, Info: Info, Enums: Enum.KeyCode, Callback: Callback) -> {},
}

local _ENV = (getgenv or getrenv or getfenv)()

local Connections = _ENV.Connections or {} do
    _ENV.Connections = Connections

    for i = 1, #Connections do
        Connections[i]:Disconnect()
    end

    table.clear(Connections)
end

local Owner = "vita6it"
local Repository = "Liquid"
local Github = "https://raw.githubusercontent.com"

local VirtualInputManager = game:GetService("VirtualInputManager")
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService('UserInputService')
local TeleportService = game:GetService("TeleportService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService('Lighting')
local Players = game:GetService("Players")

local function Process(folder, file)
    return string.format("%s/%s/%s/main/%s/%s", Github, Owner, Repository, folder, file)
end

local function Importer(folder, file)
    local Url = Process(folder, file)
    local Response = game:HttpGet(Url)

    return loadstring(Response)()
end 

local function AddConnection(signal, callback)
    table.insert(Connections, signal:Connect(callback))
end

local Preload = {
    Parallels = Importer("Utils", "Parallels.luau"),
    Managers = Importer("Utils", "Managers.luau"),
    Games = Importer("Utils", "Game.luau"),
    Components = Importer("Utils", "Components.luau"),
}

local Managers: ManagersType, Settings = Preload.Managers("Liquid's Managers")
local Parallels: ParallelsType = Preload.Parallels(RunService)
local Components: ComponentsType = Preload.Components(Managers, Parallels.Cached, Parallels.FullOptions[1], Importer)
local Games = Preload.Games(Settings, AddConnection)

local Window = Components:Window()

Window.Managers(Window)
