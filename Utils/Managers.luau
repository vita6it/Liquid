return(function(Folder)
    local Managers = {}
    local Settings = {}
    
    local PlaceId: number = game.PlaceId
    local HttpService: HttpService = game:GetService('HttpService')
    
    local FullPath: string = Folder .. "/settings/" .. PlaceId .. ".json"
    
    local isfolder = isfolder or (function( ... ) return( ... ) end)
    local makefolder = makefolder or (function( ... ) return( ... ) end)
    local isfile = isfile or (function( ... ) return( ... ) end)
    local readfile = readfile or (function( ... ) return( ... ) end)
    local writefile = writefile or (function( ... ) return( ... ) end)
    
    local function CreateFolders()
        local paths = {
            Folder,
            Folder .. "/settings"
        }

        for i = 1, #paths do
            local str = paths[i]

            if not isfolder(str) then
                makefolder(str)
            end
        end
    end
    
    do
        Managers.Default = function(index: string, value: any?)
            if Settings[index] == nil then
                Settings[index] = value
            end
        end 
        
        Managers.Save = function(index: string, value: any?)
            if index ~= nil then
                Settings[index] = value
            end

            if not isfolder(Folder) then
                makefolder(Folder)
            end

            if not isfolder(Folder .. "/settings") then
                makefolder(Folder .. "/settings")
            end

            writefile(FullPath, HttpService:JSONEncode(Settings))
        end
        
        Managers.Load = function()
            if not isfile(FullPath) then
               Managers.Save()
            end

            return HttpService:JSONDecode(readfile(FullPath))
        end

        Managers.GetPath = function()
            return FullPath
        end
    end
    
    do CreateFolders()
        Managers.Default('Initailized', true)
    end

    Settings = Managers.Load()

    return Managers, Settings
end)
