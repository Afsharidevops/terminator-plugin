#!/usr/bin/env bash
set -euo pipefail
plugin_dir="${XDG_CONFIG_HOME:-$HOME/.config}/terminator/plugins"
file="$plugin_dir/select_copy_all.py"
if [[ -f "$file" ]]; then
  rm -- "$file"
  echo "Removed $file"
else
  echo "Plugin not installed."
fi
echo 'Restart Terminator to finish uninstalling.'
echo 'Any backup-select-copy-all-* directories were left untouched.'
