# VS Code settings

`settings.json` and `keybindings.json` live here so they can be shared across machines. On Macs they are symlinked into `~/Library/Application Support/Code/User/`, so edits made via VS Code (or by hand) update the repo directly.

## Set up on a new machine

Back up anything already there, then symlink these files into `~/Library/Application Support/Code/User/`:

```bash
mkdir -p "$HOME/Library/Application Support/Code/User"

# Back up existing files if present:
[ -e "$HOME/Library/Application Support/Code/User/settings.json" ] && mv "$HOME/Library/Application Support/Code/User/settings.json" "$HOME/Library/Application Support/Code/User/settings.json.bak"
[ -e "$HOME/Library/Application Support/Code/User/keybindings.json" ] && mv "$HOME/Library/Application Support/Code/User/keybindings.json" "$HOME/Library/Application Support/Code/User/keybindings.json.bak"

# Symlink from the repo:
ln -s vscode-settings/settings.json "$HOME/Library/Application Support/Code/User/settings.json"
ln -s vscode-settings/keybindings.json "$HOME/Library/Application Support/Code/User/keybindings.json"
```

If you'd rather have plain copies (no symlinks), swap `ln -s` for `cp`.

Then launch VS Code and sign in.
