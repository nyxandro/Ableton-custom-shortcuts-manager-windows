#Requires AutoHotkey v2.0

configFile := "AbletonHotkeys.ini"

IsAutoStartEnabled() {
    val := IniRead(configFile, "Settings", "AutoStart", "0")
    return val = "1"
}


; --- Глобальный массив хоткеев ---
gHotkeys := [
    {command: "Toggle Second Window", default: "Ctrl + Shift + W", custom: ""},
    {command: "Export Audio/Video", default: "Ctrl + Shift + R", custom: ""},
    {command: "Export MIDI File", default: "Ctrl + Shift + E", custom: ""},
    {command: "Toggle Between Device/Clip View", default: "Shift + Tab", custom: ""},
    {command: "Hide/Show Video Window", default: "Ctrl + Alt + V", custom: ""},
    {command: "Hide/Show Browser", default: "Ctrl + Alt + B", custom: ""},
    {command: "Hide/Show Browser (alt)", default: "Ctrl + Alt + 5", custom: ""},
    {command: "Hide/Show Overview", default: "Ctrl + Alt + 0", custom: ""},
    {command: "Hide/Show In/Out", default: "Ctrl + Alt + I", custom: ""},
    {command: "Hide/Show Sends", default: "Ctrl + Alt + S", custom: ""},
    {command: "Hide/Show Mixer", default: "Ctrl + Alt + M", custom: ""},
    {command: "Hide/Show Clip View", default: "Ctrl + Alt + 3", custom: ""},
    {command: "Hide/Show Device View", default: "Ctrl + Alt + 4", custom: ""},
    {command: "Hide/Show the Groove Pool", default: "Ctrl + Alt + 6", custom: ""},
    {command: "Open the Settings", default: "Ctrl + ,", custom: ""},
    {command: "Move Focus to the Control Bar", default: "Alt + 0", custom: ""},
    {command: "Move Focus to the Session View", default: "Alt + 1", custom: ""},
    {command: "Move Focus to the Arrangement View", default: "Alt + 2", custom: ""},
    {command: "Move Focus to the Clip View", default: "Alt + 3", custom: ""},
    {command: "Move Focus to the Device View", default: "Alt + 4", custom: ""},
    {command: "Move Focus to the Browser", default: "Alt + 5", custom: ""},
    {command: "Move Focus to the Groove Pool", default: "Alt + 6", custom: ""},
    {command: "Move Focus to the Help View", default: "Alt + 7", custom: ""},
    {command: "Move Focus to the Selected Clip Panel", default: "Alt + 8", custom: ""},
    {command: "Move Focus to the Clip Panels", default: "Alt + Shift + P", custom: ""},
    {command: "Move to Previous Focusable Control", default: "Shift + Tab", custom: ""},
    {command: "Move to Next Neighbor of Current Control", default: "Ctrl + Tab", custom: ""},
    {command: "Move to Previous Neighbor of Current Control", default: "Ctrl + Shift + Tab", custom: ""},
    {command: "New Live Set", default: "Ctrl + N", custom: ""},
    {command: "Open Live Set", default: "Ctrl + O", custom: ""},
    {command: "Save Live Set", default: "Ctrl + S", custom: ""},
    {command: "Save Live Set As...", default: "Ctrl + Shift + S", custom: ""},
    {command: "Quit Live", default: "Ctrl + Q", custom: ""},
    {command: "Group Devices", default: "Ctrl + G", custom: ""},
    {command: "Ungroup Devices", default: "Ctrl + Shift + G", custom: ""},
    {command: "Show/Hide Plug-In Window", default: "Ctrl + Alt + P", custom: ""},
    {command: "Set Start Marker", default: "Ctrl + F9", custom: ""},
    {command: "Set Loop Brace Start", default: "Ctrl + F10", custom: ""},
    {command: "Set Loop Brace End", default: "Ctrl + F11", custom: ""},
    {command: "Set End Marker", default: "Ctrl + F12", custom: ""},
    {command: "Nudge Loop Brace Left/Right", default: "Left / Right", custom: ""},
    {command: "Move Loop by Loop Length", default: "Up / Down", custom: ""},
    {command: "Halve/Double Loop Length", default: "Ctrl + Up / Ctrl + Down", custom: ""},
    {command: "Shorten/Lengthen Loop", default: "Ctrl + Left / Ctrl + Right", custom: ""},
    {command: "Select Material in Loop", default: "Ctrl + Shift + L", custom: ""},
    {command: "Zoom In Window", default: "Ctrl + +", custom: ""},
    {command: "Zoom Out Window", default: "Ctrl + -", custom: ""},
    {command: "Scroll Display to Follow Playback", default: "Ctrl + Shift + F", custom: ""},
    {command: "Pan Left/Right of Selection", default: "Ctrl + Alt + Left/Right", custom: ""},
    {command: "Quantize", default: "Ctrl + U", custom: ""},
    {command: "Quantize Settings", default: "Ctrl + Shift + U", custom: ""},
    {command: "Move Selected Warp Marker", default: "Left / Right", custom: ""},
    {command: "Select Warp Marker", default: "Ctrl + Left / Ctrl + Right", custom: ""},
    {command: "Move Clip Region with Start Marker", default: "Shift + Left / Shift + Right", custom: ""},
    {command: "Insert Warp Marker", default: "Ctrl + I", custom: ""},
    {command: "Delete Warp Marker", default: "Delete", custom: ""},
    {command: "Insert Transient", default: "Ctrl + Shift + I", custom: ""},
    {command: "Delete Transient", default: "Ctrl + Shift + Delete", custom: ""},
    {command: "Select All Notes", default: "Ctrl + A", custom: ""},
    {command: "Chop Notes on Grid", default: "Ctrl + E", custom: ""},
    {command: "Join Notes", default: "Ctrl + J", custom: ""},
    {command: "Fit Notes to Time Range", default: "Ctrl + Alt + J", custom: ""},
    {command: "Scroll Editor Vertically", default: "Page Up / Page Down", custom: ""},
    {command: "Scroll Editor Vertically in Fine Increments", default: "Shift + Page Up / Shift + Page Down", custom: ""},
    {command: "Scroll Editor Horizontally", default: "Ctrl + Page Up / Ctrl + Page Down", custom: ""},
    {command: "Select Next/Previous Note", default: "Alt + Up / Alt + Down", custom: ""},
    {command: "Select Next/Previous Note in Same Key Track", default: "Alt + Left / Alt + Right", custom: ""},
    {command: "Adjust Note Selection Velocity", default: "Ctrl + Up / Ctrl + Down", custom: ""},
    {command: "Adjust Note Selection Velocity Deviation", default: "Ctrl + Shift + Up / Ctrl + Shift + Down", custom: ""},
    {command: "Adjust Note Selection Chance", default: "Ctrl + Alt + Up / Ctrl + Alt + Down", custom: ""},
    {command: "Toggle Full-Size Clip View", default: "Ctrl + Alt + E", custom: ""},
    {command: "Group Notes (Play All)", default: "Ctrl + 6", custom: ""},
    {command: "Ungroup Notes", default: "Ctrl + Shift + 6", custom: ""},
    {command: "Apply Current MIDI Tool Settings", default: "Ctrl + Enter", custom: ""},
    {command: "Invert Note Selection", default: "Ctrl + Shift + A", custom: ""},
    {command: "Show/Hide MIDI Note Filters", default: "Ctrl + Shift + F", custom: ""},
    {command: "Narrow Grid", default: "Ctrl + 1", custom: ""},
    {command: "Widen Grid", default: "Ctrl + 2", custom: ""},
    {command: "Triplet Grid", default: "Ctrl + 3", custom: ""},
    {command: "Snap to Grid", default: "Ctrl + 4", custom: ""},
    {command: "Fixed/Zoom-Adaptive Grid", default: "Ctrl + 5", custom: ""},
    {command: "Sixteenth-Note Quantization", default: "Ctrl + 6", custom: ""},
    {command: "Eighth-Note Quantization", default: "Ctrl + 7", custom: ""},
    {command: "Quarter-Note Quantization", default: "Ctrl + 8", custom: ""},
    {command: "1-Bar Quantization", default: "Ctrl + 9", custom: ""},
    {command: "Quantization Off", default: "Ctrl + 0", custom: ""},
    {command: "Create Follow Action Chain", default: "Ctrl + Shift + Enter", custom: ""},
    {command: "Move Selected Track Left/Right", default: "Ctrl + Left/Right arrow keys", custom: ""},
    {command: "Move Nonadjacent Scenes Without Collapsing", default: "Ctrl + Up/Down arrow keys", custom: ""},
    {command: "Split Clip at Selection", default: "Ctrl + E", custom: ""},
    {command: "Consolidate Selection into Clip", default: "Ctrl + J", custom: ""},
    {command: "Crop Selected Clips", default: "Ctrl + Shift + J", custom: ""},
    {command: "Resize Clip When Insert Marker is at Clip Edge", default: "Enter + Left/Right arrow keys", custom: ""},
    {command: "Slide Waveform", default: "Shift + Alt + drag", custom: ""},
    {command: "Stretch Warped Clip", default: "Shift + drag in clip title bar", custom: ""},
    {command: "Select Time Within Clip", default: "Shift + Alt + drag in clip title bar", custom: ""},
    {command: "Create Fade/Crossfade", default: "Ctrl + Alt + F", custom: ""},
    {command: "Delete Fades/Crossfades in Selected Clip(s)", default: "Ctrl + Alt + Backspace", custom: ""},
    {command: "Toggle Loop Brace", default: "Ctrl + L", custom: ""},
    {command: "Adjust Loop Brace Length", default: "Ctrl + Left/Right arrow keys", custom: ""},
    {command: "Select Loop Brace Contents", default: "Ctrl + Shift + L", custom: ""},
    {command: "Capture MIDI", default: "Ctrl + Shift + C", custom: ""},
    {command: "Insert Silence", default: "Ctrl + I", custom: ""},
    {command: "Cut Time", default: "Ctrl + Shift + X", custom: ""},
    {command: "Paste Time", default: "Ctrl + Shift + V", custom: ""},
    {command: "Duplicate Time", default: "Ctrl + Shift + D", custom: ""},
    {command: "Delete Time", default: "Ctrl + Shift + Delete", custom: ""},
    {command: "Fold/Unfold Selected Tracks (alt)", default: "Left/Right arrow keys", custom: ""},
    {command: "Unfold All Tracks", default: "Alt + U", custom: ""},
    {command: "Adjust Height of Selected Tracks/Clips", default: "Alt + (+) / Alt + (-)", custom: ""},
    {command: "Scroll Display Left/Right of Selection", default: "Ctrl + Alt + drag", custom: ""},
    {command: "Nudge Selection Left/Right", default: "Left/Right arrow keys", custom: ""},
    {command: "Play from Insert Marker in Selected Clip", default: "Ctrl + Space", custom: ""},
    {command: "Move Focus to Mixer", default: "Alt + Shift + M", custom: ""},
    {command: "Show Take Lanes", default: "Ctrl + Alt + U", custom: ""},
    {command: "Add Take Lane", default: "Shift + Alt + T", custom: ""},
    {command: "Duplicate Selected Take Lane", default: "Ctrl + D", custom: ""},
    {command: "Replace Main Take Clip with Next/Previous Take", default: "Ctrl + Up/Down arrow keys", custom: ""},
    {command: "Insert Audio Track", default: "Ctrl + T", custom: ""},
    {command: "Insert MIDI Track", default: "Ctrl + Shift + T", custom: ""},
    {command: "Insert Return Track", default: "Ctrl + Alt + T", custom: ""},
    {command: "Rename Selected Track", default: "Ctrl + R", custom: ""},
    {command: "Group Selected Tracks", default: "Ctrl + G", custom: ""},
    {command: "Ungroup Tracks", default: "Ctrl + Shift + G", custom: ""},
    {command: "Move Nonadjacent Tracks Without Collapsing", default: "Ctrl + Arrow keys", custom: ""},
    {command: "Freeze/Unfreeze Tracks", default: "Ctrl + Alt + Shift + F", custom: ""},
    {command: "Continue Play from Stop Point", default: "Shift + Space", custom: ""},
    {command: "Arm Recording in Arrangement View", default: "Shift + F9", custom: ""},
    {command: "Record to Session View", default: "Ctrl + Shift + F9", custom: ""},
    {command: "Turn Audio Engine On/Off", default: "Ctrl + Alt + Shift + E", custom: ""},
    {command: "Scroll Down/Up", default: "Up/Down arrow keys", custom: ""},
    {command: "Close/Open Folders", default: "Left/Right arrow keys", custom: ""},
    {command: "Preview Selected File", default: "Shift + Enter", custom: ""},
    {command: "Search in Browser", default: "Ctrl + F", custom: ""},
    {command: "Show Similar Files Using Similarity Search", default: "Ctrl + Shift + F", custom: ""},
    {command: "Insert Empty MIDI Clip", default: "Ctrl + Shigt + M", custom: ""},
    {command: "Bounce to New Track", default: "Ctrl + Alt + Shift + J", custom: ""},
    {command: "Show/Hide Return Tracks", default: "Ctrl + Alt + R", custom: ""},
    {command: "Browser History Back", default: "Ctrl + [", custom: ""},
	{command: "Browser History Forward", default: "Ctrl + ]", custom: ""},
	{command: "Edit MIDI Map", default: "Ctrl + M", custom: ""},
	{command: "Follow", default: "Shift + Alt + F", custom: ""},
	{command: "Hide Device View", default: "Ctrl + Alt + L", custom: ""},
	{command: "Move Insert Marker To Playhead", default: "Ctrl + Shift + Space", custom: ""},
	{command: "Edit Key Map", default: "Ctrl + K", custom: ""}
]

; --- Загрузка кастомных хоткеев из ini-файла ---
for idx, item in gHotkeys {
    custom := IniRead(configFile, "Hotkeys", item.command, "")
    if custom != ""
        gHotkeys[idx].custom := custom
}

; --- Функция для повторной загрузки кастомных хоткеев ---
ReloadCustomHotkeys() {
    global gHotkeys, configFile
    for idx, item in gHotkeys {
        custom := IniRead(configFile, "Hotkeys", item.command, "")
        gHotkeys[idx].custom := custom
    }
}

mainGui := Gui(, "Ableton Live Users - Live Shortcuts")
mainGui.SetFont("s10")

; --- Список поддерживаемых окон Ableton ---
gAbletonWindowList := [
    "ahk_exe Ableton Live 12 Suite.exe",
    "ahk_exe Ableton Live 12.exe",
    "ahk_exe Ableton Live 12 Trial.exe",
    "ahk_exe Ableton Live 12 Free.exe",
    "ahk_exe Ableton Live 12 Standart.exe",
    "ahk_exe Ableton Live 12 Intro.exe"
]

; --- Статус-индикатор ---
mainGui.Add("Text", "xm y10") ; отступ сверху
statusColor := "Red"
statusText := "Ableton Live window not found"
statusBars := []
statusBarsH := []
statusLabel := ""
barX := 10 ; начальный x
barY := 10 ; фиксированный y для всех палочек
barW := 2
barH := 17
barGap := 3 ; стартовый отступ между палочками
Loop 4 {
    bar := mainGui.Add("Text", Format("x{} y{} w{} h{} vstatusBar{} Background000000", barX, barY, barW, barH, A_Index), "")
    statusBars.Push(bar)
    barX += barW + (barGap)
}

UpdateStatus() ; Цвет палочек и текста сразу синхронизируется со статусом

; --- Второй блок: горизонтальные палочки ---
hBarX := barX + 1 ; отступ справа от вертикальных палочек
hBarY := barY
hBarW := 19
hBarH := 2
hBarGap := 3
Loop 4 {
    hbar := mainGui.Add("Text", Format("x{} y{} w{} h{} vstatusBarH{} Background000000", hBarX, hBarY, hBarW, hBarH, A_Index), "")
    statusBarsH.Push(hbar)
    hBarY += hBarH + (hBarGap)
}

UpdateStatus() ; Цвет палочек и текста сразу синхронизируется со статусом

statusLabel := mainGui.Add("Text", Format("x{} y{} w500 h20 vstatusLabel BackgroundTrans", hBarX + hBarW + 20, barY), statusText)
mainGui.Add("Text", "xm y+15 w700 0x10") ; горизонтальный разделитель

; --- Меню ---
mainGui.Add("Text", "xm y+0 h20", "Search by command")
searchEdit := mainGui.Add("Edit", "w350 vsearchEdit y+0")
searchEdit.OnEvent("Change", FilterList)
btnAssignedOnly := mainGui.Add("Button", "x+10 yp w160", "Assigned only")
assignedOnlyMode := false
btnAssignedOnly.OnEvent("Click", ToggleAssignedOnly)

; --- Кнопка показа только конфликтов ---
btnConfOnly := mainGui.Add("Button", "x+10 yp w160", "Conflict only")
conflictOnlyMode := false
btnConfOnly.OnEvent("Click", ToggleConflictOnly)

lv := mainGui.Add("ListView", "xm y+10 w700 r20", ["Command", "Ableton default", "Custom", "Conflict"])
lv.OnEvent("DoubleClick", EditHotkey)
; lv.OnEvent("ItemSelect", OnRowSelect) ; отключено – больше не обновляет поля при выборе строки
lv.ModifyCol(1, 300) ; Команда — шире
lv.ModifyCol(2, 140) ; Дефолтное
lv.ModifyCol(3, 140) ; Кастомное
lv.ModifyCol(4, 60)  ; Conflict

; Кнопки управления внизу окна
mainGui.Add("Text", "y+0") ; отступ перед нижними кнопками
btnAdd := mainGui.Add("Button", "x10 y+0 w150", "➕ Add Shortcut")
btnAdd.Opt("Background00CFFF") ; blue
btnAdd.OnEvent("Click", AddHotkey)
btnDel := mainGui.Add("Button", "x+10 w150", "🗑 Delete Shortcut")
btnDel.Opt("BackgroundFFA040") ; orange
btnDel.OnEvent("Click", DeleteHotkey)
btnDelAll := mainGui.Add("Button", "x+10 w120", "❌ Reset All")
btnDelAll.Opt("BackgroundFF3333") ; red
btnDelAll.OnEvent("Click", DeleteAllHotkeys)

; --- Группа для проверки хоткеев ---
gbCheck := mainGui.Add("GroupBox", "xm y+10 w700 h70", "Shortcut check")
lastCustomEdit := mainGui.Add("Edit", "x20 y+0 w230 ReadOnly vlastCustomEdit", "")
arrow := mainGui.Add("Text", "x+10 yp+0 w20 Center", "→")
lastDefaultEdit := mainGui.Add("Edit", "x+0 y+0 w230 ReadOnly vlastDefaultEdit", "")
btnCheckCapture := mainGui.Add("Button", "x+10 yp-3 w120", "Capture")
btnCheckCapture.OnEvent("Click", StartCheckCapture)



; --- Кнопка настроек в правом верхнем углу ---
btnSettings := mainGui.Add("Button", "x500 y10 w100 h25", "Settings")
btnSettings.OnEvent("Click", ShowSettings)

; --- Кнопка About ---
btnAbout := mainGui.Add("Button", "x+10 yp w100 h25", "About")
btnAbout.OnEvent("Click", ShowAbout)

; --- Глобальные переменные для трея и настроек ---
g_TrayMenu := ""
g_HideOnClose := false
g_StartMinimized := false

; --- Загрузка настроек трея из INI ---
LoadTraySettings() {
    global g_HideOnClose, g_StartMinimized, configFile
    g_HideOnClose := IniRead(configFile, "Settings", "HideOnClose", "0") = "1"
    g_StartMinimized := IniRead(configFile, "Settings", "StartMinimized", "0") = "1"
}
LoadTraySettings()

; --- Создание меню трея ---
CreateTrayMenu() {
    A_TrayMenu.Delete() ; очистить все пункты
    A_TrayMenu.Add("Show/Hide window", (*) => ToggleMainWindow())
    A_TrayMenu.Add()
    A_TrayMenu.Add("Reload", (*) => Reload())
    A_TrayMenu.Add()
    A_TrayMenu.Add("Exit", (*) => ExitApp())
    A_TrayMenu.SetIcon("Exit", "app.ico")
}

ToggleMainWindow() {
    global mainGui
    if mainGui.Visible
        mainGui.Hide()
    else
        mainGui.Show()
}

; --- Переопределяем обработчик закрытия окна ---
mainGui.OnEvent("Close", (*) => (
    g_HideOnClose
        ? mainGui.Hide()
        : ExitApp()
))

; --- Показываем окно или скрываем при запуске ---
if g_StartMinimized {
    mainGui.Hide()
} else {
    mainGui.Show()
}

CreateTrayMenu()

ShowSettings(*) {
    global mainGui, g_HideOnClose, g_StartMinimized
    settingsGui := Gui("+Owner" mainGui.Hwnd, "Settings")
    settingsGui.SetFont("s10")
    isAutoStart := IsAutoStartEnabled()
    cbAutoStart := settingsGui.Add("CheckBox", "w320 vcbAutoStart", "Run with Windows")
    cbAutoStart.Value := isAutoStart
    cbHideOnClose := settingsGui.Add("CheckBox", "w320 vcbHideOnClose", "Hide to tray on close")
    cbHideOnClose.Value := g_HideOnClose
    cbStartMin := settingsGui.Add("CheckBox", "w320 vcbStartMinimized", "Start minimized to tray")
    cbStartMin.Value := g_StartMinimized
    btnSave := settingsGui.Add("Button", "w100 y+10", "Save")
    btnSave.OnEvent("Click", (*) => SaveSettings(settingsGui, cbAutoStart, cbHideOnClose, cbStartMin))
    settingsGui.Show("AutoSize Center")
}

SaveSettings(settingsGui, cbAutoStart, cbHideOnClose, cbStartMin) {
    startupLnk := A_Startup "\\AbletonHotkeyManager.lnk"
    scriptPath := A_ScriptFullPath
    autoStart := cbAutoStart.Value ? 1 : 0
    hideOnClose := cbHideOnClose.Value ? 1 : 0
    startMin := cbStartMin.Value ? 1 : 0
    IniWrite(autoStart, configFile, "Settings", "AutoStart")
    IniWrite(hideOnClose, configFile, "Settings", "HideOnClose")
    IniWrite(startMin, configFile, "Settings", "StartMinimized")
    if autoStart {
        FileCreateShortcut(scriptPath, startupLnk)
    } else {
        if FileExist(startupLnk)
            FileDelete(startupLnk)
    }
    settingsGui.Destroy()
    LoadTraySettings()
}

ShowAbout(*) {
    aboutGui := Gui("+Owner" mainGui.Hwnd, "About")
    aboutGui.SetFont("s10")
    aboutGui.Add("Text", "xm ym", "Ableton Live Shortcuts V 0.1")
    aboutGui.Add("Text", "xm", "2025")
    ; --- Ссылка внизу ---
link := aboutGui.Add("Text", "xm Center cBlue", "by @abletonliveusers")
link.SetFont("underline")
link.OnEvent("Click", (*) => Run("https://t.me/abletonliveusers"))

UpdateStatus()
    aboutGui.Add("Text", "xm", "Created using AI")
    aboutGui.Add("Button", "xm y+10 w320", "Close").OnEvent("Click", (*) => aboutGui.Destroy())
    aboutGui.Show("AutoSize Center")
}

NormalizeKey(key) {
    static keyMap := Map(
        "esc", "esc", "escape", "esc",
        "del", "delete", "delete", "delete",
        "pgup", "pgup", "pageup", "pgup",
        "pgdn", "pgdn", "pagedown", "pgdn",
        "ins", "insert", "insert", "insert",
        "bs", "backspace", "backspace", "backspace",
        "tab", "tab", "enter", "enter",
        "space", "space", "win", "win",
        "appskey", "appskey", "appkey", "appskey",
        "printscreen", "printscreen", "prtsc", "printscreen",
        "scrolllock", "scrolllock", "pause", "pause",
        "capslock", "capslock", "numlock", "numlock",
        "+", "+", "^", "^", "!", "!", "#", "#"
    )
    key := StrLower(key)
    return keyMap.Has(key) ? keyMap[key] : key
}

NormalizeHotkey(hk) {
    if !hk
        return ""
    hk := StrLower(Trim(RegExReplace(hk, "\\s+", "")))
    mods := []
    keys := []
    parts := StrSplit(hk, "+")
    for i, part in parts {
        p := Trim(part)
        if p = "ctrl" || p = "control" || p = "^"
            mods.Push("ctrl")
        else if p = "alt" || p = "!"
            mods.Push("alt")
        else if p = "shift" || p = "+"
            mods.Push("shift")
        else if p = "win" || p = "#"
            mods.Push("win")
        else if p = "appskey" || p = "appkey"
            mods.Push("appskey")
        else if p = "" {
            continue
        } else if p = "plus" || p = "+" || p = "{+}" {
            keys.Push("+")
        } else {
            keys.Push(NormalizeKey(p))
        }
    }
    uniqueMods := RemoveDuplicates(mods)
    if keys.Length = 0
        return ""
    if keys.Length > 1
        return "__MULTIKEY_ERROR__"
    if !IsValidMainKey(keys[1])
        return "__INVALID_KEY__"
    return (uniqueMods.Length ? ArrayJoin(uniqueMods, "+") . "+" : "") . keys[1]
}

ArrayJoin(arr, sep := "+") {
    out := ""
    for i, v in arr
        out .= (i > 1 ? sep : "") v
    return out
}

IsSwap(item, other) {
    return item.custom && other.custom
        && NormalizeHotkey(item.custom) = NormalizeHotkey(other.default)
        && NormalizeHotkey(other.custom) = NormalizeHotkey(item.default)
}

GetEffectiveHotkey(item) {
    if item.custom && item.custom != ""
        return NormalizeHotkey(item.custom)
    return NormalizeHotkey(item.default)
}

ShowList(filtered := false) {
    lv.Delete()
    arr := filtered ? filtered : gHotkeys
    BuildHotkeyMaps()
    for idx, item in arr {
        conflict := ""
        if item.custom && item.custom != "" {
            hk := NormalizeHotkey(item.custom)
            if (gCustomMap.Has(hk) && gCustomMap[hk] > 1) || gDefaultMap.Has(hk)
                conflict := "⚠️"
        } else {
            hk := NormalizeHotkey(item.default)
            if gCustomMap.Has(hk)
                conflict := "⚠️"
        }
        lv.Add(, item.command, item.default, item.custom, conflict)
    }
}

FilterList(*) {
    val := searchEdit.Value
    BuildHotkeyMaps()
    if conflictOnlyMode {
        filtered := []
        for item in gHotkeys {
            if itemHasConflict(item)
                if (!val || InStr(item.command, val, false))
                    filtered.Push(item)
        }
        ShowList(filtered)
        return
    }
    if assignedOnlyMode {
        filtered := []
        for item in gHotkeys {
            if item.custom && item.custom != "" && (!val || InStr(item.command, val, false))
                filtered.Push(item)
        }
        ShowList(filtered)
        return
    }
    if !val {
        ShowList()
        return
    }
    filtered := []
    for item in gHotkeys {
        if InStr(item.command, val, false)
            filtered.Push(item)
    }
    ShowList(filtered)
}

ToggleAssignedOnly(*) {
    global assignedOnlyMode
    assignedOnlyMode := !assignedOnlyMode
    btnAssignedOnly.Text := assignedOnlyMode ? "Show all" : "Assigned only"
    FilterList()
}

ToggleConflictOnly(*) {
    global conflictOnlyMode
    conflictOnlyMode := !conflictOnlyMode
    btnConfOnly.Text := conflictOnlyMode ? "Show all" : "Conflict only"
    FilterList()
}

OnRowSelect(*) {
    row := lv.GetNext(0, "F")
    if !row
        return
    cust := lv.GetText(row, 3)
    def := lv.GetText(row, 2)
    UpdateHotkeyCheck(cust, def)
}

ShowList()

; После показа окна — корректируем координаты
Sleep 50 ; небольшой таймаут для корректного расчёта позиций
{
    x := y := w := h := 0
    gbCheck.GetPos(&x, &y, &w, &h)
    lastCustomEdit.Move(x + 15, y + 30)
    arrow.Move(x + 258, y + 34)
    lastDefaultEdit.Move(x + 290, y + 30)
    ; Автоматически уменьшаем высоту окна на 30 пикселей
    mainGui.GetPos(&gx, &gy, &gw, &gh)
    mainGui.Move(gx, gy, gw, gh - 30)
    btnCheckCapture.GetPos(&gx, &gy, &gw, &gh)
    btnCheckCapture.Move(gx + 40, gy - 55, gw, gh)
}

; --- Остальной код (AddHotkey, EditHotkey, DeleteHotkey, RegisterAllCustomHotkeys и т.д.) должен быть ниже, как реализовано ранее ---

; --- Регистрация кастомных хоткеев ---
registeredHotkeys := []
RegisterAllCustomHotkeys()

RegisterAllCustomHotkeys() {
    global gHotkeys, registeredHotkeys
    for hk in registeredHotkeys
        try Hotkey(hk, "Off")
    registeredHotkeys := []

    HotIf(AbletonWinActive) ; активируем хоткеи только когда окно Ableton активно
    for item in gHotkeys {
        if item.custom && item.custom != "" {
            ahkHotkey := ToAhkHotkey(item.custom)
            if ahkHotkey {
                def := item.default
                hkHook := InStr(ahkHotkey, "$") ? ahkHotkey : "$" ahkHotkey
                Hotkey(hkHook, MakeHotkeyHandler(item.custom, def), "On")
                registeredHotkeys.Push(hkHook)
            }
        }
    }
    HotIf() ; сброс условия
}

SendDefaultHotkey(def) {
    ahkDef := ToAhkHotkey(def)
    if ahkDef {
        if (RegExMatch(ahkDef, "^{F\\d+}$")) {
            SendInput(ahkDef)
        } else {
            ; Сбрасываем текущие Ctrl/Shift/Alt/Win, чтобы не влияли на отправку
            SendInput("{Ctrl up}{Shift up}{Alt up}{Win up}")
            SendInput(ahkDef)
        }
    }
}

global g_SendingHotkey := false

MakeHotkeyHandler(custom, def) {
    return (*) => (
        HandleCustomHotkey(custom, def)
    )
}

HandleCustomHotkey(custom, def) {
    global g_SendingHotkey, registeredHotkeys
    if g_SendingHotkey
        return

    g_SendingHotkey := true

    defAhk := ToAhkHotkey(def)
    if defAhk {
        defHook := InStr(defAhk, "$") ? defAhk : "$" defAhk
        for _, hk in registeredHotkeys {
            if (hk = defHook)
                 Hotkey(hk, "Off")
        }
    }

    SendDefaultHotkey(def)

    if defAhk {
        defHook := InStr(defAhk, "$") ? defAhk : "$" defAhk
        for _, hk in registeredHotkeys {
            if (hk = defHook)
                 Hotkey(hk, "On")
        }
    }

    g_SendingHotkey := false
}

; Преобразование строки хоткея в формат AHK2
ToAhkHotkey(str) {
    if !str
        return ""

    ; --- Определяем модификаторы ---
    hasCtrl := false, hasAlt := false, hasShift := false, hasWin := false
    key := ""

    for _, part in StrSplit(str, ["+", " "]) {
        p := Trim(part)
        if !p
            continue
        lp := StrLower(p)

        if (lp = "ctrl" || lp = "control" || lp = "^") {
            hasCtrl := true
            continue
        }
        if (lp = "alt" || lp = "!") {
            hasAlt := true
            continue
        }
        if (lp = "shift" || lp = "+") {
            hasShift := true
            continue
        }
        if (lp = "win" || lp = "#") {
            hasWin := true
            continue
        }

        ; --- Основная клавиша ---
        if (lp ~= "^f\\d{1,2}$") {
            key := "{" p "}"
        } else if (lp = "tab") {
            key := "{Tab}"
        } else if (lp = "space") {
            key := "{Space}"
        } else if (lp = "enter") {
            key := "{Enter}"
        } else if (lp = "esc" || lp = "escape") {
            key := "{Esc}"
        } else if (lp = "delete") {
            key := "{Delete}"
        } else if (lp = "home") {
            key := "{Home}"
        } else if (lp = "end") {
            key := "{End}"
        } else if (lp = "pgup") {
            key := "{PgUp}"
        } else if (lp = "pgdn") {
            key := "{PgDn}"
        } else if (lp = "up") {
            key := "{Up}"
        } else if (lp = "down") {
            key := "{Down}"
        } else if (lp = "left") {
            key := "{Left}"
        } else if (lp = "right") {
            key := "{Right}"
        } else if (StrLen(p) = 1) {
            key := StrLower(p)
        }
    }

    ; Если основная клавиша не определена, вернуть ""
    if !key
        return ""

    ; --- Формируем строку хоткея в каноническом порядке: ^ ! + # ---
    prefix := ""
    if hasCtrl
        prefix .= "^"
    if hasAlt
        prefix .= "!"
    if hasShift
        prefix .= "+"
    if hasWin
        prefix .= "#"

    return prefix . key
}

; --- Глобальные переменные для захвата хоткея ---
global g_Capturing := false
global g_EditHotkey := ""
global g_Captured := ""

; --- Глобальные обработчики для захвата хоткея ---
WM_KEYDOWN(wParam, lParam, msg, hwnd) {
    global g_Capturing, g_EditHotkey, g_Captured
    if !g_Capturing
        return
    mods := []
    if GetKeyState("Ctrl", "P")
        mods.Push("Ctrl")
    if GetKeyState("Shift", "P")
        mods.Push("Shift")
    if GetKeyState("Alt", "P")
        mods.Push("Alt")
    key := GetKeyName(Format("vk{:x}", wParam))
    if (key ~= "^[A-Za-z]$" && GetKeyState("Shift", "P") && !mods.Has("Shift"))
        mods.Push("Shift")
    if IsModKey(key)
        return
    uniqueMods := RemoveDuplicates(mods)
    if (key != "") {
        uniqueMods := RemoveDuplicates(mods)
    }
    if (key = "Tab")
        key := "Tab"
    else if (key = "Space")
        key := "Space"
    g_Captured := (uniqueMods.Length ? ArrayJoin(uniqueMods, " + ") . " + " : "") . key
    g_EditHotkey.Value := g_Captured
    ; Обновляем второе поле проверки соответствий
    HotkeyCheckDisplay(g_Captured)
    g_Capturing := false
    ; Отключаем временные обработчики (MaxThreads:=0)
    OnMessage(0x100, WM_KEYDOWN, 0)      ; WM_KEYDOWN
    OnMessage(0x101, WM_KEYUP, 0)        ; WM_KEYUP
    OnMessage(0x104, WM_KEYDOWN, 0)      ; WM_SYSKEYDOWN (Alt)
    OnMessage(0x105, WM_KEYUP, 0)        ; WM_SYSKEYUP   (Alt)
}
WM_KEYUP(*) {
    ; Не используется, но нужен для снятия OnMessage
}

IsModKey(key) {
    static mods := ["Ctrl", "Control", "Shift", "Alt"]
    for _, v in mods
        if (StrLower(key) = v)
            return true
    return false
}

AddHotkey(*) {
    static keyNames := Map("Ctrl", "Ctrl", "Shift", "Shift", "Alt", "Alt", "Tab", "Tab", "Space", "Space")
    addGui := Gui(, "Add Shortcut")
    addGui.SetFont("s10")
    addGui.AddText(, "Command:")
    cbCmd := addGui.Add("ComboBox", "w300 vcmdName")
    cmds := []
    for item in gHotkeys
        cmds.Push(item.command)
    cbCmd.Add(cmds)
    cbCmd.Choose(1)
    addGui.AddText(, "Shortcut combination:")
    editHotkey := addGui.Add("Edit", "w300 vcustomHotkey ReadOnly")
    btnCapture := addGui.Add("Button", "y+10 w300", "Capture combination")
    btnSave := addGui.Add("Button", "x13 y+10 w145", "Save")
    btnCancel := addGui.Add("Button", "x+10 yp w144", "Cancel")
    addGui.AddText("xm y+0", "")
    captured := ""
    capturing := false

    btnCapture.OnEvent("Click", CaptureHotkey)
    btnSave.OnEvent("Click", SaveHotkey)
    btnCancel.OnEvent("Click", (*) => addGui.Destroy())

    addGui.Show()

    CaptureHotkey(*) {
        global g_Capturing, g_EditHotkey, g_Captured
        g_Capturing := true
        g_EditHotkey := editHotkey
        g_Captured := ""
        editHotkey.Value := "Press the combination..."
        OnMessage(0x100, WM_KEYDOWN)
        OnMessage(0x101, WM_KEYUP)
        OnMessage(0x104, WM_KEYDOWN) ; WM_SYSKEYDOWN for Alt
        OnMessage(0x105, WM_KEYUP)   ; WM_SYSKEYUP for Alt
    }
    SaveHotkey(*) {
        cmd := cbCmd.Text
        hotkey := editHotkey.Value
        if !cmd || !hotkey || hotkey = "Press the combination..." {
            MsgBox "Select a command and enter a key combination!"
            return
        }
        normCustom := NormalizeHotkey(hotkey)
        if (normCustom = "") {
            MsgBox "Ошибка: Пустой хоткей!"
            editHotkey.Value := ""
            return
        }
        if (normCustom = "__MULTIKEY_ERROR__") {
            MsgBox "Ошибка: В хоткее может быть только одна основная клавиша!"
            editHotkey.Value := ""
            return
        }
        if (normCustom = "__INVALID_KEY__") {
            MsgBox "Ошибка: Основная клавиша недопустима для хоткея! Используйте букву, цифру, F1–F24 или спецклавишу."
            editHotkey.Value := ""
            return
        }
        for _, item in gHotkeys {
            if (item.command = cmd && item.default && item.default != "") {
                normDefault := NormalizeHotkey(item.default)
                if (normDefault = normCustom) {
                    MsgBox "Custom shortcut cannot be the same as the default shortcut for this command!"
                    editHotkey.Value := ""
                    return
                }
            }
        }
        for _, item in gHotkeys {
            if (item.custom && item.custom != "" && NormalizeHotkey(item.custom) = NormalizeHotkey(hotkey) && StrLower(item.command) != StrLower(cmd)) {
                MsgBox "This shortcut is already assigned to another command! Please choose a unique combination."
                editHotkey.Value := ""
                return
            }
        }
        IniWrite(hotkey, configFile, "Hotkeys", cmd)
        ReloadCustomHotkeys()
        ShowList()
        addGui.Destroy()
        RegisterAllCustomHotkeys()
    }
}

DeleteHotkey(*) {
    row := lv.GetNext(0, "F")
    if !row {
        MsgBox "Select a row to delete!"
        return
    }
    cmd := lv.GetText(row, 1)
    IniDelete(configFile, "Hotkeys", cmd)
    for idx, item in gHotkeys {
        if item.command = cmd {
            gHotkeys[idx].custom := ""
            break
        }
    }
    ReloadCustomHotkeys()
    ShowList()
    RegisterAllCustomHotkeys()
}

EditHotkey(*) {
    row := lv.GetNext(0, "F")
    if !row
        return
    cmd := lv.GetText(row, 1)
    custom := lv.GetText(row, 3)
    ShowHotkeyEditor(cmd, custom)
}

ShowHotkeyEditor(cmd, custom) {
    static keyNames := Map("Ctrl", "Ctrl", "Shift", "Shift", "Alt", "Alt", "Tab", "Tab", "Space", "Space")
    addGui := Gui(, "Edit Shortcut")
    addGui.SetFont("s10")
    addGui.AddText(, "Command:")
    txtCmd := addGui.Add("Edit", "w300 ReadOnly", cmd)
    addGui.AddText(, "Shortcut combination:")
    editHotkey := addGui.Add("Edit", "w300 vcustomHotkey ReadOnly", custom)
    btnCapture := addGui.Add("Button", "y+10 w300", "Capture combination")
    btnSave := addGui.Add("Button", "x13 y+10 w145", "Save")
    btnCancel := addGui.Add("Button", "x+10 yp w144", "Cancel")
    addGui.AddText("xm y+0", "")
    captured := custom
    capturing := false

    btnCapture.OnEvent("Click", CaptureHotkey)
    btnSave.OnEvent("Click", SaveHotkey)
    btnCancel.OnEvent("Click", (*) => addGui.Destroy())

    addGui.Show()

    CaptureHotkey(*) {
        global g_Capturing, g_EditHotkey, g_Captured
        g_Capturing := true
        g_EditHotkey := editHotkey
        g_Captured := custom
        editHotkey.Value := "Press the combination..."
        OnMessage(0x100, WM_KEYDOWN)
        OnMessage(0x101, WM_KEYUP)
        OnMessage(0x104, WM_KEYDOWN) ; WM_SYSKEYDOWN for Alt
        OnMessage(0x105, WM_KEYUP)   ; WM_SYSKEYUP for Alt
    }
    SaveHotkey(*) {
        hotkey := editHotkey.Value
        if !hotkey || hotkey = "Press the combination..." {
            MsgBox "Enter a key combination!"
            return
        }
        normCustom := NormalizeHotkey(hotkey)
        if (normCustom = "") {
            MsgBox "Ошибка: Пустой хоткей!"
            editHotkey.Value := ""
            return
        }
        if (normCustom = "__MULTIKEY_ERROR__") {
            MsgBox "Ошибка: В хоткее может быть только одна основная клавиша!"
            editHotkey.Value := ""
            return
        }
        if (normCustom = "__INVALID_KEY__") {
            MsgBox "Ошибка: Основная клавиша недопустима для хоткея! Используйте букву, цифру, F1–F24 или спецклавишу."
            editHotkey.Value := ""
            return
        }
        for _, item in gHotkeys {
            if (item.command = cmd && item.default && item.default != "") {
                normDefault := NormalizeHotkey(item.default)
                if (normDefault = normCustom) {
                    MsgBox "Custom shortcut cannot be the same as the default shortcut for this command!"
                    editHotkey.Value := ""
                    return
                }
            }
        }
        for _, item in gHotkeys {
            if (item.custom && item.custom != "" && NormalizeHotkey(item.custom) = NormalizeHotkey(hotkey) && StrLower(item.command) != StrLower(cmd)) {
                MsgBox "This shortcut is already assigned to another command! Please choose a unique combination."
                editHotkey.Value := ""
                return
            }
        }
        IniWrite(hotkey, configFile, "Hotkeys", cmd)
        ReloadCustomHotkeys()
        ShowList()
        RegisterAllCustomHotkeys()
        addGui.Destroy()
    }
}

; --- Для обновления этих полей ---
UpdateHotkeyCheck(custom, def) {
    global lastCustomEdit, lastDefaultEdit
    lastCustomEdit.Value := custom
    lastDefaultEdit.Value := def
}

DeleteAllHotkeys(*) {
    if MsgBox("Do you really want to delete all custom hotkeys?", "Confirmation", "OKCancel Icon! ") = "OK" {
        global gHotkeys, lv
        for idx, item in gHotkeys {
            gHotkeys[idx].custom := ""
        }
        IniDelete(configFile, "Hotkeys")
        ReloadCustomHotkeys()
        ShowList()
        RegisterAllCustomHotkeys()
    }
}

UpdateStatus() {
    global statusBars, statusLabel, statusColor, statusText, gAbletonWindowList
    hwnd := ""
    for wnd in gAbletonWindowList {
        hwnd := WinExist(wnd)
        if hwnd
            break
    }
    if hwnd {
        statusColor := "0x00C000" ; зелёный
        statusText := "Ableton Live window found — shortcuts are working"
    } else {
        statusColor := "Red"
        statusText := "Ableton Live window not found"
    }
    if IsObject(statusLabel) {
        statusLabel.Text := statusText
        statusLabel.SetFont("c" statusColor " s10")
    }
}
SetTimer(UpdateStatus, 2000)
UpdateStatus()

IsValidMainKey(key) {
    if (key ~= "^[a-z0-9]$")
        return true
    if (key ~= "^f([1-9]|1[0-9]|2[0-4])$")
        return true
    valid := ["enter","tab","esc","escape","delete","home","end","pgup","pgdn","up","down","left","right","space","appskey","appkey","plus","-","[","]",",",".","/","\\"]
    for _, v in valid
        if (key = v)
            return true
    return false
}

RemoveDuplicates(arr) {
    ; Возвращает список модификаторов без дубликатов
    ordered := ["ctrl", "alt", "shift", "win", "appskey"]
    out := []
    for _, mod in ordered {
        for _, v in arr {
            if (StrLower(v) = mod) {
                out.Push(mod)
                break
            }
        }
    }
    return out
}

itemHasConflict(item) {
    hk := item.custom && item.custom != "" ? NormalizeHotkey(item.custom) : NormalizeHotkey(item.default)
    if hk = "" || hk = "__MULTIKEY_ERROR__" || hk = "__INVALID_KEY__"
        return false
    global gCustomMap, gDefaultMap
    if item.custom && item.custom != "" {
        return (gCustomMap.Has(hk) && gCustomMap[hk] > 1) || gDefaultMap.Has(hk)
    } else {
        return gCustomMap.Has(hk)
    }
}

AbletonWinActive(*) {
    global gAbletonWindowList
    for wnd in gAbletonWindowList {
        if WinActive(wnd)
            return true
    }
    return false
}

; --- Глобальные карты задействованных хоткеев ---
gCustomMap := Map()
gDefaultMap := Map()

BuildHotkeyMaps() {
    global gHotkeys, gCustomMap, gDefaultMap
    gCustomMap := Map()
    gDefaultMap := Map()
    for _, it in gHotkeys {
        if it.custom && it.custom != "" {
            hk := NormalizeHotkey(it.custom)
            if hk = "" || hk = "__MULTIKEY_ERROR__" || hk = "__INVALID_KEY__"
                continue
            gCustomMap[hk] := gCustomMap.Has(hk) ? gCustomMap[hk] + 1 : 1
        } else {
            hk := NormalizeHotkey(it.default)
            if hk = "" || hk = "__MULTIKEY_ERROR__" || hk = "__INVALID_KEY__"
                continue
            gDefaultMap[hk] := gDefaultMap.Has(hk) ? gDefaultMap[hk] + 1 : 1
        }
    }
}

StartCheckCapture(*) {
    global g_Capturing, g_EditHotkey, g_Captured, lastCustomEdit
    g_Capturing := true
    g_EditHotkey := lastCustomEdit ; сюда будем писать пойманное
    g_Captured := ""
    lastCustomEdit.Value := "Press the combination..."
    OnMessage(0x100, WM_KEYDOWN)
    OnMessage(0x101, WM_KEYUP)
    OnMessage(0x104, WM_KEYDOWN)
    OnMessage(0x105, WM_KEYUP)
}

HotkeyCheckDisplay(hk) {
    global gHotkeys, lastDefaultEdit
    norm := NormalizeHotkey(hk)
    if norm = "" || InStr(norm, "__") {
        lastDefaultEdit.Value := "Not found"
        return
    }

    ; Ищем, является ли введённый хоткей кастомным и показываем его дефолт
    for item in gHotkeys {
        if item.custom && item.custom != "" && NormalizeHotkey(item.custom) = norm {
            lastDefaultEdit.Value := item.default
            return
        }
    }

    ; Если кастомного совпадения нет — выводим сообщение об отсутствии соответствия
    lastDefaultEdit.Value := "Нет соответствий"
}