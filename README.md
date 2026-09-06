# AHK-Scripts-Collection

![license](https://img.shields.io/badge/license-MIT-green)
![AutoHotkey](https://img.shields.io/badge/AutoHotkey-v2-blue)

A collection of simple, single-purpose AutoHotkey v2 scripts for Windows.

---

## Scripts in This Project

| Script | Description |
| --- | --- |
| [**Passkey Focus Helper**](./Passkey-Focus-Helper/README.md) | Automatically brings the Windows passkey / credential dialog to the foreground when it appears. |

---

## Installation

1. Install [AutoHotkey v2.0 or later](https://www.autohotkey.com/) (64-bit).

2. Download the repository as a ZIP archive, or clone it:

   ```bash
   git clone https://github.com/p65536/AHK-Scripts-Collection.git
   ```

3. Run the `.ahk` file for the script you want to use.

Each script is self-contained in its own directory. See the corresponding README for script-specific usage and configuration.

---

## Updating

If the repository was cloned with Git:

```bash
git pull
```

If it was downloaded manually, replace the existing project files with the latest versions.

User-specific `config.ahk` files and custom icons are excluded from Git tracking, so local configuration can be kept separately from the distributed files.

When a script provides `sample-config.ahk`, compare your local `config.ahk` with the latest sample when new configuration options are added.

---

## Tested Environment

* Windows 11
* [AutoHotkey v2.0 or later](https://www.autohotkey.com/) (64-bit)

Windows 10 may also work, but has not been tested.

---

## License

This project is licensed under the MIT License.

## Author

* [p65536](https://github.com/p65536)
