# VS Code settings

`settings.json` and `keybindings.json` live here so they can be shared across machines. Copy them into `~/Library/Application Support/Code/User/` on each Mac to apply.

## Set up on a new machine

Back up anything already there, then copy these files into `~/Library/Application Support/Code/User/`. Run from the repo root (the directory containing `vscode-settings/`):

```bash
mkdir -p "$HOME/Library/Application Support/Code/User"

# Back up existing files if present:
[ -e "$HOME/Library/Application Support/Code/User/settings.json" ] && mv "$HOME/Library/Application Support/Code/User/settings.json" "$HOME/Library/Application Support/Code/User/settings.json.bak"
[ -e "$HOME/Library/Application Support/Code/User/keybindings.json" ] && mv "$HOME/Library/Application Support/Code/User/keybindings.json" "$HOME/Library/Application Support/Code/User/keybindings.json.bak"

# Copy from the repo:
cp vscode-settings/settings.json "$HOME/Library/Application Support/Code/User/settings.json"
cp vscode-settings/keybindings.json "$HOME/Library/Application Support/Code/User/keybindings.json"
```

Note: with copies, edits made via VS Code only change the local file — to share them across machines, copy the updated file back into `vscode-settings/` and commit. If you'd rather have edits flow through to the repo automatically, swap `cp` for `ln -s` and use absolute paths (e.g. `"$(pwd)/vscode-settings/settings.json"`).

Then launch VS Code and sign in.
