#Requires AutoHotkey v2.0

; --- Глобальные переменные ---
mainGui := ""
g_WindowVisible := true
configFile := "AbletonCSM.ini"

; --- Система локализации ---
g_CurrentLanguage := ""

; Словарь переводов
Lang := Map(
    "en", Map(
        ; Основное окно
        "window_title", "Ableton Live Users - Live Shortcuts",
        "status_found", "Ableton Live window found — shortcuts are working",
        "status_not_found", "Ableton Live window not found",
        
        ; Заголовки колонок
        "column_command", "Command",
        "column_key", "Key", 
        "column_custom_key", "Custom Key",
        "column_conflict", "Conflict",
        
        ; Кнопки и элементы управления
        "search_placeholder", "Search by command",
        "btn_assigned_only", "Assigned only",
        "btn_show_all", "Show all",
        "btn_conflict_only", "Conflict only", 
        "btn_add", "➕ Add",
        "btn_delete", "🗑 Delete",
        "btn_reset_all", "❌ Reset All",
        "btn_capture", "Capture",
        "btn_settings", "Settings",
        "btn_about", "About",
        
        ; Группа проверки хоткеев
        "group_shortcut_check", "Shortcut check",
        
        ; Диалоги добавления/редактирования
        "dialog_add_title", "Add",
        "dialog_edit_title", "Edit Shortcut",
        "label_command", "Command:",
        "label_shortcut", "Shortcut combination:",
        "hint_modifiers", "Supported modifiers: Ctrl, Shift, Alt",
        "placeholder_press", "Press the combination...",
        "btn_recapture", "Re-capture combination",
        "btn_save", "Save",
        "btn_cancel", "Cancel",
        
        ; Настройки
        "settings_title", "Settings",
        "settings_language", "Language:",
        "settings_autostart", "Run with Windows",
        "settings_hide_on_close", "Hide to tray on close", 
        "settings_start_minimized", "Start minimized to tray",
        
        ; О программе
        "about_title", "About",
        "about_version", "Ableton Custom Shortcuts Manager V0.3.1",
        "about_year", "2025",
        "about_link", "by @abletonliveusers - community in telegram",
        "about_created", "Created using AI",
        "btn_close", "Close",
        
        ; Сообщения об ошибках
        "error_empty_hotkey", "Error: Empty hotkey!",
        "error_multikey", "Error: A hotkey can only contain one main key!",
        "error_invalid_key", "Error: Invalid main key for hotkey! Use a letter, digit, F1-F24 or special key.",
        "error_requires_modifier", "Error: This key requires a modifier (Ctrl, Shift, or Alt) to be used as a hotkey!",
        "error_same_as_default", "Custom shortcut cannot be the same as the default shortcut for this command!",
        "error_already_assigned", "This shortcut is already assigned to another command! Please choose a unique combination.",
        "error_select_command", "Select a command and enter a key combination!",
        "error_enter_combination", "Enter a key combination!",
        "error_select_row", "Select a row to delete!",
        
        ; Подтверждения
        "confirm_delete_all", "Do you really want to delete all custom hotkeys?",
        "confirm_title", "Confirmation",
        
        ; Результаты поиска
        "no_matches", "No matches found",
        
        ; Конфликты
        "conflict_with", "Conflict with:",
        "conflict_custom", "custom",
        "conflict_default", "default"
    ),
    
    "ru", Map(
        ; Основное окно
        "window_title", "Ableton Live Users - Горячие клавиши",
        "status_found", "Окно Ableton Live найдено — горячие клавиши работают",
        "status_not_found", "Окно Ableton Live не найдено",
        
        ; Заголовки колонок
        "column_command", "Команда",
        "column_key", "Клавиша",
        "column_custom_key", "Своя клавиша", 
        "column_conflict", "Конфликт",
        
        ; Кнопки и элементы управления
        "search_placeholder", "Поиск по команде",
        "btn_assigned_only", "Только назначенные",
        "btn_show_all", "Показать все",
        "btn_conflict_only", "Только конфликты",
        "btn_add", "➕ Добавить",
        "btn_delete", "🗑 Удалить", 
        "btn_reset_all", "❌ Сбросить все",
        "btn_capture", "Захватить",
        "btn_settings", "Настройки",
        "btn_about", "О программе",
        
        ; Группа проверки хоткеев
        "group_shortcut_check", "Проверка сочетаний",
        
        ; Диалоги добавления/редактирования
        "dialog_add_title", "Добавить",
        "dialog_edit_title", "Редактировать горячую клавишу",
        "label_command", "Команда:",
        "label_shortcut", "Сочетание клавиш:",
        "hint_modifiers", "Поддерживаемые модификаторы: Ctrl, Shift, Alt",
        "placeholder_press", "Нажмите сочетание...",
        "btn_recapture", "Перезахватить сочетание",
        "btn_save", "Сохранить",
        "btn_cancel", "Отмена",
        
        ; Настройки
        "settings_title", "Настройки",
        "settings_language", "Язык:",
        "settings_autostart", "Запускать с Windows",
        "settings_hide_on_close", "Скрывать в трей при закрытии",
        "settings_start_minimized", "Запускать свернутым в трей",
        
        ; О программе
        "about_title", "О программе", 
        "about_version", "Ableton Custom Shortcuts Manager V0.3.1",
        "about_year", "2025",
        "about_link", "by @abletonliveusers - сообщество в телеграм",
        "about_created", "Создано с помощью ИИ",
        "btn_close", "Закрыть",
        
        ; Сообщения об ошибках
        "error_empty_hotkey", "Ошибка: Пустая горячая клавиша!",
        "error_multikey", "Ошибка: Горячая клавиша может содержать только одну основную клавишу!",
        "error_invalid_key", "Ошибка: Недопустимая основная клавиша! Используйте букву, цифру, F1-F24 или специальную клавишу.",
        "error_requires_modifier", "Ошибка: Эта клавиша требует модификатор (Ctrl, Shift или Alt) для использования в качестве горячей клавиши!",
        "error_same_as_default", "Пользовательская горячая клавиша не может совпадать со стандартной для этой команды!",
        "error_already_assigned", "Это сочетание уже назначено другой команде! Выберите уникальное сочетание.",
        "error_select_command", "Выберите команду и введите сочетание клавиш!",
        "error_enter_combination", "Введите сочетание клавиш!",
        "error_select_row", "Выберите строку для удаления!",
        
        ; Подтверждения
        "confirm_delete_all", "Вы действительно хотите удалить все пользовательские горячие клавиши?",
        "confirm_title", "Подтверждение",
        
        ; Результаты поиска
        "no_matches", "Совпадений не найдено",
        
        ; Конфликты
        "conflict_with", "Конфликт с:",
        "conflict_custom", "пользовательская",
        "conflict_default", "стандартная"
    )
)

; Функция получения текста по ключу
GetLangText(key) {
    global g_CurrentLanguage, Lang
    if Lang.Has(g_CurrentLanguage) && Lang[g_CurrentLanguage].Has(key) {
        return Lang[g_CurrentLanguage][key]
    }
    ; Если перевод не найден, возвращаем английский вариант
    if Lang.Has("en") && Lang["en"].Has(key) {
        return Lang["en"][key]
    }
    ; Если и английского нет, возвращаем сам ключ
    return key
}

; Загрузка языка из настроек
LoadLanguage() {
    global g_CurrentLanguage, configFile
    g_CurrentLanguage := IniRead(configFile, "Settings", "Language", "en")
    ; Проверяем, что язык поддерживается
    if !Lang.Has(g_CurrentLanguage) {
        g_CurrentLanguage := "en"
    }
}

; Сохранение языка в настройки
SaveLanguage(language) {
    global g_CurrentLanguage, configFile
    g_CurrentLanguage := language
    IniWrite(language, configFile, "Settings", "Language")
}

; Функция обновления интерфейса при смене языка
UpdateInterface() {
    global mainGui, btnAssignedOnly, btnConfOnly, assignedOnlyMode, conflictOnlyMode
    ; Обновляем заголовок окна
    mainGui.Title := GetLangText("window_title")
    ; Обновляем кнопки фильтрации
    btnAssignedOnly.Text := assignedOnlyMode ? GetLangText("btn_show_all") : GetLangText("btn_assigned_only")
    btnConfOnly.Text := conflictOnlyMode ? GetLangText("btn_show_all") : GetLangText("btn_conflict_only")
    ; Обновляем меню трея
    CreateTrayMenu()
    ; Обновляем статус
    UpdateStatus()
}

; Инициализация языка
LoadLanguage()

; --- Установка иконки в трей ---
if A_IsCompiled {
    TraySetIcon(A_ScriptFullPath) ; Используем иконку встроенную в EXE
} else {
    TraySetIcon(A_ScriptDir "\app.ico") ; Используем внешнюю иконку для разработки
}

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
    {command: "Move to Next Neighbor of Current Control", default: "Ctrl + Tab", custom: ""},
    {command: "Move to Previous Neighbor of Current Control", default: "Ctrl + Shift + Tab", custom: ""},
    {command: "New Live Set", default: "Ctrl + N", custom: ""},
    {command: "Open Live Set", default: "Ctrl + O", custom: ""},
    {command: "Save Live Set", default: "Ctrl + S", custom: ""},
    {command: "Save Live Set As...", default: "Ctrl + Shift + S", custom: ""},
    {command: "Quit Live", default: "Ctrl + Q", custom: ""},
    {command: "Group Devices / Group Selected Tracks", default: "Ctrl + G", custom: ""},
    {command: "Ungroup Devices / Ungroup Tracks", default: "Ctrl + Shift + G", custom: ""},
    {command: "Show/Hide Plug-In Window", default: "Ctrl + Alt + P", custom: ""},
    {command: "Set Start Marker", default: "Ctrl + F9", custom: ""},
    {command: "Set Loop Brace Start", default: "Ctrl + F10", custom: ""},
    {command: "Set Loop Brace End", default: "Ctrl + F11", custom: ""},
    {command: "Set End Marker", default: "Ctrl + F12", custom: ""},
    {command: "Halve/Double Loop Length", default: "Ctrl + Up / Ctrl + Down", custom: ""},
    {command: "Shorten/Lengthen Loop", default: "Ctrl + Left / Ctrl + Right", custom: ""},
    {command: "Select Material in Loop", default: "Ctrl + Shift + L", custom: ""},
    {command: "Zoom In Window", default: "Ctrl + +", custom: ""},
    {command: "Zoom Out Window", default: "Ctrl + -", custom: ""},
    {command: "Scroll Display to Follow Playback", default: "Ctrl + Shift + F", custom: ""},
    {command: "Pan Left/Right of Selection", default: "Ctrl + Alt + Left/Right", custom: ""},
    {command: "Quantize", default: "Ctrl + U", custom: ""},
    {command: "Quantize Settings", default: "Ctrl + Shift + U", custom: ""},
    {command: "Move Clip Region with Start Marker", default: "Shift + Left / Shift + Right", custom: ""},
    {command: "Insert Warp Marker", default: "Ctrl + I", custom: ""},
    {command: "Delete Warp Marker", default: "Delete", custom: ""},
    {command: "Insert Transient", default: "Ctrl + Shift + I", custom: ""},
    {command: "Select All Notes", default: "Ctrl + A", custom: ""},
    {command: "Fit Notes to Time Range", default: "Ctrl + Alt + J", custom: ""},
    {command: "Scroll Editor Vertically in Fine Increments", default: "Shift + Page Up / Shift + Page Down", custom: ""},
    {command: "Scroll Editor Horizontally", default: "Ctrl + Page Up / Ctrl + Page Down", custom: ""},
    {command: "Select Next/Previous Note", default: "Alt + Up / Alt + Down", custom: ""},
    {command: "Select Next/Previous Note in Same Key Track", default: "Alt + Left / Alt + Right", custom: ""},
    {command: "Adjust Note Selection Velocity Deviation", default: "Ctrl + Shift + Up / Ctrl + Shift + Down", custom: ""},
    {command: "Adjust Note Selection Chance", default: "Ctrl + Alt + Up / Ctrl + Alt + Down", custom: ""},
    {command: "Toggle Full-Size Clip View", default: "Ctrl + Alt + E", custom: ""},
    {command: "Group Notes (Play All)", default: "Ctrl + 6", custom: ""},
    {command: "Ungroup Notes", default: "Ctrl + Shift + 6", custom: ""},
    {command: "Apply Current MIDI Tool Settings", default: "Ctrl + Enter", custom: ""},
    {command: "Invert Note Selection", default: "Ctrl + Shift + A", custom: ""},
    {command: "Narrow Grid", default: "Ctrl + 1", custom: ""},
    {command: "Widen Grid", default: "Ctrl + 2", custom: ""},
    {command: "Triplet Grid", default: "Ctrl + 3", custom: ""},
    {command: "Snap to Grid", default: "Ctrl + 4", custom: ""},
    {command: "Fixed/Zoom-Adaptive Grid", default: "Ctrl + 5", custom: ""},
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
    {command: "Create Fade/Crossfade", default: "Ctrl + Alt + F", custom: ""},
    {command: "Delete Fades/Crossfades in Selected Clip(s)", default: "Ctrl + Alt + Backspace", custom: ""},
    {command: "Toggle Loop Brace", default: "Ctrl + L", custom: ""},
    {command: "Capture MIDI", default: "Ctrl + Shift + C", custom: ""},
    {command: "Cut Time", default: "Ctrl + Shift + X", custom: ""},
    {command: "Paste Time", default: "Ctrl + Shift + V", custom: ""},
    {command: "Duplicate Time", default: "Ctrl + Shift + D", custom: ""},
    {command: "Delete Time", default: "Ctrl + Shift + Delete", custom: ""},
    {command: "Unfold All Tracks", default: "Alt + U", custom: ""},
    {command: "Adjust Height of Selected Tracks/Clips", default: "Alt + (+) / Alt + (-)", custom: ""},
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
    {command: "Freeze/Unfreeze Tracks", default: "Ctrl + Alt + Shift + F", custom: ""},
    {command: "Continue Play from Stop Point", default: "Shift + Space", custom: ""},
    {command: "Arm Recording in Arrangement View", default: "Shift + F9", custom: ""},
    {command: "Record to Session View", default: "Ctrl + Shift + F9", custom: ""},
    {command: "Turn Audio Engine On/Off", default: "Ctrl + Alt + Shift + E", custom: ""},
    {command: "Preview Selected File", default: "Shift + Enter", custom: ""},
    {command: "Search in Browser", default: "Ctrl + F", custom: ""},
    {command: "Insert Empty MIDI Clip", default: "Ctrl + Shift + M", custom: ""},
    {command: "Bounce to New Track", default: "Ctrl + B", custom: ""},
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

mainGui := Gui(, GetLangText("window_title"))
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
statusText := GetLangText("status_not_found")
statusBars := []
statusBarsH := []
statusLabel := ""
barX := 10 ; начальный x
barY := 10 ; фиксированный y для всех палочек
barW := 2
barH := 17
barGap := 3 ; стартовый отступ между палочками
Loop 4 {
    bar := mainGui.Add("Text", Format("x{} y{} w{} h{} vstatusBar{} BackgroundB0B0B0", barX, barY, barW, barH, A_Index), "")
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
    hbar := mainGui.Add("Text", Format("x{} y{} w{} h{} vstatusBarH{} BackgroundB0B0B0", hBarX, hBarY, hBarW, hBarH, A_Index), "")
    statusBarsH.Push(hbar)
    hBarY += hBarH + (hBarGap)
}

UpdateStatus() ; Цвет палочек и текста сразу синхронизируется со статусом

statusLabel := mainGui.Add("Text", Format("x{} y{} w500 h20 vstatusLabel BackgroundTrans", hBarX + hBarW + 20, barY), statusText)
mainGui.Add("Text", "xm y+15 w700 0x10") ; горизонтальный разделитель

; --- Меню ---
mainGui.Add("Text", "xm y+0 h20", GetLangText("search_placeholder"))
searchEdit := mainGui.Add("Edit", "w350 vsearchEdit y+0")
searchEdit.OnEvent("Change", FilterList)
btnAssignedOnly := mainGui.Add("Button", "x+10 yp w160", GetLangText("btn_assigned_only"))
assignedOnlyMode := false
btnAssignedOnly.OnEvent("Click", ToggleAssignedOnly)

; --- Кнопка показа только конфликтов ---
btnConfOnly := mainGui.Add("Button", "x+10 yp w160", GetLangText("btn_conflict_only"))
conflictOnlyMode := false
btnConfOnly.OnEvent("Click", ToggleConflictOnly)

lv := mainGui.Add("ListView", "xm y+10 w700 r20", [GetLangText("column_command"), GetLangText("column_key"), GetLangText("column_custom_key"), GetLangText("column_conflict")])
lv.OnEvent("DoubleClick", EditHotkey)
lv.OnEvent("Click", OnListViewClick)
; lv.OnEvent("ItemSelect", OnRowSelect) ; отключено – больше не обновляет поля при выборе строки
lv.ModifyCol(1, 300) ; Команда — шире
lv.ModifyCol(2, 140) ; Дефолтное
lv.ModifyCol(3, 140) ; Кастомное
lv.ModifyCol(4, 60)  ; Conflict

; Кнопки управления внизу окна
mainGui.Add("Text", "y+0") ; отступ перед нижними кнопками
btnAdd := mainGui.Add("Button", "x12 y+0 w100", GetLangText("btn_add"))
btnAdd.OnEvent("Click", AddHotkey)
btnDel := mainGui.Add("Button", "x+10 w120", GetLangText("btn_delete"))
btnDel.OnEvent("Click", DeleteHotkey)
btnDelAll := mainGui.Add("Button", "x+10 w130", GetLangText("btn_reset_all"))
btnDelAll.OnEvent("Click", DeleteAllHotkeys)

; --- Группа для проверки хоткеев ---
gbCheck := mainGui.Add("GroupBox", "xm y+10 w700 h70", GetLangText("group_shortcut_check"))
lastCustomEdit := mainGui.Add("Edit", "x20 y+0 w230 ReadOnly vlastCustomEdit", "")
arrow := mainGui.Add("Text", "x+10 yp+0 w20 Center", "→")
lastDefaultEdit := mainGui.Add("Edit", "x+0 y+0 w230 ReadOnly vlastDefaultEdit", "")
btnCheckCapture := mainGui.Add("Button", "x+10 yp-3 w120", GetLangText("btn_capture"))
btnCheckCapture.OnEvent("Click", StartCheckCapture)

; --- Кнопка настроек в правом верхнем углу ---
btnSettings := mainGui.Add("Button", "x500 y10 w100 h25", GetLangText("btn_settings"))
btnSettings.OnEvent("Click", ShowSettings)

; --- Кнопка About ---
btnAbout := mainGui.Add("Button", "x+10 yp w100 h25", GetLangText("btn_about"))
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
    if g_CurrentLanguage = "ru" {
        A_TrayMenu.Add("Показать/Скрыть окно", (*) => ToggleMainWindow())
        A_TrayMenu.Add()
        A_TrayMenu.Add("Перезагрузить", (*) => Reload())
        A_TrayMenu.Add()
        A_TrayMenu.Add("Выход", (*) => ExitApp())
        A_TrayMenu.Default := "Показать/Скрыть окно"
    } else {
        A_TrayMenu.Add("Show/Hide window", (*) => ToggleMainWindow())
        A_TrayMenu.Add()
        A_TrayMenu.Add("Reload", (*) => Reload())
        A_TrayMenu.Add()
        A_TrayMenu.Add("Exit", (*) => ExitApp())
        A_TrayMenu.Default := "Show/Hide window"
    }
    A_TrayMenu.ClickCount := 1
}

ToggleMainWindow() {
    global mainGui, g_WindowVisible
    ; Дополнительная защита от ошибок
    try {
        if IsObject(mainGui) && mainGui.Hwnd {
            ; Проверяем реальное состояние окна через Windows API
            actuallyVisible := WinExist("ahk_id " . mainGui.Hwnd) && (WinGetMinMax("ahk_id " . mainGui.Hwnd) >= 0)
            
            if actuallyVisible {
                mainGui.Hide()
                g_WindowVisible := false
            } else {
                mainGui.Show()
                g_WindowVisible := true
            }
        }
    } catch as err {
        ; В случае ошибки пытаемся просто показать окно
        try {
            if IsObject(mainGui) {
                mainGui.Show()
                g_WindowVisible := true
            }
        }
    }
}

; --- Переопределяем обработчик закрытия окна ---
mainGui.OnEvent("Close", CloseHandler)

CloseHandler(*) {
    global g_HideOnClose, g_WindowVisible
    if g_HideOnClose {
        mainGui.Hide()
        g_WindowVisible := false
    } else {
        ExitApp()
    }
}

; --- Показываем окно или скрываем при запуске ---
if g_StartMinimized {
    mainGui.Hide()
    g_WindowVisible := false
} else {
    mainGui.Show()
    g_WindowVisible := true
}

CreateTrayMenu()

ShowSettings(*) {
    global mainGui, g_HideOnClose, g_StartMinimized, g_CurrentLanguage
    try {
        settingsGui := Gui("+Owner" mainGui.Hwnd, GetLangText("settings_title"))
        settingsGui.SetFont("s10")
        
        ; Выбор языка
        settingsGui.Add("Text", "xm ym", GetLangText("settings_language"))
        cbLanguage := settingsGui.Add("DropDownList", "w320 vcbLanguage")
        cbLanguage.Add(["English", "Русский"])
        cbLanguage.Value := g_CurrentLanguage = "ru" ? 2 : 1
        
        isAutoStart := IsAutoStartEnabled()
        cbAutoStart := settingsGui.Add("CheckBox", "w320 vcbAutoStart", GetLangText("settings_autostart"))
        cbAutoStart.Value := isAutoStart
        cbHideOnClose := settingsGui.Add("CheckBox", "w320 vcbHideOnClose", GetLangText("settings_hide_on_close"))
        cbHideOnClose.Value := g_HideOnClose
        cbStartMin := settingsGui.Add("CheckBox", "w320 vcbStartMinimized", GetLangText("settings_start_minimized"))
        cbStartMin.Value := g_StartMinimized
        btnSave := settingsGui.Add("Button", "w100 y+10", GetLangText("btn_save"))
        btnSave.OnEvent("Click", (*) => SaveSettings(settingsGui, cbLanguage, cbAutoStart, cbHideOnClose, cbStartMin))
        settingsGui.Show("AutoSize Center")
    } catch as err {
        ; В случае ошибки просто создаем обычное окно настроек
        settingsGui := Gui(, GetLangText("settings_title"))
        settingsGui.SetFont("s10")
        
        ; Выбор языка
        settingsGui.Add("Text", "xm ym", GetLangText("settings_language"))
        cbLanguage := settingsGui.Add("DropDownList", "w320 vcbLanguage")
        cbLanguage.Add(["English", "Русский"])
        cbLanguage.Value := g_CurrentLanguage = "ru" ? 2 : 1
        
        isAutoStart := IsAutoStartEnabled()
        cbAutoStart := settingsGui.Add("CheckBox", "w320 vcbAutoStart", GetLangText("settings_autostart"))
        cbAutoStart.Value := isAutoStart
        cbHideOnClose := settingsGui.Add("CheckBox", "w320 vcbHideOnClose", GetLangText("settings_hide_on_close"))
        cbHideOnClose.Value := g_HideOnClose
        cbStartMin := settingsGui.Add("CheckBox", "w320 vcbStartMinimized", GetLangText("settings_start_minimized"))
        cbStartMin.Value := g_StartMinimized
        btnSave := settingsGui.Add("Button", "w100 y+10", GetLangText("btn_save"))
        btnSave.OnEvent("Click", (*) => SaveSettings(settingsGui, cbLanguage, cbAutoStart, cbHideOnClose, cbStartMin))
        settingsGui.Show("AutoSize Center")
    }
}

SaveSettings(settingsGui, cbLanguage, cbAutoStart, cbHideOnClose, cbStartMin) {
    startupLnk := A_Startup "\\AbletonCustomShortcutsManager.lnk"
    scriptPath := A_ScriptFullPath
    
    ; Сохранение языка
    newLanguage := cbLanguage.Value = 2 ? "ru" : "en"
    if newLanguage != g_CurrentLanguage {
        SaveLanguage(newLanguage)
        ; Предупреждение о необходимости перезапуска
        if g_CurrentLanguage = "ru" {
            MsgBox("Для применения изменений языка требуется перезапуск приложения.", "Изменение языка", "OK Icon!")
        } else {
            MsgBox("Application restart is required to apply language changes.", "Language Change", "OK Icon!")
        }
    }
    
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
    try {
        aboutGui := Gui("+Owner" mainGui.Hwnd, GetLangText("about_title"))
        aboutGui.SetFont("s10")
        aboutGui.Add("Text", "xm ym", GetLangText("about_version"))
        aboutGui.Add("Text", "xm", GetLangText("about_year"))
        ; --- Ссылка внизу ---
        link := aboutGui.Add("Text", "xm Center cBlue", GetLangText("about_link"))
        link.SetFont("underline")
        link.OnEvent("Click", (*) => Run("https://t.me/abletonliveusers"))
        aboutGui.Add("Text", "xm", GetLangText("about_created"))
        aboutGui.Add("Button", "xm y+10 w320", GetLangText("btn_close")).OnEvent("Click", (*) => aboutGui.Destroy())
        aboutGui.Show("AutoSize Center")
    } catch as err {
        ; В случае ошибки создаем обычное окно
        aboutGui := Gui(, GetLangText("about_title"))
        aboutGui.SetFont("s10")
        aboutGui.Add("Text", "xm ym", GetLangText("about_version"))
        aboutGui.Add("Text", "xm", GetLangText("about_year"))
        ; --- Ссылка внизу ---
        link := aboutGui.Add("Text", "xm Center cBlue", GetLangText("about_link"))
        link.SetFont("underline")
        link.OnEvent("Click", (*) => Run("https://t.me/abletonliveusers"))
        aboutGui.Add("Text", "xm", GetLangText("about_created"))
        aboutGui.Add("Button", "xm y+10 w320", GetLangText("btn_close")).OnEvent("Click", (*) => aboutGui.Destroy())
        aboutGui.Show("AutoSize Center")
    }
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
        "space", "space",
        "printscreen", "printscreen", "prtsc", "printscreen",
        "scrolllock", "scrolllock", "pause", "pause",
        "capslock", "capslock", "numlock", "numlock",
        "+", "+", "^", "^", "!", "!"
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
    if RequiresModifier(keys[1]) && uniqueMods.Length = 0
        return "__REQUIRES_MODIFIER__"
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
    btnAssignedOnly.Text := assignedOnlyMode ? GetLangText("btn_show_all") : GetLangText("btn_assigned_only")
    FilterList()
}

ToggleConflictOnly(*) {
    global conflictOnlyMode
    conflictOnlyMode := !conflictOnlyMode
    btnConfOnly.Text := conflictOnlyMode ? GetLangText("btn_show_all") : GetLangText("btn_conflict_only")
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

OnListViewClick(*) {
    ; Получаем позицию клика
    CoordMode("Mouse", "Client")
    MouseGetPos(&mouseX, &mouseY)
    
    ; Получаем информацию о кликнутой ячейке
    row := lv.GetNext(0, "F")
    if !row {
        ; Если кликнули не на строку, скрываем подсказку
        ToolTip()
        return
    }
    
    ; Проверяем, кликнули ли на колонку "Conflict" (4-я колонка)
    conflictText := lv.GetText(row, 4)
    if conflictText = "⚠️" {
        ; Получаем информацию о конфликте
        cmd := lv.GetText(row, 1)
        conflictInfo := GetConflictInfo(cmd)
        if conflictInfo != "" {
            ; Показываем подсказку
            ToolTip(conflictInfo, mouseX + 20, mouseY + 20)
            ; Автоматически убираем подсказку через 8 секунд
            SetTimer(() => ToolTip(), -8000)
        }
    } else {
        ; Если кликнули не на конфликт, скрываем подсказку
        ToolTip()
    }
}

GetConflictInfo(currentCommand) {
    ; Найти текущий элемент в массиве
    currentItem := ""
    for item in gHotkeys {
        if item.command = currentCommand {
            currentItem := item
            break
        }
    }
    
    if !currentItem
        return ""
    
    conflictingCommands := []
    
    ; Определяем хоткей для проверки конфликтов
    checkHotkey := ""
    if currentItem.custom && currentItem.custom != "" {
        checkHotkey := NormalizeHotkey(currentItem.custom)
    } else {
        checkHotkey := NormalizeHotkey(currentItem.default)
    }
    
    if checkHotkey = "" || InStr(checkHotkey, "__")
        return ""
    
    ; Ищем конфликтующие команды
    BuildHotkeyMaps()
    
    for item in gHotkeys {
        if item.command = currentCommand
            continue
            
        ; Проверяем конфликт с кастомным хоткеем
        if item.custom && item.custom != "" {
            if NormalizeHotkey(item.custom) = checkHotkey {
                conflictingCommands.Push(item.command . " (" . GetLangText("conflict_custom") . ": " . item.custom . ")")
            }
        } else {
            ; Проверяем конфликт с дефолтным хоткеем
            if NormalizeHotkey(item.default) = checkHotkey {
                conflictingCommands.Push(item.command . " (" . GetLangText("conflict_default") . ": " . item.default . ")")
            }
        }
    }
    
    if conflictingCommands.Length = 0
        return ""
    
    result := GetLangText("conflict_with") . "`n"
    for _, conflictCmd in conflictingCommands {
        result .= "• " . conflictCmd . "`n"
    }
    
    return RTrim(result, "`n")
}

ShowList()

; После показа окна — корректируем координаты
Sleep 50 ; небольшой таймаут для корректного расчёта позиций
x := y := w := h := 0
gbCheck.GetPos(&x, &y, &w, &h)
lastCustomEdit.Move(x + 15, y + 30)
arrow.Move(x + 258, y + 34)
lastDefaultEdit.Move(x + 290, y + 30)
btnCheckCapture.GetPos(&gx, &gy, &gw, &gh)
btnCheckCapture.Move(gx + 40, gy - 55, gw, gh)
; Создаем ссылку внизу после всех манипуляций с позициями
linkTelegram := mainGui.Add("Text", Format("x{} y{} w{} h20 cBlue", x, y + h + 10, w), GetLangText("about_link"))
linkTelegram.SetFont("s10 underline")
linkTelegram.OnEvent("Click", (*) => Run("https://t.me/abletonliveusers"))

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
    return (*) => HandleCustomHotkey(custom, def)
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
    hasCtrl := false, hasAlt := false, hasShift := false
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
        } else if (lp = "backspace") {
            key := "{Backspace}"
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

    ; --- Формируем строку хоткея в каноническом порядке: ^ ! + ---
    prefix := ""
    if hasCtrl
        prefix .= "^"
    if hasAlt
        prefix .= "!"
    if hasShift
        prefix .= "+"

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
    else if (key = "Backspace")
        key := "Backspace"
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
    
    ; Получаем выделенную строку из таблицы
    selectedRow := lv.GetNext(0, "F")
    selectedCommand := ""
    if selectedRow {
        selectedCommand := lv.GetText(selectedRow, 1)
    }
    
    addGui := Gui(, GetLangText("dialog_add_title"))
    addGui.SetFont("s10")
    addGui.AddText(, GetLangText("label_command"))
    cbCmd := addGui.Add("ComboBox", "w300 vcmdName")
    cmds := []
    for item in gHotkeys
        cmds.Push(item.command)
    cbCmd.Add(cmds)
    
    ; Выбираем команду из выделенной строки или первую, если ничего не выделено
    if selectedCommand {
        for idx, cmd in cmds {
            if cmd = selectedCommand {
                cbCmd.Choose(idx)
                break
            }
        }
    } else {
        cbCmd.Choose(1)
    }
    addGui.AddText(, GetLangText("label_shortcut"))
    addGui.AddText("w300 c0x666666", GetLangText("hint_modifiers"))
    editHotkey := addGui.Add("Edit", "w300 vcustomHotkey ReadOnly", GetLangText("placeholder_press"))
    btnCapture := addGui.Add("Button", "y+10 w300", GetLangText("btn_recapture"))
    btnSave := addGui.Add("Button", "x13 y+10 w145", GetLangText("btn_save"))
    btnCancel := addGui.Add("Button", "x+10 yp w144", GetLangText("btn_cancel"))
    addGui.AddText("xm y+0", "")
    captured := ""
    capturing := false

    btnCapture.OnEvent("Click", CaptureHotkey)
    btnSave.OnEvent("Click", SaveHotkey)
    btnCancel.OnEvent("Click", (*) => addGui.Destroy())

    addGui.Show()
    
    ; Автоматически начинаем захват при открытии окна
    CaptureHotkey()

    CaptureHotkey(*) {
        global g_Capturing, g_EditHotkey, g_Captured
        g_Capturing := true
        g_EditHotkey := editHotkey
        g_Captured := ""
        editHotkey.Value := GetLangText("placeholder_press")
        OnMessage(0x100, WM_KEYDOWN)
        OnMessage(0x101, WM_KEYUP)
        OnMessage(0x104, WM_KEYDOWN) ; WM_SYSKEYDOWN for Alt
        OnMessage(0x105, WM_KEYUP)   ; WM_SYSKEYUP for Alt
    }
    SaveHotkey(*) {
        cmd := cbCmd.Text
        hotkey := editHotkey.Value
        if !cmd || !hotkey || hotkey = GetLangText("placeholder_press") {
            MsgBox GetLangText("error_select_command")
            return
        }
        normCustom := NormalizeHotkey(hotkey)
        if (normCustom = "") {
            MsgBox GetLangText("error_empty_hotkey")
            editHotkey.Value := ""
            return
        }
        if (normCustom = "__MULTIKEY_ERROR__") {
            MsgBox GetLangText("error_multikey")
            editHotkey.Value := ""
            return
        }
        if (normCustom = "__INVALID_KEY__") {
            MsgBox GetLangText("error_invalid_key")
            editHotkey.Value := ""
            return
        }
        if (normCustom = "__REQUIRES_MODIFIER__") {
            MsgBox GetLangText("error_requires_modifier")
            editHotkey.Value := ""
            return
        }
        for _, item in gHotkeys {
            if (item.command = cmd && item.default && item.default != "") {
                normDefault := NormalizeHotkey(item.default)
                if (normDefault = normCustom) {
                    MsgBox GetLangText("error_same_as_default")
                    editHotkey.Value := ""
                    return
                }
            }
        }
        for _, item in gHotkeys {
            if (item.custom && item.custom != "" && NormalizeHotkey(item.custom) = NormalizeHotkey(hotkey) && StrLower(item.command) != StrLower(cmd)) {
                MsgBox GetLangText("error_already_assigned")
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
        MsgBox GetLangText("error_select_row")
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
    addGui := Gui(, GetLangText("dialog_edit_title"))
    addGui.SetFont("s10")
    addGui.AddText(, GetLangText("label_command"))
    txtCmd := addGui.Add("Edit", "w300 ReadOnly", cmd)
    addGui.AddText(, GetLangText("label_shortcut"))
    addGui.AddText("w300 c0x666666", GetLangText("hint_modifiers"))
    editHotkey := addGui.Add("Edit", "w300 vcustomHotkey ReadOnly", GetLangText("placeholder_press"))
    btnCapture := addGui.Add("Button", "y+10 w300", GetLangText("btn_recapture"))
    btnSave := addGui.Add("Button", "x13 y+10 w145", GetLangText("btn_save"))
    btnCancel := addGui.Add("Button", "x+10 yp w144", GetLangText("btn_cancel"))
    addGui.AddText("xm y+0", "")
    captured := custom
    capturing := false

    btnCapture.OnEvent("Click", CaptureHotkey)
    btnSave.OnEvent("Click", SaveHotkey)
    btnCancel.OnEvent("Click", (*) => addGui.Destroy())

    addGui.Show()
    
    ; Автоматически начинаем захват при открытии окна
    CaptureHotkey()

    CaptureHotkey(*) {
        global g_Capturing, g_EditHotkey, g_Captured
        g_Capturing := true
        g_EditHotkey := editHotkey
        g_Captured := custom
        editHotkey.Value := GetLangText("placeholder_press")
        OnMessage(0x100, WM_KEYDOWN)
        OnMessage(0x101, WM_KEYUP)
        OnMessage(0x104, WM_KEYDOWN) ; WM_SYSKEYDOWN for Alt
        OnMessage(0x105, WM_KEYUP)   ; WM_SYSKEYUP for Alt
    }
    SaveHotkey(*) {
        hotkey := editHotkey.Value
        if !hotkey || hotkey = GetLangText("placeholder_press") {
            MsgBox GetLangText("error_enter_combination")
            return
        }
        normCustom := NormalizeHotkey(hotkey)
        if (normCustom = "") {
            MsgBox GetLangText("error_empty_hotkey")
            editHotkey.Value := ""
            return
        }
        if (normCustom = "__MULTIKEY_ERROR__") {
            MsgBox GetLangText("error_multikey")
            editHotkey.Value := ""
            return
        }
        if (normCustom = "__INVALID_KEY__") {
            MsgBox GetLangText("error_invalid_key")
            editHotkey.Value := ""
            return
        }
        if (normCustom = "__REQUIRES_MODIFIER__") {
            MsgBox GetLangText("error_requires_modifier")
            editHotkey.Value := ""
            return
        }
        for _, item in gHotkeys {
            if (item.command = cmd && item.default && item.default != "") {
                normDefault := NormalizeHotkey(item.default)
                if (normDefault = normCustom) {
                    MsgBox GetLangText("error_same_as_default")
                    editHotkey.Value := ""
                    return
                }
            }
        }
        for _, item in gHotkeys {
            if (item.custom && item.custom != "" && NormalizeHotkey(item.custom) = NormalizeHotkey(hotkey) && StrLower(item.command) != StrLower(cmd)) {
                MsgBox GetLangText("error_already_assigned")
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
    if MsgBox(GetLangText("confirm_delete_all"), GetLangText("confirm_title"), "OKCancel Icon! ") = "OK" {
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
        statusText := GetLangText("status_found")
    } else {
        statusColor := "Red"
        statusText := GetLangText("status_not_found")
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
    valid := ["enter","tab","esc","escape","delete","home","end","pgup","pgdn","up","down","left","right","space","plus","-","[","]",",",".","/","\\"]
    for _, v in valid
        if (key = v)
            return true
    return false
}

RequiresModifier(key) {
    ; Клавиши которые нельзя использовать без модификаторов
    requiresMod := ["space","tab","enter","esc","escape","backspace"]
    for _, v in requiresMod
        if (key = v)
            return true
    return false
}

RemoveDuplicates(arr) {
    ; Возвращает список модификаторов без дубликатов
    ordered := ["ctrl", "alt", "shift"]
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
    if hk = "" || hk = "__MULTIKEY_ERROR__" || hk = "__INVALID_KEY__" || hk = "__REQUIRES_MODIFIER__"
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
            if hk = "" || hk = "__MULTIKEY_ERROR__" || hk = "__INVALID_KEY__" || hk = "__REQUIRES_MODIFIER__"
                continue
            gCustomMap[hk] := gCustomMap.Has(hk) ? gCustomMap[hk] + 1 : 1
        } else {
            hk := NormalizeHotkey(it.default)
            if hk = "" || hk = "__MULTIKEY_ERROR__" || hk = "__INVALID_KEY__" || hk = "__REQUIRES_MODIFIER__"
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
        lastDefaultEdit.Value := GetLangText("no_matches")
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
    lastDefaultEdit.Value := ""
}

; --- Base64 декодер ---
Base64_Decode(string) {
    static base64 := "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
    padding := Mod(4 - Mod(StrLen(string), 4), 4)
    string .= padding ? SubStr("===", 1, padding) : ""
    decoded := Buffer(Ceil(StrLen(string) * 3 / 4))
    index := 1, i := 0
    Loop Parse string {
        if (i := InStr(base64, A_LoopField) - 1) >= 0
            value := value << 6 | i
        else continue
        if Mod(A_Index, 4) = 0 {
            decoded[index++] := value >> 16
            decoded[index++] := value >> 8 & 0xFF
            decoded[index++] := value & 0xFF
            value := 0
        }
    }
    if padding {
        decoded.Size -= padding
        if padding = 1 {
            decoded[index - 1] := value >> 8 & 0xFF
            decoded[index - 2] := value >> 16
        } else if padding = 2
            decoded[index - 1] := value >> 16
    }
    return decoded
}