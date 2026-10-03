# Xanax UI — AI Import Guide

Paste this file (or the prompt pack at the bottom) into any AI to get back
drop-in script code for this UI. No other context needed.

## 1. What this is

`Xanax.lua` — single-file Roblox Luau UI library, executor LocalScript only.
Black/white monochrome theme. Caller builds a window out of
Category → Page → SubPage → Section → elements. The library owns rendering,
theming, flags, configs, and teardown. Your script owns cheat logic.

## 2. Loading the library (executor LocalScript only)

From a local file — the path is relative to the executor workspace, so the
`Xanax` folder must live where the executor reads files (where you see the
`esdeeeeee` folder appear), not just Downloads:

```lua
local Library = loadstring(readfile("Xanax/Xanax.lua"))()
```

From the web after uploading it somewhere raw (GitHub raw, pastebin raw):

```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/you/repo/main/Xanax.lua"))()
```

Then build a window with the skeleton in section 3. Nothing renders until
you create at least one Page — the file alone only defines the library.

## 3. Minimal skeleton (copy-paste, then extend)

```lua
local Library = loadstring(readfile("Xanax/Xanax.lua"))()

local Window = Library:CreateWindow({ Name = "Xanax" })
Window:Category("Main")

local MainPage = Window:Page({Name = "Main", Icon = "136879043989014"})
local MainSub = MainPage:SubPage({Name = "Features"})
local MainSection = MainSub:Section({Name = "Aimbot", Icon = "136879043989014", Side = 1})

MainSection:Toggle({Name = "Enabled", Flag = "AimbotEnabled", Default = false, Callback = function(Value)
    print("aimbot:", Value)
end})

Window:Category("Settings")
Library:CreateSettingsPage(Window) -- theming, configs, webhook, unload. Call once, last.
```

`Side = 1` or `2` splits sections into two columns. `Icon` is a Roblox
image asset id string (may be `""`).

## 4. Element catalog (exact shapes — do not invent fields)

```lua
Section:Toggle({Name, Flag, Default = false, Desc = "", Callback = function(Value) end})
Section:Button({Name, Primary = false, Callback = function() end})
Section:Slider({Name, Flag, Min, Max, Default, Decimals = 1, Suffix = "", Callback = function(Value) end})
Section:Dropdown({Name, Flag, Items = {}, Multi = false, Default, Callback = function(Value) end})
Section:Textbox({Flag, Placeholder, Default = "", Finished = false, Numeric = false, Callback = function(Value) end})
Section:Label("Text")            -- static row; returns Label
Section:Divider("Caption")       -- hairline rule; Caption optional
Section:Paragraph("...")         -- wrapped muted prose

Label:Colorpicker({Flag, Default = Color3, Callback = function(Color) end})
Label:Keybind({Flag, Default = Enum.KeyCode.E, Mode = "Toggle", Callback = function(Toggled) end})
Label:Badge({Text, Style = "Jade"})          -- Style: "Jade" | "Iris" | "Muted"
```

Useful handles: `Label:SetText(s)`, `Toggle:Set(v)`, `Toggle:Get()`,
`Dropdown:Set(option)`, `Dropdown:Refresh(list)`, `Textbox:Get()`,
`*:SetVisibility(bool)`. Live state always readable at
`Library.Flags["YourFlag"]`. Menu key: `Library.MenuKeybind`.
`Library.Version` is `"2.4.0"`.

## 5. Rules for generated code (non-negotiable)

- One block per option, exactly the shapes above. Unique `Flag` per
  interactive element — collisions silently share state.
- Cheat logic lives OUTSIDE callbacks, in a loop reading flags:
  ```lua
  task.spawn(function()
      while true do
          task.wait()
          if Library.Flags["AimbotEnabled"] then
              -- read Library.Flags["AimbotFOV"] etc, act here
          end
      end
  end)
  ```
- `task.wait` / `task.spawn` / `task.delay` only. Never `wait/spawn/delay`.
- No `+=` / `-=` (executor 5.1-parse safety). Use `x = x + 1`.
- `pcall` around anything fallible (HttpGet, file IO, loadstring of
  foreign code). Never let a callback throw — one throw aborts the build.
- No stubs, no TODOs, no dead code. Complete and runnable or say what is
  unverified.
- Left-click a keybind button rebinds it; right-click opens Toggle/Hold/
  Always popup. `Z` toggles the window (rebindable in Settings).

## 6. Configs (free persistence)

Settings tab → Configs: name + Create/Save/Load/Delete/Refresh. A config
named `default` auto-loads ~1s after boot. Webhook + watermark + scale
toggles persist the same way.

## 7. Prompt pack — paste into any AI with a task

> Build Luau executor code for the Xanax UI library using ONLY the element
> shapes in sections 4-5 of the AI guide. Target: <YOUR CHEAT HERE, e.g.
> "speed + fly tab: Speed toggle+slider 16-300, Fly toggle, FlySpeed
> slider, Fly keybind, status Badge">. Flag prefix: <PREFIX, e.g. "Movement">.
> Cheat logic in task.spawn loops reading Library.Flags. Constraints:
> task.* only, no +=, pcall around fallible calls, unique Flags, complete
> runnable code, no stubs. Return ONLY the page/section/element blocks plus
> the logic loop — no window boilerplate.

## 8. Smoke test (in executor, cannot be automated)

Boot → window opens with spring animation → drag window (follows, no lag)
→ toggle Z (close/reopen) → set an option → Settings → Configs → Save →
Unload → re-run → Save-named `default` restores state → Unload leaves no
UI and no errors in console.
