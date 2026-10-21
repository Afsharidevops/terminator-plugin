# Terminator Plugin — Select All + Copy All

Add **Select all** and **Copy all to clipboard** entries to the right-click menu in GTK3 [Terminator](https://github.com/gnome-terminator/terminator) on Linux.

## One-command install (Ubuntu)

```bash
curl -fsSL https://raw.githubusercontent.com/Afsharidevops/terminator-plugin/main/install.sh | bash
```

> Run only after uploading this repository to `Afsharidevops/terminator-plugin` with the `main` branch. Review `install.sh` before running a remote script.

## Manual install

```bash
git clone https://github.com/Afsharidevops/terminator-plugin.git
cd terminator-plugin
bash install.sh
```

## Enable

Close **all** Terminator windows and reopen. In **Right Click → Preferences → Plugins**, enable **SelectAll** and **CopyAll**. Then right-click inside the terminal to use the new options.

## Uninstall

From a clone of the repository:

```bash
bash uninstall.sh
```

Or remove `~/.config/terminator/plugins/select_copy_all.py` and restart Terminator. Installation uses no sudo and backs up existing `selectall.py`, `copyall.py`, and `select_copy_all.py` before replacing them.

## Requirements

Terminator with GTK3/VTE plugin support; Python 3; `curl` for one-command installation.

## Limitations

The `VTE.select_all()` API may only select the visible screen or a limited part of the scrollback, depending on your Terminator/VTE version. **Full command history is not guaranteed.** For complete session logs, use `script` or capture command output to a file.

## License

GPL-2.0-only. Inspired by [egroeper/terminator-plugins](https://github.com/egroeper/terminator-plugins).
