#Requires AutoHotkey v2.0 64-bit
#SingleInstance Force
Persistent()

; ==============================================================================
;  Default Configuration Fallback
; ==============================================================================
; These defaults ensure full standalone functionality even if config.ahk is missing.
defaultTrayIconSpec  := A_WinDir . "\System32\imageres.dll,54"
trayIconSpec         := defaultTrayIconSpec
trayIconTip          := "[AHK] Passkey Focus Helper"

; Load user customizations if config.ahk exists
#Include *i config.ahk

; ------------------------------------------------------------------------------
;  Initialization
; ------------------------------------------------------------------------------
; Tray icon & tooltip initialization
ParseIconSpec(trayIconSpec, &trayIconPath, &trayIconIndex)

; Fall back to the built-in default if the configured icon source is invalid
if !FileExist(trayIconPath)
    ParseIconSpec(defaultTrayIconSpec, &trayIconPath, &trayIconIndex)

if FileExist(trayIconPath) {
    trayIconNumber := (trayIconIndex = "")
        ? 1
        : (trayIconIndex >= 0 ? trayIconIndex + 1 : trayIconIndex)
    TraySetIcon(trayIconPath, trayIconNumber, 1)
}

A_IconTip := trayIconTip

EVENT_OBJECT_SHOW        := 0x8002
OBJID_WINDOW             := 0
WINEVENT_OUTOFCONTEXT    := 0x0000
WINEVENT_SKIPOWNPROCESS  := 0x0002

winEventCallback := CallbackCreate(WinEventProc)

winEventHook := DllCall(
    "user32\SetWinEventHook",
    "UInt", EVENT_OBJECT_SHOW,
    "UInt", EVENT_OBJECT_SHOW,
    "Ptr",  0,
    "Ptr",  winEventCallback,
    "UInt", 0,
    "UInt", 0,
    "UInt", WINEVENT_OUTOFCONTEXT | WINEVENT_SKIPOWNPROCESS,
    "Ptr"
)

if !winEventHook {
    CallbackFree(winEventCallback)
    MsgBox("SetWinEventHook failed.", "Passkey Focus Helper", "Iconx")
    ExitApp()
}

OnExit(Cleanup)

; ------------------------------------------------------------------------------
;  Window Event Handler
; ------------------------------------------------------------------------------
WinEventProc(hWinEventHook, event, hWnd, idObject, idChild, idEventThread, eventTime) {
    if (idObject != OBJID_WINDOW || !hWnd)
        return

    try {
        if (WinGetProcessName(hWnd) != "CredentialUIBroker.exe")
            return

        WinActivate(hWnd)
        DllCall("user32\SetForegroundWindow", "Ptr", hWnd)
        DllCall("user32\BringWindowToTop", "Ptr", hWnd)
    }
}

; ------------------------------------------------------------------------------
;  Cleanup
; ------------------------------------------------------------------------------
Cleanup(exitReason, exitCode) {
    global winEventHook, winEventCallback

    if winEventHook {
        DllCall("user32\UnhookWinEvent", "Ptr", winEventHook)
        winEventHook := 0
    }

    if winEventCallback {
        CallbackFree(winEventCallback)
        winEventCallback := 0
    }
}

; ------------------------------------------------------------------------------
;  Custom Icon Resolver
; ------------------------------------------------------------------------------
ParseIconSpec(iconSpec, &iconPath, &iconIndex) {
    iconPath := iconSpec
    iconIndex := ""

    if RegExMatch(iconSpec, "^(.*),(-?\d+)$", &match) {
        iconPath := match[1]
        iconIndex := Integer(match[2])
    }
}
