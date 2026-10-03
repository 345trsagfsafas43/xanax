-- made by samet (joestar._3 on discord)
-- https://discord.gg/VhvTd5HV8d
-- default theme tokens sourced from withraven.ai (Graylark) assets/css/colors_and_type.css
-- example at bottom

if typeof(getgenv) == "function" then
    local OldLibrary = getgenv().Library

    if OldLibrary then
        pcall(function()
            OldLibrary:Unload()
        end)
    end
end

if not game:GetService("Players").LocalPlayer then
    warn("[Xanax] LocalPlayer is nil — run as a LocalScript / executor client, not a server Script.")
    return
end

local Library do
    local UserInputService = game:GetService("UserInputService")
    local Players = game:GetService("Players")
    local HttpService = game:GetService("HttpService")
    local RunService = game:GetService("RunService")
    local CoreGui = cloneref and cloneref(game:GetService("CoreGui")) or game:GetService("CoreGui")
    local TweenService = game:GetService("TweenService")

    local GetHui = typeof(gethui) == "function" and gethui or function()
        return CoreGui
    end

    local LocalPlayer = Players.LocalPlayer
    local Mouse = LocalPlayer:GetMouse()

    local FromRGB = Color3.fromRGB
    local FromHSV = Color3.fromHSV
    local FromHex = Color3.fromHex

    local RGBSequence = ColorSequence.new
    local RGBSequenceKeypoint = ColorSequenceKeypoint.new

    local UDim2New = UDim2.new
    local UDimNew = UDim.new
    local Vector2New = Vector2.new

    local MathClamp = math.clamp
    local MathFloor = math.floor

    local TableInsert = table.insert
    local TableFind = table.find
    local TableRemove = table.remove
    local TableConcat = table.concat
    local TableClone = table.clone
    local TableUnpack = table.unpack

    local StringFormat = string.format
    local StringFind = string.find
    local StringGSub = string.gsub
    local StringLen = string.len

    local InstanceNew = Instance.new

    Library = {
        Theme =  { },

        MenuKeybind = tostring(Enum.KeyCode.Z), 

        Flags = { },

        Version = "2.4.0",

        Tween = {
            Time = 0.15,
            Style = Enum.EasingStyle.Quart,
            Direction = Enum.EasingDirection.Out
        },

        FadeSpeed = 0.15,

        Performance = {
            EnableTweens = true,
            DirectDrag = true,
        },

        Webhook = {
            URL = "",
            Enabled = false,
            SendOnLoad = false,
            Username = "Xanax UI",
            Spacing = 0.45,
        },

        Folders = {
            Directory = "esdeeeeee",
            Configs = "esdeeeeee/Configs",
            Assets = "esdeeeeee/Assets",
            Fonts = "esdeeeeee/Fonts",
        },

        -- Ignore below
        Pages = { },
        Sections = { },

        Connections = { },
        Threads = { },

        ThemeMap = { },
        ThemeIndex = { },
        ThemeDynamic = { },

        OpenFrames = { },

        SetFlags = { },

        Keybinds = { },
        KeybindHooked = false,
        KeybindListVisible = true,
        Sliders = { },
        SliderHooked = false,
        Dropdowns = { },
        DropdownHooked = false,

        WebhookQueue = { },
        WebhookDraining = false,

        UnnamedConnections = 0,
        UnnamedFlags = 0,

        _FadeGen = 0,

        Holder = nil,
        NotifHolder = nil,
        UnusedHolder = nil,

        Font = nil
    }

    local Keys = {
        ["Unknown"]           = "Unknown",
        ["Backspace"]         = "Back",
        ["Tab"]               = "Tab",
        ["Clear"]             = "Clear",
        ["Return"]            = "Return",
        ["Pause"]             = "Pause",
        ["Escape"]            = "Escape",
        ["Space"]             = "Space",
        ["QuotedDouble"]      = '"',
        ["Hash"]              = "#",
        ["Dollar"]            = "$",
        ["Percent"]           = "%",
        ["Ampersand"]         = "&",
        ["Quote"]             = "'",
        ["LeftParenthesis"]   = "(",
        ["RightParenthesis"]  = " )",
        ["Asterisk"]          = "*",
        ["Plus"]              = "+",
        ["Comma"]             = ",",
        ["Minus"]             = "-",
        ["Period"]            = ".",
        ["Slash"]             = "`",
        ["Three"]             = "3",
        ["Seven"]             = "7",
        ["Eight"]             = "8",
        ["Colon"]             = ":",
        ["Semicolon"]         = ";",
        ["LessThan"]          = "<",
        ["GreaterThan"]       = ">",
        ["Question"]          = "?",
        ["Equals"]            = "=",
        ["At"]                = "@",
        ["LeftBracket"]       = "LeftBracket",
        ["RightBracket"]      = "RightBracked",
        ["BackSlash"]         = "BackSlash",
        ["Caret"]             = "^",
        ["Underscore"]        = "_",
        ["Backquote"]         = "`",
        ["LeftCurly"]         = "{",
        ["Pipe"]              = "|",
        ["RightCurly"]        = "}",
        ["Tilde"]             = "~",
        ["Delete"]            = "Delete",
        ["End"]               = "End",
        ["KeypadZero"]        = "Keypad0",
        ["KeypadOne"]         = "Keypad1",
        ["KeypadTwo"]         = "Keypad2",
        ["KeypadThree"]       = "Keypad3",
        ["KeypadFour"]        = "Keypad4",
        ["KeypadFive"]        = "Keypad5",
        ["KeypadSix"]         = "Keypad6",
        ["KeypadSeven"]       = "Keypad7",
        ["KeypadEight"]       = "Keypad8",
        ["KeypadNine"]        = "Keypad9",
        ["KeypadPeriod"]      = "KeypadP",
        ["KeypadDivide"]      = "KeypadD",
        ["KeypadMultiply"]    = "KeypadM",
        ["KeypadMinus"]       = "KeypadM",
        ["KeypadPlus"]        = "KeypadP",
        ["KeypadEnter"]       = "KeypadE",
        ["KeypadEquals"]      = "KeypadE",
        ["Insert"]            = "Insert",
        ["Home"]              = "Home",
        ["PageUp"]            = "PageUp",
        ["PageDown"]          = "PageDown",
        ["RightShift"]        = "RightShift",
        ["LeftShift"]         = "LeftShift",
        ["RightControl"]      = "RightControl",
        ["LeftControl"]       = "LeftControl",
        ["LeftAlt"]           = "LeftAlt",
        ["RightAlt"]          = "RightAlt"
    }

    local Themes = {
        ["Xanax"] = {
            ["Background"] = FromRGB(12, 12, 12),
            ["Inline"] = FromRGB(20, 20, 20),
            ["Element"] = FromRGB(32, 32, 32),
            ["Outline"] = FromRGB(52, 52, 52),
            ["Accent"] = FromRGB(238, 238, 238),
            ["Text"] = FromRGB(238, 238, 238),
            ["TextDim"] = FromRGB(175, 175, 175),
            ["TextSoft"] = FromRGB(200, 200, 200),
            ["TextFaint"] = FromRGB(110, 110, 110),
            ["IrisDeep"] = FromRGB(28, 28, 30),
            ["IrisPale"] = FromRGB(220, 220, 224),
            ["Success"] = FromRGB(220, 220, 220),
            ["Warning"] = FromRGB(170, 170, 170),
            ["Danger"] = FromRGB(130, 130, 130),
            ["Info"] = FromRGB(190, 190, 190),
            -- legacy keys kept so old example code doesn't nil-error
            ["Border"] = FromRGB(35, 35, 35),
            ["Border 2"] = FromRGB(52, 52, 52),
        }
    }
    Themes["Preset"] = Themes["Xanax"]

    Library.__index = Library
    Library.Sections.__index = Library.Sections
    Library.Pages.__index = Library.Pages

    Library.Theme = TableClone(Themes["Preset"])

    -- Folders
    local FolderPaths = { }
    for _, FolderPath in Library.Folders do
        TableInsert(FolderPaths, FolderPath)
    end

    table.sort(FolderPaths, function(FolderA, FolderB)
        local _, DepthA = StringGSub(FolderA, "/", "")
        local _, DepthB = StringGSub(FolderB, "/", "")
        return DepthA < DepthB
    end)

    for _, FolderPath in FolderPaths do
        if not isfolder(FolderPath) then
            pcall(makefolder, FolderPath)
        end
    end

    -- Tweening
    local Tween = { } do
        Tween.__index = Tween

        Tween.Create = function(self, Item, Info, Goal, IsRawItem)
            Item = IsRawItem and Item or Item.Instance
            if Item == nil then
                return nil
            end
            if Library.Performance and Library.Performance.EnableTweens == false then
                pcall(function()
                    for Prop, Val in Goal do
                        Item[Prop] = Val
                    end
                end)
                return nil
            end
            Info = Info or TweenInfo.new(Library.Tween.Time, Library.Tween.Style, Library.Tween.Direction)
            Library._ActiveTweens = Library._ActiveTweens or {}
            local Prev = Library._ActiveTweens[Item]
            if Prev then
                pcall(function() Prev:Cancel() end)
                Library._ActiveTweens[Item] = nil
            end
            local Ok, Tw = pcall(TweenService.Create, TweenService, Item, Info, Goal)
            if not Ok or Tw == nil then
                pcall(function()
                    for Prop, Val in Goal do
                        Item[Prop] = Val
                    end
                end)
                return nil
            end
            Library._ActiveTweens[Item] = Tw
            pcall(function()
                Tw.Completed:Once(function()
                    if Library._ActiveTweens then
                        Library._ActiveTweens[Item] = nil
                    end
                end)
            end)
            Tw:Play()
            local NewTween = {
                Tween = Tw,
                Info = Info,
                Goal = Goal,
                Item = Item
            }
            setmetatable(NewTween, Tween)
            return NewTween
        end

        local FadePropCache = { }

        Tween.GetProperty = function(self, Item)
            Item = Item or self.Item

            local Class = Item.ClassName
            local Cached = FadePropCache[Class]

            if Cached ~= nil then
                if Cached == false then
                    return nil
                end

                return Cached
            end

            local Result = nil

            if Item:IsA("Frame") then
                Result = { "BackgroundTransparency" }
            elseif Item:IsA("TextLabel") or Item:IsA("TextButton") then
                Result = { "TextTransparency", "BackgroundTransparency" }
            elseif Item:IsA("ImageLabel") or Item:IsA("ImageButton") then
                Result = { "BackgroundTransparency", "ImageTransparency" }
            elseif Item:IsA("ScrollingFrame") then
                Result = { "BackgroundTransparency", "ScrollBarImageTransparency" }
            elseif Item:IsA("TextBox") then
                Result = { "TextTransparency", "BackgroundTransparency" }
            elseif Item:IsA("UIStroke") then
                Result = { "Transparency" }
            end

            if Result == nil then
                FadePropCache[Class] = false
            else
                FadePropCache[Class] = Result
            end

            return Result
        end

        local FadeTargetsCache = setmetatable({ }, { __mode = "k" })

        Tween.GetFadeTargets = function(self, Root)
            local Generation = Library._FadeGen
            local Cached = FadeTargetsCache[Root]

            if Cached and Cached.Generation == Generation then
                return Cached.Targets
            end

            local Descendants = Root:GetDescendants()
            local Targets = TableClone(Descendants)
            TableInsert(Targets, Root)
            FadeTargetsCache[Root] = { Targets = Targets, Generation = Generation }
            return Targets
        end

        Tween.BatchFade = function(self, Root, Opening, Speed, ZIndexWhenOpen, OnDone)
            local Targets = self:GetFadeTargets(Root)
            local Goals = { }
            local Order = { }
            local Restores = { }

            for _, Node in Targets do
                local Shown = true
                local Current = Node

                while Current do
                    if Current:IsA("GuiObject") and not Current.Visible then
                        Shown = false
                        break
                    end
                    if Current:IsA("LayerCollector") and not Current.Enabled then
                        Shown = false
                        break
                    end
                    Current = Current.Parent
                end

                if not Shown then
                    continue
                end

                local Properties = Tween:GetProperty(Node)

                if not Properties then
                    continue
                end

                if type(Properties) ~= "table" then
                    Properties = { Properties }
                end

                local NodeGoal = nil

                for _, Property in Properties do
                    local OkProp, Resting = pcall(function() return Node[Property] end)

                    if not OkProp or Resting == 1 then
                        continue
                    end

                    if Opening then
                        pcall(function()
                            Node[Property] = 1
                        end)
                    else
                        TableInsert(Restores, { Node = Node, Property = Property, Value = Resting })
                    end

                    if not NodeGoal then
                        NodeGoal = { }
                    end

                    NodeGoal[Property] = Opening and Resting or 1
                end

                if NodeGoal then
                    Goals[Node] = NodeGoal
                    TableInsert(Order, Node)
                end

                if ZIndexWhenOpen and not Node.ClassName:find("UI") then
                    Node.ZIndex = Opening and ZIndexWhenOpen or 1
                end
            end

            local LastTween
            local Info = TweenInfo.new(Speed or Library.FadeSpeed, Library.Tween.Style, Library.Tween.Direction)

            for _, Node in Order do
                local Created = Tween:Create(Node, Info, Goals[Node], true)

                if Created then
                    LastTween = Created
                end
            end

            local function Finish()
                if OnDone then
                    OnDone()
                end

                if not Opening then
                    for _, Entry in Restores do
                        pcall(function()
                            Entry.Node[Entry.Property] = Entry.Value
                        end)
                    end
                end
            end

            if LastTween then
                LastTween.Tween.Completed:Once(Finish)
            else
                Finish()
            end

            return LastTween
        end

        Tween.Get = function(self)
            if not self.Tween then 
                return
            end

            return self.Tween, self.Info, self.Goal
        end

        Tween.Pause = function(self)
            if not self.Tween then 
                return
            end

            self.Tween:Pause()
        end

        Tween.Play = function(self)
            if not self.Tween then 
                return
            end

            self.Tween:Play()
        end

        Tween.Clean = function(self)
            if not self.Tween then 
                return
            end

            self.Tween:Pause()
        end
    end

    -- Instances
    local Instances = { } do
        Instances.__index = Instances

        Instances.Create = function(self, Class, Properties)
            local NewItem = {
                Instance = InstanceNew(Class),
                Properties = Properties,
                Class = Class
            }

            setmetatable(NewItem, Instances)

            for Property, Value in NewItem.Properties do
                NewItem.Instance[Property] = Value
            end

            Library._FadeGen = Library._FadeGen + 1

            return NewItem
        end

        Instances.AddToTheme = function(self, Properties)
            if not self.Instance then 
                return
            end

            Library:AddToTheme(self, Properties)
        end

        Instances.ChangeItemTheme = function(self, Properties)
            if not self.Instance then 
                return
            end

            Library:ChangeItemTheme(self, Properties)
        end

        Instances.Connect = function(self, Event, Callback, Name)
            if not self.Instance then 
                return
            end

            if not self.Instance[Event] then 
                return
            end

            return Library:Connect(self.Instance[Event], Callback, Name)
        end

        Instances.Tween = function(self, Info, Goal)
            if not self.Instance then 
                return
            end

            return Tween:Create(self, Info, Goal)
        end

        Instances.Disconnect = function(self, Name)
            if not self.Instance then 
                return
            end

            return Library:Disconnect(Name)
        end

        Instances.Clean = function(self)
            if not self.Instance then 
                return
            end

            Library._FadeGen = Library._FadeGen + 1
            Library:UnregisterTheme(self.Instance)
            self.Instance:Destroy()
        end

        Instances.MakeDraggable = function(self)
            if not self.Instance then 
                return
            end

            local Gui = self.Instance

            local Dragging = false 
            local DragStart
            local StartPosition 

            local Set = function(Input)
                local DragDelta = Input.Position - DragStart
                local NewX = StartPosition.X.Offset + DragDelta.X
                local NewY = StartPosition.Y.Offset + DragDelta.Y
                local ParentSize = Gui.Parent and Gui.Parent.AbsoluteSize or Vector2New(1920, 1080)
                local GuiSize = Gui.AbsoluteSize
                NewX = MathClamp(NewX, 0, math.max(0, ParentSize.X - GuiSize.X))
                NewY = MathClamp(NewY, 0, math.max(0, ParentSize.Y - GuiSize.Y))
                Gui.Position = UDim2New(StartPosition.X.Scale, NewX, StartPosition.Y.Scale, NewY)
            end

            local InputChanged

            self:Connect("InputBegan", function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                    Dragging = true

                    DragStart = Input.Position
                    StartPosition = Gui.Position

                    if InputChanged then 
                        return
                    end

                    InputChanged = Input.Changed:Connect(function()
                        if Input.UserInputState == Enum.UserInputState.End then
                            Dragging = false

                            InputChanged:Disconnect()
                            InputChanged = nil
                        end
                    end)
                end
            end)

            Library:Connect(UserInputService.InputChanged, function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
                    if Dragging then
                        Set(Input)
                    end
                end
            end)

            return Dragging
        end

        Instances.MakeResizeable = function(self, Minimum, Maximum)
            if not self.Instance then 
                return
            end

            local Gui = self.Instance

            local Resizing = false 
            local Start = UDim2New()
            local Delta = UDim2New()
            local ResizeMax = Gui.Parent.AbsoluteSize - Gui.AbsoluteSize

            local ResizeButton = Instances:Create("ImageButton", {
				Parent = Gui,
                Image = "rbxassetid://",
				AnchorPoint = Vector2New(1, 1),
				BorderColor3 = FromRGB(0, 0, 0),
				Size = UDim2New(0, 8, 0, 8),
				Position = UDim2New(1, -4, 1, -4),
                Name = "\0",
				BorderSizePixel = 0,
				BackgroundTransparency = 1,
                ZIndex = 5,
				AutoButtonColor = false,
                Visible = true,
			})  ResizeButton:AddToTheme({ImageColor3 = "Accent"})

            local InputChanged

            ResizeButton:Connect("InputBegan", function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then

                    Resizing = true

                    Start = Gui.Size - UDim2New(0, Input.Position.X, 0, Input.Position.Y)

                    if InputChanged then 
                        return
                    end

                    InputChanged = Input.Changed:Connect(function()
                        if Input.UserInputState == Enum.UserInputState.End then
                            Resizing = false

                            InputChanged:Disconnect()
                            InputChanged = nil
                        end
                    end)
                end
            end)

            Library:Connect(UserInputService.InputChanged, function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
                    if Resizing then
                        ResizeMax = Maximum or Gui.Parent.AbsoluteSize - Gui.AbsoluteSize

                        Delta = Start + UDim2New(0, Input.Position.X, 0, Input.Position.Y)
                        Delta = UDim2New(0, math.clamp(Delta.X.Offset, Minimum.X, ResizeMax.X), 0, math.clamp(Delta.Y.Offset, Minimum.Y, ResizeMax.Y))

                        if Library.Performance.DirectDrag then
                            Gui.Size = Delta
                        else
                            Tween:Create(Gui, TweenInfo.new(0.17, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = Delta}, true)
                        end
                    end
                end
            end)

            return Resizing
        end

        Instances.OnHover = function(self, Function)
            if not self.Instance then 
                return
            end
            
            return Library:Connect(self.Instance.MouseEnter, Function)
        end

        Instances.OnHoverLeave = function(self, Function)
            if not self.Instance then 
                return
            end
            
            return Library:Connect(self.Instance.MouseLeave, Function)
        end
    end

    -- Custom font
    local CustomFont = { } do
        function CustomFont:New(Name, Weight, Style, Data)
            if not isfile(Data.Id) then 
                writefile(Data.Id, game:HttpGet(Data.Url))
            end

            local FontData = {
                name = Name,
                faces = {
                    {
                        name = Name,
                        weight = Weight,
                        style = Style,
                        assetId = getcustomasset(Data.Id)
                    }
                }
            }

            writefile(`{Library.Folders.Fonts}/{Name}.font`, HttpService:JSONEncode(FontData))
            return Font.new(getcustomasset(`{Library.Folders.Fonts}/{Name}.font`), Enum.FontWeight.Regular, Enum.FontStyle.Normal)
        end

        local function FallbackFont()
            local Ok, Face = pcall(Font.fromEnum, Enum.Font.GothamBold)

            if Ok and Face then
                return Face
            end

            return Enum.Font.GothamBold
        end

        pcall(function()
            Library.Font = CustomFont:New("InterSemiBold", "Regular", "Normal", {
                Id = "Inter",
                Url = "https://github.com/sametexe001/luas/raw/refs/heads/main/fonts/InterSemibold.ttf"
            })
        end)

        if not Library.Font then
            Library.Font = FallbackFont()
        end

        Library.FontMono = Library.Font
        pcall(function()
            Library.FontMono = CustomFont:New("DMMono", "Regular", "Normal", {
                Id = "DMMono",
                Url = "https://github.com/google/fonts/raw/main/ofl/dmmono/DMMono-Regular.ttf"
            })
        end)
        if not Library.FontMono then
            Library.FontMono = Library.Font
        end
    end

    Library.Holder = Instances:Create("ScreenGui", {
        Parent = GetHui(),
        Name = "\0",
        ZIndexBehavior = Enum.ZIndexBehavior.Global,
        DisplayOrder = 2,
        ResetOnSpawn = false
    })

    Library.UnusedHolder = Instances:Create("ScreenGui", {
        Parent = GetHui(),
        Name = "\0",
        ZIndexBehavior = Enum.ZIndexBehavior.Global,
        Enabled = false,
        ResetOnSpawn = false
    })

    Library.NotifHolder = Instances:Create("Frame", {
        Parent = Library.Holder.Instance,
        Name = "\0",
        BackgroundTransparency = 1,
        Size = UDim2New(0, 0, 1, 0),
        BorderColor3 = FromRGB(0, 0, 0),
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.X,
        BackgroundColor3 = FromRGB(255, 255, 255)
    })
    
    Instances:Create("UIListLayout", {
        Parent = Library.NotifHolder.Instance,
        Name = "\0",
        Padding = UDimNew(0, 12),
        SortOrder = Enum.SortOrder.LayoutOrder
    })
    
    Instances:Create("UIPadding", {
        Parent = Library.NotifHolder.Instance,
        Name = "\0",
        PaddingTop = UDimNew(0, 12),
        PaddingBottom = UDimNew(0, 12),
        PaddingRight = UDimNew(0, 12),
        PaddingLeft = UDimNew(0, 12)
    })

    Library.Unload = function(self)
        pcall(function()
            if self._ActiveTweens then
                for Inst, Tw in self._ActiveTweens do
                    pcall(function() Tw:Cancel() end)
                end
                self._ActiveTweens = {}
            end
        end)
        for Index, Value in self.Connections do
            pcall(function()
                if Value.Connection then
                    Value.Connection:Disconnect()
                end
            end)
        end
        self.Connections = {}
        for Index, Value in self.Threads do
            pcall(coroutine.close, Value)
        end
        self.Threads = {}
        self.ThemeMap = {}
        self.ThemeIndex = {}
        self.ThemeDynamic = {}
        self.Keybinds = {}
        self.KeybindHooked = false
        self.KeybindListItems = nil
        self.Sliders = {}
        self.SliderHooked = false
        self.Dropdowns = {}
        self.DropdownHooked = false
        self.WebhookQueue = {}
        self.OpenFrames = {}
        if self.Holder then
            pcall(function() self.Holder:Clean() end)
            self.Holder = nil
        end
        if self.UnusedHolder then
            pcall(function() self.UnusedHolder:Clean() end)
            self.UnusedHolder = nil
        end
        self.NotifHolder = nil

        if typeof(getgenv) == "function" then
            getgenv().Library = nil
        end

        Library = nil
    end

    Library.GetImage = function(self, Image)
        local ImageData = self.Images and self.Images[Image]

        if not ImageData then 
            return
        end

        return getcustomasset(self.Folders.Assets .. "/" .. ImageData[1])
    end

    Library.Round = function(self, Number, Float)
        local Divisor = Float or 1

        if Divisor == 0 then
            Divisor = 1
        end

        local Multiplier = 1 / Divisor
        return MathFloor(Number * Multiplier) / Multiplier
    end

    Library.Thread = function(self, Function)
        local NewThread = coroutine.create(Function)
        
        coroutine.wrap(function()
            coroutine.resume(NewThread)
        end)()

        TableInsert(self.Threads, NewThread)
        return NewThread
    end
    
    Library.SafeCall = function(self, Function, ...)
        local Arguements = { ... }
        local Success, Result = pcall(Function, TableUnpack(Arguements))

        if not Success then
            warn(Result)
            return false
        end

        return Success
    end

    local function GetWebRequest()
        if typeof(http_request) == "function" then
            return http_request
        end
        if typeof(request) == "function" then
            return request
        end
        if typeof(syn) == "table" and typeof(syn.request) == "function" then
            return syn.request
        end
        return nil
    end

    local function DrainWebhookQueue(Spacing)
        local State = Library

        if not State or State.WebhookDraining then
            return
        end

        State.WebhookDraining = true

        task.spawn(function()
            local RequestFn = GetWebRequest()

            while RequestFn and #State.WebhookQueue > 0 do
                local Entry = TableRemove(State.WebhookQueue, 1)

                pcall(function()
                    RequestFn({
                        Url = Entry.URL,
                        Method = "POST",
                        Headers = { ["Content-Type"] = "application/json" },
                        Body = Entry.Payload
                    })
                end)

                task.wait(Spacing)
            end

            State.WebhookDraining = false
        end)
    end

    Library.AccentColorNumber = function(self)
        local Accent = self.Theme.Accent
        return MathFloor(Accent.R * 255) * 65536 + MathFloor(Accent.G * 255) * 256 + MathFloor(Accent.B * 255)
    end

    Library.SaveWebhook = function(self)
        pcall(function()
            writefile(self.Folders.Directory .. "/webhook.json", HttpService:JSONEncode({
                URL = self.Webhook.URL,
                Enabled = self.Webhook.Enabled,
                SendOnLoad = self.Webhook.SendOnLoad,
                Username = self.Webhook.Username
            }))
        end)
    end

    Library.LoadWebhook = function(self)
        local Path = self.Folders.Directory .. "/webhook.json"
        local ReadOk, Raw = pcall(readfile, Path)

        if not ReadOk or type(Raw) ~= "string" or Raw == "" then
            return false
        end

        local DecodeOk, Data = pcall(function()
            return HttpService:JSONDecode(Raw)
        end)

        if not DecodeOk or type(Data) ~= "table" then
            return false
        end

        if type(Data.URL) == "string" then
            self.Webhook.URL = Data.URL
        end
        if type(Data.Enabled) == "boolean" then
            self.Webhook.Enabled = Data.Enabled
        end
        if type(Data.SendOnLoad) == "boolean" then
            self.Webhook.SendOnLoad = Data.SendOnLoad
        end
        if type(Data.Username) == "string" and Data.Username ~= "" then
            self.Webhook.Username = Data.Username
        end

        return true
    end

    Library.SendWebhook = function(self, Title, Description, Color)
        if not self.Webhook.Enabled then
            return false, "webhook disabled"
        end

        local URL = tostring(self.Webhook.URL or "")

        if #URL < 10 or StringFind(URL, "http", 1, true) ~= 1 then
            warn("[Xanax] Webhook URL not set")
            return false, "bad url"
        end

        local RequestFn = GetWebRequest()
        if not RequestFn then
            warn("[Xanax] No http request function on this executor")
            return false, "no request fn"
        end

        local UserText = "unknown"
        pcall(function()
            UserText = LocalPlayer.DisplayName .. " (@" .. LocalPlayer.Name .. " | " .. tostring(LocalPlayer.UserId) .. ")"
        end)

        local FooterText = UserText
        pcall(function()
            FooterText = UserText .. " | " .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
        end)

        local OkEncode, Payload = pcall(function()
            return HttpService:JSONEncode({
                username = self.Webhook.Username or "Xanax UI",
                embeds = {{
                    title = tostring(Title or "Xanax UI"),
                    description = tostring(Description or ""),
                    color = tonumber(Color) or self:AccentColorNumber(),
                    footer = { text = FooterText },
                    timestamp = DateTime.now():ToIsoDate(),
                }},
            })
        end)

        if not OkEncode then
            return false, Payload
        end

        TableInsert(self.WebhookQueue, { URL = URL, Payload = Payload })
        DrainWebhookQueue(self.Webhook.Spacing)

        return true
    end

    Library:LoadWebhook()

    Library.Connect = function(self, Event, Callback, Name)
        if not Name then
            self.UnnamedConnections = self.UnnamedConnections + 1
            Name = StringFormat("connection_number_%s", self.UnnamedConnections)
        end

        local NewConnection = {
            Event = Event,
            Callback = Callback,
            Name = Name,
            Connection = nil
        }

        NewConnection.Disconnect = function()
            if NewConnection.Connection then
                pcall(function()
                    NewConnection.Connection:Disconnect()
                end)
                NewConnection.Connection = nil
            end
        end

        local Ok, Conn = pcall(function()
            return Event:Connect(Callback)
        end)
        if Ok then
            NewConnection.Connection = Conn
        else
            warn("[Library] Connect failed: " .. tostring(Conn))
        end

        TableInsert(self.Connections, NewConnection)
        return NewConnection
    end

    Library.Disconnect = function(self, Name)
        for _, Connection in self.Connections do 
            if Connection.Name == Name then
                Connection.Connection:Disconnect()
                break
            end
        end
    end

    Library.NextFlag = function(self)
        self.UnnamedFlags = self.UnnamedFlags + 1
        return StringFormat("flag_number_%s", self.UnnamedFlags)
    end

    local function UnwrapItem(Item)
        if type(Item) == "table" then
            return Item.Instance
        end

        return Item
    end

    Library.AddToTheme = function(self, Item, Properties)
        Item = UnwrapItem(Item)

        if Item == nil then
            return
        end

        if not self.ThemeMap[Item] then
            self.ThemeMap[Item] = {
                Item = Item,
                Properties = { },
                Entries = { }
            }
        end

        self:ChangeItemTheme(Item, Properties)
    end

    local function UnregisterThemeEntries(self, Item, Entries)
        for _, Entry in Entries do
            local Bucket = self.ThemeIndex[Entry.Key]

            if Bucket then
                for Index = #Bucket, 1, -1 do
                    local Indexed = Bucket[Index]

                    if Indexed.Item == Item and Indexed.Property == Entry.Property then
                        TableRemove(Bucket, Index)
                        break
                    end
                end
            end
        end
    end

    Library.UnregisterTheme = function(self, Item)
        Item = UnwrapItem(Item)

        if Item == nil then
            return
        end

        local ThemeData = self.ThemeMap[Item]

        if not ThemeData then
            return
        end

        UnregisterThemeEntries(self, Item, ThemeData.Entries)

        if ThemeData.Dynamic then
            local Index = TableFind(self.ThemeDynamic, ThemeData)

            if Index then
                TableRemove(self.ThemeDynamic, Index)
            end
        end

        self.ThemeMap[Item] = nil
    end

	Library.ToRich = function(self, Text, Color)
		return `<font color="rgb({MathFloor(Color.R * 255)}, {MathFloor(Color.G * 255)}, {MathFloor(Color.B * 255)})">{Text}</font>`
	end

    Library.GetConfig = function(self)
        local Config = { }
        local Encoded = "{}"

        Library:SafeCall(function()
            for Index, Value in Library.Flags do 
                if type(Value) == "table" and Value.Key then
                    Config[Index] = {Key = tostring(Value.Key), Mode = Value.Mode, Toggled = Value.Toggled}
                elseif type(Value) == "table" and Value.Color then
                    Config[Index] = {Color = "#" .. Value.HexValue, Alpha = Value.Alpha}
                else
                    Config[Index] = Value
                end
            end

            Encoded = HttpService:JSONEncode(Config)
        end)

        return Encoded
    end

    Library.LoadConfig = function(self, Config)
        local DecodeOk, Decoded = pcall(HttpService.JSONDecode, HttpService, Config)

        if not DecodeOk or type(Decoded) ~= "table" then
            warn("[Library] Config decode failed: " .. tostring(Decoded))
            return false, Decoded
        end

        local Success, Result = Library:SafeCall(function()
            for Index, Value in Decoded do 
                local SetFunction = Library.SetFlags[Index]

                if not SetFunction then
                    continue
                end

                if type(Value) == "table" and Value.Key then 
                    SetFunction(Value)
                elseif type(Value) == "table" and Value.Color then
                    SetFunction(Value.Color, Value.Alpha)
                else
                    SetFunction(Value)
                end
            end
        end)

        return Success, Result
    end

    Library.DeleteConfig = function(self, Config)
        if type(Config) ~= "string" or Config == "" then
            return
        end

        local FileName = StringFind(Config, ".json", 1, true) and Config or (Config .. ".json")
        local FilePath = Library.Folders.Configs .. "/" .. FileName

        if isfile(FilePath) then
            delfile(FilePath)
        end
    end

    Library.RefreshConfigsList = function(self, Element)
        local ReturnList = { }

        local ListOk, Files = pcall(listfiles, Library.Folders.Configs)

        if ListOk and type(Files) == "table" then
            for _, File in Files do
                if type(File) == "string" and File:sub(-5) == ".json" then
                    local NameStart = 1

                    for Index = #File, 1, -1 do
                        local Character = File:sub(Index, Index)

                        if Character == "/" or Character == "\\" then
                            NameStart = Index + 1
                            break
                        end
                    end

                    local ConfigName = File:sub(NameStart, #File - 5)

                    if ConfigName ~= "" then
                        TableInsert(ReturnList, ConfigName)
                    end
                end
            end
        end

        Element:Refresh(ReturnList)
    end

    Library.ChangeItemTheme = function(self, Item, Properties)
        Item = UnwrapItem(Item)

        if Item == nil then
            return
        end

        local ThemeData = self.ThemeMap[Item]

        if not ThemeData then
            return
        end

        UnregisterThemeEntries(self, Item, ThemeData.Entries)

        ThemeData.Entries = { }
        ThemeData.Properties = Properties

        local HasFunction = false

        for Property, Value in Properties do
            if type(Value) == "string" then
                local ThemeValue = self.Theme[Value]

                if ThemeValue ~= nil then
                    Item[Property] = ThemeValue
                end

                TableInsert(ThemeData.Entries, { Property = Property, Key = Value })

                local Bucket = self.ThemeIndex[Value]

                if not Bucket then
                    Bucket = { }
                    self.ThemeIndex[Value] = Bucket
                end

                TableInsert(Bucket, { Item = Item, Property = Property })
            else
                HasFunction = true
                Item[Property] = Value()
            end
        end

        if HasFunction and not ThemeData.Dynamic then
            ThemeData.Dynamic = true
            TableInsert(self.ThemeDynamic, ThemeData)
        elseif not HasFunction and ThemeData.Dynamic then
            ThemeData.Dynamic = false

            local Index = TableFind(self.ThemeDynamic, ThemeData)

            if Index then
                TableRemove(self.ThemeDynamic, Index)
            end
        end
    end

    Library.ChangeTheme = function(self, Theme, Color)
        self.Theme[Theme] = Color

        local Bucket = self.ThemeIndex[Theme]

        if Bucket then
            for _, Entry in Bucket do
                Entry.Item[Entry.Property] = Color
            end
        end

        for _, ThemeData in self.ThemeDynamic do
            for Property, Value in ThemeData.Properties do
                if type(Value) == "function" then
                    pcall(function()
                        ThemeData.Item[Property] = Value()
                    end)
                end
            end
        end
    end

    Library.IsMouseOverFrame = function(self, Frame)
        Frame = Frame.Instance

        local MousePosition = Vector2New(Mouse.X, Mouse.Y)

        return MousePosition.X >= Frame.AbsolutePosition.X and MousePosition.X <= Frame.AbsolutePosition.X + Frame.AbsoluteSize.X 
        and MousePosition.Y >= Frame.AbsolutePosition.Y and MousePosition.Y <= Frame.AbsolutePosition.Y + Frame.AbsoluteSize.Y
    end

    Library.Lerp = function(self, Start, Finish, Time)
        return Start + (Finish - Start) * Time
    end

    Library.CompareVectors = function(self, PointA, PointB)
        return (PointA.X < PointB.X) or (PointA.Y < PointB.Y)
    end

    Library.IsClipped = function(self, Object, Column)
        local Parent = Column
        
        local BoundryTop = Parent.AbsolutePosition
        local BoundryBottom = BoundryTop + Parent.AbsoluteSize

        local Top = Object.AbsolutePosition
        local Bottom = Top + Object.AbsoluteSize 

        return Library:CompareVectors(Top, BoundryTop) or Library:CompareVectors(BoundryBottom, Bottom)
    end

    do
        Library.CreateColorpicker = function(self, Data)
            local Colorpicker = {
                Hue = 0,
                Saturation = 0,
                Value = 0,

                Color = FromRGB(0, 0, 0),
                HexValue = "000000",

                Flag = Data.Flag,

                IsOpen = false
            }

            local Items = { } do
                Items["ColorpickerButton"] = Instances:Create("TextButton", {
                    Parent = Data.Parent.Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(0, 0, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    Size = UDim2New(0, 14, 0, 14),
                    BorderSizePixel = 0,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Instances:Create("UIStroke", {
                    Parent = Items["ColorpickerButton"].Instance,
                    Name = "\0",
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                    Color = FromRGB(56, 62, 62),
                    Thickness = 1
                }):AddToTheme({Color = "Border 2"})
                
                Instances:Create("UICorner", {
                    Parent = Items["ColorpickerButton"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 6)
                })
                
                Items["ColorpickerWindow"] = Instances:Create("Frame", {
                    Parent = Library.UnusedHolder.Instance,
                    Name = "\0",
                    Visible = false,
                    Position = UDim2New(0, 115, 0, 102),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0, 183, 0, 201),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(16, 18, 18)
                })  Items["ColorpickerWindow"]:AddToTheme({BackgroundColor3 = "Background"})
                
                Instances:Create("UICorner", {
                    Parent = Items["ColorpickerWindow"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 7)
                })
                
                Items["Inline"] = Instances:Create("Frame", {
                    Parent = Items["ColorpickerWindow"].Instance,
                    Name = "\0",
                    Position = UDim2New(0, 6, 0, 6),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(1, -12, 1, -12),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(21, 24, 24)
                })  Items["Inline"]:AddToTheme({BackgroundColor3 = "Inline"})
                
                Instances:Create("UIStroke", {
                    Parent = Items["Inline"].Instance,
                    Name = "\0",
                    Color = FromRGB(30, 33, 33),
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                }):AddToTheme({Color = "Border"})
                
                Instances:Create("UICorner", {
                    Parent = Items["Inline"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 7)
                })
                
                Items["Palette"] = Instances:Create("TextButton", {
                    Parent = Items["Inline"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(0, 0, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "-,",
                    AutoButtonColor = false,
                    Position = UDim2New(0, 6, 0, 6),
                    Size = UDim2New(1, -12, 1, -40),
                    BorderSizePixel = 0,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Instances:Create("UICorner", {
                    Parent = Items["Palette"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 7)
                })
                
                Instances:Create("UIStroke", {
                    Parent = Items["Palette"].Instance,
                    Name = "\0",
                    Color = FromRGB(30, 33, 33),
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                }):AddToTheme({Color = "Border"})
                
                Items["Saturation"] = Instances:Create("ImageLabel", {
                    Parent = Items["Palette"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    Image = "rbxassetid://130624743341203",
                    BackgroundTransparency = 1,
                    Size = UDim2New(1, 0, 1, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Instances:Create("UICorner", {
                    Parent = Items["Saturation"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 7)
                })
                
                Items["Value"] = Instances:Create("ImageLabel", {
                    Parent = Items["Palette"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(1, 2, 1, 0),
                    Image = "rbxassetid://96192970265863",
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, -1, 0, 0),
                    ZIndex = 3,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Instances:Create("UICorner", {
                    Parent = Items["Value"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 7)
                })
                
                Items["PaletteDragger"] = Instances:Create("Frame", {
                    Parent = Items["Palette"].Instance,
                    Name = "\0",
                    Size = UDim2New(0, 3, 0, 3),
                    Position = UDim2New(0, 5, 0, 5),
                    BorderColor3 = FromRGB(0, 0, 0),
                    ZIndex = 3,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Instances:Create("UICorner", {
                    Parent = Items["PaletteDragger"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(1, 0)
                })
                
                Instances:Create("UIStroke", {
                    Parent = Items["PaletteDragger"].Instance,
                    Name = "\0",
                    Color = FromRGB(120, 120, 120),
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                })
                
                Items["Hue"] = Instances:Create("TextButton", {
                    Parent = Items["Inline"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(0, 0, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    AnchorPoint = Vector2New(0, 1),
                    Position = UDim2New(0, 6, 1, -6),
                    Size = UDim2New(1, -12, 0, 18),
                    BorderSizePixel = 0,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Instances:Create("UICorner", {
                    Parent = Items["Hue"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 7)
                })
                
                Instances:Create("UIStroke", {
                    Parent = Items["Hue"].Instance,
                    Name = "\0",
                    Color = FromRGB(30, 33, 33),
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                }):AddToTheme({Color = "Border"})
                
                Instances:Create("UIGradient", {
                    Parent = Items["Hue"].Instance,
                    Name = "\0",
                    Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 0, 0)), RGBSequenceKeypoint(0.17, FromRGB(255, 255, 0)), RGBSequenceKeypoint(0.33, FromRGB(0, 255, 0)), RGBSequenceKeypoint(0.5, FromRGB(0, 255, 255)), RGBSequenceKeypoint(0.67, FromRGB(0, 0, 255)), RGBSequenceKeypoint(0.83, FromRGB(255, 0, 255)), RGBSequenceKeypoint(1, FromRGB(255, 0, 0))}
                })
                
                Items["HueDragger"] = Instances:Create("Frame", {
                    Parent = Items["Hue"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0, 2, 1, 0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Instances:Create("UIStroke", {
                    Parent = Items["HueDragger"].Instance,
                    Name = "\0",
                    Color = FromRGB(30, 33, 33),
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                }):AddToTheme({Color = "Border"})                
            end

            local Debounce = false
            local RenderStepped  

            function Colorpicker:Get()
                return Colorpicker.Color
            end

            function Colorpicker:SetVisibility(Bool)
                Items["ColorpickerButton"].Instance.Visible = Bool
            end

            function Colorpicker:SetOpen(Bool)
                if Debounce then 
                    return
                end

                Colorpicker.IsOpen = Bool

                Debounce = true 

                if Colorpicker.IsOpen then 
                    Items["ColorpickerWindow"].Instance.Visible = true
                    Items["ColorpickerWindow"].Instance.Parent = Library.Holder.Instance
                    
                    local LastPX, LastPY = -1, -1

                    RenderStepped = Library:Connect(RunService.RenderStepped, function()
                        local Btn = Items["ColorpickerButton"].Instance
                        local PX = MathFloor(Btn.AbsolutePosition.X)
                        local PY = MathFloor(Btn.AbsolutePosition.Y)

                        if PX ~= LastPX or PY ~= LastPY then
                            LastPX, LastPY = PX, PY
                            Items["ColorpickerWindow"].Instance.Position = UDim2New(0, PX + 18, 0, PY - 25)
                        end
                    end)

                    for Index, Value in Library.OpenFrames do 
                        if not Data.Section.IsSettings then
                            Value:SetOpen(false)
                        end
                    end

                    Library.OpenFrames[Colorpicker] = Colorpicker 
                else
                    if Library.OpenFrames[Colorpicker] then 
                        Library.OpenFrames[Colorpicker] = nil
                    end

                    if RenderStepped then 
                        RenderStepped:Disconnect()
                        RenderStepped = nil
                    end
                end

                Tween:BatchFade(Items["ColorpickerWindow"].Instance, Bool, Library.FadeSpeed, Bool and 4 or 1, function()
                    Debounce = false
                    Items["ColorpickerWindow"].Instance.Visible = Colorpicker.IsOpen

                    if not Colorpicker.IsOpen then
                        task.delay(0.2, function()
                            if not Colorpicker.IsOpen then
                                pcall(function()
                                    Items["ColorpickerWindow"].Instance.Parent = Library.UnusedHolder.Instance
                                end)
                            end
                        end)
                    end
                end)
            end

            function Colorpicker:Update()
                local Hue, Saturation, Value = Colorpicker.Hue, Colorpicker.Saturation, Colorpicker.Value
                Colorpicker.Color = FromHSV(Hue, Saturation, Value)
                Colorpicker.HexValue = Colorpicker.Color:ToHex()

                Library.Flags[Colorpicker.Flag] = {
                    Color = Colorpicker.Color,
                    HexValue = Colorpicker.HexValue,
                    Alpha = Colorpicker.Alpha,
                }

                Items["ColorpickerButton"]:Tween(nil, {BackgroundColor3 = Colorpicker.Color})
                Items["Palette"]:Tween(nil, {BackgroundColor3 = FromHSV(Hue, 1, 1)})

                if Data.Callback then 
                    Library:SafeCall(Data.Callback, Colorpicker.Color, Colorpicker.Alpha)
                end
            end

            local SlidingPalette = false
            local PaletteChanged
            
            function Colorpicker:SlidePalette(Input)
                if not Input or not SlidingPalette then
                    return
                end

                local ValueX = MathClamp(1 - (Input.Position.X - Items["Palette"].Instance.AbsolutePosition.X) / Items["Palette"].Instance.AbsoluteSize.X, 0, 1)
                local ValueY = MathClamp(1 - (Input.Position.Y - Items["Palette"].Instance.AbsolutePosition.Y) / Items["Palette"].Instance.AbsoluteSize.Y, 0, 1)

                Colorpicker.Saturation = ValueX
                Colorpicker.Value = ValueY

                local SlideX = MathClamp((Input.Position.X - Items["Palette"].Instance.AbsolutePosition.X) / Items["Palette"].Instance.AbsoluteSize.X, 0, 0.98)
                local SlideY = MathClamp((Input.Position.Y - Items["Palette"].Instance.AbsolutePosition.Y) / Items["Palette"].Instance.AbsoluteSize.Y, 0, 0.98)

                if Library.Performance.DirectDrag then
                    Items["PaletteDragger"].Instance.Position = UDim2New(SlideX, 0, SlideY, 0)
                else
                    Items["PaletteDragger"]:Tween(TweenInfo.new(0.12, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2New(SlideX, 0, SlideY, 0)})
                end

                Colorpicker:Update()
            end
            
            local SlidingHue = false
            local HueChanged

            function Colorpicker:SlideHue(Input)
                if not Input or not SlidingHue then
                    return
                end
                
                local ValueX = MathClamp((Input.Position.X - Items["Hue"].Instance.AbsolutePosition.X) / Items["Hue"].Instance.AbsoluteSize.X, 0, 1)

                Colorpicker.Hue = ValueX

                local SlideX = MathClamp((Input.Position.X - Items["Hue"].Instance.AbsolutePosition.X) / Items["Hue"].Instance.AbsoluteSize.X, 0, 0.995)

                if Library.Performance.DirectDrag then
                    Items["HueDragger"].Instance.Position = UDim2New(SlideX, 0, 0, 0)
                else
                    Items["HueDragger"]:Tween(TweenInfo.new(0.12, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2New(SlideX, 0, 0, 0)})
                end

                Colorpicker:Update()
            end

            function Colorpicker:Set(Color, Alpha)
                if type(Color) == "table" then
                    Color = FromRGB(Color[1], Color[2], Color[3])
                    Alpha = Color[4]
                elseif type(Color) == "string" then
                    Color = FromHex(Color)
                end 

                Colorpicker.Hue, Colorpicker.Saturation, Colorpicker.Value = Color:ToHSV()
                Colorpicker.Alpha = Alpha or 0  

                local PaletteValueX = MathClamp(1 - Colorpicker.Saturation, 0, 0.98)
                local PaletteValueY = MathClamp(1 - Colorpicker.Value, 0, 0.98)

                local HuePositionX = MathClamp(Colorpicker.Hue, 0, 0.99)

                Items["PaletteDragger"]:Tween(TweenInfo.new(0.12, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2New(PaletteValueX, 0, PaletteValueY, 0)})
                Items["HueDragger"]:Tween(TweenInfo.new(0.12, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2New(HuePositionX, 0, 0, 0)})
                Colorpicker:Update()
            end

            Items["ColorpickerButton"]:Connect("MouseButton1Down", function()
                Colorpicker:SetOpen(not Colorpicker.IsOpen)
            end)

            Items["Palette"]:Connect("InputBegan", function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                    SlidingPalette = true 

                    Colorpicker:SlidePalette(Input)

                    if PaletteChanged then
                        return
                    end

                    PaletteChanged = Input.Changed:Connect(function()
                        if Input.UserInputState == Enum.UserInputState.End then
                            SlidingPalette = false

                            PaletteChanged:Disconnect()
                            PaletteChanged = nil
                        end
                    end)
                end
            end)

            Items["Hue"]:Connect("InputBegan", function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                    SlidingHue = true 

                    Colorpicker:SlideHue(Input)

                    if HueChanged then
                        return
                    end

                    HueChanged = Input.Changed:Connect(function()
                        if Input.UserInputState == Enum.UserInputState.End then
                            SlidingHue = false

                            HueChanged:Disconnect()
                            HueChanged = nil
                        end
                    end)
                end
            end)

            Library:Connect(UserInputService.InputBegan, function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                    if Colorpicker.IsOpen then
                        if Library:IsMouseOverFrame(Items["ColorpickerWindow"]) then
                            return
                        end

                        Colorpicker:SetOpen(false)
                    end
                end
            end)
            
            Library:Connect(UserInputService.InputChanged, function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
                    if SlidingPalette then 
                        Colorpicker:SlidePalette(Input)
                    end

                    if SlidingHue then 
                        Colorpicker:SlideHue(Input)
                    end
                end
            end)

            Items["ColorpickerButton"]:Connect("Changed", function(Property)
                if Property == "AbsolutePosition" and Colorpicker.IsOpen then
                    Colorpicker.IsOpen = not Library:IsClipped(Items["ColorpickerButton"].Instance, Data.Section.Items["Section"].Instance.Parent)
                    Items["ColorpickerWindow"].Instance.Visible = Colorpicker.IsOpen
                end
            end)

            if Data.Default then
                Colorpicker:Set(Data.Default)
            end

            Library.SetFlags[Colorpicker.Flag] = function(Color, Alpha)
                Colorpicker:Set(Color, Alpha)
            end

            return Colorpicker, Items 
        end

        Library.CreateKeybind = function(self, Data)
            local Keybind = {
                Flag = Data.Flag,

                Key = "",
                Value = "",
                Mode = "",
                Toggled = false,

                Picking = false,
                IsOpen = false
            }

            local Items = { } do
                Items["KeyButton"] = Instances:Create("TextButton", {
                    Parent = Data.Parent.Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(179, 179, 179),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "-",
                    AutoButtonColor = false,
                    Size = UDim2New(0, 0, 1, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 12,
                    BackgroundColor3 = FromRGB(30, 34, 34)
                })  Items["KeyButton"]:AddToTheme({BackgroundColor3 = "Element"})
                
                Instances:Create("UICorner", {
                    Parent = Items["KeyButton"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 6)
                })
                
                Instances:Create("UIPadding", {
                    Parent = Items["KeyButton"].Instance,
                    Name = "\0",
                    PaddingRight = UDimNew(0, 4),
                    PaddingLeft = UDimNew(0, 5)
                })                

                Items["KeybindWindow"] = Instances:Create("Frame", {
                    Parent = Library.UnusedHolder.Instance,
                    Name = "\0",
                    Visible = false,
                    Position = UDim2New(0, 231, 0, 102),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0, 67, 0, 92),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(16, 18, 18)
                })  Items["KeybindWindow"]:AddToTheme({BackgroundColor3 = "Background"})
                
                Instances:Create("UICorner", {
                    Parent = Items["KeybindWindow"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 7)
                })
                
                Items["Inline"] = Instances:Create("Frame", {
                    Parent = Items["KeybindWindow"].Instance,
                    Name = "\0",
                    Position = UDim2New(0, 6, 0, 6),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(1, -12, 1, -12),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(21, 24, 24)
                })  Items["Inline"]:AddToTheme({BackgroundColor3 = "Inline"})
                
                Instances:Create("UIStroke", {
                    Parent = Items["Inline"].Instance,
                    Name = "\0",
                    Color = FromRGB(30, 33, 33),
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                }):AddToTheme({Color = "Border"})
                
                Instances:Create("UICorner", {
                    Parent = Items["Inline"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 7)
                })
                
                Items["Toggle"] = Instances:Create("TextButton", {
                    Parent = Items["Inline"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(238, 238, 238),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "Toggle",
                    AutoButtonColor = false,
                    BackgroundTransparency = 1,
                    Size = UDim2New(1, 0, 0, 20),
                    BorderSizePixel = 0,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Instances:Create("UIListLayout", {
                    Parent = Items["Inline"].Instance,
                    Name = "\0",
                    Padding = UDimNew(0, 5),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })
                
                Instances:Create("UIPadding", {
                    Parent = Items["Inline"].Instance,
                    Name = "\0",
                    PaddingTop = UDimNew(0, 4)
                })
                
                Items["Hold"] = Instances:Create("TextButton", {
                    Parent = Items["Inline"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(179, 179, 179),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "Hold",
                    AutoButtonColor = false,
                    BackgroundTransparency = 1,
                    Size = UDim2New(1, 0, 0, 20),
                    BorderSizePixel = 0,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Items["Always"] = Instances:Create("TextButton", {
                    Parent = Items["Inline"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(179, 179, 179),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "Always",
                    AutoButtonColor = false,
                    BackgroundTransparency = 1,
                    Size = UDim2New(1, 0, 0, 20),
                    BorderSizePixel = 0,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })                
            end

            local Modes = {
                ["Always"] = Items["Always"],
                ["Hold"] = Items["Hold"],
                ["Toggle"] = Items["Toggle"]
            }

            local Debounce = false
            local RenderStepped 

            function Keybind:SetOpen(Bool)
                if Debounce then 
                    return
                end

                Keybind.IsOpen = Bool

                Debounce = true 

                if Keybind.IsOpen then 
                    Items["KeybindWindow"].Instance.Visible = true
                    Items["KeybindWindow"].Instance.Parent = Library.Holder.Instance
                    
                    local LastPX, LastPY = -1, -1

                    RenderStepped = Library:Connect(RunService.RenderStepped, function()
                        local Btn = Items["KeyButton"].Instance
                        local PX = MathFloor(Btn.AbsolutePosition.X)
                        local PY = MathFloor(Btn.AbsolutePosition.Y)

                        if PX ~= LastPX or PY ~= LastPY then
                            LastPX, LastPY = PX, PY
                            Items["KeybindWindow"].Instance.Position = UDim2New(0, PX + 18, 0, PY - 25)
                        end
                    end)

                    for Index, Value in Library.OpenFrames do 
                        if not Data.Section.IsSettings then
                            Value:SetOpen(false)
                        end
                    end

                    Library.OpenFrames[Keybind] = Keybind 
                else
                    if Library.OpenFrames[Keybind] then 
                        Library.OpenFrames[Keybind] = nil
                    end

                    if RenderStepped then 
                        RenderStepped:Disconnect()
                        RenderStepped = nil
                    end
                end

                Tween:BatchFade(Items["KeybindWindow"].Instance, Bool, Library.FadeSpeed, Bool and 2 or 1, function()
                    Debounce = false
                    Items["KeybindWindow"].Instance.Visible = Keybind.IsOpen

                    if not Keybind.IsOpen then
                        task.delay(0.2, function()
                            if not Keybind.IsOpen then
                                pcall(function()
                                    Items["KeybindWindow"].Instance.Parent = Library.UnusedHolder.Instance
                                end)
                            end
                        end)
                    end
                end)
            end

            function Keybind:SetMode(Mode)
                for Index, Value in Modes do 
                    if Index == Mode then
                        Value:Tween(nil, {TextColor3 = FromRGB(238, 238, 238)})
                    else
                        Value:Tween(nil, {TextColor3 = FromRGB(179, 179, 179)})
                    end
                end

                Library.Flags[Keybind.Flag] = {
                    Mode = Keybind.Mode,
                    Key = Keybind.Key,
                    Toggled = Keybind.Toggled
                }

                if Data.Callback then 
                    Library:SafeCall(Data.Callback, Keybind.Toggled)
                end
            end

            function Keybind:Get()
                return Keybind.Key, Keybind.Mode, Keybind.Toggled
            end

            function Keybind:Set(Key)
                if StringFind(tostring(Key), "Enum") then 
                    Keybind.Key = tostring(Key)

                    Key = Key.Name == "Backspace" and "None" or Key.Name

                    local KeyString = Keys[Keybind.Key] or StringGSub(Key, "Enum.", "") or "None"
                    local TextToDisplay = StringGSub(StringGSub(KeyString, "KeyCode.", ""), "UserInputType.", "") or "None"

                    Keybind.Value = TextToDisplay
                    Items["KeyButton"].Instance.Text = TextToDisplay

                    Library.Flags[Keybind.Flag] = {
                        Mode = Keybind.Mode,
                        Key = Keybind.Key,
                        Toggled = Keybind.Toggled
                    }

                    if Data.Callback then 
                        Library:SafeCall(Data.Callback, Keybind.Toggled)
                    end
                elseif type(Key) == "table" then
                    local RealKey = Key.Key == "Backspace" and "None" or Key.Key
                    Keybind.Key = tostring(Key.Key)

                    if Key.Toggled ~= nil and (Key.Mode or "Toggle") ~= "Hold" then
                        Keybind.Toggled = Key.Toggled
                    end

                    if Key.Mode then
                        Keybind.Mode = Key.Mode
                        Keybind:SetMode(Key.Mode)
                    else
                        Keybind.Mode = "Toggle"
                        Keybind:SetMode("Toggle")
                    end

                    local KeyString = Keys[Keybind.Key] or StringGSub(tostring(RealKey), "Enum.", "") or RealKey
                    local TextToDisplay = KeyString and StringGSub(StringGSub(KeyString, "KeyCode.", ""), "UserInputType.", "") or "None"

                    TextToDisplay = StringGSub(StringGSub(KeyString, "KeyCode.", ""), "UserInputType.", "")

                    Keybind.Value = TextToDisplay
                    Items["KeyButton"].Instance.Text = TextToDisplay

                    if Data.Callback then 
                        Library:SafeCall(Data.Callback, Keybind.Toggled)
                    end
                elseif TableFind({"Toggle", "Hold", "Always"}, Key) then
                    Keybind.Mode = Key
                    Keybind:SetMode(Key)

                    if Data.Callback then 
                        Library:SafeCall(Data.Callback, Keybind.Toggled)
                    end
                end

                Keybind.Picking = false

                Library:RefreshKeybindList()
            end

            function Keybind:Press(Bool)
                if Keybind.Mode == "Toggle" then 
                    Keybind.Toggled = not Keybind.Toggled
                elseif Keybind.Mode == "Hold" then 
                    Keybind.Toggled = Bool
                elseif Keybind.Mode == "Always" then 
                    Keybind.Toggled = true
                end

                Library.Flags[Keybind.Flag] = {
                    Mode = Keybind.Mode,
                    Key = Keybind.Key,
                    Toggled = Keybind.Toggled
                }

                if Data.Callback then 
                    Library:SafeCall(Data.Callback, Keybind.Toggled)
                end

                Library:RefreshKeybindList()
            end

            Items["KeyButton"]:Connect("MouseButton1Click", function()
                Keybind.Picking = true 

                Items["KeyButton"].Instance.Text = "."
                Library:Thread(function()
                    local Count = 1

                    while true do 
                        if not Keybind.Picking then 
                            break
                        end

                        if Count == 4 then
                            Count = 1
                        end

                        Items["KeyButton"].Instance.Text = Count == 1 and "." or Count == 2 and ".." or Count == 3 and "..."
                        Count = Count + 1
                        task.wait(0.35)
                    end
                end)

                local InputBegan
                InputBegan = UserInputService.InputBegan:Connect(function(Input)
                    if Input.UserInputType == Enum.UserInputType.Keyboard then 
                        Keybind:Set(Input.KeyCode)
                    else
                        Keybind:Set(Input.UserInputType)
                    end

                    InputBegan:Disconnect()
                    InputBegan = nil
                end)
            end)

            Items["KeyButton"]:Connect("MouseButton2Down", function()
                Keybind:SetOpen(not Keybind.IsOpen)
            end)

            Items["KeyButton"]:Connect("Changed", function(Property)
                if Property == "AbsolutePosition" and Keybind.IsOpen then
                    Keybind.IsOpen = not Library:IsClipped(Items["KeybindWindow"].Instance, Data.Section.Items["Section"].Instance.Parent)
                    Items["KeybindWindow"].Instance.Visible = Keybind.IsOpen
                end
            end)

            Items["Toggle"]:Connect("MouseButton1Down", function()
                Keybind.Mode = "Toggle"
                Keybind:SetMode("Toggle")
            end)

            Items["Hold"]:Connect("MouseButton1Down", function()
                Keybind.Mode = "Hold"
                Keybind:SetMode("Hold")
            end)

            Items["Always"]:Connect("MouseButton1Down", function()
                Keybind.Mode = "Always"
                Keybind:SetMode("Always")
            end)

            Keybind._Popup = Items["KeybindWindow"]
            Library.Keybinds[Keybind] = Keybind
            Library:BuildKeybindList()

            if not Library.KeybindHooked then
                Library.KeybindHooked = true

                Library:Connect(UserInputService.InputBegan, function(Input)
                    local IsMouse = Input.UserInputType == Enum.UserInputType.MouseButton1

                    for _, Keybind in Library.Keybinds do
                        if Keybind.Picking then
                            continue
                        end

                        if IsMouse and Keybind.IsOpen then
                            if not Library:IsMouseOverFrame(Keybind._Popup) then
                                Keybind:SetOpen(false)
                            end
                        end

                        if Keybind.Value == "None" or Keybind.Key == "" then
                            continue
                        end

                        if tostring(Input.KeyCode) == Keybind.Key or tostring(Input.UserInputType) == Keybind.Key then
                            if Keybind.Mode == "Toggle" then
                                Keybind:Press()
                            else
                                Keybind:Press(true)
                            end
                        end
                    end
                end)

                Library:Connect(UserInputService.InputEnded, function(Input)
                    for _, Keybind in Library.Keybinds do
                        if Keybind.Picking or Keybind.Value == "None" or Keybind.Key == "" then
                            continue
                        end

                        if tostring(Input.KeyCode) == Keybind.Key or tostring(Input.UserInputType) == Keybind.Key then
                            if Keybind.Mode == "Hold" then
                                Keybind:Press(false)
                            elseif Keybind.Mode == "Always" then
                                Keybind:Press(true)
                            end
                        end
                    end
                end)
            end

            if Data.Default then 
                Keybind:Set({
                    Mode = Data.Mode or "Toggle",
                    Key = Data.Default,
                })
            end

            Library.SetFlags[Keybind.Flag] = function(Value)
                Keybind:Set(Value)
            end

            return Keybind, Items 
        end

        Library.BuildKeybindList = function(self)
            if self.KeybindListItems and self.KeybindListItems.Frame and self.KeybindListItems.Frame.Instance then
                return
            end

            local Holder = self.Holder and self.Holder.Instance

            if not Holder then
                return
            end

            local Items = { } do
                Items["Frame"] = Instances:Create("Frame", {
                    Parent = Holder,
                    Name = "\0",
                    Position = UDim2New(0, 12, 0, 44),
                    Size = UDim2New(0, 0, 0, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.XY,
                    Visible = self.KeybindListVisible ~= false,
                    BackgroundColor3 = FromRGB(20, 20, 20)
                })

                Items["Frame"]:AddToTheme({BackgroundColor3 = "Inline"})

                Instances:Create("UICorner", {
                    Parent = Items["Frame"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 6)
                })

                Items["Stroke"] = Instances:Create("UIStroke", {
                    Parent = Items["Frame"].Instance,
                    Name = "\0",
                    Color = FromRGB(35, 35, 35),
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                    Thickness = 1
                })

                Items["Stroke"]:AddToTheme({Color = "Border"})

                Instances:Create("UIPadding", {
                    Parent = Items["Frame"].Instance,
                    Name = "\0",
                    PaddingTop = UDimNew(0, 8),
                    PaddingBottom = UDimNew(0, 8),
                    PaddingLeft = UDimNew(0, 10),
                    PaddingRight = UDimNew(0, 10)
                })

                Instances:Create("UIListLayout", {
                    Parent = Items["Frame"].Instance,
                    Name = "\0",
                    Padding = UDimNew(0, 4),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })

                Items["Header"] = Instances:Create("TextLabel", {
                    Parent = Items["Frame"].Instance,
                    Name = "\0",
                    FontFace = Library.FontMono,
                    TextColor3 = FromRGB(110, 110, 110),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "KEYBINDS",
                    BackgroundTransparency = 1,
                    Size = UDim2New(0, 0, 0, 12),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 10,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
            end

            self.KeybindListItems = { Frame = Items["Frame"], Rows = { } }
            self:RefreshKeybindList()
        end

        Library.RefreshKeybindList = function(self)
            local List = self.KeybindListItems

            if not List or not List.Frame or not List.Frame.Instance then
                return
            end

            for _, Row in List.Rows do
                pcall(function()
                    Row:Clean()
                end)
            end

            List.Rows = { }

            for _, Keybind in self.Keybinds do
                if Keybind.Key and Keybind.Key ~= "" then
                    local State = Keybind.Toggled and "ON" or "OFF"

                    local Row = Instances:Create("TextLabel", {
                        Parent = List.Frame.Instance,
                        Name = "\0",
                        FontFace = Library.FontMono,
                        TextColor3 = Keybind.Toggled and FromRGB(238, 238, 238) or FromRGB(110, 110, 110),
                        BorderColor3 = FromRGB(0, 0, 0),
                        Text = tostring(Keybind.Value) .. "   " .. string.upper(Keybind.Mode or "") .. "   " .. State,
                        BackgroundTransparency = 1,
                        Size = UDim2New(0, 0, 0, 13),
                        BorderSizePixel = 0,
                        AutomaticSize = Enum.AutomaticSize.X,
                        TextSize = 11,
                        BackgroundColor3 = FromRGB(255, 255, 255)
                    })

                    TableInsert(List.Rows, Row)
                end
            end

            List.Frame.Instance.Visible = (self.KeybindListVisible ~= false) and (#List.Rows > 0)
        end

        Library.Notification = function(self, Name, Duration, Icon)
            local Items = { } do 
                Items["Notification"] = Instances:Create("Frame", {
                    Parent = Library.NotifHolder.Instance,
                    Name = "\0",
                    Size = UDim2New(0, 0, 0, 30),
                    BorderColor3 = FromRGB(0, 0, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    BackgroundColor3 = FromRGB(16, 18, 18)
                })  Items["Notification"]:AddToTheme({BackgroundColor3 = "Background"})
                
                Instances:Create("UICorner", {
                    Parent = Items["Notification"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 7)
                })
                
                Items["UIStroke"] = Instances:Create("UIStroke", {
                    Parent = Items["Notification"].Instance,
                    Name = "\0",
                    Color = FromRGB(30, 33, 33),
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                })  Items["UIStroke"]:AddToTheme({Color = "Border"})
                
                Instances:Create("UIPadding", {
                    Parent = Items["Notification"].Instance,
                    Name = "\0",
                    PaddingRight = UDimNew(0, 8),
                    PaddingLeft = UDimNew(0, 8)
                })
                
                if Icon then
                    Items["Icon"] = Instances:Create("ImageLabel", {
                        Parent = Items["Notification"].Instance,
                        Name = "\0",
                        ImageColor3 = FromRGB(238, 238, 238),
                        BorderColor3 = FromRGB(0, 0, 0),
                        AnchorPoint = Vector2New(0, 0.5),
                        Image = "rbxassetid://"..Icon,
                        BackgroundTransparency = 1,
                        Position = UDim2New(0, 0, 0.5, 0),
                        Size = UDim2New(0, 16, 0, 16),
                        BorderSizePixel = 0,
                        BackgroundColor3 = FromRGB(255, 255, 255)
                    })
                end
                
                Items["Text"] = Instances:Create("TextLabel", {
                    Parent = Items["Notification"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(238, 238, 238),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = Name,
                    AnchorPoint = Vector2New(0, 0.5),
                    Size = UDim2New(0, 0, 0, 15),
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, Icon and 24 or 0, 0.5, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })

                Items["Tick"] = Instances:Create("Frame", {
                    Parent = Items["Notification"].Instance,
                    Name = "\0",
                    AnchorPoint = Vector2New(0, 0.5),
                    Position = UDim2New(0, 1, 0.5, 0),
                    Size = UDim2New(0, 2, 1, -10),
                    BorderSizePixel = 0,
                    BorderColor3 = FromRGB(0, 0, 0),
                    BackgroundTransparency = 0.15,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })

                Instances:Create("UICorner", {
                    Parent = Items["Tick"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(1, 0)
                })
            end

            Library:Thread(function()
                local Size = Items["Notification"].Instance.AbsoluteSize

                for Index, Value in Items do 
                    if Value.Instance:IsA("Frame") then
                        Value.Instance.BackgroundTransparency = 1
                    elseif Value.Instance:IsA("TextLabel") then 
                        Value.Instance.TextTransparency = 1
                    elseif Value.Instance:IsA("ImageLabel") then 
                        Value.Instance.ImageTransparency = 1
                    elseif Value.Instance:IsA("UIStroke") then
                        Value.Instance.Transparency = 1
                    end
                end 

                task.wait(0.3)

                Items["Notification"].Instance.AutomaticSize = Enum.AutomaticSize.Y

                for Index, Value in Items do 
                    if Value.Instance:IsA("Frame") then
                        Value:Tween(nil, {BackgroundTransparency = 0})
                    elseif Value.Instance:IsA("TextLabel") then 
                        Value:Tween(nil, {TextTransparency = 0})
                    elseif Value.Instance:IsA("ImageLabel") then 
                        Value:Tween(nil, {ImageTransparency = 0.5})
                    elseif Value.Instance:IsA("UIStroke") then
                        Value:Tween(nil, {Transparency = 0})
                    end
                end

                Items["Notification"]:Tween(nil, {Size = UDim2New(0, Size.X, 0, Size.Y)})

                task.delay(Duration, function()
                    for Index, Value in Items do 
                        if Value.Instance:IsA("Frame") then
                            Value:Tween(nil, {BackgroundTransparency = 1})
                        elseif Value.Instance:IsA("TextLabel") then 
                            Value:Tween(nil, {TextTransparency = 1})
                        elseif Value.Instance:IsA("ImageLabel") then 
                            Value:Tween(nil, {ImageTransparency = 1})
                        elseif Value.Instance:IsA("UIStroke") then
                            Value:Tween(nil, {Transparency = 1})
                        end
                    end

                    Items["Notification"]:Tween(nil, {Size = UDim2New(0, 0, 0, 0)})
                    task.wait(0.5)
                    Items["Notification"]:Clean()
                end)
            end)
        end

        Library.Window = function(self, Data)
            local StartTime = tick()
            Data = Data or { }

            local Window = {
                Name = Data.Name or Data.name or "Window",
                SubTitle = Data.SubTitle or Data.subtitle or "for PUBG",
                ExpiresIn = Data.ExpiresIn or Data.expiresin or "23d",
                
                Pages = { },
                Items = { },
                IsOpen = false,
                UIScale = 1
            }

            local Items = { } do 
                Items["MainFrame"] = Instances:Create("Frame", {
                    Parent = Library.Holder.Instance,
                    Name = "\0",
                    AnchorPoint = Vector2New(0.5, 0.5),
                    Position = UDim2New(0.5, 0, 0.5, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0, 798, 0, 599),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(16, 18, 18)
                })  Items["MainFrame"]:AddToTheme({BackgroundColor3 = "Background"})

                Items["MainFrame"]:MakeDraggable()
                Items["MainFrame"]:MakeResizeable(Vector2New(Items["MainFrame"].Instance.AbsoluteSize.X, Items["MainFrame"].Instance.AbsoluteSize.Y), Vector2New(9999, 9999))
                
                Instances:Create("UICorner", {
                    Parent = Items["MainFrame"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 7)
                })

                Items["MainStroke"] = Instances:Create("UIStroke", {
                    Parent = Items["MainFrame"].Instance,
                    Name = "\0",
                    Color = FromRGB(22, 22, 28),
                    Thickness = 1,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                })
                Items["MainStroke"]:AddToTheme({Color = "Border"})

                Items["MainScale"] = Instances:Create("UIScale", {
                    Parent = Items["MainFrame"].Instance,
                    Name = "\0",
                    Scale = 1
                })

                Window.MainScale = Items["MainScale"]

                Window.WatermarkItems = { }

                do
                    Window.WatermarkItems["Mark"] = Instances:Create("Frame", {
                        Parent = Library.Holder.Instance,
                        Name = "\0",
                        Position = UDim2New(0, 12, 0, 12),
                        Size = UDim2New(0, 0, 0, 26),
                        BorderColor3 = FromRGB(0, 0, 0),
                        BorderSizePixel = 0,
                        AutomaticSize = Enum.AutomaticSize.X,
                        BackgroundColor3 = FromRGB(20, 20, 20)
                    })

                    Window.WatermarkItems["Mark"]:AddToTheme({BackgroundColor3 = "Inline"})

                    Instances:Create("UICorner", {
                        Parent = Window.WatermarkItems["Mark"].Instance,
                        Name = "\0",
                        CornerRadius = UDimNew(0, 6)
                    })

                    Window.WatermarkItems["MarkStroke"] = Instances:Create("UIStroke", {
                        Parent = Window.WatermarkItems["Mark"].Instance,
                        Name = "\0",
                        Color = FromRGB(35, 35, 35),
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        Thickness = 1
                    })

                    Window.WatermarkItems["MarkStroke"]:AddToTheme({Color = "Border"})

                    Instances:Create("UIPadding", {
                        Parent = Window.WatermarkItems["Mark"].Instance,
                        Name = "\0",
                        PaddingLeft = UDimNew(0, 10),
                        PaddingRight = UDimNew(0, 10)
                    })

                    Window.WatermarkItems["Text"] = Instances:Create("TextLabel", {
                        Parent = Window.WatermarkItems["Mark"].Instance,
                        Name = "\0",
                        FontFace = Library.FontMono,
                        TextColor3 = FromRGB(175, 175, 175),
                        BorderColor3 = FromRGB(0, 0, 0),
                        Text = "XANAX",
                        BackgroundTransparency = 1,
                        Size = UDim2New(0, 0, 1, 0),
                        BorderSizePixel = 0,
                        AutomaticSize = Enum.AutomaticSize.X,
                        TextSize = 12,
                        BackgroundColor3 = FromRGB(255, 255, 255)
                    })
                end

                local WatermarkFrames = 0

                Library:Connect(RunService.RenderStepped, function()
                    WatermarkFrames = WatermarkFrames + 1
                end)

                Library:Thread(function()
                    local PlaceName = "Unknown"

                    pcall(function()
                        PlaceName = tostring(game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name or "Unknown")
                    end)

                    if #PlaceName > 24 then
                        PlaceName = PlaceName:sub(1, 24)
                    end

                    while Window.WatermarkItems and Window.WatermarkItems["Text"] do
                        task.wait(1)

                        local Frames = WatermarkFrames
                        WatermarkFrames = 0

                        local Label = Window.WatermarkItems["Text"] and Window.WatermarkItems["Text"].Instance

                        if Label then
                            Label.Text = "XANAX | " .. PlaceName .. " | " .. tostring(Frames) .. " FPS"
                        end
                    end
                end)

                Items["TopLight"] = Instances:Create("Frame", {
                    Parent = Items["MainFrame"].Instance,
                    Name = "\0",
                    AnchorPoint = Vector2New(0, 0),
                    Position = UDim2New(0, 10, 0, 0),
                    Size = UDim2New(1, -20, 0, 1),
                    BorderSizePixel = 0,
                    ZIndex = 5,
                    BackgroundTransparency = 0.9,
                    BorderColor3 = FromRGB(0, 0, 0),
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Items["Side"] = Instances:Create("Frame", {
                    Parent = Items["MainFrame"].Instance,
                    Name = "\0",
                    BackgroundTransparency = 1,
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0, 215, 1, 0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Items["Title"] = Instances:Create("Frame", {
                    Parent = Items["Side"].Instance,
                    Name = "\0",
                    Position = UDim2New(0, 6, 0, 6),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(1, -12, 0, 60),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(21, 24, 24)
                })  Items["Title"]:AddToTheme({BackgroundColor3 = "Inline"})
                
                Instances:Create("UICorner", {
                    Parent = Items["Title"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 7)
                })
                
                Instances:Create("UIStroke", {
                    Parent = Items["Title"].Instance,
                    Name = "\0",
                    Color = FromRGB(30, 33, 33),
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                }):AddToTheme({Color = "Border"})

                local LogoAsset = ""

                pcall(function()
                    if typeof(getcustomasset) == "function" and typeof(isfile) == "function" then
                        local LogoPath = "esdeeeeee/Assets/logo.png"
                        local Ok, Exists = pcall(isfile, LogoPath)

                        if Ok and Exists then
                            local OkAsset, Asset = pcall(getcustomasset, LogoPath)

                            if OkAsset and type(Asset) == "string" and Asset ~= "" then
                                LogoAsset = Asset
                            end
                        end
                    end
                end)
                
                Items["Background"] = Instances:Create("Frame", {
                    Parent = Items["Title"].Instance,
                    Name = "\0",
                    AnchorPoint = Vector2New(0, 0.5),
                    Position = UDim2New(0, 12, 0.5, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    BackgroundTransparency = 1,
                    Size = UDim2New(0, 48, 0, 48),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Instances:Create("UICorner", {
                    Parent = Items["Background"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 7)
                })
                
                Instances:Create("UIStroke", {
                    Parent = Items["Background"].Instance,
                    Name = "\0",
                    Color = FromRGB(30, 33, 33),
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                }):AddToTheme({Color = "Border"})
                
                Items["Logo"] = Instances:Create("ImageLabel", {
                    Parent = Items["Background"].Instance,
                    Name = "\0",
                    ImageColor3 = FromRGB(238, 238, 238),
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(0.5, 0.5),
                    Image = LogoAsset,
                    BackgroundTransparency = 1,
                    Position = UDim2New(0.5, 0, 0.5, 0),
                    Size = UDim2New(1, -8, 1, -8),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })

                Items["Eyebrow"] = Instances:Create("TextLabel", {
                    Parent = Items["Title"].Instance,
                    Name = "\0",
                    FontFace = Library.FontMono,
                    TextColor3 = FromRGB(110, 110, 110),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = string.upper(Window.Name) .. " · XNX-001",
                    Size = UDim2New(0, 0, 0, 10),
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 70, 0, 7),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 10,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })

                Items["RealTitle"] = Instances:Create("TextLabel", {
                    Parent = Items["Title"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(238, 238, 238),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = Window.Name,
                    Size = UDim2New(0, 0, 0, 16),
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 70, 0, 19),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 15,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })

                Items["Game"] = Instances:Create("TextLabel", {
                    Parent = Items["Title"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(175, 175, 175),
                    Text = Window.SubTitle,
                    Size = UDim2New(0, 0, 0, 13),
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 70, 0, 37),
                    BorderColor3 = FromRGB(0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 12,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Items["Pages"] = Instances:Create("Frame", {
                    Parent = Items["Side"].Instance,
                    Name = "\0",
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 0, 0, 75),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(1, 0, 1, -80),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Instances:Create("UIListLayout", {
                    Parent = Items["Pages"].Instance,
                    Name = "\0",
                    Padding = UDimNew(0, 8),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })

                Instances:Create("UIPadding", {
                    Parent = Items["Pages"].Instance,
                    Name = "\0",
                    PaddingLeft = UDimNew(0, 8)
                })                

                Items["Content"] = Instances:Create("Frame", {
                    Parent = Items["MainFrame"].Instance,
                    Name = "\0",
                    Position = UDim2New(0, 220, 0, 6),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(1, -226, 1, -12),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(21, 24, 24)
                })  Items["Content"]:AddToTheme({BackgroundColor3 = "Inline"})
                
                Instances:Create("UICorner", {
                    Parent = Items["Content"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 7)
                })
                
                Instances:Create("UIStroke", {
                    Parent = Items["Content"].Instance,
                    Name = "\0",
                    Color = FromRGB(30, 33, 33),
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                }):AddToTheme({Color = "Border"})          
                
                Items["Bottom_"] = Instances:Create("Frame", {
                    Parent = Items["Side"].Instance,
                    Name = "\0",
                    AnchorPoint = Vector2New(0, 1),
                    Position = UDim2New(0, 6, 1, -6),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(1, -12, 0, 45),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(21, 24, 24)
                })  Items["Bottom_"]:AddToTheme({BackgroundColor3 = "Inline"})
                
                Instances:Create("UICorner", {
                    Parent = Items["Bottom_"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 7)
                })
                
                Instances:Create("UIStroke", {
                    Parent = Items["Bottom_"].Instance,
                    Name = "\0",
                    Color = FromRGB(30, 33, 33),
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                }):AddToTheme({Color = "Border"})
                
                Items["SubExpires"] = Instances:Create("TextLabel", {
                    Parent = Items["Bottom_"].Instance,
                    Name = "\0",
                    FontFace = Library.FontMono,
                    TextColor3 = FromRGB(238, 238, 238),
                    TextTransparency = 0.5,
                    Text = "Sub expires in "..Window.ExpiresIn,
                    Size = UDim2New(0, 0, 0, 15),
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 10, 0, 8),
                    BorderColor3 = FromRGB(0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 12,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Items["SessionDuration"] = Instances:Create("TextLabel", {
                    Parent = Items["Bottom_"].Instance,
                    Name = "\0",
                    FontFace = Library.FontMono,
                    TextColor3 = FromRGB(238, 238, 238),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "Session duration: ",
                    Size = UDim2New(0, 0, 0, 15),
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 10, 0, 23),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 12,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })                

                Library:Thread(function()
                    while task.wait(1) do
                        local SecondsPassed = MathFloor(tick() - StartTime)
                        local MinutesPassed = MathFloor(SecondsPassed / 60)

                        if MinutesPassed > 0 then
                            SecondsPassed = SecondsPassed - MinutesPassed * 60
                        end

                        Items["SessionDuration"].Instance.Text = "Session duration: "..MinutesPassed..":"..SecondsPassed
                    end
                end)

                Window.Items = Items
            end
            
            local Debounce = false

            function Window:SetCenter()
                local CenterPosition = Items["MainFrame"].Instance.AbsolutePosition
                task.wait()
                Items["MainFrame"].Instance.AnchorPoint = Vector2New(0, 0)

                Items["MainFrame"].Instance.Position = UDim2New(0, CenterPosition.X, 0, CenterPosition.Y)
            end

            function Window:SetOpen(Bool)
                if Debounce then 
                    return
                end

                Window.IsOpen = Bool

                Debounce = true 

                if Window.IsOpen then 
                    Items["MainFrame"].Instance.Visible = true 
                end

                if Items["MainScale"] then
                    local TargetScale = Window.UIScale or 1

                    if Window.IsOpen then
                        Items["MainScale"].Instance.Scale = TargetScale * 0.9
                        Items["MainScale"]:Tween(TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = TargetScale})
                    else
                        Items["MainScale"]:Tween(TweenInfo.new(0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Scale = TargetScale * 0.97})
                    end
                end

                Tween:BatchFade(Items["MainFrame"].Instance, Bool, Library.FadeSpeed, nil, function()
                    Debounce = false
                    Items["MainFrame"].Instance.Visible = Window.IsOpen
                end)
            end

            Library:Connect(UserInputService.InputBegan, function(Input)
                if tostring(Input.KeyCode) == Library.MenuKeybind or tostring(Input.UserInputType) == Library.MenuKeybind then
                    Window:SetOpen(not Window.IsOpen)
                end
            end)

            Window:SetCenter()
            task.wait()
            Window:SetOpen(true)
            return setmetatable(Window, Library)
        end

        Library.CreateWindow = function(self, Data)
            return self:Window(Data)
        end

        Library.Page = function(self, Data)
            Data = Data or { }

            local Page = {
                Window = self,

                Name = Data.Name or Data.name or "Page",
                Icon = Data.Icon or Data.icon or "136879043989014",

                Items = { },
                SubPages = { },
                Active = false
            }

            local Items = { } do
                Items["Inactive"] = Instances:Create("TextButton", {
                    Parent = Page.Window.Items["Pages"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(0, 0, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    BackgroundTransparency = 1,
                    Size = UDim2New(0, 200, 0, 30),
                    BorderSizePixel = 0,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(21, 24, 24)
                })  Items["Inactive"]:AddToTheme({BackgroundColor3 = "Inline"})
                
                Items["UIStroke"] = Instances:Create("UIStroke", {
                    Parent = Items["Inactive"].Instance,
                    Name = "\0",
                    Color = FromRGB(30, 33, 33),
                    Transparency = 1,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                })  Items["UIStroke"]:AddToTheme({Color = "Border"})
                
                Instances:Create("UICorner", {
                    Parent = Items["Inactive"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 7)
                })
                
                Items["Icon"] = Instances:Create("ImageLabel", {
                    Parent = Items["Inactive"].Instance,
                    Name = "\0",
                    ImageColor3 = FromRGB(179, 179, 179),
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(0, 0.5),
                    Image = "rbxassetid://"..Page.Icon,
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 10, 0.5, 0),
                    Size = UDim2New(0, 16, 0, 16),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Items["Text"] = Instances:Create("TextLabel", {
                    Parent = Items["Inactive"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(179, 179, 179),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = Page.Name,
                    AnchorPoint = Vector2New(0, 0.5),
                    Size = UDim2New(0, 0, 0, 15),
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 38, 0.5, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                                
                Items["Page"] = Instances:Create("Frame", {
                    Parent = Library.UnusedHolder.Instance,
                    Name = "\0",
                    Visible = false,
                    BackgroundTransparency = 1,
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(1, 0, 1, 0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Items["PageName"] = Instances:Create("TextLabel", {
                    Parent = Items["Page"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(238, 238, 238),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = Page.Name,
                    Size = UDim2New(0, 0, 0, 15),
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 15, 0, 15),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 18,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Items["SubPages"] = Instances:Create("Frame", {
                    Parent = Items["Page"].Instance,
                    Name = "\0",
                    Size = UDim2New(0, 0, 0, 30),
                    Position = UDim2New(0, 13, 0, 42),
                    BorderColor3 = FromRGB(0, 0, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    BackgroundColor3 = FromRGB(16, 18, 18)
                })  Items["SubPages"]:AddToTheme({BackgroundColor3 = "Background"})
                
                Instances:Create("UIPadding", {
                    Parent = Items["SubPages"].Instance,
                    Name = "\0",
                    PaddingTop = UDimNew(0, 2),
                    PaddingBottom = UDimNew(0, 2),
                    PaddingRight = UDimNew(0, 2),
                    PaddingLeft = UDimNew(0, 2)
                })
                
                Instances:Create("UIListLayout", {
                    Parent = Items["SubPages"].Instance,
                    Name = "\0",
                    Padding = UDimNew(0, 2),
                    FillDirection = Enum.FillDirection.Horizontal,
                    SortOrder = Enum.SortOrder.LayoutOrder
                })

                Instances:Create("UICorner", {
                    Parent = Items["SubPages"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 7)
                })                

                Items["Columns"] = Instances:Create("Frame", {
                    Parent = Items["Page"].Instance,
                    Name = "\0",
                    Size = UDim2New(1, -20, 1, -82),
                    Position = UDim2New(0, 10, 0, 75),
                    BorderColor3 = FromRGB(0, 0, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    BackgroundColor3 = FromRGB(255, 255, 255),
                    BackgroundTransparency = 1
                })  

                Page.Items = Items
            end

            local Debounce = false

            function Page:Turn(Bool)
                if Debounce then 
                    return 
                end

                Page.Active = Bool 
                
                Debounce = true
                Items["Page"].Instance.Visible = Bool 
                Items["Page"].Instance.Parent = Bool and Page.Window.Items["Content"].Instance or Library.UnusedHolder.Instance

                if Page.Active then
                    Items["Inactive"]:Tween(nil, {BackgroundTransparency = 0})
                    Items["Icon"]:Tween(nil, {ImageColor3 = FromRGB(238, 238, 238)})
                    Items["Text"]:Tween(nil, {TextColor3 = FromRGB(238, 238, 238)})
                    Items["UIStroke"]:Tween(nil, {Transparency = 0})
                else
                    Items["Inactive"]:Tween(nil, {BackgroundTransparency = 1})
                    Items["Icon"]:Tween(nil, {ImageColor3 = FromRGB(179, 179, 179)})
                    Items["Text"]:Tween(nil, {TextColor3 = FromRGB(179, 179, 179)})
                    Items["UIStroke"]:Tween(nil, {Transparency = 1})
                end

                Debounce = false
            end

            Items["Inactive"]:OnHover(function()
                if not Page.Active then
                    Items["Text"]:Tween(TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = FromRGB(238, 238, 238)})
                    Items["Icon"]:Tween(TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = FromRGB(238, 238, 238)})
                end
            end)

            Items["Inactive"]:OnHoverLeave(function()
                if not Page.Active then
                    Items["Text"]:Tween(TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = FromRGB(179, 179, 179)})
                    Items["Icon"]:Tween(TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = FromRGB(179, 179, 179)})
                end
            end)

            Items["Inactive"]:Connect("MouseButton1Down", function()
                for Index, Value in Page.Window.Pages do 
                    if Value == Page and Page.Active then
                        return
                    end

                    Value:Turn(Value == Page)
                end
            end)

            if #Page.Window.Pages == 0 then 
                Page:Turn(true)
            end

            TableInsert(Page.Window.Pages, Page)
            return setmetatable(Page, Library.Pages)
        end

        Library.Category = function(self, Name)
            local Items = { } do
                Items["Category"] = Instances:Create("TextLabel", {
                    Parent = self.Items["Pages"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(179, 179, 179),
                    TextTransparency = 0,
                    Text = string.upper(tostring(Name)),
                    Size = UDim2New(0, 0, 0, 15),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    BorderColor3 = FromRGB(0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 11,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })

                Items["Rule"] = Instances:Create("Frame", {
                    Parent = self.Items["Pages"].Instance,
                    Name = "\0",
                    Size = UDim2New(1, -8, 0, 1),
                    BorderSizePixel = 0,
                    BorderColor3 = FromRGB(0, 0, 0),
                    BackgroundTransparency = 0.87,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
            end

            return Items
        end

        Library.Pages.SubPage = function(self, Data)
            Data = Data or { }

            local Page = {
                Window = self.Window,
                Page = self,

                Name = Data.Name or Data.name or "SubPage",
                Columns = Data.Columns or Data.columns or 2,

                Items = { },
                ColumnsData = { },
                Active = false
            }

            local Items = { } do 
                Items["Inactive"] = Instances:Create("TextButton", {
                    Parent = Page.Page.Items["SubPages"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(238, 238, 238),
                    TextTransparency = 0.5,
                    Text = Page.Name,
                    AutoButtonColor = false,
                    Size = UDim2New(0, 0, 1, 0),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    BorderColor3 = FromRGB(0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(30, 34, 34)
                })  Items["Inactive"]:AddToTheme({BackgroundColor3 = "Element"})
                 
                Instances:Create("UIPadding", {
                    Parent = Items["Inactive"].Instance,
                    Name = "\0",
                    PaddingRight = UDimNew(0, 8),
                    PaddingLeft = UDimNew(0, 8)
                })
                
                Instances:Create("UICorner", {
                    Parent = Items["Inactive"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 7)
                })                

                Items["Page"] = Instances:Create("Frame", {
                    Parent = Library.UnusedHolder.Instance,
                    Name = "\0",
                    Visible = false,
                    BackgroundTransparency = 1,
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(1, 0, 1, 0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })

                Instances:Create("UIListLayout", {
                    Parent = Items["Page"].Instance,
                    Name = "\0",
                    FillDirection = Enum.FillDirection.Horizontal,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    HorizontalFlex = Enum.UIFlexAlignment.Fill
                })
            
                for Index = 1, Page.Columns do 
                    local NewColumn = Instances:Create("ScrollingFrame", {
                        Parent = Items["Page"].Instance,
                        Name = "\0",
                        ScrollBarImageColor3 = FromRGB(0, 0, 0),
                        Active = true,
                        BorderColor3 = FromRGB(0, 0, 0),
                        ScrollBarThickness = 0,
                        BackgroundTransparency = 1,
                        Size = UDim2New(1, 0, 1, 0),
                        BorderSizePixel = 0,
                        BackgroundColor3 = FromRGB(255, 255, 255)
                    })
                    
                    if Index == 1 then
                        Instances:Create("UIPadding", {
                            Parent = NewColumn.Instance,
                            Name = "\0",
                            PaddingTop = UDimNew(0, 3),
                            PaddingBottom = UDimNew(0, 3),
                            PaddingRight = UDimNew(0, 8),
                            PaddingLeft = UDimNew(0, 3)
                        })                
                    elseif Index == 2 then
                        Instances:Create("UIPadding", {
                            Parent = NewColumn.Instance,
                            Name = "\0",
                            PaddingTop = UDimNew(0, 3),
                            PaddingBottom = UDimNew(0, 3),
                            PaddingRight = UDimNew(0, 20),
                            PaddingLeft = UDimNew(0, 8)
                        })
                    end

                    Page.ColumnsData[Index] = NewColumn
                end
            end

            local Debounce = false

            function Page:Turn(Bool)
                if Debounce then 
                    return 
                end

                Page.Active = Bool 
                
                Debounce = true
                Items["Page"].Instance.Visible = Bool 
                Items["Page"].Instance.Parent = Bool and Page.Page.Items["Columns"].Instance or Library.UnusedHolder.Instance

                if Page.Active then
                    Items["Inactive"]:Tween(nil, {BackgroundTransparency = 0, TextTransparency = 0})
                else
                    Items["Inactive"]:Tween(nil, {BackgroundTransparency = 1, TextTransparency = 0.5})
                end

                Debounce = false
            end

            Items["Inactive"]:Connect("MouseButton1Down", function()
                for Index, Value in Page.Page.SubPages do 
                    if Value == Page and Page.Active then
                        return
                    end

                    Value:Turn(Value == Page)
                end
            end)

            if #Page.Page.SubPages == 0 then 
                Page:Turn(true)
            end

            TableInsert(Page.Page.SubPages, Page)
            return setmetatable(Page, Library.Pages)
        end

        Library.Pages.Section = function(self, Data)
            Data = Data or { }

            local Section = {
                Window = self.Window,
                Page = self,

                Name = Data.Name or Data.name or "Section",
                Icon = Data.Icon or Data.icon or "",
                Side = Data.Side or Data.side or 1,

                Items = { }
            }

            local Items = { } do
                Items["Section"] = Instances:Create("Frame", {
                    Parent = Section.Page.ColumnsData[Section.Side].Instance,
                    Name = "\0",
                    Size = UDim2New(1, 0, 0, 25),
                    BorderColor3 = FromRGB(0, 0, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundColor3 = FromRGB(21, 24, 24)
                })  Items["Section"]:AddToTheme({BackgroundColor3 = "Inline"})
                
                Instances:Create("UICorner", {
                    Parent = Items["Section"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 7)
                })
                
                Instances:Create("UIStroke", {
                    Parent = Items["Section"].Instance,
                    Name = "\0",
                    Color = FromRGB(30, 33, 33),
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                }):AddToTheme({Color = "Border"})
                
                Items["Icon"] = Instances:Create("ImageLabel", {
                    Parent = Items["Section"].Instance,
                    Name = "\0",
                    ImageColor3 = FromRGB(179, 179, 179),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Image = "rbxassetid://"..Section.Icon,
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 12, 0, 12),
                    Size = UDim2New(0, 16, 0, 16),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Instances:Create("UIPadding", {
                    Parent = Items["Section"].Instance,
                    Name = "\0",
                    PaddingBottom = UDimNew(0, 12)
                })
                
                Items["Text"] = Instances:Create("TextLabel", {
                    Parent = Items["Section"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(179, 179, 179),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = Section.Name,
                    Size = UDim2New(0, 0, 0, 15),
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 35, 0, 12),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })

                Items["Divider"] = Instances:Create("Frame", {
                    Parent = Items["Section"].Instance,
                    Name = "\0",
                    Position = UDim2New(0, 12, 0, 34),
                    Size = UDim2New(1, -24, 0, 1),
                    BorderSizePixel = 0,
                    BorderColor3 = FromRGB(0, 0, 0),
                    BackgroundTransparency = 0.87,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Items["Content"] = Instances:Create("Frame", {
                    Parent = Items["Section"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 12, 0, 42),
                    Size = UDim2New(1, -24, 0, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Instances:Create("UIListLayout", {
                    Parent = Items["Content"].Instance,
                    Name = "\0",
                    Padding = UDimNew(0, 8),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })
                
                Section.Items = Items
            end

            return setmetatable(Section, Library.Sections)
        end

        Library.Sections.Toggle = function(self, Data)
            Data = Data or { }

            local Toggle = {
                Window = self.Window,
                Page = self.Page,
                Section = self,

                Name = Data.Name or Data.name or "Toggle",
                Flag = Data.Flag or Data.flag or Library:NextFlag(),
                Default = Data.Default or Data.default or false,
                Callback = Data.Callback or Data.callback or function() end,
                Desc = Data.Desc or Data.desc or "",

                Value = false
            }

            local Items = { } do 
                Items["Toggle"] = Instances:Create("TextButton", {
                    Parent = Toggle.Section.Items["Content"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(0, 0, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    BackgroundTransparency = 1,
                    Size = UDim2New(1, 0, 0, Toggle.Desc ~= "" and 30 or 16),
                    BorderSizePixel = 0,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Items["Text"] = Instances:Create("TextLabel", {
                    Parent = Items["Toggle"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(179, 179, 179),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = Toggle.Name,
                    AnchorPoint = Vector2New(0, 0.5),
                    Size = UDim2New(0, 0, 0, 15),
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 0, 0.5, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })

                if Toggle.Desc ~= "" then
                    Items["Desc"] = Instances:Create("TextLabel", {
                        Parent = Items["Toggle"].Instance,
                        Name = "\0",
                        FontFace = Library.Font,
                        TextColor3 = FromRGB(110, 110, 110),
                        BorderColor3 = FromRGB(0, 0, 0),
                        Text = Toggle.Desc,
                        Size = UDim2New(1, -30, 0, 12),
                        BackgroundTransparency = 1,
                        Position = UDim2New(0, 0, 0, 16),
                        BorderSizePixel = 0,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        TextSize = 12,
                        BackgroundColor3 = FromRGB(255, 255, 255)
                    })
                end
                
                Items["Indicator"] = Instances:Create("Frame", {
                    Parent = Items["Toggle"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(1, 0),
                    BackgroundTransparency = 1,
                    Position = UDim2New(1, 0, 0, 0),
                    Size = UDim2New(0, 14, 0, 14),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(30, 33, 33)
                })  Items["Indicator"]:AddToTheme({BackgroundColor3 = "Element"})
                
                Instances:Create("UIStroke", {
                    Parent = Items["Indicator"].Instance,
                    Name = "\0",
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                    Color = FromRGB(56, 62, 62),
                    Thickness = 1
                }):AddToTheme({Color = "Border 2"})
                
                Instances:Create("UICorner", {
                    Parent = Items["Indicator"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 6)
                })
                
                Items["Inline"] = Instances:Create("Frame", {
                    Parent = Items["Indicator"].Instance,
                    Name = "\0",
                    BackgroundTransparency = 1,
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(1, 0, 1, 0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Inline"]:AddToTheme({BackgroundColor3 = "Accent"})
                
                Instances:Create("UICorner", {
                    Parent = Items["Inline"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 6)
                })
                
                Items["CheckImage"] = Instances:Create("ImageLabel", {
                    Parent = Items["Inline"].Instance,
                    Name = "\0",
                    ImageColor3 = FromRGB(0, 0, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(0.5, 0.5),
                    Image = "rbxassetid://132128200461292",
                    ImageTransparency = 1,
                    BackgroundTransparency = 1,
                    Position = UDim2New(0.5, 0, 0.5, 0),
                    Size = UDim2New(1, -4, 1, -4),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Items["SubElements"] = Instances:Create("Frame", {
                    Parent = Items["Toggle"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(1, 0),
                    BackgroundTransparency = 1,
                    Position = UDim2New(1, -25, 0, 0),
                    Size = UDim2New(0, 0, 1, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Instances:Create("UIListLayout", {
                    Parent = Items["SubElements"].Instance,
                    Name = "\0",
                    FillDirection = Enum.FillDirection.Horizontal,
                    HorizontalAlignment = Enum.HorizontalAlignment.Right,
                    Padding = UDimNew(0, 6),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })                
            end

            function Toggle:Get()
                return Toggle.Value 
            end

            function Toggle:Set(Value)
                Toggle.Value = Value 
                Library.Flags[Toggle.Flag] = Value 

                local Snap = TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

                if Toggle.Value then 
                    Items["Inline"]:Tween(Snap,  {BackgroundTransparency = 0})
                    Items["CheckImage"]:Tween(Snap, {ImageTransparency = 0})
                    Items["Text"]:Tween(Snap, {TextColor3 = FromRGB(238, 238, 238)})
                else
                    Items["Inline"]:Tween(Snap,  {BackgroundTransparency = 1})
                    Items["CheckImage"]:Tween(Snap, {ImageTransparency = 1})
                    Items["Text"]:Tween(Snap, {TextColor3 = FromRGB(179, 179, 179)})
                end

                if Toggle.Callback then 
                    Library:SafeCall(Toggle.Callback, Toggle.Value)
                end
            end

            function Toggle:SetVisibility(Bool)
                Items["Toggle"].Instance.Visible = Bool 
            end

            function Toggle:Colorpicker(Data)
                Data = Data or { }

                local Colorpicker = {
                    Window = Toggle.Window,
                    Page = Toggle.Page,
                    Section = Toggle.Section,

                    Flag = Data.Flag or Data.flag or Library:NextFlag(),
                    Default = Data.Default or Data.default or Color3.fromRGB(255, 255, 255),
                    Callback = Data.Callback or Data.callback or function() end
                }

                local NewColorpicker = Library:CreateColorpicker({
                    Parent = Items["SubElements"],
                    Page = Colorpicker.Page,
                    Section = Colorpicker.Section,
                    Flag = Colorpicker.Flag,
                    Default = Colorpicker.Default,
                    Callback = Colorpicker.Callback
                })

                return NewColorpicker
            end

            function Toggle:Keybind(Data)
                Data = Data or { }

                local Keybind = {
                    Window = Toggle.Window,
                    Page = Toggle.Page,
                    Section = Toggle.Section,

                    Flag = Data.Flag or Data.flag or Library:NextFlag(),
                    Default = Data.Default or Data.default or Enum.KeyCode.E,
                    Callback = Data.Callback or Data.callback or function() end,
                    Mode = Data.Mode or Data.mode or "Toggle"
                }

                local NewKeybind = Library:CreateKeybind({
                    Parent = Items["SubElements"],
                    Page = Keybind.Page,
                    Section = Keybind.Section,
                    Flag = Keybind.Flag,
                    Default = Keybind.Default,
                    Mode = Keybind.Mode,
                    Callback = Keybind.Callback
                })

                return NewKeybind
            end

            Items["Toggle"]:Connect("MouseButton1Down", function()
                Toggle:Set(not Toggle.Value)
            end)

            Toggle:Set(Toggle.Default)

            Library.SetFlags[Toggle.Flag] = function(Value)
                Toggle:Set(Value)
            end

            return Toggle 
        end

        Library.Sections.Button = function(self, Data)
            Data = Data or { }

            local Button = {
                Window = self.Window,
                Page = self.Page,
                Section = self,

                Name = Data.Name or Data.name,
                Callback = Data.Callback or Data.callback or function() end,
                Primary = Data.Primary or Data.primary or false
            }

            local Items = { } do
                Items["Button"] = Instances:Create("TextButton", {
                    Parent = Button.Section.Items["Content"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = Button.Primary and FromRGB(0, 0, 0) or FromRGB(238, 238, 238),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = Button.Name,
                    AutoButtonColor = false,
                    Size = UDim2New(1, 0, 0, 25),
                    BorderSizePixel = 0,
                    TextSize = 14,
                    BackgroundColor3 = Button.Primary and FromRGB(238, 238, 238) or FromRGB(30, 34, 34)
                })

                if not Button.Primary then
                    Items["Button"]:AddToTheme({BackgroundColor3 = "Element"})
                end
                
                Instances:Create("UICorner", {
                    Parent = Items["Button"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 6)
                })

                Items["ButtonScale"] = Instances:Create("UIScale", {
                    Parent = Items["Button"].Instance,
                    Name = "\0",
                    Scale = 1
                })
                
                Items["ButtonStroke"] = Instances:Create("UIStroke", {
                    Parent = Items["Button"].Instance,
                    Name = "\0",
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                    Color = FromRGB(56, 62, 62),
                    Thickness = 1
                })
                Items["ButtonStroke"]:AddToTheme({Color = "Border 2"})
                
                Instances:Create("UIPadding", {
                    Parent = Items["Button"].Instance,
                    Name = "\0",
                    PaddingBottom = UDimNew(0, 1)
                })                
            end

            function Button:SetVisibility(Bool)
                Items["Button"].Instance.Visible = Bool
            end

            function Button:Press()
                if Items["ButtonScale"] then
                    Items["ButtonScale"]:Tween(TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Scale = 0.97})
                end

                Items["Button"]:ChangeItemTheme({BackgroundColor3 = "Accent"})
                Items["Button"]:Tween(nil, {BackgroundColor3 = Library.Theme.Accent, TextColor3 = FromRGB(0, 0, 0)})

                task.wait(0.1)

                Items["Button"]:ChangeItemTheme({BackgroundColor3 = "Element"})
                Items["Button"]:Tween(nil, {BackgroundColor3 = Button.Primary and FromRGB(238, 238, 238) or Library.Theme.Element, TextColor3 = Button.Primary and FromRGB(0, 0, 0) or FromRGB(238, 238, 238)})

                if Items["ButtonScale"] then
                    Items["ButtonScale"]:Tween(TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Scale = 1})
                end

                Library:SafeCall(Button.Callback)
            end

            Items["Button"]:OnHover(function()
                if Items["ButtonStroke"] then
                    Items["ButtonStroke"]:Tween(TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Color = Button.Primary and Library.Theme.Accent or FromRGB(255, 255, 255)})
                end
            end)

            Items["Button"]:OnHoverLeave(function()
                if Items["ButtonStroke"] then
                    Items["ButtonStroke"]:Tween(TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Color = Library.Theme["Border 2"]})
                end
            end)

            Items["Button"]:Connect("MouseButton1Down", function()
                Button:Press()
            end)

            return Button
        end

        Library.Sections.Slider = function(self, Data)
            Data = Data or { }

            local Min = Data.Min or Data.min or 0
            local Max = Data.Max or Data.max or 100

            if Min > Max then
                Min, Max = Max, Min
            end

            local Decimals = Data.Decimals or Data.decimals or 1

            if Decimals < 0 then
                Decimals = 0
            end

            local Slider = {
                Window = self.Window,
                Page = self.Page,
                Section = self,

                Name = Data.Name or Data.name or "Slider",
                Min = Min,
                Max = Max,
                Callback = Data.Callback or Data.callback or function() end,
                Default = Data.Default or Data.default or 0,
                Flag = Data.Flag or Data.flag or Library:NextFlag(),
                Decimals = Decimals,
                Suffix = Data.Suffix or Data.suffix or "",

                Value = 0,
                Sliding = false
            }

            local Items = { } do 
                Items["Slider"] = Instances:Create("Frame", {
                    Parent = Slider.Section.Items["Content"].Instance,
                    Name = "\0",
                    BackgroundTransparency = 1,
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(1, 0, 0, 30),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Items["Text"] = Instances:Create("TextLabel", {
                    Parent = Items["Slider"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(238, 238, 238),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = Slider.Name,
                    BackgroundTransparency = 1,
                    Size = UDim2New(0, 0, 0, 15),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Items["Value"] = Instances:Create("TextLabel", {
                    Parent = Items["Slider"].Instance,
                    Name = "\0",
                    FontFace = Library.FontMono,
                    TextColor3 = FromRGB(179, 179, 179),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "",
                    AnchorPoint = Vector2New(1, 0),
                    Size = UDim2New(0, 0, 0, 15),
                    BackgroundTransparency = 1,
                    Position = UDim2New(1, 0, 0, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Items["RealSlider"] = Instances:Create("TextButton", {
                    Parent = Items["Slider"].Instance,
                    Text = "",
                    AutoButtonColor = false,
                    Name = "\0",
                    AnchorPoint = Vector2New(0, 1),
                    Position = UDim2New(0, 0, 1, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(1, 0, 0, 5),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(30, 34, 34)
                })  Items["RealSlider"]:AddToTheme({BackgroundColor3 = "Element"})
                
                Instances:Create("UICorner", {
                    Parent = Items["RealSlider"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(1, 0)
                })
                
                Items["Accent"] = Instances:Create("Frame", {
                    Parent = Items["RealSlider"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0.4000000059604645, 0, 1, 0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Accent"]:AddToTheme({BackgroundColor3 = "Accent"})
                
                Instances:Create("UICorner", {
                    Parent = Items["Accent"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 7)
                })
                
                Items["Circle"] = Instances:Create("Frame", {
                    Parent = Items["Accent"].Instance,
                    Name = "\0",
                    AnchorPoint = Vector2New(1, 0.5),
                    Position = UDim2New(1, 5, 0.5, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0, 8, 0, 8),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Circle"]:AddToTheme({BackgroundColor3 = "Accent"})
                
                Instances:Create("UICorner", {
                    Parent = Items["Circle"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 7)
                })
                
                Instances:Create("UIGradient", {
                    Parent = Items["Accent"].Instance,
                    Name = "\0",
                    Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(180, 180, 180)), RGBSequenceKeypoint(1, FromRGB(255, 255, 255))}
                })                
            end

            function Slider:Get()
                return Slider.Value
            end

            function Slider:SetVisibility(Bool)
                Items["Slider"].Instance.Visible = Bool
            end

            function Slider:Set(Value, Instant)
                Slider.Value = Library:Round(MathClamp(Value, Slider.Min, Slider.Max), Slider.Decimals)
                Library.Flags[Slider.Flag] = Slider.Value

                local Range = Slider.Max - Slider.Min
                local Alpha = Range ~= 0 and ((Slider.Value - Slider.Min) / Range) or 0

                if Instant then
                    Items["Accent"].Instance.Size = UDim2New(Alpha, -2, 1, 0)
                else
                    Items["Accent"]:Tween(TweenInfo.new(0.12, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2New(Alpha, -2, 1, 0)})
                end

                Items["Value"].Instance.Text = StringFormat("%s%s", Slider.Value, Slider.Suffix)

                if Slider.Callback then
                    Library:SafeCall(Slider.Callback, Slider.Value)
                end
            end

            local InputChanged
            local InputChanged2

            Items["RealSlider"]:Connect("InputBegan", function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                    Slider.Sliding = true

                    local SizeX = (Input.Position.X - Items["RealSlider"].Instance.AbsolutePosition.X) / Items["RealSlider"].Instance.AbsoluteSize.X
                    local Value = ((Slider.Max - Slider.Min) * SizeX) + Slider.Min

                    Slider:Set(Value, Library.Performance.DirectDrag)

                    if InputChanged then
                        return 
                    end

                    InputChanged = Input.Changed:Connect(function()
                        if Input.UserInputState == Enum.UserInputState.End then
                            Slider.Sliding = false

                            InputChanged:Disconnect()
                            InputChanged = nil
                        end
                    end)
                end
            end)

            Items["Circle"]:Connect("InputBegan", function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                    Slider.Sliding = true

                    local SizeX = (Input.Position.X - Items["RealSlider"].Instance.AbsolutePosition.X) / Items["RealSlider"].Instance.AbsoluteSize.X
                    local Value = ((Slider.Max - Slider.Min) * SizeX) + Slider.Min

                    Slider:Set(Value, Library.Performance.DirectDrag)

                    if InputChanged2 or InputChanged then
                        return 
                    end

                    InputChanged2 = Input.Changed:Connect(function()
                        if Input.UserInputState == Enum.UserInputState.End then
                            Slider.Sliding = false

                            InputChanged2:Disconnect()
                            InputChanged2 = nil
                        end
                    end)
                end
            end)

            Slider._Track = Items["RealSlider"]
            Library.Sliders[Slider] = Slider

            if not Library.SliderHooked then
                Library.SliderHooked = true

                Library:Connect(UserInputService.InputChanged, function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
                        for _, Active in Library.Sliders do
                            if Active.Sliding and Active._Track and Active._Track.Instance then
                                local Track = Active._Track.Instance
                                local SizeX = (Input.Position.X - Track.AbsolutePosition.X) / Track.AbsoluteSize.X
                                local Value = ((Active.Max - Active.Min) * SizeX) + Active.Min

                                Active:Set(Value, Library.Performance.DirectDrag)
                            end
                        end
                    end
                end)
            end

            Slider:Set(Slider.Default) 

            Library.SetFlags[Slider.Flag] = function(Value)
                Slider:Set(Value)
            end

            return Slider 
        end

        Library.Sections.Dropdown = function(self, Data)
            Data = Data or { }

            local Dropdown = {
                Window = self.Window,
                Page = self.Page,
                Section = self,

                Name = Data.Name or Data.name or "Dropdown",
                Flag = Data.Flag or Data.flag or Library:NextFlag(),
                Items = Data.Items or Data.items or { },
                Default = Data.Default or Data.default or "",
                Callback = Data.Callback or Data.callback or function() end,
                Multi = Data.Multi or Data.multi or false,

                Value = { },
                Options = { },
                IsOpen = false
            }

            local Items = { } do 
                Items["Dropdown"] = Instances:Create("Frame", {
                    Parent = Dropdown.Section.Items["Content"].Instance,
                    Name = "\0",
                    BackgroundTransparency = 1,
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(1, 0, 0, 25),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Items["Text"] = Instances:Create("TextLabel", {
                    Parent = Items["Dropdown"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(238, 238, 238),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = Dropdown.Name,
                    AnchorPoint = Vector2New(0, 0.5),
                    Size = UDim2New(0, 0, 0, 15),
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 0, 0.5, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Items["RealDropdown"] = Instances:Create("TextButton", {
                    Parent = Items["Dropdown"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(0, 0, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    AnchorPoint = Vector2New(1, 0.5),
                    Position = UDim2New(1, 0, 0.5, 0),
                    Size = UDim2New(0, 80, 0, 25),
                    BorderSizePixel = 0,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(30, 34, 34)
                })  Items["RealDropdown"]:AddToTheme({BackgroundColor3 = "Element"})
                
                Instances:Create("UICorner", {
                    Parent = Items["RealDropdown"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 6)
                })
                
                Items["Value"] = Instances:Create("TextLabel", {
                    Parent = Items["RealDropdown"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(179, 179, 179),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "...",
                    AnchorPoint = Vector2New(0, 0.5),
                    Size = UDim2New(1, -6, 0, 15),
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 6, 0.5, 0),
                    BorderSizePixel = 0,
                    TextSize = 12,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Items["Icon"] = Instances:Create("ImageLabel", {
                    Parent = Items["RealDropdown"].Instance,
                    Name = "\0",
                    ImageColor3 = FromRGB(179, 179, 179),
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(1, 0.5),
                    Image = "rbxassetid://135448248851234",
                    BackgroundTransparency = 1,
                    Position = UDim2New(1, -5, 0.5, 0),
                    Size = UDim2New(0, 16, 0, 16),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Items["OptionHolder"] = Instances:Create("Frame", {
                    Parent = Library.UnusedHolder.Instance,
                    Name = "\0",
                    Visible = false,
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(0, 0),
                    Position = UDim2New(1, 0, 0.5, 0),
                    Size = UDim2New(0, 80, 0, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundColor3 = FromRGB(21, 24, 24)
                })  Items["OptionHolder"]:AddToTheme({BackgroundColor3 = "Inline"})
                
                Instances:Create("UIStroke", {
                    Parent = Items["OptionHolder"].Instance,
                    Name = "\0",
                    Color = FromRGB(30, 33, 33),
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                }):AddToTheme({Color = "Border"})
                
                Items["Holder"] = Instances:Create("ScrollingFrame", {
                    Parent = Items["OptionHolder"].Instance,
                    Name = "\0",
                    Active = true,
                    AutomaticCanvasSize = Enum.AutomaticSize.XY,
                    ScrollBarThickness = 2,
                    Size = UDim2New(1, 0, 1, 0),
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1,
                    ScrollingDirection = Enum.ScrollingDirection.Y,
                    BorderColor3 = FromRGB(0, 0, 0),
                    BackgroundColor3 = FromRGB(255, 255, 255),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    CanvasSize = UDim2New(0, 0, 0, 0)
                })  Items["Holder"]:AddToTheme({ScrollBarImageColor3 = "Accent"})
                
                Instances:Create("UIListLayout", {
                    Parent = Items["Holder"].Instance,
                    Name = "\0",
                    SortOrder = Enum.SortOrder.LayoutOrder
                })                

                Instances:Create("UIPadding", {
                    Parent = Items["OptionHolder"].Instance,
                    Name = "\0",
                    PaddingBottom = UDimNew(0, 4)
                })                
            end

            function Dropdown:Get()
                return Dropdown.Value
            end

            function Dropdown:SetVisibility(Bool)
                Items["Dropdown"].Instance.Visible = Bool
            end

            local Debounce = false
            local RenderStepped

            function Dropdown:SetOpen(Bool)
                if Debounce then 
                    return
                end

                Dropdown.IsOpen = Bool

                Debounce = true 

                if Dropdown.IsOpen then 
                    Items["OptionHolder"].Instance.Visible = true
                    Items["OptionHolder"].Instance.Parent = Library.Holder.Instance
                    
                    local LastPX, LastPY, LastW = -1, -1, -1

                    RenderStepped = Library:Connect(RunService.RenderStepped, function()
                        local Real = Items["RealDropdown"].Instance
                        local PX = MathFloor(Real.AbsolutePosition.X)
                        local PY = MathFloor(Real.AbsolutePosition.Y)
                        local W = MathFloor(Real.AbsoluteSize.X)

                        if PX ~= LastPX or PY ~= LastPY or W ~= LastW then
                            LastPX, LastPY, LastW = PX, PY, W
                            Items["OptionHolder"].Instance.Position = UDim2New(0, PX, 0, PY - 25)
                            Items["OptionHolder"].Instance.Size = UDim2New(0, W, 0, 0)
                        end
                    end)

                    for Index, Value in Library.OpenFrames do 
                        if Value ~= Dropdown and not Dropdown.Section.IsSettings then 
                            Value:SetOpen(false)
                        end
                    end

                    Library.OpenFrames[Dropdown] = Dropdown 
                else
                    if Library.OpenFrames[Dropdown] then 
                        Library.OpenFrames[Dropdown] = nil
                    end

                    if RenderStepped then 
                        RenderStepped:Disconnect()
                        RenderStepped = nil
                    end
                end

                Tween:BatchFade(Items["OptionHolder"].Instance, Bool, Library.FadeSpeed, Bool and 3 or 1, function()
                    Debounce = false
                    Items["OptionHolder"].Instance.Visible = Dropdown.IsOpen

                    if not Dropdown.IsOpen then
                        task.delay(0.2, function()
                            if not Dropdown.IsOpen then
                                pcall(function()
                                    Items["OptionHolder"].Instance.Parent = Library.UnusedHolder.Instance
                                end)
                            end
                        end)
                    end
                end)
            end

            function Dropdown:Set(Option)
                if Dropdown.Multi then 
                    if type(Option) ~= "table" then 
                        return
                    end

                    Dropdown.Value = Option
                    Library.Flags[Dropdown.Flag] = Option

                    for Index, Value in Option do
                        local OptionData = Dropdown.Options[Value]
                         
                        if not OptionData then
                            continue
                        end

                        OptionData.Selected = true 
                        OptionData:Toggle("Active")
                    end

                    Items["Value"].Instance.Text = TableConcat(Option, ", ")
                else
                    if not Dropdown.Options[Option] then
                        return
                    end

                    local OptionData = Dropdown.Options[Option]

                    Dropdown.Value = Option
                    Library.Flags[Dropdown.Flag] = Option

                    for Index, Value in Dropdown.Options do
                        if Value ~= OptionData then
                            Value.Selected = false 
                            Value:Toggle("Inactive")
                        else
                            Value.Selected = true 
                            Value:Toggle("Active")
                        end
                    end

                    Items["Value"].Instance.Text = Option
                end

                if Dropdown.Callback then   
                    Library:SafeCall(Dropdown.Callback, Dropdown.Value)
                end
            end

            function Dropdown:Add(Option)
                local OptionButton = Instances:Create("TextButton", {
                    Parent = Items["Holder"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(179, 179, 179),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = Option,
                    AutoButtonColor = false,
                    BackgroundTransparency = 1,
                    Size = UDim2New(1, 0, 0, 25),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  OptionButton:AddToTheme({BackgroundColor3 = "Accent"})

                local OptionData = {
                    Button = OptionButton,
                    Name = Option,
                    Selected = false
                }
                
                function OptionData:Toggle(Value)
                    if Value == "Active" then
                        OptionData.Button:Tween(nil, {BackgroundTransparency = 0, TextColor3 = FromRGB(0, 0, 0)})
                    else
                        OptionData.Button:Tween(nil, {BackgroundTransparency = 1, TextColor3 = FromRGB(179, 179, 179)})
                    end
                end

                function OptionData:Set()
                    OptionData.Selected = not OptionData.Selected

                    if Dropdown.Multi then 
                        local Index = TableFind(Dropdown.Value, OptionData.Name)

                        if Index then 
                            TableRemove(Dropdown.Value, Index)
                        else
                            TableInsert(Dropdown.Value, OptionData.Name)
                        end

                        OptionData:Toggle(Index and "Inactive" or "Active")

                        Library.Flags[Dropdown.Flag] = Dropdown.Value

                        local TextFormat = #Dropdown.Value > 0 and TableConcat(Dropdown.Value, ", ") or "..."
                        Items["Value"].Instance.Text = TextFormat
                    else
                        if OptionData.Selected then 
                            Dropdown.Value = OptionData.Name
                            Library.Flags[Dropdown.Flag] = OptionData.Name

                            OptionData.Selected = true
                            OptionData:Toggle("Active")

                            for Index, Value in Dropdown.Options do 
                                if Value ~= OptionData then
                                    Value.Selected = false 
                                    Value:Toggle("Inactive")
                                end
                            end

                            Items["Value"].Instance.Text = OptionData.Name
                        else
                            Dropdown.Value = nil
                            Library.Flags[Dropdown.Flag] = nil

                            OptionData.Selected = false
                            OptionData:Toggle("Inactive")

                            Items["Value"].Instance.Text = "..."
                        end
                    end

                    if Dropdown.Callback then
                        Library:SafeCall(Dropdown.Callback, Dropdown.Value)
                    end
                end

                OptionData.Button:Connect("MouseButton1Down", function()
                    OptionData:Set()
                end)

                Dropdown.Options[OptionData.Name] = OptionData
                return OptionData
            end

            function Dropdown:Remove(Option)
                if Dropdown.Options[Option] then
                    Dropdown.Options[Option].Button:Clean()
                    Dropdown.Options[Option] = nil
                end
            end

            function Dropdown:Refresh(List)
                for Index, Value in Dropdown.Options do 
                    Dropdown:Remove(Value.Name)
                end

                for Index, Value in List do 
                    Dropdown:Add(Value)
                end
            end

            Items["RealDropdown"]:Connect("MouseButton1Down", function()
                Dropdown:SetOpen(not Dropdown.IsOpen)
            end)

            Dropdown._Popup = Items["OptionHolder"]
            Library.Dropdowns[Dropdown] = Dropdown

            if not Library.DropdownHooked then
                Library.DropdownHooked = true

                Library:Connect(UserInputService.InputBegan, function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                        for _, Open in Library.Dropdowns do
                            if Open.IsOpen and not Library:IsMouseOverFrame(Open._Popup) then
                                Open:SetOpen(false)
                            end
                        end
                    end
                end)
            end

            Items["RealDropdown"]:Connect("Changed", function(Property)
                if Property == "AbsolutePosition" and Dropdown.IsOpen then
                    Dropdown.IsOpen = not Library:IsClipped(Items["OptionHolder"].Instance, Dropdown.Section.Items["Section"].Instance.Parent)
                    Items["OptionHolder"].Instance.Visible = Dropdown.IsOpen
                end
            end)

            for Index, Value in Dropdown.Items do 
                Dropdown:Add(Value)
            end

            if Dropdown.Default then 
                Dropdown:Set(Dropdown.Default)
            end

            Library.SetFlags[Dropdown.Flag] = function(Value)
                Dropdown:Set(Value)
            end

            return Dropdown
        end

        Library.Sections.Label = function(self, Name)
            local Label = {
                Window = self.Window,
                Page = self.Page,
                Section = self,

                Name = Name or "Label"
            }

            local Items = { } do
                Items["Label"] = Instances:Create("Frame", {
                    Parent = Label.Section.Items["Content"].Instance,
                    Name = "\0",
                    BackgroundTransparency = 1,
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(1, 0, 0, 17),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Items["Text"] = Instances:Create("TextLabel", {
                    Parent = Items["Label"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(179, 179, 179),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = Label.Name,
                    AnchorPoint = Vector2New(0, 0.5),
                    Size = UDim2New(0, 0, 0, 15),
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 0, 0.5, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Items["SubElements"] = Instances:Create("Frame", {
                    Parent = Items["Label"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(1, 0),
                    BackgroundTransparency = 1,
                    Position = UDim2New(1, 0, 0, 0),
                    Size = UDim2New(0, 0, 1, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Instances:Create("UIListLayout", {
                    Parent = Items["SubElements"].Instance,
                    Name = "\0",
                    FillDirection = Enum.FillDirection.Horizontal,
                    HorizontalAlignment = Enum.HorizontalAlignment.Right,
                    Padding = UDimNew(0, 6),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })      
            end

            function Label:SetText(Text)
               Text = tostring(Text)
               Items["Text"].Instance.Text = Text 
            end

            function Label:SetVisibility(Bool)
                Items["Label"].Instance.Visible = Bool
            end

            function Label:Colorpicker(Data)
                Data = Data or { }

                local Colorpicker = {
                    Window = Label.Window,
                    Page = Label.Page,
                    Section = Label.Section,

                    Flag = Data.Flag or Data.flag or Library:NextFlag(),
                    Default = Data.Default or Data.default or Color3.fromRGB(255, 255, 255),
                    Callback = Data.Callback or Data.callback or function() end
                }

                local NewColorpicker = Library:CreateColorpicker({
                    Parent = Items["SubElements"],
                    Page = Colorpicker.Page,
                    Section = Colorpicker.Section,
                    Flag = Colorpicker.Flag,
                    Default = Colorpicker.Default,
                    Callback = Colorpicker.Callback
                })

                return NewColorpicker
            end

            function Label:Keybind(Data)
                Data = Data or { }

                local Keybind = {
                    Window = Label.Window,
                    Page = Label.Page,
                    Section = Label.Section,

                    Flag = Data.Flag or Data.flag or Library:NextFlag(),
                    Default = Data.Default or Data.default or Enum.KeyCode.E,
                    Callback = Data.Callback or Data.callback or function() end,
                    Mode = Data.Mode or Data.mode or "Toggle"
                }

                local NewKeybind = Library:CreateKeybind({
                    Parent = Items["SubElements"],
                    Page = Keybind.Page,
                    Section = Keybind.Section,
                    Flag = Keybind.Flag,
                    Default = Keybind.Default,
                    Mode = Keybind.Mode,
                    Callback = Keybind.Callback
                })

                return NewKeybind
            end

            function Label:Badge(Data)
                Data = Data or { }

                if type(Data) == "string" then
                    Data = { Text = Data }
                end

                local Style = Data.Style or Data.style or "Jade"

                local BadgeStyles = {
                    Jade = { Bg = "Accent", BgTransp = 0.78, Text = "Accent" },
                    Iris = { Bg = "IrisDeep", BgTransp = 0.2, Text = "IrisPale" },
                    Muted = { Bg = "Element", BgTransp = 0, Text = "TextDim" }
                }

                local Pick = BadgeStyles[Style] or BadgeStyles.Jade

                local BadgeItems = { } do
                    BadgeItems["Badge"] = Instances:Create("TextLabel", {
                        Parent = Items["SubElements"].Instance,
                        Name = "\0",
                        FontFace = Library.Font,
                        TextColor3 = FromRGB(31, 216, 164),
                        BorderColor3 = FromRGB(0, 0, 0),
                        Text = Data.Text or Data.text or "Badge",
                        BackgroundTransparency = Pick.BgTransp,
                        Size = UDim2New(0, 0, 1, 0),
                        BorderSizePixel = 0,
                        AutomaticSize = Enum.AutomaticSize.X,
                        TextSize = 12,
                        BackgroundColor3 = FromRGB(31, 216, 164)
                    })

                    BadgeItems["Badge"]:AddToTheme({BackgroundColor3 = Pick.Bg, TextColor3 = Pick.Text})

                    Instances:Create("UICorner", {
                        Parent = BadgeItems["Badge"].Instance,
                        Name = "\0",
                        CornerRadius = UDimNew(0, 6)
                    })

                    Instances:Create("UIPadding", {
                        Parent = BadgeItems["Badge"].Instance,
                        Name = "\0",
                        PaddingLeft = UDimNew(0, 8),
                        PaddingRight = UDimNew(0, 8)
                    })
                end

                return BadgeItems
            end
 
            return Label
        end

        Library.Sections.Divider = function(self, Data)
            Data = Data or { }

            if type(Data) == "string" then
                Data = { Text = Data }
            end

            local Divider = {
                Window = self.Window,
                Page = self.Page,
                Section = self,

                Text = Data.Text or Data.text or ""
            }

            local Items = { } do
                Items["Divider"] = Instances:Create("Frame", {
                    Parent = Divider.Section.Items["Content"].Instance,
                    Name = "\0",
                    BackgroundTransparency = 1,
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(1, 0, 0, Divider.Text ~= "" and 17 or 9),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })

                Items["Rule"] = Instances:Create("Frame", {
                    Parent = Items["Divider"].Instance,
                    Name = "\0",
                    AnchorPoint = Vector2New(0, 0.5),
                    Position = UDim2New(0, 0, 0.5, 0),
                    Size = UDim2New(1, 0, 0, 1),
                    BorderSizePixel = 0,
                    BorderColor3 = FromRGB(0, 0, 0),
                    BackgroundTransparency = 0.87,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })

                if Divider.Text ~= "" then
                    Items["Caption"] = Instances:Create("TextLabel", {
                        Parent = Items["Divider"].Instance,
                        Name = "\0",
                        FontFace = Library.FontMono,
                        TextColor3 = FromRGB(179, 179, 179),
                        BorderColor3 = FromRGB(0, 0, 0),
                        Text = string.upper(Divider.Text),
                        AnchorPoint = Vector2New(0.5, 0.5),
                        BackgroundTransparency = 0,
                        Position = UDim2New(0.5, 0, 0.5, 0),
                        Size = UDim2New(0, 0, 0, 13),
                        BorderSizePixel = 0,
                        AutomaticSize = Enum.AutomaticSize.X,
                        TextSize = 10,
                        BackgroundColor3 = FromRGB(25, 25, 25)
                    })

                    Items["Caption"]:AddToTheme({BackgroundColor3 = "Inline"})

                    Instances:Create("UIPadding", {
                        Parent = Items["Caption"].Instance,
                        Name = "\0",
                        PaddingLeft = UDimNew(0, 8),
                        PaddingRight = UDimNew(0, 8)
                    })
                end
            end

            function Divider:SetVisibility(Bool)
                Items["Divider"].Instance.Visible = Bool
            end

            return Divider
        end

        Library.Sections.Paragraph = function(self, Data)
            Data = Data or { }

            if type(Data) == "string" then
                Data = { Text = Data }
            end

            local Paragraph = {
                Window = self.Window,
                Page = self.Page,
                Section = self,

                Text = Data.Text or Data.text or "Paragraph"
            }

            local Items = { } do
                Items["Paragraph"] = Instances:Create("TextLabel", {
                    Parent = Paragraph.Section.Items["Content"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(175, 175, 175),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = Paragraph.Text,
                    BackgroundTransparency = 1,
                    Size = UDim2New(1, 0, 0, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    TextWrapped = true,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextYAlignment = Enum.TextYAlignment.Top,
                    TextSize = 12,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
            end

            function Paragraph:SetText(Text)
                Items["Paragraph"].Instance.Text = tostring(Text)
            end

            function Paragraph:SetVisibility(Bool)
                Items["Paragraph"].Instance.Visible = Bool
            end

            return Paragraph
        end

        Library.Sections.Textbox = function(self, Data)
            Data = Data or { }

            local Textbox = {
                Window = self.Window,
                Page = self.Page,
                Section = self,

                Flag = Data.Flag or Data.flag or Library:NextFlag(),
                Default = Data.Default or Data.default or "",
                Callback = Data.Callback or Data.callback or function() end,
                Placeholder = Data.Placeholder or Data.placeholder or "Placeholder",
                Numeric = Data.Numeric or Data.numeric or false,
                Finished = Data.Finished or Data.finished or false,

                Value = ""
            }

            local Items = { } do 
                Items["Textbox"] = Instances:Create("Frame", {
                    Parent = Textbox.Section.Items["Content"].Instance,
                    Name = "\0",
                    BackgroundTransparency = 1,
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(1, 0, 0, 25),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Items["Input"] = Instances:Create("TextBox", {
                    Parent = Items["Textbox"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    CursorPosition = -1,
                    TextColor3 = FromRGB(238, 238, 238),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "",
                    Size = UDim2New(1, 0, 1, 0),
                    ClipsDescendants = true,
                    BorderSizePixel = 0,
                    PlaceholderColor3 = FromRGB(96, 96, 96),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    PlaceholderText = Textbox.Placeholder,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(30, 34, 34)
                })  Items["Input"]:AddToTheme({BackgroundColor3 = "Element"})
                
                Instances:Create("UICorner", {
                    Parent = Items["Input"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 6)
                })
                
                Items["InputStroke"] = Instances:Create("UIStroke", {
                    Parent = Items["Input"].Instance,
                    Name = "\0",
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                    Color = FromRGB(56, 62, 62),
                    Thickness = 1
                })  Items["InputStroke"]:AddToTheme({Color = "Border 2"})
                
                Instances:Create("UIPadding", {
                    Parent = Items["Input"].Instance,
                    Name = "\0",
                    PaddingLeft = UDimNew(0, 8)
                })                 
            end

            function Textbox:Get()
                return Textbox.Value
            end

            function Textbox:SetVisibility(Bool)
                Items["Textbox"].Instance.Visible = Bool
            end

            function Textbox:Set(Value)
                if Textbox.Numeric then
                    if (not tonumber(Value)) and StringLen(tostring(Value)) > 0 then
                        Value = Textbox.Value
                    end
                end

                Textbox.Value = Value
                Items["Input"].Instance.Text = Value
                Library.Flags[Textbox.Flag] = Value

                if Textbox.Callback then
                    Library:SafeCall(Textbox.Callback, Value)
                end
            end

            if Textbox.Finished then 
                Items["Input"]:Connect("FocusLost", function(PressedEnterQuestionMark)
                    if PressedEnterQuestionMark then
                        Textbox:Set(Items["Input"].Instance.Text)
                    end
                end)
            else
                Library:Connect(Items["Input"].Instance:GetPropertyChangedSignal("Text"), function()
                    Textbox:Set(Items["Input"].Instance.Text)
                end)
            end

            Items["Input"]:Connect("Focused", function()
                Items["InputStroke"]:Tween(TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Color = Library.Theme.Accent})
            end)

            Items["Input"]:Connect("FocusLost", function()
                Items["InputStroke"]:Tween(TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Color = Library.Theme["Border 2"]})
            end)

            if Textbox.Default then
                Textbox:Set(Textbox.Default)
            end

            Library.SetFlags[Textbox.Flag] = function(Value)
                Textbox:Set(Value)
            end

            return Textbox 
        end
    end

    Library.CreateSettingsPage = function(self, Window)
        local SettingsPage = Window:Page({Name = "Settings", Icon = "72732892493295"}) do 
            local ConfigsSubPage = SettingsPage:SubPage({Name = "Configs"})
            local ThemingSubPage = SettingsPage:SubPage({Name = "Theming"})
            local SettingsSubPage = SettingsPage:SubPage({Name = "Settings"})

            do -- Configs
                local ConfigsSection = ConfigsSubPage:Section({Name = "Configs", Side = 1, Icon = "97491613646216"})

                local ConfigName = ""
                local ConfigSelected

                local ConfigsList = ConfigsSection:Dropdown({
                    Name = "Configs", 
                    Flag = "ConfigsList", 
                    Items = { }, 
                    Multi = false,
                    Callback = function(Value)
                        ConfigSelected = Value
                    end
                })

                ConfigsSection:Textbox({ 
                    Default = "", 
                    Flag = "ConfigName", 
                    Placeholder = "Config name", 
                    Callback = function(Value)
                        ConfigName = Value
                    end
                })

                ConfigsSection:Button({
                    Name = "Create",
                    Callback = function()
                    if ConfigName and ConfigName ~= "" then
                        writefile(Library.Folders.Configs .. "/" .. ConfigName .. ".json", Library:GetConfig())
                        Library:RefreshConfigsList(ConfigsList)
                        ConfigsList:Set(ConfigName)
                    end
                end})

                ConfigsSection:Button({
                    Name = "Delete", 
                    Callback = function()
                    if ConfigSelected and ConfigSelected ~= "" then
                        Library:DeleteConfig(ConfigSelected)
                        ConfigSelected = nil
                        Library:RefreshConfigsList(ConfigsList)
                    end
                end})

                ConfigsSection:Button({
                    Name = "Load", 
                    Callback = function()
                    if ConfigSelected and ConfigSelected ~= "" then
                        local ConfigPath = Library.Folders.Configs .. "/" .. ConfigSelected .. ".json"

                        if isfile(ConfigPath) then
                            Library:LoadConfig(readfile(ConfigPath))
                        end
                    end
                end})

                ConfigsSection:Button({
                    Name = "Save", 
                    Callback = function()
                    local TargetName = (ConfigSelected and ConfigSelected ~= "") and ConfigSelected or ConfigName

                    if TargetName and TargetName ~= "" then
                        writefile(Library.Folders.Configs .. "/" .. TargetName .. ".json", Library:GetConfig())
                        Library:RefreshConfigsList(ConfigsList)
                        ConfigsList:Set(TargetName)
                    end
                end})

                ConfigsSection:Button({
                    Name = "Refresh", 
                    Callback = function()
                    Library:RefreshConfigsList(ConfigsList)
                end})

                Library:RefreshConfigsList(ConfigsList)               
            end

            do -- Theming
                local ThemingSection = ThemingSubPage:Section({Name = "Theming", Icon = "131595494666590", Side = 1})
                for Index, Value in Library.Theme do 
                    ThemingSection:Label(Index):Colorpicker({
                        Flag = Index.."Theme",
                        Default = Value,
                        Callback = function(Value)
                            Library.Theme[Index] = Value
                            Library:ChangeTheme(Index, Value)
                        end
                    })
                end
            end

            do -- Settings
                local SettingsSection = SettingsSubPage:Section({Name = "Settings", Icon = "72732892493295", Side = 1})     
                
                SettingsSection:Button({
                    Name = "Unload",
                    Callback = function()
                        Library:Unload()
                    end
                })
                
                SettingsSection:Label("Menu Keybind"):Keybind({
                    Name = "Menu Keybind",
                    Flag = "MenuKeybind",
                    Default = Library.MenuKeybind,
                    Mode = "Toggle",
                    Callback = function()
                        Library.MenuKeybind = Library.Flags["MenuKeybind"].Key
                    end
                })

                SettingsSection:Slider({
                    Name = "Tween Speed",
                    Default = 0.3,
                    Flag = "Tween Speed",
                    Decimals = 0.01,
                    Suffix = "s",
                    Max = 10,
                    Min = 0,
                    Callback = function(Value)
                        Library.Tween.Time = Value
                    end
                })

                SettingsSection:Dropdown({
                    Name = "Tween Style",
                    Flag = "Tween style",
                    Items = { "Linear", "Quad", "Quart", "Back", "Bounce", "Circular", "Cubic", "Elastic", "Exponential", "Sine", "Quint" },
                    Default = "Quart",
                    Callback = function(Value)
                        if not Value then Value = "Quint" end
                        Library.Tween.Style = Enum.EasingStyle[Value]
                    end
                })

                SettingsSection:Dropdown({
                    Name = "Tween Direction",
                    Flag = "Tween direction",
                    Items = { "In", "Out", "InOut" },
                    Default = "Out",
                    Callback = function(Value)
                        if not Value then Value = "Out" end
                        Library.Tween.Direction = Enum.EasingDirection[Value]
                    end
                })

                SettingsSection:Toggle({
                    Name = "Enable Animations",
                    Flag = "RavenEnableTweens",
                    Default = true,
                    Callback = function(Value)
                        Library.Performance.EnableTweens = Value and true or false
                    end
                })

                SettingsSection:Toggle({
                    Name = "Direct Drag",
                    Flag = "RavenDirectDrag",
                    Default = true,
                    Callback = function(Value)
                        Library.Performance.DirectDrag = Value and true or false
                    end
                })

                SettingsSection:Slider({
                    Name = "UI Scale",
                    Flag = "RavenUIScale",
                    Min = 0.7,
                    Max = 1.3,
                    Default = 1,
                    Decimals = 0.01,
                    Suffix = "x",
                    Callback = function(Value)
                        Window.UIScale = Value

                        if Window.MainScale and Window.MainScale.Instance and Window.IsOpen then
                            Window.MainScale.Instance.Scale = Value
                        end
                    end
                })

                SettingsSection:Toggle({
                    Name = "Watermark",
                    Flag = "RavenWatermark",
                    Default = true,
                    Callback = function(Value)
                        if Window.WatermarkItems and Window.WatermarkItems["Mark"] then
                            Window.WatermarkItems["Mark"].Instance.Visible = Value and true or false
                        end
                    end
                })

                SettingsSection:Toggle({
                    Name = "Keybind List",
                    Flag = "RavenKeybindList",
                    Default = true,
                    Callback = function(Value)
                        Library.KeybindListVisible = Value and true or false
                        Library:RefreshKeybindList()
                    end
                })

                local WebhookSaveThread

                SettingsSection:Textbox({
                    Flag = "RavenWebhookURL",
                    Placeholder = "Discord webhook URL",
                    Default = Library.Webhook.URL or "",
                    Callback = function(Value)
                        Library.Webhook.URL = tostring(Value or "")

                        if WebhookSaveThread then
                            pcall(task.cancel, WebhookSaveThread)
                        end

                        WebhookSaveThread = task.delay(0.5, function()
                            WebhookSaveThread = nil
                            Library:SaveWebhook()
                        end)
                    end
                })

                SettingsSection:Toggle({
                    Name = "Enable Webhook",
                    Flag = "RavenWebhookEnabled",
                    Default = Library.Webhook.Enabled and true or false,
                    Callback = function(Value)
                        Library.Webhook.Enabled = Value and true or false
                        Library:SaveWebhook()
                    end
                })

                SettingsSection:Toggle({
                    Name = "Report on Load",
                    Flag = "RavenWebhookSendOnLoad",
                    Default = Library.Webhook.SendOnLoad and true or false,
                    Callback = function(Value)
                        Library.Webhook.SendOnLoad = Value and true or false
                        Library:SaveWebhook()
                    end
                })

                SettingsSection:Button({
                    Name = "Test Webhook",
                    Callback = function()
                        local Ok, Err = Library:SendWebhook("Xanax UI : Test", "Webhook is wired correctly.", Library:AccentColorNumber())
                        if not Ok then
                            warn("[Xanax] Webhook test failed: " .. tostring(Err))
                        end
                    end
                })
            end

        end
    end
end

task.delay(1, function()
    pcall(function()
        local Path = Library.Folders.Configs .. "/default.json"

        if isfile(Path) then
            Library:LoadConfig(readfile(Path))
        end
    end)
end)

task.delay(2, function()
    pcall(function()
        if Library.Webhook.SendOnLoad and Library.Webhook.Enabled and #Library.Webhook.URL > 10 then
            Library:SendWebhook("Xanax UI : Loaded", "User loaded the UI.", Library:AccentColorNumber())
        end
    end)
end)

local Window = Library:Window({Name = "Xanax", SubTitle = "Frontline Visual Intelligence"})
Window:Category("Main")
local CombatPage = Window:Page({Name = "Page", Icon = "136879043989014"})
Window:Page({Name = "Page", Icon = "136879043989014"})
Window:Page({Name = "Page", Icon = "136879043989014"})

local CombatSubPage = CombatPage:SubPage({Name = "Combat"})
CombatPage:SubPage({Name = "Weapon"})
CombatPage:SubPage({Name = "FoV"})

Window:Category("Settings")
Library:CreateSettingsPage(Window)

for Index = 1, 2 do 
    local AimbotSection = CombatSubPage:Section({Name = "Aimbot", Icon = "136879043989014", Side = Index})

    AimbotSection:Toggle({Name = "Toggle", Flag = "Toggle", Desc = "Small dim description under the name.", Callback = function(Value)
        print(Value)
    end})

    AimbotSection:Button({Name = "Button", Callback = function()
        print("Button")
    end})

    AimbotSection:Slider({Name = "Slider", Flag = "Slider", Min = 0, Max = 100, Default = 50, Suffix = "%", Decimals = 1, Callback = function(Value)
        print(Value)
    end})

    AimbotSection:Dropdown({Name = "Dropdown", Flag = "Dropdown", Items = {"Optionn 1", "Optionn 2", "Optionn 3", "Optionn 4"}, Default = "Optionn 2", Multi = false, Callback = function(Value)
        print(Value)
    end})

    AimbotSection:Label("Label"):Colorpicker({Flag = "Colorpicker", Default = Color3.fromRGB(255, 255, 255), Callback = function(Value)
        print(Value)
    end})

    AimbotSection:Label("Label"):Keybind({Flag = "Keybind", Default = Enum.KeyCode.E, Mode = "Toggle", Callback = function(Value)
        print(Value)
    end})

    AimbotSection:Textbox({Flag = "Textbox", Placeholder = "Placeholder", Default = "Text", Finished = false, Numeric = false, Callback = function(Value)
        print(Value)
    end})

    AimbotSection:Divider("Status")

    AimbotSection:Paragraph("Muted descriptive copy. Wraps on its own and stays dim so controls keep focus.")

    AimbotSection:Label("Build"):Badge({Text = "Stable", Style = "Jade"})

    AimbotSection:Button({Name = "Primary Action", Primary = true, Callback = function()
        print("Primary")
    end})
end

local ScriptsSubPage = CombatPage:SubPage({Name = "Scripts"})
local ScriptsSection = ScriptsSubPage:Section({Name = "Loader", Icon = "136879043989014", Side = 1})

local function ExecuteSource(Source)
    if typeof(loadstring) ~= "function" then
        Library:Notification("loadstring unavailable", 3, nil)
        return
    end

    local OkCompile, Fn = pcall(loadstring, Source)

    if not OkCompile or type(Fn) ~= "function" then
        Library:Notification("Compile error", 3, nil)
        warn("[Xanax] Script compile failed: " .. tostring(Fn))
        return
    end

    local OkRun, RunErr = pcall(Fn)

    if OkRun then
        Library:Notification("Script executed", 3, nil)
    else
        Library:Notification("Runtime error", 3, nil)
        warn("[Xanax] Script failed: " .. tostring(RunErr))
    end
end

local ScriptBox = ScriptsSection:Textbox({
    Flag = "ScriptSource",
    Placeholder = "Paste code or script URL",
    Default = "",
    Finished = false,
    Callback = function() end
})

ScriptsSection:Button({Name = "Execute", Callback = function()
    ExecuteSource(tostring(ScriptBox:Get() or ""))
end})

ScriptsSection:Button({Name = "Load URL", Callback = function()
    local Url = tostring(ScriptBox:Get() or ""):gsub("%s+", "")

    if Url == "" then
        Library:Notification("Empty URL", 3, nil)
        return
    end

    local Ok, Body = pcall(function()
        return game:HttpGet(Url)
    end)

    if not Ok or type(Body) ~= "string" or Body == "" then
        Library:Notification("Download failed", 3, nil)
        return
    end

    ExecuteSource(Body)
end})

Library:Notification("Notification without icon", 5, nil)
Library:Notification("Notification with icon lol noob", 5, "94627324690861")
Library:Notification("Press " .. tostring(Library.MenuKeybind):gsub("Enum.KeyCode.", ""):gsub("Enum.UserInputType.", "") .. " to toggle the menu", 5, nil)

if typeof(getgenv) == "function" then
    getgenv().Library = Library
end

return Library

--[[
    RUN: executor LocalScript / client context only.
        local Library = loadstring(readfile("Library+Example.lua"))()
        local Window = Library:CreateWindow({ Name = "Xanax" })  -- or use the example window returned below

    HOTKEYS: right-click a keybind button -> mode popup (Toggle / Hold / Always)
             left-click it -> press a key to bind, click again to cancel
             Library.MenuKeybind (default Z) toggles the main window
             Settings tab: Tween Speed/Style/Direction, Enable Animations, Discord Reporting

    CLEANUP: Settings -> Unload button, or call Library:Unload()
             (re-running the file auto-unloads the previous instance first)

    WEBHOOK: Settings -> Discord Reporting: paste URL (auto-saves to <workspace>/webhook.json),
             Enable Webhook, Report on Load, Test Webhook.
             Queue respects Discord's 5 posts / 2 seconds (Library.Webhook.Spacing).
]]

