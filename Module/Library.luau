local a={}

local b=game:GetService'Players'
local c=game:GetService'RunService'
local d=game:GetService'UserInputService'
game:GetService'ContentProvider'
local e=game:GetService'TweenService'
local f=game:GetService'CoreGui'

local g=if d.TouchEnabled and not d.KeyboardEnabled then true else false

local h=b.LocalPlayer
local i=h.PlayerGui

local j=workspace.CurrentCamera

game.Players.LocalPlayer:GetMouse()

function a.Parent(k)
    if not c:IsStudio()then
        return(gethui and gethui())or f
    end

    return i
end

function a.Draggable(k,l,m)
    local n=false
    local o
    local p

    l.InputBegan:Connect(function(q)
        if q.UserInputType==Enum.UserInputType.MouseButton1
            or q.UserInputType==Enum.UserInputType.Touch then

            n=true

            if q.UserInputType==Enum.UserInputType.MouseButton1 then
                o=d:GetMouseLocation()
            else
                o=q.Position
            end

            p=m.Position

            q.Changed:Connect(function()
                if q.UserInputState==Enum.UserInputState.End then
                    n=false
                end
            end)
        end
    end)

    d.InputChanged:Connect(function(q)
        if n and(q.UserInputType==Enum.UserInputType.MouseMovement
            or q.UserInputType==Enum.UserInputType.Touch)then

            local r

            if q.UserInputType==Enum.UserInputType.MouseMovement then
                r=d:GetMouseLocation()
            else
                r=q.Position
            end

            local s=r-o

            m.Position=UDim2.new(
                p.X.Scale,
                p.X.Offset+s.X,
                p.Y.Scale,
                p.Y.Offset+s.Y
            )
        end
    end)
end

function a.Button(k,l)
    local m=Instance.new"TextButton"

    m.Name="Click"
    m.Parent=l
    m.BackgroundColor3=Color3.fromRGB(255,255,255)
    m.BackgroundTransparency=1.000
    m.BorderColor3=Color3.fromRGB(0,0,0)
    m.BorderSizePixel=0
    m.Size=UDim2.new(1,0,1,0)
    m.Font=Enum.Font.SourceSans
    m.Text=""
    m.TextColor3=Color3.fromRGB(0,0,0)
    m.TextSize=14.000
    m.ZIndex=l.ZIndex+3

    return m
end

function a.Tween(k,l)
    return e:Create(l.v,TweenInfo.new(l.t,Enum.EasingStyle[l.s],Enum.EasingDirection[l.d]),l.g)
end

function a.Effect(k,l,m)
    m.ClipsDescendants=true

    local n=h:GetMouse()

    local o=n.X-l.AbsolutePosition.X
    local p=n.Y-l.AbsolutePosition.Y

    if o<0 or p<0 or o>l.AbsoluteSize.X or p>l.AbsoluteSize.Y then
        return
    end

    local q=Instance.new"Frame"
    q.Parent=m
    q.BackgroundColor3=Color3.fromRGB(255,255,255)
    q.BackgroundTransparency=0.95
    q.BorderSizePixel=0
    q.AnchorPoint=Vector2.new(0.5,0.5)
    q.Position=UDim2.new(0,o,0,p)
    q.Size=UDim2.new(0,0,0,0)
    q.ZIndex=m.ZIndex

    local r=Instance.new"UICorner"
    r.CornerRadius=UDim.new(1,0)
    r.Parent=q

    local s=TweenInfo.new(2.5,Enum.EasingStyle.Back,Enum.EasingDirection.Out)

    local t=e:Create(q,s,{
        Size=UDim2.new(0,l.AbsoluteSize.X*1.5,0,l.AbsoluteSize.X*1.5),
        BackgroundTransparency=1
    })

    t.Completed:Connect(function()
        q:Destroy()
    end)

    t:Play()
end

function a.Asset(k,l)
    if typeof(l)=='number'then
        return"rbxassetid://"..l
    end

    if typeof(l)=='string'and l:find'rbxassetid://'then
        return l
    end

    return l
end

function a.VectorToUdim(k,l)
    return UDim2.new(0,l.X,0,l.Y)
end

function a.Resize(k,l,m,n,o,p)
    local q=false
    local r
    local s

    n=n or Vector2.new(50,50)
    o=o or Vector2.new(1000,1000)
    p=p or 1.5

    l.InputBegan:Connect(function(t)
        if t.UserInputType==Enum.UserInputType.MouseButton1
            or t.UserInputType==Enum.UserInputType.Touch then
            q=true
            r=t.Position
            s=m.Size

            t.Changed:Connect(function()
                if t.UserInputState==Enum.UserInputState.End then
                    q=false
                end
            end)
        end
    end)

    d.InputChanged:Connect(function(t)
        if q and(t.UserInputType==Enum.UserInputType.MouseMovement
            or t.UserInputType==Enum.UserInputType.Touch)then
            local u=(t.Position-r)*p

            local v=math.clamp(s.X.Offset+u.X,n.X,o.X)
            local w=math.clamp(s.Y.Offset+u.Y,n.Y,o.Y)

            m.Size=UDim2.new(
                s.X.Scale,v,
                s.Y.Scale,w
            )
        end
    end)
end

function a.BlurFrame(k,l)
    local m="Glass"
    local n={}
    local o=Instance.new('Folder',j)
    o.Name='BlurSnox'

    local p=99999999
    local q=math.random(1,p)

    local r=Instance.new('DepthOfFieldEffect',game:GetService'Lighting')
    r.FarIntensity=0
    r.FocusDistance=51.6
    r.InFocusRadius=50
    r.NearIntensity=1
    r.Name="DPT_"..q

    local s=Instance.new'Frame'
    s.Parent=l
    s.Size=UDim2.new(0.95,0,0.95,0)
    s.Position=UDim2.new(0.5,0,0.5,0)
    s.AnchorPoint=Vector2.new(0.5,0.5)
    s.BackgroundTransparency=1

    local t

    do
        local u=0
        function t()
            u=u+1
            return'neon::'..tostring(u)
        end
    end

    do
        local function IsNotNaN(u)
            return u==u
        end

        local u=IsNotNaN(j:ScreenPointToRay(0,0).Origin.x)

        while not u do
            c.RenderStepped:wait()
            u=IsNotNaN(j:ScreenPointToRay(0,0).Origin.x)
        end
    end

    local u;do
        local v,w,x,y=math.acos,math.max,math.pi,math.sqrt
        local z=0.2

        local function DrawTriangle(A,B,C,D,E)
            local F=(A-B).magnitude
            local G=(B-C).magnitude
            local H=(C-A).magnitude
            local I=w(F,G,H)
            local J,K,L

            if F==I then
                J,K,L=A,B,C
            elseif G==I then
                J,K,L=B,C,A
            elseif H==I then
                J,K,L=C,A,B
            end

            local M=((K-J).x*(L-J).x+(K-J).y*(L-J).y+(K-J).z*(L-J).z)/(J-K).magnitude
            local N=y((L-J).magnitude^2-M*M)
            local O=(J-K).magnitude-M

            local P=CFrame.new(K,J)
            local Q=CFrame.Angles(x/2,0,0)

            local R=P

            local S=(R*Q).lookVector
            local T=J+CFrame.new(J,K).lookVector*M
            local U=CFrame.new(T,L).lookVector
            local V=S.x*U.x+S.y*U.y+S.z*U.z

            local W=CFrame.Angles(0,0,v(V))

            R=R*W

            if((R*Q).lookVector-U).magnitude>0.01 then
                R=R*CFrame.Angles(0,0,-2*v(V))
            end

            R=R*CFrame.new(0,N/2,-(O+M/2))

            local X=P*W*CFrame.Angles(0,x,0)

            if((X*Q).lookVector-U).magnitude>0.01 then
                X=X*CFrame.Angles(0,0,2*v(V))
            end

            X=X*CFrame.new(0,N/2,O/2)

            if not D then
                D=Instance.new'Part'
                D.FormFactor='Custom'
                D.TopSurface=0
                D.BottomSurface=0
                D.Anchored=true
                D.CanCollide=false
                D.CastShadow=false
                D.Material=m
                D.Size=Vector3.new(z,z,z)
                local Y=Instance.new('SpecialMesh',D)
                Y.MeshType=2
                Y.Name='WedgeMesh'
            end

            D.WedgeMesh.Scale=Vector3.new(0,N/z,M/z)
            D.CFrame=R

            if not E then
                E=D:clone()
            end

            E.WedgeMesh.Scale=Vector3.new(0,N/z,O/z)
            E.CFrame=X

            return D,E
        end

        function u(A,B,C,D,E)
            E[1],E[2]=DrawTriangle(A,B,C,E[1],E[2])
            E[3],E[4]=DrawTriangle(C,B,D,E[3],E[4])
        end
    end

    if n[s]then
        return n[s].parts
    end

    local v=t()
    local w={}
    local x=Instance.new('Folder',o)
    x.Name=s.Name

    local y={}

    do
        local function add(z)
            if z:IsA'GuiObject'then
                y[#y+1]=z
                add(z.Parent)
            end
        end

        add(s)
    end

    local function UpdateOrientation(z)
        local A={
            Transparency=0.98;
            BrickColor=BrickColor.new'Institutional white';
        }
        local B=1-0.05*s.ZIndex

        local C,D=s.AbsolutePosition,s.AbsolutePosition+s.AbsoluteSize
        local E,F=Vector2.new(D.x,C.y),Vector2.new(C.x,D.y)
        do
            local G=0;
            for H,I in ipairs(y)do
                G=G+I.Rotation
            end
            if G~=0 and G%180~=0 then
                local H=C:lerp(D,0.5)
                local I,J=math.sin(math.rad(G)),math.cos(math.rad(G))

                C=Vector2.new(J*(C.x-H.x)-I*(C.y-H.y),I*(C.x-H.x)+J*(C.y-H.y))+H
                E=Vector2.new(J*(E.x-H.x)-I*(E.y-H.y),I*(E.x-H.x)+J*(E.y-H.y))+H
                F=Vector2.new(J*(F.x-H.x)-I*(F.y-H.y),I*(F.x-H.x)+J*(F.y-H.y))+H
                D=Vector2.new(J*(D.x-H.x)-I*(D.y-H.y),I*(D.x-H.x)+J*(D.y-H.y))+H
            end
        end

        u(
            j:ScreenPointToRay(C.x,C.y,B).Origin,
            j:ScreenPointToRay(E.x,E.y,B).Origin,
            j:ScreenPointToRay(F.x,F.y,B).Origin,
            j:ScreenPointToRay(D.x,D.y,B).Origin,
            w
        )

        if z then
            for G,H in pairs(w)do
                H.Parent=x
            end
            for G,H in pairs(A)do
                for I,J in pairs(w)do
                    J[G]=H
                end
            end
        end
    end

    UpdateOrientation(true)
    c:BindToRenderStep(v,2000,UpdateOrientation)

    return{
        r,
        s
    }
end

function a.Template(k,l,m,n,o)
    local p=Instance.new"Frame"
    local q=Instance.new"UIStroke"
    local r=Instance.new"UICorner"
    local s=Instance.new"Frame"
    local t=Instance.new"UIListLayout"
    local u=Instance.new"TextLabel"
    local v=Instance.new"TextLabel"
    local w=Instance.new"UIPadding"
    local x=Instance.new"Frame"
    local y=Instance.new"UIListLayout"
    local z=Instance.new"UIPadding"

    p.Name="Template"
    p.Parent=l
    p.BackgroundColor3=Color3.fromRGB(70,70,70)
    p.BackgroundTransparency=0.8199999928474426
    p.BorderColor3=Color3.fromRGB(0,0,0)
    p.BorderSizePixel=0
    p.Size=UDim2.new(1,0,0,63)

    q.Parent=p
    q.Color=Color3.fromRGB(25,25,25)
    q.Thickness=1
    q.Transparency=0.5

    r.Parent=p
    r.CornerRadius=UDim.new(0,4)

    s.Name="Text"
    s.Parent=p
    s.AnchorPoint=Vector2.new(0,0.5)
    s.BackgroundColor3=Color3.fromRGB(255,255,255)
    s.BackgroundTransparency=1
    s.BorderColor3=Color3.fromRGB(0,0,0)
    s.BorderSizePixel=0
    s.Position=UDim2.new(0,0,0.5,0)
    s.Size=UDim2.new(1,(o and-o)or-15,1,0)

    t.Parent=s
    t.SortOrder=Enum.SortOrder.LayoutOrder
    t.VerticalAlignment=Enum.VerticalAlignment.Center

    v.Name="Title"
    v.Parent=s
    v.BackgroundColor3=Color3.fromRGB(255,255,255)
    v.BackgroundTransparency=1
    v.BorderColor3=Color3.fromRGB(0,0,0)
    v.BorderSizePixel=0
    v.LayoutOrder=-1
    v.Size=UDim2.new(1,0,0,13)
    v.Font=Enum.Font.GothamSemibold
    v.RichText=true
    v.Text=m
    v.TextColor3=Color3.fromRGB(235,235,235)
    v.TextSize=13
    v.TextXAlignment=Enum.TextXAlignment.Left

    w.Parent=s
    w.PaddingBottom=UDim.new(0,2)
    w.PaddingLeft=UDim.new(0,15)

    x.Name="Scaler"
    x.Parent=p
    x.BackgroundColor3=Color3.fromRGB(255,255,255)
    x.BackgroundTransparency=1
    x.BorderColor3=Color3.fromRGB(0,0,0)
    x.BorderSizePixel=0
    x.Size=UDim2.new(1,0,1,0)

    y.Parent=x
    y.HorizontalAlignment=Enum.HorizontalAlignment.Right
    y.SortOrder=Enum.SortOrder.LayoutOrder
    y.VerticalAlignment=Enum.VerticalAlignment.Center

    z.Parent=x
    z.PaddingRight=UDim.new(0,20)

    if n then
        u.Name="Desc"
        u.Parent=s
        u.BackgroundColor3=Color3.fromRGB(145,145,145)
        u.BackgroundTransparency=1
        u.BorderColor3=Color3.fromRGB(0,0,0)
        u.BorderSizePixel=0
        u.Size=UDim2.new(1,0,0,20)
        u.Font=Enum.Font.GothamMedium
        u.RichText=true
        u.Text=n
        u.TextColor3=Color3.fromRGB(145,145,145)
        u.TextSize=11
        u.TextWrapped=true
        u.TextXAlignment=Enum.TextXAlignment.Left

        u:GetPropertyChangedSignal"TextBounds":Connect(function()
            u.Size=UDim2.new(1,0,0,u.TextBounds.Y)

            p.Size=UDim2.new(
                1,0,
                0,
                math.max(55,t.AbsoluteContentSize.Y+25)
            )
        end)
    else
        v:GetPropertyChangedSignal"TextBounds":Connect(function()
            v.Size=UDim2.new(1,0,0,v.TextBounds.Y)

            p.Size=UDim2.new(
                1,0,
                0,
                math.max(50,t.AbsoluteContentSize.Y+25)
            )
        end)
    end

    return p
end

local k={
    lua={
        "and","break","or","else","elseif","if","then","until","repeat","while","do","for","in","end",
        "local","return","function","export",
    },
    rbx={
        "game","workspace","script","math","string","table","task","wait","select","next","Enum",
        "tick","assert","shared","loadstring","tonumber","tostring","type",
        "typeof","unpack","Instance","CFrame","Vector3","Vector2","Color3","UDim","UDim2","Ray","BrickColor",
        "OverlapParams","RaycastParams","Axes","Random","Region3","Rect","TweenInfo",
        "collectgarbage","not","utf8","pcall","xpcall","_G","setmetatable","getmetatable","os","pairs","ipairs"
    },
    operators={
        "#","+","-","*","%","/","^","=","~","=","<",">",
    }
}

local l={
    numbers=Color3.fromHex"#FAB387",
    boolean=Color3.fromHex"#FAB387",
    operator=Color3.fromHex"#94E2D5",
    lua=Color3.fromHex"#CBA6F7",
    rbx=Color3.fromHex"#F38BA8",
    str=Color3.fromHex"#A6E3A1",
    comment=Color3.fromHex"#9399B2",
    null=Color3.fromHex"#F38BA8",
    call=Color3.fromHex"#89B4FA",
    self_call=Color3.fromHex"#89B4FA",
    local_property=Color3.fromHex"#CBA6F7",
}

local function createKeywordSet(m)
    local n={}
    for o,p in ipairs(m)do
        n[p]=true
    end
    return n
end

local m=createKeywordSet(k.lua)
local n=createKeywordSet(k.rbx)
local o=createKeywordSet(k.operators)

local function getHighlight(p,q)
    local r=p[q]

    if l[r.."_color"]then
        return l[r.."_color"]
    end

    if tonumber(r)then
        return l.numbers
    elseif r=="nil"then
        return l.null
    elseif r:sub(1,2)=="--"then
        return l.comment
    elseif o[r]then
        return l.operator
    elseif m[r]then
        return l.lua
    elseif n[r]then
        return l.rbx
    elseif r:sub(1,1)=="\""or r:sub(1,1)=="\'"then
        return l.str
    elseif r=="true"or r=="false"then
        return l.boolean
    end

    if p[q+1]=="("then
        if p[q-1]==":"then
            return l.self_call
        end

        return l.call
    end

    if p[q-1]=="."then
        if p[q-2]=="Enum"then
            return l.rbx
        end

        return l.local_property
    end
end

function a.Init(p,q)
    local r={}
    local s=""

    local t=false
    local u=false
    local v=false

    for w=1,#q do
        local x=q:sub(w,w)

        if u then
            if x=="\n"and not v then
                table.insert(r,s)
                table.insert(r,x)
                s=""

                u=false
            elseif q:sub(w-1,w)=="]]"and v then
                s=s.."]"

                table.insert(r,s)
                s=""

                u=false
                v=false
            else
                s=s..x
            end
        elseif t then
            if x==t and q:sub(w-1,w-1)~="\\"or x=="\n"then
                s=s..x
                t=false
            else
                s=s..x
            end
        else
            if q:sub(w,w+1)=="--"then
                table.insert(r,s)
                s="-"
                u=true
                v=q:sub(w+2,w+3)=="[["
            elseif x=="\""or x=="\'"then
                table.insert(r,s)
                s=x
                t=x
            elseif o[x]then
                table.insert(r,s)
                table.insert(r,x)
                s=""
            elseif x:match"[%w_]"then
                s=s..x
            else
                table.insert(r,s)
                table.insert(r,x)
                s=""
            end
        end
    end

    table.insert(r,s)

    local w={}

    for x,y in ipairs(r)do
        local z=getHighlight(r,x)

        if z then
            local A=string.format("<font color = \"#%s\">%s</font>",z:ToHex(),y:gsub("<","&lt;"):gsub(">","&gt;"))

            table.insert(w,A)
        else
            table.insert(w,y)
        end
    end

    return table.concat(w)
end

function a.Window(p,q)
    local r=q.Logo or 123458176076183
    local s=q.Title or'Liquid'
    local t=q.Description or'This is The Liquid Library.'
    local u=q.Transparent or false
    local v=q.Keybind or Enum.KeyCode.LeftControl
    local w=q.Highligh or Color3.fromRGB(255, 255, 255)

    local x=Vector2.new(800,600)
    local y=Vector2.new(500,350)
    local z=1

    local A=Instance.new"ScreenGui"do
        A.Name="Liquid"
        A.Parent=p:Parent()
        A.ZIndexBehavior=Enum.ZIndexBehavior.Global
        A.IgnoreGuiInset=true
    end

    local B=Instance.new"Frame"
    local C=Instance.new"UICorner"
    local D=Instance.new"UIStroke"
    local E=Instance.new"ImageLabel"
    local F=Instance.new"Frame"
    local G=Instance.new"ImageLabel"
    local H=Instance.new"UICorner"
    local I=Instance.new"ImageLabel"
    local J=Instance.new"UICorner"
    local K=Instance.new"ImageLabel"

    B.Name="Background"
    B.Parent=A
    B.AnchorPoint=Vector2.new(0.5,0.5)
    B.BackgroundColor3=Color3.fromRGB(28,28,28)
    B.BackgroundTransparency=u and 0.16 or 0
    B.BorderColor3=Color3.fromRGB(0,0,0)
    B.BorderSizePixel=0
    B.Position=UDim2.new(0.5,0,0.5,0)
    B.Size=a:VectorToUdim(if g then y else x)

    C.Parent=B

    D.Parent=B
    D.Color=Color3.fromRGB(65,65,65)
    D.Thickness=0.5

    a.Blured=a:BlurFrame(B)

    E.Name="Shadow"
    E.Parent=B
    E.AnchorPoint=Vector2.new(0.5,0.5)
    E.BackgroundColor3=Color3.fromRGB(0,0,0)
    E.BackgroundTransparency=1
    E.BorderColor3=Color3.fromRGB(0,0,0)
    E.BorderSizePixel=0
    E.Position=UDim2.new(0.5,0,0.5,0)
    E.Size=UDim2.new(1,120,1,120)
    E.ZIndex=0
    E.Image="rbxassetid://8992230677"
    E.ImageColor3=Color3.fromRGB(0,0,0)
    E.ImageTransparency=0.5
    E.ScaleType=Enum.ScaleType.Slice
    E.SliceCenter=Rect.new(99,99,99,99)

    F.Name="Effect"
    F.Parent=B
    F.BackgroundColor3=Color3.fromRGB(255,255,255)
    F.BackgroundTransparency=1
    F.BorderColor3=Color3.fromRGB(0,0,0)
    F.BorderSizePixel=0
    F.Size=UDim2.new(1,0,1,0)

    G.Name="Grid"
    G.Parent=F
    G.BackgroundColor3=Color3.fromRGB(255,255,255)
    G.BackgroundTransparency=1
    G.BorderColor3=Color3.fromRGB(0,0,0)
    G.BorderSizePixel=0
    G.Size=UDim2.new(1,0,1,0)
    G.Image="rbxassetid://9968344105"
    G.ImageTransparency=0.9750000238418579
    G.ScaleType=Enum.ScaleType.Tile
    G.TileSize=UDim2.new(0,128,0,128)

    H.Parent=G

    I.Name="GridDark"
    I.Parent=F
    I.BackgroundColor3=Color3.fromRGB(255,255,255)
    I.BackgroundTransparency=1
    I.BorderColor3=Color3.fromRGB(0,0,0)
    I.BorderSizePixel=0
    I.Size=UDim2.new(1,0,1,0)
    I.Image="rbxassetid://9968344227"
    I.ImageTransparency=0.949999988079071
    I.ScaleType=Enum.ScaleType.Tile
    I.TileSize=UDim2.new(0,128,0,128)

    J.Parent=I

    K.Name="ShadowCorner"
    K.Parent=B
    K.AnchorPoint=Vector2.new(0.5,0.5)
    K.BackgroundColor3=Color3.fromRGB(0,0,0)
    K.BackgroundTransparency=1
    K.BorderColor3=Color3.fromRGB(0,0,0)
    K.BorderSizePixel=0
    K.Position=UDim2.new(0.5,0,0.5,3)
    K.Size=UDim2.new(1,24,1,24)
    K.ZIndex=0
    K.Image="rbxassetid://138260268144845"
    K.ImageColor3=Color3.fromRGB(0,0,0)
    K.ImageTransparency=0.5
    K.ScaleType=Enum.ScaleType.Slice
    K.SliceCenter=Rect.new(99,99,99,99)

    local L=Instance.new'UIScale'do
        L.Scale=z
        L.Parent=A
    end

    local M=Instance.new"ScreenGui"do
        M.Name="Liquid"
        M.Parent=p:Parent()
        M.ZIndexBehavior=Enum.ZIndexBehavior.Global
        M.IgnoreGuiInset=true
    end

    local N=true
    local O

    local P=Instance.new"ImageLabel"do
        local Q=Instance.new"TextButton"
        P.Name="Toggle"
        P.Parent=M
        P.AnchorPoint=Vector2.new(1,0.5)
        P.BackgroundColor3=Color3.fromRGB(255,255,255)
        P.BackgroundTransparency=1
        P.BorderColor3=Color3.fromRGB(0,0,0)
        P.BorderSizePixel=0
        P.Position=UDim2.new(0.015,0,0.5,0)
        P.Size=UDim2.new(0,7,0,200)
        P.Image="rbxassetid://80999662900595"
        P.ImageTransparency=0.699999988079071
        P.ScaleType=Enum.ScaleType.Slice
        P.SliceCenter=Rect.new(256,256,256,256)
        P.SliceScale=0.38671875

        Q.Name="Input"
        Q.Parent=P
        Q.Active=true
        Q.AnchorPoint=Vector2.new(0.5,0.5)
        Q.BackgroundColor3=Color3.fromRGB(255,255,255)
        Q.BackgroundTransparency=1
        Q.BorderColor3=Color3.fromRGB(0,0,0)
        Q.BorderSizePixel=0
        Q.Position=UDim2.new(0.5,0,0.5,0)
        Q.Size=UDim2.new(1,25,1,25)
        Q.Font=Enum.Font.SourceSans
        Q.Text=""
        Q.TextSize=14
        Q.ZIndex=99

        O=function(R)
            a:Tween{
                v=P,
                t=0.2,
                s="Back",
                d="Out",
                g={ImageTransparency=0.3}
            }:Play()

            delay(0.05,function()
                a:Tween{
                    v=P,
                    t=0.2,
                    s="Back",
                    d="Out",
                    g={ImageTransparency=0.7}
                }:Play()
            end)

            if R then
                a:Tween{
                    v=L,
                    t=0.5,
                    s="Sine",
                    d="Out",
                    g={Scale=0}
                }:Play()
                a:Tween{
                    v=B,
                    t=0.3,
                    s="Back",
                    d="In",
                    g={Position=UDim2.new(0.5,0,1,0)}
                }:Play()
            else
                a:Tween{
                    v=L,
                    t=0.3,
                    s="Sine",
                    d="Out",
                    g={Scale=z}
                }:Play()
                a:Tween{
                    v=B,
                    t=0.3,
                    s="Back",
                    d="Out",
                    g={Position=UDim2.new(0.5,0,0.5,0)}
                }:Play()
            end
        end

        Q.MouseButton1Click:Connect(function()
            O(N)
            N=not N
        end)

        d.InputBegan:Connect(function(R,S)
            if not S and R.KeyCode==v then
                O(N)
                N=not N
            end
        end)
    end

    local Q=Instance.new"Frame"
    local R=Instance.new"Frame"
    local S=Instance.new"UIListLayout"
    local T=Instance.new"Frame"
    local U=Instance.new"Frame"
    local V=Instance.new"UIListLayout"
    local W=Instance.new"UIPadding"
    local X=Instance.new"Frame"
    local Y=Instance.new"TextLabel"
    local Z=Instance.new"UIListLayout"
    local _=Instance.new"TextLabel"
    local aa=Instance.new"ImageLabel"
    local ab=Instance.new"Frame"
    local ac=Instance.new"UIListLayout"
    local ad=Instance.new"UIPadding"
    local ae=Instance.new"Frame"
    local af=Instance.new"ImageLabel"
    local ag=Instance.new"Frame"
    local ah=Instance.new"ImageLabel"
    local ai=Instance.new"Frame"
    local aj=Instance.new"ImageLabel"
    local ak=Instance.new"UIPadding"

    Q.Name="Header"
    Q.Parent=B
    Q.BackgroundColor3=Color3.fromRGB(255,255,255)
    Q.BackgroundTransparency=1
    Q.BorderColor3=Color3.fromRGB(0,0,0)
    Q.BorderSizePixel=0
    Q.Size=UDim2.new(1,0,0,45)

    R.Name="Window"
    R.Parent=Q
    R.BackgroundColor3=Color3.fromRGB(255,255,255)
    R.BackgroundTransparency=1
    R.BorderColor3=Color3.fromRGB(0,0,0)
    R.BorderSizePixel=0
    R.Size=UDim2.new(1,0,1,0)

    S.Parent=R
    S.Padding=UDim.new(0,5)
    S.FillDirection=Enum.FillDirection.Horizontal
    S.SortOrder=Enum.SortOrder.LayoutOrder
    S.VerticalAlignment=Enum.VerticalAlignment.Center

    T.Name="Corner"
    T.Parent=R
    T.AnchorPoint=Vector2.new(0,0.5)
    T.BackgroundColor3=Color3.fromRGB(29,29,28)
    T.BackgroundTransparency=1
    T.BorderColor3=Color3.fromRGB(0,0,0)
    T.BorderSizePixel=0
    T.Position=UDim2.new(0,0,0.5,0)
    T.Size=UDim2.new(1,0,0,40)

    U.Name="Info"
    U.Parent=T
    U.BackgroundColor3=Color3.fromRGB(255,255,255)
    U.BackgroundTransparency=1
    U.BorderColor3=Color3.fromRGB(0,0,0)
    U.BorderSizePixel=0
    U.Size=UDim2.new(1,0,1,0)

    V.Parent=U
    V.Padding=UDim.new(0,10)
    V.FillDirection=Enum.FillDirection.Horizontal
    V.SortOrder=Enum.SortOrder.LayoutOrder
    V.VerticalAlignment=Enum.VerticalAlignment.Center

    W.Parent=U
    W.PaddingLeft=UDim.new(0,8)

    X.Name="Text"
    X.Parent=U
    X.BackgroundColor3=Color3.fromRGB(255,255,255)
    X.BackgroundTransparency=1
    X.BorderColor3=Color3.fromRGB(0,0,0)
    X.BorderSizePixel=0
    X.Position=UDim2.new(0,0,0.100000001,0)
    X.Size=UDim2.new(0,111,0,32)

    Y.Name="Title"
    Y.Parent=X
    Y.BackgroundColor3=Color3.fromRGB(255,255,255)
    Y.BackgroundTransparency=1
    Y.BorderColor3=Color3.fromRGB(0,0,0)
    Y.BorderSizePixel=0
    Y.Size=UDim2.new(0,200,0,14)
    Y.Font=Enum.Font.GothamSemibold
    Y.RichText=true
    Y.Text=s
    Y.TextColor3=Color3.fromRGB(235,235,235)
    Y.TextSize=14
    Y.TextXAlignment=Enum.TextXAlignment.Left

    Z.Parent=X
    Z.SortOrder=Enum.SortOrder.LayoutOrder
    Z.VerticalAlignment=Enum.VerticalAlignment.Center

    _.Name="Desc"
    _.Parent=X
    _.BackgroundColor3=Color3.fromRGB(255,255,255)
    _.BackgroundTransparency=1
    _.BorderColor3=Color3.fromRGB(0,0,0)
    _.BorderSizePixel=0
    _.Size=UDim2.new(0,200,0,14)
    _.Font=Enum.Font.GothamSemibold
    _.RichText=true
    _.Text=t
    _.TextColor3=Color3.fromRGB(145,145,145)
    _.TextSize=10
    _.TextTransparency=0
    _.TextXAlignment=Enum.TextXAlignment.Left

    aa.Name="Logo"
    aa.Parent=U
    aa.BackgroundColor3=Color3.fromRGB(255,255,255)
    aa.BackgroundTransparency=1
    aa.BorderColor3=Color3.fromRGB(0,0,0)
    aa.BorderSizePixel=0
    aa.LayoutOrder=-1
    aa.Size=UDim2.new(0,22,0,22)
    aa.Image=a:Asset(r)

    ab.Name="HeadButton"
    ab.Parent=T
    ab.BackgroundColor3=Color3.fromRGB(255,255,255)
    ab.BackgroundTransparency=1
    ab.BorderColor3=Color3.fromRGB(0,0,0)
    ab.BorderSizePixel=0
    ab.Size=UDim2.new(1,0,1,0)

    ac.Parent=ab
    ac.Padding=UDim.new(0,7)
    ac.FillDirection=Enum.FillDirection.Horizontal
    ac.HorizontalAlignment=Enum.HorizontalAlignment.Right
    ac.SortOrder=Enum.SortOrder.LayoutOrder
    ac.VerticalAlignment=Enum.VerticalAlignment.Center

    ad.Parent=ab
    ad.PaddingBottom=UDim.new(0,4)
    ad.PaddingRight=UDim.new(0,3)

    ae.Name="MaxSize"
    ae.Parent=ab
    ae.BackgroundColor3=Color3.fromRGB(255,255,255)
    ae.BackgroundTransparency=1
    ae.BorderColor3=Color3.fromRGB(0,0,0)
    ae.BorderSizePixel=0
    ae.LayoutOrder=998
    ae.Size=UDim2.new(0,25,0,25)

    af.Name="asset"
    af.Parent=ae
    af.AnchorPoint=Vector2.new(0.5,0.5)
    af.BackgroundColor3=Color3.fromRGB(255,255,255)
    af.BackgroundTransparency=1
    af.BorderColor3=Color3.fromRGB(0,0,0)
    af.BorderSizePixel=0
    af.Position=UDim2.new(0.5,0,0.5,0)
    af.Size=UDim2.new(0,16,0,16)
    af.Image="rbxassetid://9886659406"

    ag.Name="Destroy"
    ag.Parent=ab
    ag.BackgroundColor3=Color3.fromRGB(255,255,255)
    ag.BackgroundTransparency=1
    ag.BorderColor3=Color3.fromRGB(0,0,0)
    ag.BorderSizePixel=0
    ag.LayoutOrder=999
    ag.Size=UDim2.new(0,25,0,25)

    ah.Name="asset"
    ah.Parent=ag
    ah.AnchorPoint=Vector2.new(0.5,0.5)
    ah.BackgroundColor3=Color3.fromRGB(255,255,255)
    ah.BackgroundTransparency=1
    ah.BorderColor3=Color3.fromRGB(0,0,0)
    ah.BorderSizePixel=0
    ah.Position=UDim2.new(0.5,0,0.5,0)
    ah.Size=UDim2.new(0,16,0,16)
    ah.Image="rbxassetid://9886659671"

    ai.Name="Minisize"
    ai.Parent=ab
    ai.BackgroundColor3=Color3.fromRGB(255,255,255)
    ai.BackgroundTransparency=1
    ai.BorderColor3=Color3.fromRGB(0,0,0)
    ai.BorderSizePixel=0
    ai.LayoutOrder=995
    ai.Size=UDim2.new(0,25,0,25)

    aj.Name="asset"
    aj.Parent=ai
    aj.AnchorPoint=Vector2.new(0.5,0.5)
    aj.BackgroundColor3=Color3.fromRGB(255,255,255)
    aj.BackgroundTransparency=1
    aj.BorderColor3=Color3.fromRGB(0,0,0)
    aj.BorderSizePixel=0
    aj.Position=UDim2.new(0.5,0,0.5,0)
    aj.Size=UDim2.new(0,16,0,16)
    aj.Image="rbxassetid://9886659276"

    ak.Parent=R
    ak.PaddingLeft=UDim.new(0,4)
    ak.PaddingRight=UDim.new(0,5)
    ak.PaddingTop=UDim.new(0,3)

    if not g then
        local al=Vector2.new(500,350)
        local am=Vector2.new(800,600)
        local an=B.Size
        local ao=100
        local ap=a:Button(ae)

        local function Maxs(aq)
            if aq then
                if B.Size.Y.Offset~=am.Y then
                    local ar=a:Tween{
                        v=B,
                        t=0.2,
                        s="Exponential",
                        d="Out",
                        g={Size=UDim2.new(0,B.Size.X.Offset,0,am.Y)}
                    }

                    ar:Play()
                    ar.Completed:Wait()
                end

                if B.Size.X.Offset~=am.X then
                    a:Tween{
                        v=B,
                        t=0.2,
                        s="Exponential",
                        d="Out",
                        g={Size=UDim2.new(0,am.X,0,B.Size.Y.Offset)}
                    }:Play()
                end
            else
                if B.Size.X.Offset~=al.X then
                    local ar=a:Tween{
                        v=B,
                        t=0.2,
                        s="Exponential",
                        d="Out",
                        g={Size=UDim2.new(0,al.X,0,B.Size.Y.Offset)}
                    }

                    ar:Play()
                    ar.Completed:Wait()
                end

                if B.Size.Y.Offset~=al.Y then
                    a:Tween{
                        v=B,
                        t=0.2,
                        s="Exponential",
                        d="Out",
                        g={Size=UDim2.new(0,B.Size.X.Offset,0,al.Y)}
                    }:Play()
                end
            end
        end

        ap.MouseButton1Click:Connect(function()
            an=B.Size

            local aq=an.X.Offset
            local ar=an.Y.Offset

            local as=math.sqrt((aq-al.X)^2+(ar-al.Y)^2)
            local at=math.sqrt((aq-am.X)^2+(ar-am.Y)^2)

            if as<=ao then
                Maxs(true)
            elseif at<=ao then
                Maxs(false)
            else
                Maxs(true)
            end
        end)
    else
        ae.Visible=false
    end

    do
        local al=a:Button(ai)

        al.MouseButton1Click:Connect(function()
            O(N)
            N=not N
        end)
    end

    do
        local al=a:Button(ag)

        al.MouseButton1Click:Connect(function()
            A:Destroy()
            M:Destroy()
        end)
    end

    local al=Instance.new"Frame"
    local am=Instance.new"ImageLabel"
    local an=Instance.new"TextButton"
    local ao=Instance.new"Frame"

    al.Name="Components"
    al.Parent=B
    al.AnchorPoint=Vector2.new(0.5,0.5)
    al.BackgroundColor3=Color3.fromRGB(255,255,255)
    al.BackgroundTransparency=1
    al.BorderColor3=Color3.fromRGB(0,0,0)
    al.BorderSizePixel=0
    al.Position=UDim2.new(0.5,0,0.5,0)
    al.Size=UDim2.new(1,0,1,0)

    am.Name="Draggable"
    am.Parent=al
    am.AnchorPoint=Vector2.new(0.5,0)
    am.BackgroundColor3=Color3.fromRGB(255,255,255)
    am.BackgroundTransparency=1
    am.BorderColor3=Color3.fromRGB(0,0,0)
    am.BorderSizePixel=0
    am.Position=UDim2.new(0.5,0,1,4)
    am.Size=UDim2.new(0,200,0,4)
    am.Image="rbxassetid://80999662900595"
    am.ImageTransparency=0.800000011920929
    am.ScaleType=Enum.ScaleType.Slice
    am.SliceCenter=Rect.new(256,256,256,256)
    am.SliceScale=0.38671875

    an.Name="Input"
    an.Parent=am
    an.Active=true
    an.AnchorPoint=Vector2.new(0.5,0.5)
    an.BackgroundColor3=Color3.fromRGB(255,255,255)
    an.BackgroundTransparency=1
    an.BorderColor3=Color3.fromRGB(0,0,0)
    an.BorderSizePixel=0
    an.Position=UDim2.new(0.5,0,0.5,0)
    an.Size=UDim2.new(1,12,1,12)
    an.Font=Enum.Font.SourceSans
    an.Text=""
    an.TextSize=14

    ao.Name="Size"
    ao.Parent=al
    ao.AnchorPoint=Vector2.new(0.5,0.5)
    ao.BackgroundColor3=Color3.fromRGB(255,255,255)
    ao.BackgroundTransparency=1
    ao.BorderColor3=Color3.fromRGB(0,0,0)
    ao.BorderSizePixel=0
    ao.Position=UDim2.new(1,0,1,0)
    ao.Size=UDim2.new(0,40,0,40)
    ao.ZIndex=-99

    a:Draggable(an,B)
    a:Draggable(Q,B)
    a:Resize(ao,B,y,x,2)

    local ap=Instance.new"Frame"
    local aq=Instance.new"Frame"
    local ar=Instance.new"ScrollingFrame"
    local as=Instance.new"UIListLayout"
    local at=Instance.new"UIPadding"
    local au=Instance.new"Frame"
    local av=Instance.new"UIPadding"

    ap.Name="TabsScale"
    ap.Parent=B
    ap.BackgroundColor3=Color3.fromRGB(255,255,255)
    ap.BackgroundTransparency=1
    ap.BorderColor3=Color3.fromRGB(0,0,0)
    ap.BorderSizePixel=0
    ap.Size=UDim2.new(1,0,1,0)

    aq.Name="Tabs"
    aq.Parent=ap
    aq.BackgroundColor3=Color3.fromRGB(255,255,255)
    aq.BackgroundTransparency=1
    aq.BorderColor3=Color3.fromRGB(0,0,0)
    aq.BorderSizePixel=0
    aq.Size=UDim2.new(0,45,1,0)

    ar.Name="TabsScrolling"
    ar.Parent=aq
    ar.Active=true
    ar.BackgroundColor3=Color3.fromRGB(255,255,255)
    ar.BackgroundTransparency=1
    ar.BorderColor3=Color3.fromRGB(0,0,0)
    ar.BorderSizePixel=0
    ar.Size=UDim2.new(1,0,1,0)
    ar.ClipsDescendants=true
    ar.AutomaticCanvasSize=Enum.AutomaticSize.None
    ar.BottomImage="rbxasset://textures/ui/Scroll/scroll-bottom.png"
    ar.CanvasPosition=Vector2.new(0,0)
    ar.ElasticBehavior=Enum.ElasticBehavior.WhenScrollable
    ar.HorizontalScrollBarInset=Enum.ScrollBarInset.None
    ar.MidImage="rbxasset://textures/ui/Scroll/scroll-middle.png"
    ar.ScrollBarImageColor3=Color3.fromRGB(0,0,0)
    ar.ScrollBarImageTransparency=1
    ar.ScrollBarThickness=0
    ar.ScrollingDirection=Enum.ScrollingDirection.XY
    ar.TopImage="rbxasset://textures/ui/Scroll/scroll-top.png"
    ar.VerticalScrollBarInset=Enum.ScrollBarInset.None
    ar.VerticalScrollBarPosition=Enum.VerticalScrollBarPosition.Right

    as.Parent=ar
    as.Padding=UDim.new(0,3)
    as.HorizontalAlignment=Enum.HorizontalAlignment.Center
    as.SortOrder=Enum.SortOrder.LayoutOrder

    as:GetPropertyChangedSignal"AbsoluteContentSize":Connect(function()
        ar.CanvasSize=UDim2.new(0,0,0,as.AbsoluteContentSize.Y+15)
    end)

    at.Parent=ar
    at.PaddingBottom=UDim.new(0,5)
    at.PaddingTop=UDim.new(0,5)

    au.Name="LineTab"
    au.Parent=aq
    au.BackgroundColor3=Color3.fromRGB(65,65,65)
    au.BackgroundTransparency=0.5
    au.BorderColor3=Color3.fromRGB(0,0,0)
    au.BorderSizePixel=0
    au.Position=UDim2.new(1,0,0,0)
    au.Size=UDim2.new(0,1,1,0)

    av.Parent=ap
    av.PaddingTop=UDim.new(0,46)

    local aw=Instance.new"Frame"
    local ax=Instance.new"Frame"
    local ay=Instance.new"UIPadding"
    local az=Instance.new"UIPadding"
    local aA=Instance.new"Frame"

    aw.Name="PageScale"
    aw.Parent=B
    aw.BackgroundColor3=Color3.fromRGB(255,255,255)
    aw.BackgroundTransparency=1
    aw.BorderColor3=Color3.fromRGB(0,0,0)
    aw.BorderSizePixel=0
    aw.Size=UDim2.new(1,0,1,0)

    ax.Name="Page"
    ax.Parent=aw
    ax.BackgroundColor3=Color3.fromRGB(255,255,255)
    ax.BackgroundTransparency=1
    ax.BorderColor3=Color3.fromRGB(0,0,0)
    ax.BorderSizePixel=0
    ax.Size=UDim2.new(1,0,1,0)

    ay.Parent=ax
    ay.PaddingLeft=UDim.new(0,45)

    az.Parent=aw
    az.PaddingLeft=UDim.new(0,1)
    az.PaddingRight=UDim.new(0,1)
    az.PaddingTop=UDim.new(0,45)

    aA.Name="LineUpper"
    aA.Parent=aw
    aA.BackgroundColor3=Color3.fromRGB(65,65,65)
    aA.BackgroundTransparency=0.5
    aA.BorderColor3=Color3.fromRGB(0,0,0)
    aA.BorderSizePixel=0
    aA.Size=UDim2.new(1,0,0,1)

    local aB={
        Value=false
    }

    function aB.Tabs(aC,aD)
        local aE=Instance.new"Frame"
        local aF=Instance.new"UICorner"
        local aG=Instance.new"ImageLabel"
        local aH=a:Button(aE)

        aE.Name="Addtab"
        aE.Parent=ar
        aE.BackgroundColor3=Color3.fromRGB(100,100,100)
        aE.BackgroundTransparency=1
        aE.BorderColor3=Color3.fromRGB(0,0,0)
        aE.BorderSizePixel=0
        aE.Size=UDim2.new(0,35,0,35)

        aF.Parent=aE
        aF.CornerRadius=UDim.new(0,5)

        aG.Name="Icon"
        aG.Parent=aE
        aG.AnchorPoint=Vector2.new(0.5,0.5)
        aG.BackgroundColor3=Color3.fromRGB(255,255,255)
        aG.BackgroundTransparency=1
        aG.BorderColor3=Color3.fromRGB(0,0,0)
        aG.BorderSizePixel=0
        aG.Position=UDim2.new(0.5,0,0.5,0)
        aG.Size=UDim2.new(0,15,0,15)
        aG.ImageTransparency=0.5
        aG.Image=aD and a:Asset(aD)or 0

        local aI=Instance.new"Frame"
        local aJ=Instance.new"UICorner"

        aI.Name="SelectLine"
        aI.Parent=aE
        aI.BackgroundTransparency=1
        aI.AnchorPoint=Vector2.new(0.5,0.5)
        aI.BackgroundColor3=w
        aI.BorderColor3=Color3.fromRGB(0,0,0)
        aI.BorderSizePixel=0
        aI.Position=UDim2.new(0,0,0.5,0)
        aI.Size=UDim2.new(0,4,0,16)

        aJ.Parent=aI
        aJ.CornerRadius=UDim.new(1,0)

        local aK=Instance.new"Frame"
        local aL=Instance.new"UIPadding"
        local aM=Instance.new"ScrollingFrame"
        local aN=Instance.new"UIListLayout"

        aK.Name="AddPage"
        aK.Parent=ax
        aK.BackgroundColor3=Color3.fromRGB(255,255,255)
        aK.BackgroundTransparency=1
        aK.BorderColor3=Color3.fromRGB(0,0,0)
        aK.BorderSizePixel=0
        aK.Size=UDim2.new(1,0,1,0)
        aK.Visible=false
        aK.Position=UDim2.new(0,0,0,15)

        aL.Parent=aM
        aL.PaddingBottom=UDim.new(0,5)
        aL.PaddingLeft=UDim.new(0,5)
        aL.PaddingRight=UDim.new(0,5)
        aL.PaddingTop=UDim.new(0,7)

        aM.Name="PageScrolling"
        aM.Parent=aK
        aM.Active=true
        aM.BackgroundColor3=Color3.fromRGB(255,255,255)
        aM.BackgroundTransparency=1
        aM.BorderColor3=Color3.fromRGB(0,0,0)
        aM.BorderSizePixel=0
        aM.Size=UDim2.new(1,0,1,0)
        aM.ClipsDescendants=true
        aM.AutomaticCanvasSize=Enum.AutomaticSize.None
        aM.BottomImage="rbxasset://textures/ui/Scroll/scroll-bottom.png"
        aM.CanvasPosition=Vector2.new(0,0)
        aM.ElasticBehavior=Enum.ElasticBehavior.WhenScrollable
        aM.HorizontalScrollBarInset=Enum.ScrollBarInset.None
        aM.MidImage="rbxasset://textures/ui/Scroll/scroll-middle.png"
        aM.ScrollBarThickness=0
        aM.ScrollingDirection=Enum.ScrollingDirection.XY
        aM.TopImage="rbxasset://textures/ui/Scroll/scroll-top.png"
        aM.VerticalScrollBarInset=Enum.ScrollBarInset.None
        aM.VerticalScrollBarPosition=Enum.VerticalScrollBarPosition.Right

        aN.Parent=aM
        aN.Padding=UDim.new(0,5)
        aN.SortOrder=Enum.SortOrder.LayoutOrder

        aN:GetPropertyChangedSignal"AbsoluteContentSize":Connect(function()
            aM.CanvasSize=UDim2.new(0,0,0,aN.AbsoluteContentSize.Y+15)
        end)

        local function OnSelect()
            for aO,aP in pairs(ax:GetChildren())do
                if aP.Name=="AddPage"then
                    aP.Visible=false
                    aP.Position=UDim2.new(0,0,0,15)
                end
            end

            for aO,aP in pairs(ar:GetChildren())do
                if aP.Name=="Addtab"then
                    a:Tween{
                        v=aP,
                        t=0.2,
                        s="Exponential",
                        d="Out",
                        g={BackgroundTransparency=1}
                    }:Play()

                    a:Tween{
                        v=aP.SelectLine,
                        t=0.2,
                        s="Exponential",
                        d="Out",
                        g={BackgroundTransparency=1}
                    }:Play()

                    a:Tween{
                        v=aP.Icon,
                        t=0.2,
                        s="Exponential",
                        d="Out",
                        g={ImageTransparency=0.5}
                    }:Play()
                end
            end

            a:Tween{
                v=aE,
                t=0.2,
                s="Exponential",
                d="Out",
                g={BackgroundTransparency=0.89}
            }:Play()

            a:Tween{
                v=aG,
                t=0.2,
                s="Exponential",
                d="Out",
                g={ImageTransparency=0}
            }:Play()

            a:Tween{
                v=aI,
                t=0.2,
                s="Exponential",
                d="Out",
                g={BackgroundTransparency=0}
            }:Play()

            aI.Size=UDim2.new(0,4,0,0)
            task.delay(0.05,function()
                a:Tween{
                    v=aI,
                    t=0.3,
                    s="Back",
                    d="Out",
                    g={Size=UDim2.new(0,4,0,16)}
                }:Play()
            end)

            aK.Visible=true

            a:Tween{
                v=aK,
                t=0.3,
                s="Back",
                d="Out",
                g={Position=UDim2.new(0,0,0,0)}
            }:Play()
        end

        task.delay(0.1,function()
            if not aB.Value then
                aB.Value=true

                a:Tween{
                    v=aE,
                    t=0.2,
                    s="Exponential",
                    d="Out",
                    g={BackgroundTransparency=0.89}
                }:Play()

                a:Tween{
                    v=aG,
                    t=0.2,
                    s="Exponential",
                    d="Out",
                    g={ImageTransparency=0}
                }:Play()

                a:Tween{
                    v=aI,
                    t=0.2,
                    s="Exponential",
                    d="Out",
                    g={BackgroundTransparency=0}
                }:Play()

                aI.Size=UDim2.new(0,4,0,0)
                task.delay(0.05,function()
                    a:Tween{
                        v=aI,
                        t=0.3,
                        s="Back",
                        d="Out",
                        g={Size=UDim2.new(0,4,0,16)}
                    }:Play()
                end)

                aK.Visible=true

                a:Tween{
                    v=aK,
                    t=0.3,
                    s="Back",
                    d="Out",
                    g={Position=UDim2.new(0,0,0,0)}
                }:Play()
            end
        end)

        aH.MouseButton1Click:Connect(OnSelect)

        local aO={}

        function aO.Select(aP)
            OnSelect()
        end

        function aO.Section(aP,aQ)
            local aR=aQ.Title or'Section'
            local aS=aQ.Icon or nil

            local aT=Instance.new"Frame"
            local aU=Instance.new"UIListLayout"
            local aV=Instance.new"TextLabel"
            local aW=Instance.new"ImageLabel"
            local aX=Instance.new"UIPadding"

            aT.Name="Section"
            aT.Parent=aM
            aT.AnchorPoint=Vector2.new(0.5,0.5)
            aT.BackgroundColor3=Color3.fromRGB(255,255,255)
            aT.BackgroundTransparency=1
            aT.BorderColor3=Color3.fromRGB(0,0,0)
            aT.BorderSizePixel=0
            aT.Position=UDim2.new(0.5,0,0.5,0)
            aT.Size=UDim2.new(1,0,0,20)

            aU.Parent=aT
            aU.Padding=UDim.new(0,5)
            aU.FillDirection=Enum.FillDirection.Horizontal
            aU.SortOrder=Enum.SortOrder.LayoutOrder
            aU.VerticalAlignment=Enum.VerticalAlignment.Center

            aV.Name="Title"
            aV.Parent=aT
            aV.BackgroundColor3=Color3.fromRGB(255,255,255)
            aV.BackgroundTransparency=1
            aV.BorderColor3=Color3.fromRGB(0,0,0)
            aV.BorderSizePixel=0
            aV.LayoutOrder=-1
            aV.Position=UDim2.new(0.052873563,0,-0.25,0)
            aV.Size=UDim2.new(0.899999976,0,0,15)
            aV.Font=Enum.Font.GothamBold
            aV.RichText=true
            aV.Text=aR
            aV.TextColor3=Color3.fromRGB(235,235,235)
            aV.TextSize=15
            aV.TextTransparency=0.2
            aV.TextXAlignment=Enum.TextXAlignment.Left

            if aS then
                aW.Name="Icon"
                aW.Parent=aT
                aW.AnchorPoint=Vector2.new(0.5,0.5)
                aW.BackgroundColor3=Color3.fromRGB(255,255,255)
                aW.BackgroundTransparency=1
                aW.BorderColor3=Color3.fromRGB(0,0,0)
                aW.BorderSizePixel=0
                aW.LayoutOrder=-5
                aW.Position=UDim2.new(0.5,0,0.5,0)
                aW.Size=UDim2.new(0,16,0,16)
                aW.Image=a:Asset(aS)
                aW.ImageTransparency=0.2
            end

            aX.Parent=aT
            aX.PaddingBottom=UDim.new(0,10)
            aX.PaddingLeft=UDim.new(0,5)
            aX.PaddingRight=UDim.new(0,5)
            aX.PaddingTop=UDim.new(0,10)

            local aY={}

            function aY.Visible(aZ,a_)
                aT.Visible=a_
            end

            return aY
        end

        function aO.Paragraph(aP,aQ)
            local aR=aQ.Title or"Title"
            local aS=aQ.Desc or nil

            local aT=a:Template(aM,aR,aS,nil)

            local aU={}

            function aU.SetTitle(aV,aW)
                aT.Text.Title.Text=aW
            end

            function aU.SetDesc(aV,aW)
                aT.Text.Desc.Text=aW
            end

            function aU.SetAll(aV,aW)
                aT.Text.Title.Text=aW[1]
                aT.Text.Desc.Text=aW[2]
            end

            function aU.Visible(aV,aW)
                aT.Visible=aW
            end

            function aU.GetFrame(aV)
                return aT
            end

            function aU.Slider(aV,aW)
                local aX=aW.Icon or nil
                local aY=aW.Min or 1
                local aZ=aW.Max or 10
                local a_=aW.Value or aY
                local a0=aW.Rounding or 0
                local a1=aW.Callback or(function(...)
                    return...
                end)

                local a2=Instance.new"Frame"
                local a3=Instance.new"UIStroke"
                local a4=Instance.new"UICorner"
                local a5=Instance.new"Frame"
                local a6=Instance.new"UIListLayout"
                local a7=Instance.new"ImageLabel"
                local a8=Instance.new"UIPadding"
                local a9=Instance.new"Frame"
                local ba=Instance.new"UICorner"
                local bb=Instance.new"Frame"
                local bc=Instance.new"UICorner"
                local bd=Instance.new"Frame"
                local be=Instance.new"UICorner"
                local bf=Instance.new"Frame"
                local bg=Instance.new"Frame"
                local bh=Instance.new"UIPadding"
                local bi=Instance.new"Frame"
                local bj=Instance.new"UICorner"
                local bk=Instance.new"UIStroke"
                local bl=Instance.new"UIPadding"
                local bm=Instance.new"ImageLabel"
                local bn=Instance.new"UIListLayout"
                local bo=Instance.new"TextBox"
                local bp=Instance.new"UIListLayout"

                local bq=a:Button(bf)

                a2.Name="Template"
                a2.Parent=aM
                a2.BackgroundColor3=Color3.fromRGB(70,70,70)
                a2.BackgroundTransparency=0.8199999928474426
                a2.BorderColor3=Color3.fromRGB(0,0,0)
                a2.BorderSizePixel=0
                a2.Size=UDim2.new(1,0,0,50)

                a3.Parent=a2
                a3.Color=Color3.fromRGB(25,25,25)
                a3.Thickness=1
                a3.Transparency=0.5

                a4.Parent=a2
                a4.CornerRadius=UDim.new(0,4)

                a5.Name="Slider"
                a5.Parent=a2
                a5.BackgroundColor3=Color3.fromRGB(255,255,255)
                a5.BackgroundTransparency=1
                a5.BorderColor3=Color3.fromRGB(0,0,0)
                a5.BorderSizePixel=0
                a5.Size=UDim2.new(1,0,1,0)

                a6.Parent=a5
                a6.Padding=UDim.new(0,20)
                a6.FillDirection=Enum.FillDirection.Horizontal
                a6.SortOrder=Enum.SortOrder.LayoutOrder
                a6.VerticalAlignment=Enum.VerticalAlignment.Center

                a7.Name="Icon"
                a7.Parent=a5
                a7.AnchorPoint=Vector2.new(0.5,0.5)
                a7.BackgroundColor3=Color3.fromRGB(255,255,255)
                a7.BackgroundTransparency=1
                a7.BorderColor3=Color3.fromRGB(0,0,0)
                a7.BorderSizePixel=0
                a7.LayoutOrder=-5
                a7.Position=UDim2.new(0.5,0,0.5,0)
                a7.Size=UDim2.new(0,20,0,20)
                a7.Image=a:Asset(aX)
                a7.ImageTransparency=0.30000001192092896

                a8.Parent=a5
                a8.PaddingLeft=UDim.new(0,15)

                a9.Name="DarkBar"
                a9.Parent=a5
                a9.BackgroundColor3=Color3.fromRGB(0,0,0)
                a9.BackgroundTransparency=0.75
                a9.BorderColor3=Color3.fromRGB(0,0,0)
                a9.BorderSizePixel=0
                a9.Size=UDim2.new(1,-125,0,5)

                ba.Parent=a9

                bb.Name="ActiveBar"
                bb.Parent=a9
                bb.BackgroundColor3=w
                bb.BorderColor3=Color3.fromRGB(0,0,0)
                bb.BorderSizePixel=0
                bb.Size=UDim2.new(0.5,0,1,0)

                bc.Parent=bb

                bd.Name="Circle"
                bd.Parent=bb
                bd.AnchorPoint=Vector2.new(1,0.5)
                bd.BackgroundColor3=w
                bd.BorderColor3=Color3.fromRGB(0,0,0)
                bd.BorderSizePixel=0
                bd.Position=UDim2.new(1,0,0.5,0)
                bd.Size=UDim2.new(0,15,0,15)

                be.Parent=bd
                be.CornerRadius=UDim.new(1,0)

                bf.Name="Slide"
                bf.Parent=a9
                bf.AnchorPoint=Vector2.new(0.5,0.5)
                bf.BackgroundColor3=Color3.fromRGB(255,255,255)
                bf.BackgroundTransparency=1
                bf.BorderColor3=Color3.fromRGB(0,0,0)
                bf.BorderSizePixel=0
                bf.Position=UDim2.new(0.5,0,0.5,0)
                bf.Size=UDim2.new(1,10,1,20)

                bg.Name="Scaler"
                bg.Parent=a2
                bg.BackgroundColor3=Color3.fromRGB(255,255,255)
                bg.BackgroundTransparency=1
                bg.BorderColor3=Color3.fromRGB(0,0,0)
                bg.BorderSizePixel=0
                bg.Size=UDim2.new(1,0,1,0)

                bh.Parent=bg
                bh.PaddingRight=UDim.new(0,15)

                bi.Name="Textbox"
                bi.Parent=bg
                bi.BackgroundColor3=Color3.fromRGB(0,0,0)
                bi.BackgroundTransparency=0.8999999761581421
                bi.BorderColor3=Color3.fromRGB(0,0,0)
                bi.BorderSizePixel=0
                bi.Position=UDim2.new(0.850467265,0,0.301587313,0)
                bi.Size=UDim2.new(0,60,0,25)

                bj.Parent=bi
                bj.CornerRadius=UDim.new(0,5)

                bk.Parent=bi
                bk.Color=Color3.fromRGB(75,75,75)
                bk.Thickness=1

                bl.Parent=bi
                bl.PaddingRight=UDim.new(0,5)

                bm.Name="Icon"
                bm.Parent=bi
                bm.AnchorPoint=Vector2.new(0.5,0.5)
                bm.BackgroundColor3=Color3.fromRGB(255,255,255)
                bm.BackgroundTransparency=1
                bm.BorderColor3=Color3.fromRGB(0,0,0)
                bm.BorderSizePixel=0
                bm.Position=UDim2.new(0.5,0,0.5,0)
                bm.Size=UDim2.new(0,15,0,15)
                bm.Image="rbxassetid://123909267283672"
                bm.ImageTransparency=0.10000000149011612

                bn.Parent=bi
                bn.Padding=UDim.new(0,5)
                bn.FillDirection=Enum.FillDirection.Horizontal
                bn.HorizontalAlignment=Enum.HorizontalAlignment.Right
                bn.SortOrder=Enum.SortOrder.LayoutOrder
                bn.VerticalAlignment=Enum.VerticalAlignment.Center

                bo.Name="Value"
                bo.Parent=bi
                bo.Active=true
                bo.BackgroundColor3=Color3.fromRGB(255,255,255)
                bo.BackgroundTransparency=1
                bo.BorderColor3=Color3.fromRGB(0,0,0)
                bo.BorderSizePixel=0
                bo.Size=UDim2.new(1,-25,1,0)
                bo.Font=Enum.Font.GothamMedium
                bo.PlaceholderColor3=Color3.fromRGB(100,100,100)
                bo.PlaceholderText=""
                bo.Text="N/A"
                bo.TextColor3=Color3.fromRGB(145,145,145)
                bo.TextSize=12
                bo.TextXAlignment=Enum.TextXAlignment.Left

                bp.Parent=bg
                bp.HorizontalAlignment=Enum.HorizontalAlignment.Right
                bp.SortOrder=Enum.SortOrder.LayoutOrder
                bp.VerticalAlignment=Enum.VerticalAlignment.Center

                local function roundToDecimal(br,bs)
                    local bt=10^bs
                    return math.floor(br*bt+0.5)/bt
                end

                local function updateSlider(br)
                    br=math.clamp(br,aY,aZ)
                    br=roundToDecimal(br,a0)
                    a:Tween{
                        v=bb,
                        t=0.5,
                        s="Exponential",
                        d="Out",
                        g={Size=UDim2.new((br-aY)/(aZ-aY),0,1,0)}
                    }:Play()

                    local bs=tonumber(bo.Text)or 0
                    local bt=br

                    local bu=5
                    local bv=bs

                    for bw=1,bu do
                        task.wait(0.01/bu)
                        bv=bv+(bt-bs)/bu
                        bo.Text=tostring(roundToDecimal(bv,a0))
                    end

                    bo.Text=tostring(roundToDecimal(bt,a0))

                    a1(br)
                end

                updateSlider(a_ or 0)

                local function move(br)
                    local bs=a9
                    local bt=math.clamp((br.Position.X-bs.AbsolutePosition.X)/bs.AbsoluteSize.X,0,1)
                    local bu=bt*(aZ-aY)+aY
                    updateSlider(bu)
                end

                bo.Focused:Connect(function()
                    a5.Visible=false

                    a:Tween{
                        v=bi,
                        t=0.5,
                        s="Exponential",
                        d="Out",
                        g={
                            Size=UDim2.new(1,-15,0,25)
                        }
                    }:Play()

                    bk.Color=w
                end)

                bo.FocusLost:Connect(function()
                    a:Tween{
                        v=bi,
                        t=0.5,
                        s="Exponential",
                        d="Out",
                        g={
                            Size=UDim2.new(0,60,0,25)
                        }
                    }:Play()

                    delay(0.1,function()
                        a5.Visible=true
                        bk.Color=Color3.fromRGB(75,75,75)

                        local br=tonumber(bo.Text)or aY
                        updateSlider(br)
                    end)
                end)

                local br=false

                bq.InputBegan:Connect(function(bs)
                    if bs.UserInputType==Enum.UserInputType.MouseButton1 or bs.UserInputType==Enum.UserInputType.Touch then
                        br=true
                        move(bs)
                    end
                end)

                bq.InputEnded:Connect(function(bs)
                    if bs.UserInputType==Enum.UserInputType.MouseButton1 or bs.UserInputType==Enum.UserInputType.Touch then
                        br=false
                    end
                end)

                d.InputChanged:Connect(function(bs)
                    if br and(bs.UserInputType==Enum.UserInputType.MouseMovement or bs.UserInputType==Enum.UserInputType.Touch)then
                        move(bs)
                    end
                end)

                local bs={}

                function bs.SetValue(bt,bu)
                    updateSlider(bu)
                end

                return bs
            end

            return aU
        end

        function aO.Button(aP,aQ)
            local aR=aQ.Title or"Title"
            local aS=aQ.Desc or nil
            local aT=aQ.Callback or(function(...)
                return...
            end)

            local aU=a:Template(aM,aR,aS,65)
            local aV=a:Button(aU)

            local aW=Instance.new"ImageLabel"
            aW.Name="Arrow"
            aW.Parent=aU.Scaler
            aW.BackgroundColor3=Color3.fromRGB(255,255,255)
            aW.BackgroundTransparency=1
            aW.BorderColor3=Color3.fromRGB(0,0,0)
            aW.BorderSizePixel=0
            aW.Size=UDim2.new(0,16,0,16)
            aW.Image="rbxassetid://10709791437"

            local aX={}

            local function OnClick()
                for aY,aZ in pairs(ax:GetChildren())do
                    if aZ.Name=="Dropdown"and aZ.Visible then
                        return
                    end
                end

                aT(aX)

                a:Effect(aV,aU)
            end

            aV.MouseButton1Click:Connect(OnClick)

            function aX.Fire(aY)
                return aT(aY)
            end

            function aX.SetCallback(aY,aZ)
                aT=aZ
            end

            function aX.SetTitle(aY,aZ)
                aU.Text.Title.Text=aZ
            end

            function aX.SetDesc(aY,aZ)
                aU.Text.Desc.Text=aZ
            end

            function aX.SetAll(aY,aZ)
                aU.Text.Title.Text=aZ[1]
                aU.Text.Desc.Text=aZ[2]
            end

            function aX.Visible(aY,aZ)
                aU.Visible=aZ
            end

            function aX.GetFrame(aY)
                return aU
            end

            return aX
        end

        function aO.Toggle(aP,aQ)
            local aR=aQ.Title or'Title'
            local aS=aQ.Desc or nil
            local aT=aQ.Value or false
            local aU=aQ.Callback or(function(...)
                return...
            end)

            local aV=a:Template(aM,aR,aS,65)
            local aW=a:Button(aV)

            local aX=Instance.new"Frame"
            local aY=Instance.new"UICorner"
            local aZ=Instance.new"UIStroke"
            local a_=Instance.new"Frame"
            local a0=Instance.new"UICorner"
            local a1=Instance.new"ImageLabel"

            aX.Name="CheckBackground"
            aX.Parent=aV.Scaler
            aX.BackgroundColor3=Color3.fromRGB(0,0,0)
            aX.BackgroundTransparency=0.9
            aX.BorderColor3=Color3.fromRGB(0,0,0)
            aX.BorderSizePixel=0
            aX.Size=UDim2.new(0,22,0,22)

            aY.Parent=aX
            aY.CornerRadius=UDim.new(0,5)

            aZ.Parent=aX
            aZ.Color=Color3.fromRGB(75,75,75)
            aZ.Thickness=1

            a_.Name="Checker"
            a_.Parent=aX
            a_.BackgroundColor3=w
            a_.BackgroundTransparency=1
            a_.BorderColor3=Color3.fromRGB(0,0,0)
            a_.BorderSizePixel=0
            a_.Size=UDim2.new(1,0,1,0)

            a0.Parent=a_
            a0.CornerRadius=UDim.new(0,5)

            a1.Name="Icon"
            a1.Parent=a_
            a1.AnchorPoint=Vector2.new(0.5,0.5)
            a1.BackgroundColor3=Color3.fromRGB(255,255,255)
            a1.BackgroundTransparency=1
            a1.BorderColor3=Color3.fromRGB(0,0,0)
            a1.BorderSizePixel=0
            a1.Position=UDim2.new(0.5,0,0.5,0)
            a1.Size=UDim2.new(0.6,0,0.6,0)
            a1.Image="rbxassetid://121742282171603"
            a1.ImageColor3=Color3.fromRGB(0,0,0)
            a1.ImageTransparency=1

            local a2={}

            local function OnChanged(a3)
                for a4,a5 in pairs(ax:GetChildren())do
                    if a5.Name=="Dropdown"and a5.Visible then
                        return
                    end
                end

                if a3 then
                    a1.Size=UDim2.new(0.85,0,0.85,0)

                    a:Tween{
                        v=a_,
                        t=0.5,
                        s="Exponential",
                        d="Out",
                        g={
                            BackgroundTransparency=0
                        }
                    }:Play()

                    a:Tween{
                        v=a1,
                        t=0.5,
                        s="Exponential",
                        d="Out",
                        g={
                            ImageTransparency=0
                        }
                    }:Play()

                    a:Tween{
                        v=a1,
                        t=0.75,
                        s="Exponential",
                        d="Out",
                        g={
                            Size=UDim2.new(0.6,0,0.6,0)
                        }
                    }:Play()

                    aZ.Color=Color3.fromRGB(30,30,30)
                else
                    a:Tween{
                        v=a_,
                        t=0.5,
                        s="Exponential",
                        d="Out",
                        g={
                            BackgroundTransparency=1
                        }
                    }:Play()

                    a:Tween{
                        v=a1,
                        t=0.5,
                        s="Exponential",
                        d="Out",
                        g={
                            ImageTransparency=1
                        }
                    }:Play()

                    aZ.Color=Color3.fromRGB(75,75,75)
                end

                a:Effect(aW,aV)
            end

            local function Init()
                for a3,a4 in pairs(ax:GetChildren())do
                    if a4.Name=="Dropdown"and a4.Visible then
                        return
                    end
                end

                aT=not aT

                aU(a2,aT)
                OnChanged(aT)
            end

            aW.MouseButton1Click:Connect(Init)

            OnChanged(aT)

            function a2.SetValue(a3,a4)
                aT=a4
                OnChanged(a4)
            end

            function a2.SetTitle(a3,a4)
                aV.Text.Title.Text=a4
            end

            function a2.SetDesc(a3,a4)
                aV.Text.Desc.Text=a4
            end

            function a2.SetAll(a3,a4)
                aV.Text.Title.Text=a4[1]
                aV.Text.Desc.Text=a4[2]
            end

            function a2.Visible(a3,a4)
                aV.Visible=a4
            end

            function a2.GetFrame(a3)
                return aV
            end

            return a2
        end

        function aO.Textbox(aP,aQ)
            local aR=aQ.Title or"Title"
            local aS=aQ.Desc or nil
            local aT=aQ.Value or"N/A"
            local aU=aQ.PlaceHolder or" ...... "
            local aV=aQ.Callback or(function(...)
                return...
            end)

            local aW=a:Template(aM,aR,aS,120)

            local aX={}

            function aX.SetTitle(aY,aZ)
                aW.Text.Title.Text=aZ
            end

            function aX.SetDesc(aY,aZ)
                aW.Text.Desc.Text=aZ
            end

            function aX.SetAll(aY,aZ)
                aW.Text.Title.Text=aZ[1]
                aW.Text.Desc.Text=aZ[2]
            end

            function aX.Visible(aY,aZ)
                aW.Visible=aZ
            end

            function aX.GetFrame(aY)
                return aW
            end

            local aY=Instance.new"Frame"
            local aZ=Instance.new"UICorner"
            local a_=Instance.new"UIStroke"
            local a0=Instance.new"UIPadding"
            local a1=Instance.new"ImageLabel"
            local a2=Instance.new"UIListLayout"
            local a3=Instance.new"TextBox"

            aY.Name="Textbox"
            aY.Parent=aW.Scaler
            aY.BackgroundColor3=Color3.fromRGB(0,0,0)
            aY.BackgroundTransparency=0.9
            aY.BorderColor3=Color3.fromRGB(0,0,0)
            aY.BorderSizePixel=0
            aY.Position=UDim2.new(0.850467265,0,0.301587313,0)
            aY.Size=UDim2.new(0,85,0,25)

            aZ.Parent=aY
            aZ.CornerRadius=UDim.new(0,5)

            a_.Parent=aY
            a_.Color=Color3.fromRGB(75,75,75)
            a_.Thickness=1

            a0.Parent=aY
            a0.PaddingRight=UDim.new(0,5)

            a1.Name="Icon"
            a1.Parent=aY
            a1.AnchorPoint=Vector2.new(0.5,0.5)
            a1.BackgroundColor3=Color3.fromRGB(255,255,255)
            a1.BackgroundTransparency=1
            a1.BorderColor3=Color3.fromRGB(0,0,0)
            a1.BorderSizePixel=0
            a1.Position=UDim2.new(0.5,0,0.5,0)
            a1.Size=UDim2.new(0,15,0,15)
            a1.Image="rbxassetid://123909267283672"
            a1.ImageTransparency=0.10000000149011612

            a2.Parent=aY
            a2.Padding=UDim.new(0,5)
            a2.FillDirection=Enum.FillDirection.Horizontal
            a2.HorizontalAlignment=Enum.HorizontalAlignment.Right
            a2.SortOrder=Enum.SortOrder.LayoutOrder
            a2.VerticalAlignment=Enum.VerticalAlignment.Center

            a3.Parent=aY
            a3.Active=true
            a3.BackgroundColor3=Color3.fromRGB(255,255,255)
            a3.BackgroundTransparency=1
            a3.BorderColor3=Color3.fromRGB(0,0,0)
            a3.BorderSizePixel=0
            a3.CursorPosition=-1
            a3.Size=UDim2.new(1,-25,1,0)
            a3.Font=Enum.Font.GothamMedium
            a3.PlaceholderColor3=Color3.fromRGB(100,100,100)
            a3.PlaceholderText=aU
            a3.Text=tostring(aT)
            a3.TextColor3=Color3.fromRGB(145,145,145)
            a3.TextSize=12
            a3.TextXAlignment=Enum.TextXAlignment.Left
            a3.TextTruncate=Enum.TextTruncate.AtEnd

            a3.Focused:Connect(function()
                aW.Text.Visible=false

                a:Tween{
                    v=aY,
                    t=0.5,
                    s="Exponential",
                    d="Out",
                    g={
                        Size=UDim2.new(1,-15,0,25)
                    }
                }:Play()

                a_.Color=w
            end)

            a3.FocusLost:Connect(function()
                aT=tostring(a3.Text)

                aV(aX,aT)

                aW.Text.Visible=true
                a_.Color=Color3.fromRGB(75,75,75)

                a:Tween{
                    v=aY,
                    t=0.5,
                    s="Exponential",
                    d="Out",
                    g={
                        Size=UDim2.new(0,85,0,25)
                    }
                }:Play()
            end)

            function aX.SetValue(a4,a5)
                a3.Text=tostring(a5)
                aT=tostring(a3.Text)
            end

            return aX
        end

        function aO.Slider(aP,aQ)
            local aR=aQ.Icon or nil
            local aS=aQ.Min or 1
            local aT=aQ.Max or 10
            local aU=aQ.Value or aS
            local aV=aQ.Rounding or 0
            local aW=aQ.Callback or(function(...)
                return...
            end)

            local aX=Instance.new"Frame"
            local aY=Instance.new"UIStroke"
            local aZ=Instance.new"UICorner"
            local a_=Instance.new"Frame"
            local a0=Instance.new"UIListLayout"
            local a1=Instance.new"ImageLabel"
            local a2=Instance.new"UIPadding"
            local a3=Instance.new"Frame"
            local a4=Instance.new"UICorner"
            local a5=Instance.new"Frame"
            local a6=Instance.new"UICorner"
            local a7=Instance.new"Frame"
            local a8=Instance.new"UICorner"
            local a9=Instance.new"Frame"
            local ba=Instance.new"Frame"
            local bb=Instance.new"UIPadding"
            local bc=Instance.new"Frame"
            local bd=Instance.new"UICorner"
            local be=Instance.new"UIStroke"
            local bf=Instance.new"UIPadding"
            local bg=Instance.new"ImageLabel"
            local bh=Instance.new"UIListLayout"
            local bi=Instance.new"TextBox"
            local bj=Instance.new"UIListLayout"

            local bk=a:Button(a9)

            aX.Name="Template"
            aX.Parent=aM
            aX.BackgroundColor3=Color3.fromRGB(70,70,70)
            aX.BackgroundTransparency=0.8199999928474426
            aX.BorderColor3=Color3.fromRGB(0,0,0)
            aX.BorderSizePixel=0
            aX.Size=UDim2.new(1,0,0,50)

            aY.Parent=aX
            aY.Color=Color3.fromRGB(25,25,25)
            aY.Thickness=1
            aY.Transparency=0.5

            aZ.Parent=aX
            aZ.CornerRadius=UDim.new(0,4)

            a_.Name="Slider"
            a_.Parent=aX
            a_.BackgroundColor3=Color3.fromRGB(255,255,255)
            a_.BackgroundTransparency=1
            a_.BorderColor3=Color3.fromRGB(0,0,0)
            a_.BorderSizePixel=0
            a_.Size=UDim2.new(1,0,1,0)

            a0.Parent=a_
            a0.Padding=UDim.new(0,20)
            a0.FillDirection=Enum.FillDirection.Horizontal
            a0.SortOrder=Enum.SortOrder.LayoutOrder
            a0.VerticalAlignment=Enum.VerticalAlignment.Center

            a1.Name="Icon"
            a1.Parent=a_
            a1.AnchorPoint=Vector2.new(0.5,0.5)
            a1.BackgroundColor3=Color3.fromRGB(255,255,255)
            a1.BackgroundTransparency=1
            a1.BorderColor3=Color3.fromRGB(0,0,0)
            a1.BorderSizePixel=0
            a1.LayoutOrder=-5
            a1.Position=UDim2.new(0.5,0,0.5,0)
            a1.Size=UDim2.new(0,20,0,20)
            a1.Image=a:Asset(aR)
            a1.ImageTransparency=0.30000001192092896

            a2.Parent=a_
            a2.PaddingLeft=UDim.new(0,15)

            a3.Name="DarkBar"
            a3.Parent=a_
            a3.BackgroundColor3=Color3.fromRGB(0,0,0)
            a3.BackgroundTransparency=0.75
            a3.BorderColor3=Color3.fromRGB(0,0,0)
            a3.BorderSizePixel=0
            a3.Size=UDim2.new(1,-125,0,5)

            a4.Parent=a3

            a5.Name="ActiveBar"
            a5.Parent=a3
            a5.BackgroundColor3=w
            a5.BorderColor3=Color3.fromRGB(0,0,0)
            a5.BorderSizePixel=0
            a5.Size=UDim2.new(0.5,0,1,0)

            a6.Parent=a5

            a7.Name="Circle"
            a7.Parent=a5
            a7.AnchorPoint=Vector2.new(1,0.5)
            a7.BackgroundColor3=w
            a7.BorderColor3=Color3.fromRGB(0,0,0)
            a7.BorderSizePixel=0
            a7.Position=UDim2.new(1,0,0.5,0)
            a7.Size=UDim2.new(0,15,0,15)

            a8.Parent=a7
            a8.CornerRadius=UDim.new(1,0)

            a9.Name="Slide"
            a9.Parent=a3
            a9.AnchorPoint=Vector2.new(0.5,0.5)
            a9.BackgroundColor3=Color3.fromRGB(255,255,255)
            a9.BackgroundTransparency=1
            a9.BorderColor3=Color3.fromRGB(0,0,0)
            a9.BorderSizePixel=0
            a9.Position=UDim2.new(0.5,0,0.5,0)
            a9.Size=UDim2.new(1,10,1,20)

            ba.Name="Scaler"
            ba.Parent=aX
            ba.BackgroundColor3=Color3.fromRGB(255,255,255)
            ba.BackgroundTransparency=1
            ba.BorderColor3=Color3.fromRGB(0,0,0)
            ba.BorderSizePixel=0
            ba.Size=UDim2.new(1,0,1,0)

            bb.Parent=ba
            bb.PaddingRight=UDim.new(0,15)

            bc.Name="Textbox"
            bc.Parent=ba
            bc.BackgroundColor3=Color3.fromRGB(0,0,0)
            bc.BackgroundTransparency=0.8999999761581421
            bc.BorderColor3=Color3.fromRGB(0,0,0)
            bc.BorderSizePixel=0
            bc.Position=UDim2.new(0.850467265,0,0.301587313,0)
            bc.Size=UDim2.new(0,60,0,25)

            bd.Parent=bc
            bd.CornerRadius=UDim.new(0,5)

            be.Parent=bc
            be.Color=Color3.fromRGB(75,75,75)
            be.Thickness=1

            bf.Parent=bc
            bf.PaddingRight=UDim.new(0,5)

            bg.Name="Icon"
            bg.Parent=bc
            bg.AnchorPoint=Vector2.new(0.5,0.5)
            bg.BackgroundColor3=Color3.fromRGB(255,255,255)
            bg.BackgroundTransparency=1
            bg.BorderColor3=Color3.fromRGB(0,0,0)
            bg.BorderSizePixel=0
            bg.Position=UDim2.new(0.5,0,0.5,0)
            bg.Size=UDim2.new(0,15,0,15)
            bg.Image="rbxassetid://123909267283672"
            bg.ImageTransparency=0.10000000149011612

            bh.Parent=bc
            bh.Padding=UDim.new(0,5)
            bh.FillDirection=Enum.FillDirection.Horizontal
            bh.HorizontalAlignment=Enum.HorizontalAlignment.Right
            bh.SortOrder=Enum.SortOrder.LayoutOrder
            bh.VerticalAlignment=Enum.VerticalAlignment.Center

            bi.Name="Value"
            bi.Parent=bc
            bi.Active=true
            bi.BackgroundColor3=Color3.fromRGB(255,255,255)
            bi.BackgroundTransparency=1
            bi.BorderColor3=Color3.fromRGB(0,0,0)
            bi.BorderSizePixel=0
            bi.Size=UDim2.new(1,-25,1,0)
            bi.Font=Enum.Font.GothamMedium
            bi.PlaceholderColor3=Color3.fromRGB(100,100,100)
            bi.PlaceholderText=tostring(aU)
            bi.Text="N/A"
            bi.TextColor3=Color3.fromRGB(145,145,145)
            bi.TextSize=12
            bi.TextXAlignment=Enum.TextXAlignment.Left

            bj.Parent=ba
            bj.HorizontalAlignment=Enum.HorizontalAlignment.Right
            bj.SortOrder=Enum.SortOrder.LayoutOrder
            bj.VerticalAlignment=Enum.VerticalAlignment.Center

            local function roundToDecimal(bl,bm)
                local bn=10^bm
                return math.floor(bl*bn+0.5)/bn
            end

            local function updateSlider(bl)
                bl=math.clamp(bl,aS,aT)
                bl=roundToDecimal(bl,aV)
                a:Tween{
                    v=a5,
                    t=0.5,
                    s="Exponential",
                    d="Out",
                    g={Size=UDim2.new((bl-aS)/(aT-aS),0,1,0)}
                }:Play()

                local bm=tonumber(bi.Text)or 0
                local bn=bl

                local bo=5
                local bp=bm

                for bq=1,bo do
                    task.wait(0.01/bo)
                    bp=bp+(bn-bm)/bo
                    bi.Text=tostring(roundToDecimal(bp,aV))
                end

                bi.Text=tostring(roundToDecimal(bn,aV))

                aW(bl)
            end

            updateSlider(aU or 0)

            local function move(bl)
                local bm=a3
                local bn=math.clamp((bl.Position.X-bm.AbsolutePosition.X)/bm.AbsoluteSize.X,0,1)
                local bo=bn*(aT-aS)+aS
                updateSlider(bo)
            end

            bi.Focused:Connect(function()
                a_.Visible=false

                a:Tween{
                    v=bc,
                    t=0.5,
                    s="Exponential",
                    d="Out",
                    g={
                        Size=UDim2.new(1,-15,0,25)
                    }
                }:Play()

                be.Color=w
            end)

            bi.FocusLost:Connect(function()
                a:Tween{
                    v=bc,
                    t=0.5,
                    s="Exponential",
                    d="Out",
                    g={
                        Size=UDim2.new(0,60,0,25)
                    }
                }:Play()

                delay(0.1,function()
                    a_.Visible=true
                    be.Color=Color3.fromRGB(75,75,75)

                    local bl=tonumber(bi.Text)or aS
                    updateSlider(bl)
                end)
            end)

            local bl=false

            bk.InputBegan:Connect(function(bm)
                if bm.UserInputType==Enum.UserInputType.MouseButton1 or bm.UserInputType==Enum.UserInputType.Touch then
                    for bn,bo in pairs(ax:GetChildren())do
                        if bo.Name=="Dropdown"and bo.Visible then
                            return
                        end
                    end

                    bl=true
                    move(bm)
                end
            end)

            bk.InputEnded:Connect(function(bm)
                if bm.UserInputType==Enum.UserInputType.MouseButton1 or bm.UserInputType==Enum.UserInputType.Touch then

                    bl=false
                end
            end)

            d.InputChanged:Connect(function(bm)
                if bl and(bm.UserInputType==Enum.UserInputType.MouseMovement or bm.UserInputType==Enum.UserInputType.Touch)then
                    for bn,bo in pairs(ax:GetChildren())do
                        if bo.Name=="Dropdown"and bo.Visible then
                            return
                        end
                    end

                    move(bm)
                end
            end)

            local bm={}

            function bm.SetValue(bn,bo)
                updateSlider(bo)
            end

            return bm
        end

        function aO.Input(aP,aQ)
            local aR=aQ.Title or"Title"
            local aS=aQ.Desc or nil
            local aT=aQ.Key or Enum.KeyCode.RightControl
            local aU=aQ.Value or false
            local aV=aQ.Callback or(function(...)
                return...
            end)

            local aW=a:Template(aM,aR,aS,125)

            local aX={}

            function aX.SetTitle(aY,aZ)
                aW.Text.Title.Text=aZ
            end

            function aX.SetDesc(aY,aZ)
                aW.Text.Desc.Text=aZ
            end

            function aX.SetAll(aY,aZ)
                aW.Text.Title.Text=aZ[1]
                aW.Text.Desc.Text=aZ[2]
            end

            function aX.Visible(aY,aZ)
                aW.Visible=aZ
            end

            function aX.GetFrame(aY)
                return aW
            end

            local aY=Instance.new"Frame"
            local aZ=Instance.new"UICorner"
            local a_=Instance.new"UIStroke"
            local a0=Instance.new"UIPadding"
            local a1=Instance.new"ImageLabel"
            local a2=Instance.new"UIListLayout"
            local a3=Instance.new"TextLabel"

            local a4=a:Button(a1)
            local a5=a:Button(a3)

            aY.Name="Bind"
            aY.Parent=aW.Scaler
            aY.BackgroundColor3=Color3.fromRGB(0,0,0)
            aY.BackgroundTransparency=0.8999999761581421
            aY.BorderColor3=Color3.fromRGB(0,0,0)
            aY.BorderSizePixel=0
            aY.Position=UDim2.new(0.850467265,0,0.301587313,0)
            aY.Size=UDim2.new(0,85,0,25)

            aZ.Parent=aY
            aZ.CornerRadius=UDim.new(0,5)

            a_.Parent=aY
            a_.Color=Color3.fromRGB(75,75,75)
            a_.Thickness=1

            a0.Parent=aY
            a0.PaddingRight=UDim.new(0,5)

            a1.Name="Icon"
            a1.Parent=aY
            a1.AnchorPoint=Vector2.new(0.5,0.5)
            a1.BackgroundColor3=Color3.fromRGB(255,255,255)
            a1.BackgroundTransparency=1
            a1.BorderColor3=Color3.fromRGB(0,0,0)
            a1.BorderSizePixel=0
            a1.Position=UDim2.new(0.5,0,0.5,0)
            a1.Size=UDim2.new(0,15,0,15)
            a1.Image="rbxassetid://91697619966971"
            a1.ImageTransparency=0.10000000149011612

            a2.Parent=aY
            a2.Padding=UDim.new(0,5)
            a2.FillDirection=Enum.FillDirection.Horizontal
            a2.HorizontalAlignment=Enum.HorizontalAlignment.Right
            a2.SortOrder=Enum.SortOrder.LayoutOrder
            a2.VerticalAlignment=Enum.VerticalAlignment.Center

            a3.Parent=aY
            a3.Active=true
            a3.BackgroundColor3=Color3.fromRGB(255,255,255)
            a3.BackgroundTransparency=1
            a3.BorderColor3=Color3.fromRGB(0,0,0)
            a3.BorderSizePixel=0
            a3.Size=UDim2.new(1,-25,1,0)
            a3.Font=Enum.Font.GothamMedium
            a3.Text=tostring(aT):gsub("Enum.KeyCode.","")
            a3.TextColor3=Color3.fromRGB(145,145,145)
            a3.TextSize=12
            a3.TextTruncate=Enum.TextTruncate.AtEnd
            a3.TextXAlignment=Enum.TextXAlignment.Left

            local function changeKey()
                for a6,a7 in pairs(ax:GetChildren())do
                    if a7.Name=="Dropdown"and a7.Visible then
                        return
                    end
                end

                a3.Text=" ...... "
                aW.Text.Visible=false

                a:Tween{
                    v=aY,
                    t=0.5,
                    s="Exponential",
                    d="Out",
                    g={
                        Size=UDim2.new(1,-15,0,25)
                    }
                }:Play()

                a_.Color=w

                local a6

                a6=d.InputBegan:Connect(function(a7)
                    if a7.UserInputType==Enum.UserInputType.Keyboard then
                        aT=a7.KeyCode

                        a3.Text=tostring(aT):gsub("Enum.KeyCode.","")

                        a6:Disconnect()
                        aV(aX,aT,aU)

                        aW.Text.Visible=true
                        a_.Color=Color3.fromRGB(75,75,75)

                        local a8=a3.TextBounds.X+30
                        local a9=math.clamp(a8,40,85)

                        a:Tween{
                            v=aY,
                            t=0.5,
                            s="Exponential",
                            d="Out",
                            g={
                                Size=UDim2.new(0,a9,0,25)
                            }
                        }:Play()
                    end
                end)
            end

            d.InputEnded:Connect(function(a6)
                if a6.KeyCode==aT then
                    aU=not aU
                    aV(aX,aT,aU)
                end
            end)

            task.defer(aV,aT,aU)

            a4.MouseButton1Click:Connect(changeKey)
            a5.MouseButton1Click:Connect(changeKey)

            function aX.SetValue(a6,a7)
                aU=a7
            end

            function aX.SetBind(a6,a7)
                aT=a7
            end

            return aX
        end

        function aO.Dropdown(aP,aQ)
            local aR=aQ.Title or"Title"
            local aS=aQ.List or{}
            local aT=aQ.Value or aS[1]or"N/A"
            local aU=aQ.Multi or false
            local aV=aQ.Callback or(function(...)
                return...
            end)

            local aW=a:Template(aM,aR,"N/A",65)
            local aX=a:Button(aW)

            local aY=Instance.new"ImageLabel"
            aY.Parent=aW.Scaler
            aY.BackgroundColor3=Color3.fromRGB(255,255,255)
            aY.BackgroundTransparency=1
            aY.BorderColor3=Color3.fromRGB(0,0,0)
            aY.BorderSizePixel=0
            aY.Size=UDim2.new(0,16,0,16)
            aY.Image="rbxassetid://132291592681506"
            aY.ImageTransparency=0.35

            local aZ=175

            local a_={}

            function a_.SetTitle(a0,a1)
                aW.Text.Title.Text=a1
            end

            local function SetDesc(a0)
                aW.Text.Desc.Text=a0
            end

            function a_.Visible(a0,a1)
                aW.Visible=a1
            end

            function a_.GetFrame(a0)
                return aW
            end

            local function Settext()
                if typeof(aT)=='table'then
                    SetDesc(table.concat(aT,", "))
                else
                    SetDesc(tostring(aT))
                end
            end

            Settext()

            local a0=Instance.new"Frame"
            local a1=Instance.new"UICorner"
            local a2=Instance.new"UIStroke"
            local a3=Instance.new"Frame"
            local a4=Instance.new"Frame"
            local a5=Instance.new"UICorner"
            local a6=Instance.new"UIListLayout"
            local a7=Instance.new"ImageLabel"
            local a8=Instance.new"UIPadding"
            local a9=Instance.new"TextBox"
            local ba=Instance.new"UIListLayout"
            local bb=Instance.new"UIPadding"
            local bc=Instance.new"Frame"
            local bd=Instance.new"ScrollingFrame"
            local be=Instance.new"UIListLayout"
            local bf=Instance.new"ImageLabel"

            local bg=55

            a0.Name="Dropdown"
            a0.Parent=ax
            a0.AnchorPoint=Vector2.new(1,0)
            a0.BackgroundColor3=Color3.fromRGB(30,30,30)
            a0.BackgroundTransparency=0.075
            a0.BorderColor3=Color3.fromRGB(0,0,0)
            a0.BorderSizePixel=0
            a0.Position=UDim2.new(1,-20,0,10)
            a0.Size=UDim2.new(0,aZ,0,bg)
            a0.Visible=false

            local bh=Instance.new"Frame"
            local bi=Instance.new"UICorner"
            local bj=Instance.new"TextLabel"

            bh.Name="NORE"
            bh.Parent=bd
            bh.AnchorPoint=Vector2.new(0.5,0.5)
            bh.BackgroundColor3=Color3.fromRGB(255,255,255)
            bh.BackgroundTransparency=0.95
            bh.BorderColor3=Color3.fromRGB(0,0,0)
            bh.BorderSizePixel=0
            bh.Size=UDim2.new(1,-10,0,30)
            bh.Visible=false

            bi.Parent=bh
            bi.CornerRadius=UDim.new(0,10)

            bj.Name="Title"
            bj.Parent=bh
            bj.BackgroundColor3=Color3.fromRGB(255,255,255)
            bj.BackgroundTransparency=1
            bj.BorderColor3=Color3.fromRGB(0,0,0)
            bj.BorderSizePixel=0
            bj.Size=UDim2.new(1,0,1,0)
            bj.Font=Enum.Font.GothamMedium
            bj.Text="No results found."
            bj.TextColor3=Color3.fromRGB(255,255,255)
            bj.TextSize=12
            bj.TextTransparency=0.5
            bj.TextTruncate=Enum.TextTruncate.AtEnd

            a1.Parent=a0
            a1.CornerRadius=UDim.new(0,10)

            a2.Parent=a0
            a2.Color=Color3.fromRGB(65,65,65)
            a2.Thickness=0.5

            a3.Name="Scaler"
            a3.Parent=a0
            a3.BackgroundColor3=Color3.fromRGB(255,255,255)
            a3.BackgroundTransparency=1
            a3.BorderColor3=Color3.fromRGB(0,0,0)
            a3.BorderSizePixel=0
            a3.Size=UDim2.new(1,0,1,0)

            a4.Name="Search"
            a4.Parent=a3
            a4.AnchorPoint=Vector2.new(0.5,0.5)
            a4.BackgroundColor3=Color3.fromRGB(255,255,255)
            a4.BackgroundTransparency=0.949999988079071
            a4.BorderColor3=Color3.fromRGB(0,0,0)
            a4.BorderSizePixel=0
            a4.Size=UDim2.new(1,-10,0,30)

            a5.Parent=a4
            a5.CornerRadius=UDim.new(0,10)

            a6.Parent=a4
            a6.Padding=UDim.new(0,7)
            a6.FillDirection=Enum.FillDirection.Horizontal
            a6.SortOrder=Enum.SortOrder.LayoutOrder
            a6.VerticalAlignment=Enum.VerticalAlignment.Center

            a7.Name="Icon"
            a7.Parent=a4
            a7.BackgroundColor3=Color3.fromRGB(255,255,255)
            a7.BackgroundTransparency=1
            a7.BorderColor3=Color3.fromRGB(0,0,0)
            a7.BorderSizePixel=0
            a7.Size=UDim2.new(0,15,0,15)
            a7.Image="rbxassetid://125928820284709"
            a7.ImageTransparency=0.5

            a8.Parent=a4
            a8.PaddingLeft=UDim.new(0,7)

            a9.Parent=a4
            a9.Active=true
            a9.BackgroundColor3=Color3.fromRGB(255,255,255)
            a9.BackgroundTransparency=1
            a9.BorderColor3=Color3.fromRGB(0,0,0)
            a9.BorderSizePixel=0
            a9.Size=UDim2.new(1,-35,1,0)
            a9.Font=Enum.Font.GothamMedium
            a9.PlaceholderColor3=Color3.fromRGB(178,178,178)
            a9.PlaceholderText="Search"
            a9.Text=""
            a9.TextColor3=Color3.fromRGB(255,255,255)
            a9.TextSize=12
            a9.TextTransparency=0.5
            a9.TextXAlignment=Enum.TextXAlignment.Left
            a9.ZIndex=aX.ZIndex+1
            a9.TextTruncate=Enum.TextTruncate.AtEnd

            a9.Focused:Connect(function()
                a:Tween{
                    v=a9,
                    t=0.5,
                    s="Exponential",
                    d="Out",
                    g={
                        TextTransparency=0.1
                    }
                }:Play()

                a:Tween{
                    v=a7,
                    t=0.5,
                    s="Exponential",
                    d="Out",
                    g={
                        ImageTransparency=0.35
                    }
                }:Play()
            end)

            a9.Changed:Connect(function()
                local bk=aZ+a9.TextBounds.X
                local bl=ax.AbsoluteSize.Y-25

                local bm=math.min(bk,bl)

                a0.Size=UDim2.new(0,bm,0,a0.Size.Y.Offset)
            end)

            ba.Parent=a3
            ba.Padding=UDim.new(0,5)
            ba.HorizontalAlignment=Enum.HorizontalAlignment.Center
            ba.SortOrder=Enum.SortOrder.LayoutOrder

            bb.Parent=a3
            bb.PaddingBottom=UDim.new(0,5)
            bb.PaddingTop=UDim.new(0,5)

            bc.Name="LineUpper"
            bc.Parent=a3
            bc.BackgroundColor3=Color3.fromRGB(65,65,65)
            bc.BackgroundTransparency=0.5
            bc.BorderColor3=Color3.fromRGB(0,0,0)
            bc.BorderSizePixel=0
            bc.Size=UDim2.new(1,0,0,1)

            bd.Name="ListScrolling"
            bd.Parent=a3
            bd.Active=true
            bd.BackgroundColor3=Color3.fromRGB(255,255,255)
            bd.BackgroundTransparency=1
            bd.BorderColor3=Color3.fromRGB(0,0,0)
            bd.BorderSizePixel=0
            bd.Size=UDim2.new(1,0,1,-40)
            bd.ClipsDescendants=true
            bd.AutomaticCanvasSize=Enum.AutomaticSize.None
            bd.BottomImage="rbxasset://textures/ui/Scroll/scroll-bottom.png"
            bd.CanvasPosition=Vector2.new(0,0)
            bd.ElasticBehavior=Enum.ElasticBehavior.WhenScrollable
            bd.HorizontalScrollBarInset=Enum.ScrollBarInset.None
            bd.MidImage="rbxasset://textures/ui/Scroll/scroll-middle.png"
            bd.ScrollBarImageColor3=Color3.fromRGB(0,0,0)
            bd.ScrollBarImageTransparency=1
            bd.ScrollBarThickness=0
            bd.ScrollingDirection=Enum.ScrollingDirection.XY
            bd.TopImage="rbxasset://textures/ui/Scroll/scroll-top.png"
            bd.VerticalScrollBarInset=Enum.ScrollBarInset.None
            bd.VerticalScrollBarPosition=Enum.VerticalScrollBarPosition.Right

            be.Parent=bd
            be.Padding=UDim.new(0,5)
            be.HorizontalAlignment=Enum.HorizontalAlignment.Center
            be.SortOrder=Enum.SortOrder.LayoutOrder

            be:GetPropertyChangedSignal"AbsoluteContentSize":Connect(function()
                bd.CanvasSize=UDim2.new(0,0,0,be.AbsoluteContentSize.Y+15)
            end)

            bf.Name="Shadow"
            bf.Parent=a0
            bf.AnchorPoint=Vector2.new(0.5,0.5)
            bf.BackgroundColor3=Color3.fromRGB(0,0,0)
            bf.BackgroundTransparency=1
            bf.BorderColor3=Color3.fromRGB(0,0,0)
            bf.BorderSizePixel=0
            bf.Position=UDim2.new(0.5,0,0.5,0)
            bf.Size=UDim2.new(1,120,1,120)
            bf.ZIndex=0
            bf.Image="rbxassetid://8992230677"
            bf.ImageColor3=Color3.fromRGB(0,0,0)
            bf.ImageTransparency=0.5
            bf.ScaleType=Enum.ScaleType.Slice
            bf.SliceCenter=Rect.new(99,99,99,99)

            local function GetMaxY()
                local bk=be.AbsoluteContentSize.Y+55
                local bl=ax.AbsoluteSize.Y-20
                local bm=math.min(bk,bl)

                return bm
            end

            local bk=false

            d.InputBegan:Connect(function(bl)
                local bm=h:GetMouse()
                local bn,bo=bm.X,bm.Y
                local bp,bq=a0.AbsolutePosition,a0.AbsoluteSize

                local function inside(br,bs)
                    return bn>=br.X and bn<=br.X+bs.X and bo>=br.Y and bo<=br.Y+bs.Y
                end

                if bl.UserInputType==Enum.UserInputType.MouseButton1 or bl.UserInputType==Enum.UserInputType.Touch then
                    if not inside(bp,bq)then
                        bk=false
                        a0.Visible=false
                        a0.Position=UDim2.new(1,0,0,10)
                        a0.Size=UDim2.new(0,aZ,0,bg)
                    end
                end
            end)

            local function OnDropdownOpen()
                for bl,bm in pairs(ax:GetChildren())do
                    if bm.Name=="Dropdown"and bm.Visible then
                        return
                    end
                end

                bk=not bk

                a:Effect(aX,aW)

                if bk then
                    a0.Visible=true

                    local bl=a:Tween{
                        v=a0,
                        t=0.3,
                        s="Back",
                        d="Out",
                        g={Position=UDim2.new(1,-10,0,10)}
                    }
                    bl:Play()


                    bl.Completed:Connect(function()
                        a:Tween{
                            v=a0,
                            t=0.75,
                            s="Exponential",
                            d="Out",
                            g={
                                Size=UDim2.new(0,aZ,0,GetMaxY())
                            }
                        }:Play()
                    end)
                else
                    a0.Visible=false
                    a0.Position=UDim2.new(1,0,0,10)
                    a0.Size=UDim2.new(0,aZ,0,bg)
                end
            end

            a9.FocusLost:Connect(function()
                a:Tween{
                    v=a9,
                    t=0.5,
                    s="Exponential",
                    d="Out",
                    g={
                        TextTransparency=0.5
                    }
                }:Play()

                a:Tween{
                    v=a7,
                    t=0.5,
                    s="Exponential",
                    d="Out",
                    g={
                        ImageTransparency=0.5
                    }
                }:Play()

                local bl=string.lower(a9.Text)
                local bm=false

                for bn,bo in pairs(bd:GetChildren())do
                    if bo:IsA"Frame"and bo.Name=='AddList'then
                        local bp=string.lower(bo.Scaler.Title.Text)

                        if string.find(bp,bl,1,true)then
                            bo.Visible=true
                            bm=true
                        else
                            bo.Visible=false
                        end
                    end
                end

                bh.Visible=not bm

                a:Tween{
                    v=a0,
                    t=0.75,
                    s="Exponential",
                    d="Out",
                    g={
                        Size=UDim2.new(0,aZ,0,GetMaxY())
                    }
                }:Play()
            end)

            local bl=0
            local bm

            function a_.Clear(bn,bo)
                local function shouldClear(bp)
                    if bo==nil then
                        return true
                    elseif type(bo)=="string"then
                        return bp.Scaler.Title.Text==bo
                    elseif type(bo)=="table"then
                        for bq,br in ipairs(bo)do
                            if bp.Scaler.Title.Text==br then
                                return true
                            end
                        end
                    end

                    return false
                end

                for bp,bq in ipairs(bd:GetChildren())do
                    if bq:IsA"Frame"and shouldClear(bq)then
                        if bm and bq.Scaler.Title.Text==bm then
                            bm=nil
                            SetDesc"N/A"
                        end
                        bq:Destroy()
                    end
                end

                if bm==bo or aW.Text.Desc.Text==bo then
                    bm=nil
                    SetDesc"N/A"
                end

                if bo==nil then
                    bm=nil
                    SetDesc"N/A"
                end
            end

            local bn={}

            local function isValueInTable(bo,bp)
                if type(bp)~="table"then
                    return false
                end

                for bq,br in pairs(bp)do
                    if br==bo then
                        return true
                    end
                end

                return false
            end

            function a_.AddList(bo,bp)
                bl+=1

                local bq=bp.Name or"UNKNOW"..bl
                local br=bp.Icon or nil

                local bs=Instance.new"Frame"
                local bt=Instance.new"Frame"
                local bu=Instance.new"UICorner"
                local bv=Instance.new"UIListLayout"
                local bw=Instance.new"UIPadding"
                local bx=Instance.new"ImageLabel"
                local by=Instance.new"TextLabel"

                local bz=Instance.new"Frame"
                local bA=Instance.new"UICorner"

                local bB=a:Button(bs)

                bz.Name="SelectLine"
                bz.Parent=bt
                bz.AnchorPoint=Vector2.new(0.5,0.5)
                bz.BackgroundColor3=w
                bz.BorderColor3=Color3.fromRGB(0,0,0)
                bz.BorderSizePixel=0
                bz.LayoutOrder=-5
                bz.BackgroundTransparency=1
                bz.Position=UDim2.new(0,0,0.5,0)
                bz.Size=UDim2.new(0,4,0,16)
                bz.Visible=false

                bA.Parent=bz
                bA.CornerRadius=UDim.new(1,0)

                bs.Name="AddList"
                bs.Parent=bd
                bs.AnchorPoint=Vector2.new(0.5,0.5)
                bs.BackgroundColor3=Color3.fromRGB(255,255,255)
                bs.BackgroundTransparency=1
                bs.BorderColor3=Color3.fromRGB(0,0,0)
                bs.BorderSizePixel=0
                bs.Size=UDim2.new(1,-10,0,30)

                bt.Name="Scaler"
                bt.Parent=bs
                bt.BackgroundColor3=Color3.fromRGB(255,255,255)
                bt.BackgroundTransparency=1
                bt.BorderColor3=Color3.fromRGB(0,0,0)
                bt.BorderSizePixel=0
                bt.Size=UDim2.new(1,0,1,0)

                bu.Parent=bt
                bu.CornerRadius=UDim.new(0,10)

                bv.Parent=bt
                bv.Padding=UDim.new(0,7)
                bv.FillDirection=Enum.FillDirection.Horizontal
                bv.SortOrder=Enum.SortOrder.LayoutOrder
                bv.VerticalAlignment=Enum.VerticalAlignment.Center

                bw.Parent=bt
                bw.PaddingLeft=UDim.new(0,7)

                if br then
                    bx.Name="Icon"
                    bx.Parent=bt
                    bx.BackgroundColor3=Color3.fromRGB(255,255,255)
                    bx.BackgroundTransparency=1
                    bx.BorderColor3=Color3.fromRGB(0,0,0)
                    bx.BorderSizePixel=0
                    bx.LayoutOrder=-4
                    bx.Size=UDim2.new(0,15,0,15)
                    bx.Image=a:Asset(br)
                    bx.ImageTransparency=0.5
                end

                by.Name="Title"
                by.Parent=bt
                by.BackgroundColor3=Color3.fromRGB(255,255,255)
                by.BackgroundTransparency=1
                by.BorderColor3=Color3.fromRGB(0,0,0)
                by.BorderSizePixel=0
                by.Size=UDim2.new(0,100,1,0)
                by.Font=Enum.Font.GothamMedium
                by.Text=bq
                by.TextColor3=Color3.fromRGB(255,255,255)
                by.TextSize=12
                by.TextTransparency=0.5
                by.TextTruncate=Enum.TextTruncate.AtEnd
                by.TextXAlignment=Enum.TextXAlignment.Left

                local function OnValue(bC)
                    if bC then
                        bz.Visible=true

                        a:Tween{
                            v=bz,
                            t=0.2,
                            s="Exponential",
                            d="Out",
                            g={BackgroundTransparency=0}
                        }:Play()

                        bz.Size=UDim2.new(0,4,0,0)

                        a:Tween{
                            v=by,
                            t=0.5,
                            s="Exponential",
                            d="Out",
                            g={TextTransparency=0.1}
                        }:Play()

                        a:Tween{
                            v=bt,
                            t=0.5,
                            s="Exponential",
                            d="Out",
                            g={BackgroundTransparency=0.95}
                        }:Play()

                        if br then
                            a:Tween{
                                v=bx,
                                t=0.5,
                                s="Exponential",
                                d="Out",
                                g={ImageTransparency=0.3}
                            }:Play()
                        end

                        task.delay(0.05,function()
                            a:Tween{
                                v=bz,
                                t=0.3,
                                s="Back",
                                d="Out",
                                g={Size=UDim2.new(0,4,0,16)}
                            }:Play()
                        end)
                    else
                        a:Tween{
                            v=bz,
                            t=0.2,
                            s="Exponential",
                            d="Out",
                            g={BackgroundTransparency=1}
                        }:Play()

                        a:Tween{
                            v=bz,
                            t=0.3,
                            s="Exponential",
                            d="In",
                            g={Size=UDim2.new(0,4,0,16)}
                        }:Play()

                        a:Tween{
                            v=by,
                            t=0.5,
                            s="Exponential",
                            d="Out",
                            g={TextTransparency=0.5}
                        }:Play()

                        a:Tween{
                            v=bt,
                            t=0.5,
                            s="Exponential",
                            d="Out",
                            g={BackgroundTransparency=1}
                        }:Play()

                        if br then
                            a:Tween{
                                v=bx,
                                t=0.5,
                                s="Exponential",
                                d="Out",
                                g={ImageTransparency=0.5}
                            }:Play()
                        end

                        bz.Visible=false
                    end
                end

                local function OnSelected()
                    if aU then
                        if bn[bq]then
                            bn[bq]=nil
                            OnValue(false)
                        else
                            bn[bq]=true
                            OnValue(true)
                        end

                        local bC={}

                        for bD,bE in pairs(bn)do
                            table.insert(bC,bD)
                        end

                        if#bC>0 then
                            table.sort(bC)
                            aT=bC
                            Settext()
                        else
                            SetDesc"N/A"
                        end

                        pcall(aV,bC)
                    else
                        for bC,bD in pairs(bd:GetChildren())do
                            if bD:IsA"Frame"and bD.Name=='AddList'then
                                a:Tween{
                                    v=bD.Scaler.SelectLine,
                                    t=0.2,
                                    s="Exponential",
                                    d="Out",
                                    g={BackgroundTransparency=1}
                                }:Play()

                                a:Tween{
                                    v=bD.Scaler.SelectLine,
                                    t=0.3,
                                    s="Exponential",
                                    d="In",
                                    g={Size=UDim2.new(0,4,0,16)}
                                }:Play()

                                a:Tween{
                                    v=bD.Scaler.Title,
                                    t=0.5,
                                    s="Exponential",
                                    d="Out",
                                    g={TextTransparency=0.5}
                                }:Play()

                                a:Tween{
                                    v=bD.Scaler,
                                    t=0.5,
                                    s="Exponential",
                                    d="Out",
                                    g={BackgroundTransparency=1}
                                }:Play()

                                if bD.Scaler:FindFirstChild'Icon'then
                                    a:Tween{
                                        v=bD.Scaler.Icon,
                                        t=0.5,
                                        s="Exponential",
                                        d="Out",
                                        g={ImageTransparency=0.5}
                                    }:Play()
                                end

                                bD.Scaler.SelectLine.Visible=false
                            end
                        end

                        OnValue(true)
                        aT=bq
                        Settext()
                        pcall(aV,aT)
                    end
                end

                delay(0,function()
                    if aU then
                        if isValueInTable(bq,aT)then
                            bn[bq]=true

                            OnValue(true)

                            local bC={}

                            for bD,bE in pairs(bn)do
                                table.insert(bC,bD)
                            end

                            if#bC>0 then
                                Settext()
                            else
                                SetDesc"N/A"
                            end

                            pcall(aV,bC)
                        end
                    else
                        if bq==aT then
                            aT=bq
                            OnValue(true)
                            Settext()
                            pcall(aV,aT)
                        end
                    end
                end)

                bB.MouseButton1Click:Connect(OnSelected)
            end

            for bo,bp in ipairs(aS)do
                local bq=bp.Title
                local br=bp.Icon or nil

                a_:AddList{
                    Name=bq,
                    Icon=br
                }
            end

            Settext()

            aX.MouseButton1Click:Connect(OnDropdownOpen)

            return a_
        end

        function aO.CodeBlock(aP,aQ)
            local aR=aQ.Header or'packages.luau'
            local aS=aQ.Code or'print("Liquid Components")'
            local aT=aQ.Icon or 120013312151116

            local aU=Instance.new"Frame"
            local aV=Instance.new"UIStroke"
            local aW=Instance.new"UICorner"
            local aX=Instance.new"Frame"
            local aY=Instance.new"UIPadding"
            local aZ=Instance.new"Frame"
            local a_=Instance.new"UICorner"
            local a0=Instance.new"UIStroke"
            local a1=Instance.new"UIPadding"
            local a2=Instance.new"ImageLabel"
            local a3=Instance.new"UIListLayout"
            local a4=Instance.new"TextLabel"
            local a5=Instance.new"Frame"
            local a6=Instance.new"ImageLabel"
            local a7=Instance.new"UIListLayout"
            local a8=Instance.new"Frame"
            local a9=Instance.new"UICorner"
            local ba=Instance.new"UIStroke"
            local bb=Instance.new"UIPadding"
            local bc=Instance.new"UIListLayout"
            local bd=Instance.new"TextLabel"

            aU.Name="Template"
            aU.Parent=aM
            aU.BackgroundColor3=Color3.fromRGB(70,70,70)
            aU.BackgroundTransparency=0.8199999928474426
            aU.BorderColor3=Color3.fromRGB(0,0,0)
            aU.BorderSizePixel=0
            aU.Size=UDim2.new(1,0,0,225)

            aV.Parent=aU
            aV.Color=Color3.fromRGB(25,25,25)
            aV.Thickness=1
            aV.Transparency=0.5

            aW.Parent=aU
            aW.CornerRadius=UDim.new(0,4)

            aX.Name="Scaler"
            aX.Parent=aU
            aX.BackgroundColor3=Color3.fromRGB(255,255,255)
            aX.BackgroundTransparency=1
            aX.BorderColor3=Color3.fromRGB(0,0,0)
            aX.BorderSizePixel=0
            aX.Size=UDim2.new(1,0,1,0)

            aY.Parent=aX
            aY.PaddingBottom=UDim.new(0,15)
            aY.PaddingLeft=UDim.new(0,15)
            aY.PaddingRight=UDim.new(0,15)
            aY.PaddingTop=UDim.new(0,15)

            aZ.Name="Header"
            aZ.Parent=aX
            aZ.BackgroundColor3=Color3.fromRGB(0,0,0)
            aZ.BackgroundTransparency=0.8999999761581421
            aZ.BorderColor3=Color3.fromRGB(0,0,0)
            aZ.BorderSizePixel=0
            aZ.LayoutOrder=999
            aZ.Position=UDim2.new(0.850467265,0,0.301587313,0)
            aZ.Size=UDim2.new(1,0,0,30)

            a_.Parent=aZ
            a_.CornerRadius=UDim.new(0,5)

            a0.Parent=aZ
            a0.Color=Color3.fromRGB(75,75,75)
            a0.Thickness=1

            a1.Parent=aZ
            a1.PaddingLeft=UDim.new(0,10)
            a1.PaddingRight=UDim.new(0,10)

            a2.Name="Icon"
            a2.Parent=aZ
            a2.AnchorPoint=Vector2.new(0.5,0.5)
            a2.BackgroundColor3=Color3.fromRGB(255,255,255)
            a2.BackgroundTransparency=1
            a2.BorderColor3=Color3.fromRGB(0,0,0)
            a2.BorderSizePixel=0
            a2.LayoutOrder=-5
            a2.Position=UDim2.new(0.5,0,0.5,0)
            a2.Size=UDim2.new(0,15,0,15)
            a2.Image=a:Asset(aT)
            a2.ImageTransparency=0.10000000149011612

            a3.Parent=aZ
            a3.Padding=UDim.new(0,10)
            a3.FillDirection=Enum.FillDirection.Horizontal
            a3.SortOrder=Enum.SortOrder.LayoutOrder
            a3.VerticalAlignment=Enum.VerticalAlignment.Center

            a4.Name="Text"
            a4.Parent=aZ
            a4.BackgroundColor3=Color3.fromRGB(255,255,255)
            a4.BackgroundTransparency=1
            a4.BorderColor3=Color3.fromRGB(0,0,0)
            a4.BorderSizePixel=0
            a4.Size=UDim2.new(1,-60,1,0)
            a4.Font=Enum.Font.GothamMedium
            a4.RichText=true
            a4.Text=aR
            a4.TextColor3=Color3.fromRGB(204,204,204)
            a4.TextSize=13
            a4.TextXAlignment=Enum.TextXAlignment.Left
            a4.TextTruncate=Enum.TextTruncate.AtEnd

            a5.Name="LineTab"
            a5.Parent=aZ
            a5.BackgroundColor3=Color3.fromRGB(65,65,65)
            a5.BackgroundTransparency=0.5
            a5.BorderColor3=Color3.fromRGB(0,0,0)
            a5.BorderSizePixel=0
            a5.LayoutOrder=-4
            a5.Position=UDim2.new(1,0,0,0)
            a5.Size=UDim2.new(0,1,1,0)

            a6.Name="Copy"
            a6.Parent=aZ
            a6.AnchorPoint=Vector2.new(0.5,0.5)
            a6.BackgroundColor3=Color3.fromRGB(255,255,255)
            a6.BackgroundTransparency=1
            a6.BorderColor3=Color3.fromRGB(0,0,0)
            a6.BorderSizePixel=0
            a6.LayoutOrder=5555
            a6.Position=UDim2.new(0.5,0,0.5,0)
            a6.Size=UDim2.new(0,15,0,15)
            a6.Image="rbxassetid://78020815235467"
            a6.ImageTransparency=0.10000000149011612

            a7.Parent=aX
            a7.Padding=UDim.new(0,7)
            a7.SortOrder=Enum.SortOrder.LayoutOrder

            a8.Name="Body"
            a8.Parent=aX
            a8.BackgroundColor3=Color3.fromRGB(0,0,0)
            a8.BackgroundTransparency=0.75
            a8.BorderColor3=Color3.fromRGB(0,0,0)
            a8.BorderSizePixel=0
            a8.LayoutOrder=999
            a8.Position=UDim2.new(0.850467265,0,0.301587313,0)
            a8.Size=UDim2.new(1,0,0,160)
            a8.ClipsDescendants=true

            a9.Parent=a8
            a9.CornerRadius=UDim.new(0,5)

            ba.Parent=a8
            ba.Color=Color3.fromRGB(75,75,75)
            ba.Thickness=1

            bb.Parent=a8
            bb.PaddingBottom=UDim.new(0,10)
            bb.PaddingLeft=UDim.new(0,15)
            bb.PaddingRight=UDim.new(0,15)
            bb.PaddingTop=UDim.new(0,10)

            bc.Parent=a8
            bc.Padding=UDim.new(0,10)
            bc.FillDirection=Enum.FillDirection.Horizontal
            bc.SortOrder=Enum.SortOrder.LayoutOrder
            bc.VerticalAlignment=Enum.VerticalAlignment.Center

            bd.Name="Code"
            bd.Parent=a8
            bd.BackgroundColor3=Color3.fromRGB(255,255,255)
            bd.BackgroundTransparency=1
            bd.BorderColor3=Color3.fromRGB(0,0,0)
            bd.BorderSizePixel=0
            bd.Size=UDim2.new(1,0,1,0)
            bd.Font=Enum.Font.GothamMedium
            bd.RichText=true
            bd.Text=a:Init(aS)
            bd.TextColor3=Color3.fromRGB(204,204,204)
            bd.TextSize=13
            bd.TextXAlignment=Enum.TextXAlignment.Left
            bd.TextYAlignment=Enum.TextYAlignment.Top
            bd.TextWrapped=true

            bd:GetPropertyChangedSignal'TextBounds':Connect(function()
                a8.Size=UDim2.new(1,0,0,math.max(34,bd.TextBounds.Y+15))
            end)

            a7:GetPropertyChangedSignal'AbsoluteContentSize':Connect(function()
                aU.Size=UDim2.new(1,0,0,a7.AbsoluteContentSize.Y+30)
            end)

            local be={}

            function be.SetCode(bf,bg)
                aS=bg
                bd.Text=a:Init(aS)
            end

            local bf=a:Button(a6)

            bf.MouseButton1Click:Connect(function()
                a6.Image="rbxassetid://121742282171603"

                delay(0.75,function()
                    a6.Image="rbxassetid://78020815235467"
                end)

                pcall(setclipboard,aS)
            end)

            return be
        end

        return aO
    end

    function aB.SetTransparent(aC,aD)
        if aD then
            B.BackgroundTransparency=0.16
        else
            B.BackgroundTransparency=0
        end
    end

    function aB.SetKeybind(aC,aD)
        v=aD
    end

    function aB.Close(aC)
        N=false
        O(true)
    end

    function aB.Open(aC)
        N=true
        O(false)
    end

    function aB.Toggle(aC)
        N=not N
        O(N)
    end

    function aB.Destroy(aC)
        A:Destroy()
        M:Destroy()
    end

    function aB.GetPath(aC)
        return A
    end

    function aB.GetWindowSettings(aC)
        return q
    end

    function aB.GetWindowSetting(aC,aD)
        return q[aD]
    end

    function aB.TweenScale(aC,aD)
        z=aD

        a:Tween{
            v=L,
            t=0.2,
            s="Exponential",
            d="Out",
            g={Scale=z}
        }:Play()
    end

    function aB.GetScale(aC)
        return L.Scale
    end

    function aB.TweenSize(aC,aD)
        a:Tween{
            v=B,
            t=0.2,
            s="Exponential",
            d="Out",
            g={Size=aD}
        }:Play()
    end

    local aC=Instance.new"ScreenGui"
    local aD=Instance.new"Frame"
    local aE=Instance.new"UIListLayout"
    local aG=Instance.new"UIPadding"

    aC.Name="LiquidNotify"
    aC.Parent=a:Parent()
    aC.ZIndexBehavior=Enum.ZIndexBehavior.Global
    aC.IgnoreGuiInset=true

    aD.Name="History"
    aD.Parent=aC
    aD.AnchorPoint=Vector2.new(1,0.5)
    aD.BackgroundColor3=Color3.fromRGB(255,255,255)
    aD.BackgroundTransparency=1
    aD.BorderColor3=Color3.fromRGB(0,0,0)
    aD.BorderSizePixel=0
    aD.Position=UDim2.new(1,0,0.5,0)
    aD.Size=UDim2.new(0,320,1,0)

    aE.Parent=aD
    aE.Padding=UDim.new(0,10)
    aE.HorizontalAlignment=Enum.HorizontalAlignment.Right
    aE.SortOrder=Enum.SortOrder.LayoutOrder
    aE.VerticalAlignment=Enum.VerticalAlignment.Bottom

    aG.Parent=aD
    aG.PaddingBottom=UDim.new(0,10)
    aG.PaddingLeft=UDim.new(0,10)
    aG.PaddingRight=UDim.new(0,10)
    aG.PaddingTop=UDim.new(0,10)

    function aB.Notification(aH,aI)
        local aJ=aI.Title or'Notification'
        local aK=aI.Desc or nil
        local aL=aI.Duration or 9e9
        local aM=aI.Icon or nil

        local aN=Instance.new"Frame"
        local aO=Instance.new"UIStroke"
        local aP=Instance.new"UICorner"
        local aQ=Instance.new"Frame"
        local aR=Instance.new"ImageLabel"
        local aS=Instance.new"UIListLayout"
        local aT=Instance.new"UIPadding"
        local aU=Instance.new"Frame"
        local aV=Instance.new"UIListLayout"
        local aW=Instance.new"TextLabel"
        local aX=Instance.new"UIPadding"
        local aY=Instance.new"TextLabel"
        local aZ=Instance.new"ImageLabel"

        aN.Name="Template"
        aN.Parent=aD
        aN.BackgroundColor3=Color3.fromRGB(40,40,40)
        aN.BackgroundTransparency=1
        aN.BorderColor3=Color3.fromRGB(0,0,0)
        aN.BorderSizePixel=0
        aN.Size=UDim2.new(0,0,0,55)
        aN.Position=UDim2.new(0.5,0,0,0)
        aN.AnchorPoint=Vector2.new(0.5,0)

        aO.Parent=aN
        aO.Color=Color3.fromRGB(25,25,25)
        aO.Thickness=1
        aO.Transparency=1

        aP.Parent=aN
        aP.CornerRadius=UDim.new(0,4)

        aQ.Name="Scaler"
        aQ.Parent=aN
        aQ.BackgroundColor3=Color3.fromRGB(255,255,255)
        aQ.BackgroundTransparency=1
        aQ.BorderColor3=Color3.fromRGB(0,0,0)
        aQ.BorderSizePixel=0
        aQ.Size=UDim2.new(1,0,1,0)

        if aM then
            aR.Name="Icon"
            aR.Parent=aQ
            aR.AnchorPoint=Vector2.new(0.5,0.5)
            aR.BackgroundColor3=Color3.fromRGB(255,255,255)
            aR.BackgroundTransparency=1
            aR.BorderColor3=Color3.fromRGB(0,0,0)
            aR.BorderSizePixel=0
            aR.Position=UDim2.new(0.5,0,0.5,0)
            aR.Size=UDim2.new(0,15,0,15)
            aR.Image=a:Asset(aM)
            aR.ImageTransparency=1
        end

        aS.Parent=aQ
        aS.Padding=UDim.new(0,15)
        aS.FillDirection=Enum.FillDirection.Horizontal
        aS.SortOrder=Enum.SortOrder.LayoutOrder
        aS.VerticalAlignment=Enum.VerticalAlignment.Center

        aT.Parent=aQ
        aT.PaddingRight=UDim.new(0,20)

        aU.Name="Text"
        aU.Parent=aQ
        aU.AnchorPoint=Vector2.new(1,0.5)
        aU.BackgroundColor3=Color3.fromRGB(255,255,255)
        aU.BackgroundTransparency=1
        aU.BorderColor3=Color3.fromRGB(0,0,0)
        aU.BorderSizePixel=0
        aU.LayoutOrder=-1
        aU.Position=UDim2.new(0,0,0.5,0)
        aU.ClipsDescendants=true

        if aM then
            aU.Size=UDim2.new(1,-30,1,0)
        else
            aU.Size=UDim2.new(1,0,1,0)
        end

        aV.Parent=aU
        aV.Padding=UDim.new(0,2)
        aV.SortOrder=Enum.SortOrder.LayoutOrder
        aV.VerticalAlignment=Enum.VerticalAlignment.Center

        aW.Name="Title"
        aW.Parent=aU
        aW.BackgroundColor3=Color3.fromRGB(255,255,255)
        aW.BackgroundTransparency=1
        aW.BorderColor3=Color3.fromRGB(0,0,0)
        aW.BorderSizePixel=0
        aW.LayoutOrder=-1
        aW.Size=UDim2.new(1,0,0,13)
        aW.Font=Enum.Font.GothamMedium
        aW.RichText=true
        aW.Text=aJ
        aW.TextColor3=Color3.fromRGB(235,235,235)
        aW.TextSize=13
        aW.TextXAlignment=Enum.TextXAlignment.Left
        aW.TextTransparency=1

        aX.Parent=aU
        aX.PaddingBottom=UDim.new(0,2)
        aX.PaddingLeft=UDim.new(0,15)
        aX.PaddingRight=UDim.new(0,15)
        aX.PaddingTop=UDim.new(0,2)

        local a_=55

        if aK then
            aY.Name="Desc"
            aY.Parent=aU
            aY.BackgroundColor3=Color3.fromRGB(145,145,145)
            aY.BackgroundTransparency=1
            aY.BorderColor3=Color3.fromRGB(0,0,0)
            aY.BorderSizePixel=0
            aY.Font=Enum.Font.GothamMedium
            aY.RichText=true
            aY.Size=UDim2.new(1,0,0,0)
            aY.Text=aK
            aY.TextColor3=Color3.fromRGB(145,145,145)
            aY.TextSize=12
            aY.TextXAlignment=Enum.TextXAlignment.Left
            aY.TextYAlignment=Enum.TextYAlignment.Top
            aY.TextTransparency=1
            aY.TextWrapped=true
            aY.AutomaticSize=Enum.AutomaticSize.Y
        end

        aZ.Name="Shadow"
        aZ.Parent=aN
        aZ.AnchorPoint=Vector2.new(0.5,0.5)
        aZ.BackgroundColor3=Color3.fromRGB(0,0,0)
        aZ.BackgroundTransparency=1
        aZ.BorderColor3=Color3.fromRGB(0,0,0)
        aZ.BorderSizePixel=0
        aZ.Position=UDim2.new(0.5,0,0.5,0)
        aZ.Size=UDim2.new(1,110,1,110)
        aZ.ZIndex=0
        aZ.Image="rbxassetid://8992230677"
        aZ.ImageColor3=Color3.fromRGB(0,0,0)
        aZ.ImageTransparency=1
        aZ.ScaleType=Enum.ScaleType.Slice
        aZ.SliceCenter=Rect.new(99,99,99,99)

        a:Tween{
            v=aZ,
            t=0.4,
            s="Back",
            d="Out",
            g={
                ImageTransparency=0.65
            }
        }:Play()

        if aK then
            a:Tween{
                v=aN,
                t=0.5,
                s="Back",
                d="Out",
                g={
                    Size=UDim2.new(1,0,0,aS.AbsoluteContentSize.Y+40),
                    BackgroundTransparency=0.1599999964237213
                }
            }:Play()
        else
            a:Tween{
                v=aN,
                t=0.5,
                s="Back",
                d="Out",
                g={
                    Size=UDim2.new(1,0,0,55),
                    BackgroundTransparency=0.1599999964237213
                }
            }:Play()
        end

        a:Tween{
            v=aO,
            t=0.4,
            s="Quart",
            d="Out",
            g={
                Transparency=0.5
            }
        }:Play()

        delay(0.2,function()
            a:Tween{
                v=aW,
                t=0.4,
                s="Quart",
                d="Out",
                g={
                    TextTransparency=0
                }
            }:Play()

            if aK then
                a:Tween{
                    v=aY,
                    t=0.4,
                    s="Quart",
                    d="Out",
                    g={
                        TextTransparency=0
                    }
                }:Play()
            end

            if aM then
                a:Tween{
                    v=aR,
                    t=0.4,
                    s="Quart",
                    d="Out",
                    g={
                        ImageTransparency=0.5
                    }
                }:Play()
            end
        end)

        delay(aL,function()
            a:Tween{
                v=aW,
                t=0.3,
                s="Quart",
                d="In",
                g={
                    TextTransparency=1
                }
            }:Play()

            if aK then
                a:Tween{
                    v=aY,
                    t=0.3,
                    s="Quart",
                    d="In",
                    g={
                        TextTransparency=1
                    }
                }:Play()
            end

            if aM then
                a:Tween{
                    v=aR,
                    t=0.3,
                    s="Quart",
                    d="In",
                    g={
                        ImageTransparency=1
                    }
                }:Play()
            end

            delay(0.15,function()
                a:Tween{
                    v=aZ,
                    t=0.4,
                    s="Back",
                    d="In",
                    g={
                        ImageTransparency=1
                    }
                }:Play()

                a:Tween{
                    v=aO,
                    t=0.3,
                    s="Quart",
                    d="In",
                    g={
                        Transparency=1
                    }
                }:Play()

                local a0=a:Tween{
                    v=aN,
                    t=0.5,
                    s="Back",
                    d="In",
                    g={
                        Size=UDim2.new(0,0,0,a_),
                        BackgroundTransparency=1
                    }
                }

                a0:Play()

                a0.Completed:Once(function()
                    aN:Destroy()
                end)
            end)
        end)
    end

    function aB.Managers(aH)
        local aI=aH:Tabs(81246215620663)do
            aI:Section{
                Title="Appearance",
                Icon=92721515638108
            }

            aI:Toggle{
                Title="Transparent",
                Desc="Make the background transparent.",
                Value=aH:GetWindowSetting'Transparent',
                Callback=function(aJ,aK)
                    aH:SetTransparent(aK)

                    aH:Notification{
                        Title=aK and"Transparent Has been Enabled"or"Transparent Has been Disabled",
                        Icon=96551286443180,
                        Duration=3
                    }
                end,
            }

            aI:Section{
                Title="Input",
                Icon=91697619966971
            }

            aI:Input{
                Title="Window Shortcut",
                Desc="A shortcut key that lets you open or close a UI window with one press.",
                Key=Enum.KeyCode.LeftControl,
                Value=true,
                Callback=function(aJ,aK,aL)
                    aH:SetKeybind(aK)
                end,
            }

            return aI
        end
    end

    return aB
end

return a
