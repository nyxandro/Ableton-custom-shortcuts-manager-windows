# Ableton Hotkey Manager

## Overview
Ableton Hotkey Manager is a lightweight AutoHotkey v2.0.2+ utility that lets you **override Ableton Live's default keyboard shortcuts with your own custom combinations** while keeping the original shortcuts one keystroke away.  
The script stays in the system tray, automatically activates when an Ableton Live 12 window is focused, and falls back to idle when Live is not running.

## Main Features
1. **Full Shortcut Database**  
   • Ships with **120 factory commands** taken from Ableton Live 12.  
   • Displays Ableton's default shortcut and an (optional) custom mapping for every command.
2. **Visual Status Indicator**  
   • Shows real-time Ableton Live detection status.  
   • Green indicator when Ableton Live is running, red when not detected.
3. **Two-way Search & Filtering**  
   • Type in the *Search by command* field to instantly filter the list.  
   • *Assigned only* toggle – show rows that already have a custom shortcut.  
   • *Conflict only* toggle – show only shortcuts that currently collide with another mapping.
4. **Enhanced Conflict Detection**  
   • Conflicts are highlighted with a ⚠️ icon.  
   • **Click on the ⚠️ icon** to see detailed conflict information in tooltip.  
   • The algorithm marks clashes between *custom ↔ custom* and *custom ↔ default* shortcuts.  
   • Duplicate modifier order is ignored (`Ctrl + Shift + A` = `Shift + Ctrl + A`).
5. **Add / Edit / Delete Shortcuts**  
   • Capture a key combination live (no manual typing required).  
   • Normalises input, blocks multi-key or invalid main keys.  
   • Enforces uniqueness – you cannot assign a combination already used by another command or by its own default shortcut.  
   • INI-based storage (`AbletonHotkeys.ini`) – portable & human-readable.
6. **Reset All**  
   • One click wipes every custom entry and reloads the default table.
7. **Shortcut Check Panel**  
   • Press *Capture* to input any key combo.  
   • If the combo exists as a custom shortcut, the panel shows the paired Ableton default.  
   • Otherwise it displays "Not found".  
   • Perfect for spotting why a certain hotkey is not firing.
8. **Smart Hotkey Forwarding**  
   • When a custom shortcut triggers, the script silently sends the original default keystroke back to Ableton.  
   • If that default is itself customised elsewhere, recursive loops are prevented.
9. **Comprehensive Ableton Window Detection**  
   • Actively monitors the following executables:
     - `Ableton Live 12 Suite.exe`
     - `Ableton Live 12.exe`
     - `Ableton Live 12 Trial.exe`
     - `Ableton Live 12 Free.exe`
     - `Ableton Live 12 Standart.exe`
     - `Ableton Live 12 Intro.exe`
   • Visual status indicator shows whether Live is found; shortcuts are only active while the window is focused.
10. **System-Tray Integration**  
    • Show/Hide main window with single tray click.  
    • Right-click menu with Reload and Exit options.  
    • Smooth window management without taskbar clutter.
11. **Startup & Behaviour Settings**  
    • *Run with Windows* – creates/removes a shortcut in *%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup*.  
    • *Hide to tray on close* – clicking × hides instead of quitting.  
    • *Start minimized to tray* – boot silently without displaying the GUI.

## Installation
1. Install **AutoHotkey v2.0.2+** from https://www.autohotkey.com.  
2. Clone or download this repository.  
3. Double-click `AbletonHotkeyManager.ahk`.  
   • First launch creates `AbletonHotkeys.ini` in the script folder.
4. Optional: open *Settings* → *Run with Windows* to enable autostart.

## File Structure
```
AbletonAHK/
├─ AbletonHotkeyManager.ahk   ; the main script
├─ AbletonHotkeys.ini         ; generated configuration
├─ app.ico                    ; tray icon
├─ Changelog.txt
└─ README.md                  ; you are here
```

## How It Works
1. **Hotkey Registration**  
   • All custom shortcuts are converted to AHK-style hotkeys.  
   • `HotIf(AbletonWinActive)` scopes them exclusively to Ableton windows.  
   • Registration is refreshed automatically after any change.
2. **Forwarding Logic**  
   • A wrapper disables the target default shortcut temporarily to avoid re-entry, sends the keystroke, then re-enables it.
3. **Conflict Algorithm**  
   • Two hash-maps (`gCustomMap`, `gDefaultMap`) index normalised strings.  
   • A shortcut is a conflict when:
     - Another custom shortcut normalises to the same string, or
     - The string is already present in the default map.
4. **Shortcut Validation**  
   • Only one main key allowed.  
   • Valid main keys: A–Z, 0–9, F1–F24, arrows, Home/End/PgUp/PgDn, etc.  
   • Special keys like Space, Tab, Enter, Backspace, Esc require modifier keys.  
   • Attempts to save invalid or duplicate combos are rejected with an explanatory message.

## User Interface Features
• **Status Indicator**: Visual indicator shows real-time connection status  
• **Interactive Conflict Tooltips**: Click ⚠️ icons to see detailed conflict information  
• **Live Key Capture**: Real-time hotkey detection for hassle-free assignment  
• **Smart Filtering**: Multiple filter modes for efficient shortcut management  
• **Tray Integration**: Minimal footprint with full tray functionality

## Contributing
Pull requests are welcome! Keep in mind all code must:
• Target AutoHotkey v2.0+, no external libraries.  
• Use One-True-Brace style and camelCase identifiers.

## License
This project is released under the MIT License. 