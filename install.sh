#!/usr/bin/env bash
set -euo pipefail

# Works when run from a cloned repo OR via curl -fsSL URL | bash.
REPO_RAW_URL="${REPO_RAW_URL:-https://raw.githubusercontent.com/Afsharidevops/terminator-plugin/main}"
plugin_dir="${XDG_CONFIG_HOME:-$HOME/.config}/terminator/plugins"
target_file="$plugin_dir/select_copy_all.py"

source_file=""
if [[ -n "${BASH_SOURCE[0]:-}" && -f "${BASH_SOURCE[0]}" ]]; then
  script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
  source_file="$script_dir/plugins/select_copy_all.py"
fi
tmp_dir=''
cleanup() { if [[ -n "$tmp_dir" ]]; then rm -rf -- "$tmp_dir"; fi; }
trap cleanup EXIT

if [[ ! -f "$source_file" ]]; then
  command -v curl >/dev/null 2>&1 || { echo 'Error: curl is required.' >&2; exit 1; }
  tmp_dir="$(mktemp -d)"
  source_file="$tmp_dir/select_copy_all.py"
  echo "Downloading plugin from ${REPO_RAW_URL}/plugins/select_copy_all.py"
  curl -fLSs --retry 2 "${REPO_RAW_URL}/plugins/select_copy_all.py" -o "$source_file"
fi

python3 -m py_compile "$source_file"
mkdir -p "$plugin_dir"

# Preserve existing plugins without modifying their contents.
backup_dir=''
for old_name in selectall.py copyall.py select_copy_all.py; do
  old_file="$plugin_dir/$old_name"
  if [[ -f "$old_file" ]]; then
    if [[ -z "$backup_dir" ]]; then
      backup_dir="$plugin_dir/backup-select-copy-all-$(date +%Y%m%d-%H%M%S)-$$"
      mkdir -p "$backup_dir"
    fi
    cp -p -- "$old_file" "$backup_dir/$old_name"
    echo "Backed up: $old_name"
  fi
done

# Remove earlier standalone plugins to avoid duplicate menu items.
rm -f -- "$plugin_dir/selectall.py" "$plugin_dir/copyall.py"
install -m 644 "$source_file" "$target_file"
echo "Installed: $target_file"
if [[ -n "$backup_dir" ]]; then echo "Backups: $backup_dir"; fi
cat <<'MSG'

Done! Close all Terminator windows and reopen Terminator.
Right-click -> Preferences -> Plugins -> enable SelectAll and CopyAll.
Copy All uses VTE's select_all(), which may not include full scrollback history.
MSG
