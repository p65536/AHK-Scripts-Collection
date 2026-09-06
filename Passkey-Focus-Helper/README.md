# Passkey Focus Helper

**For installation requirements and general repository information, see the [main README](../README.md).**

---

## Overview

Passkey Focus Helper automatically brings the Windows passkey / credential dialog to the foreground when it appears.

It is intended to work around cases where the `CredentialUIBroker.exe` window opens behind other windows instead of receiving focus.

---

## Features

* Automatically detects newly displayed `CredentialUIBroker.exe` windows.
* Brings the credential dialog to the foreground.
* Uses a Windows event hook instead of polling.
* Runs quietly in the system tray.
* Supports a customizable tray icon and tooltip.
* Uses a Windows system icon by default, so no external icon file is required.

---

## Usage

Run `Passkey-Focus-Helper.ahk` and leave it running in the system tray.

When a `CredentialUIBroker.exe` window appears, the script attempts to bring it to the foreground automatically.

No interaction with the script is normally required.

---

## Configuration

The script works with its built-in default settings.

To customize the tray icon or tooltip, copy `sample-config.ahk` to `config.ahk` and edit it as needed.

See [`sample-config.ahk`](sample-config.ahk) for available options and examples.

---

## How It Works

The script registers a Windows event hook for `EVENT_OBJECT_SHOW`.

When a window is shown, it checks the owning process. If the process is `CredentialUIBroker.exe`, the window is activated and brought to the foreground.

The script does not monitor keyboard input or credential contents.
