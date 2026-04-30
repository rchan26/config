# Claude Code settings

`settings.json` and `statusline-command.sh` live here so they can be shared across machines. Copy them into `~/.claude/` on each machine to apply.

## Set up on a new machine

Back up anything already there, then copy these files into `~/.claude/`. Run from the repo root (the directory containing `claude-settings/`):

```bash
mkdir -p ~/.claude

# Back up existing files if present:
[ -e ~/.claude/settings.json ] && mv ~/.claude/settings.json ~/.claude/settings.json.bak
[ -e ~/.claude/statusline-command.sh ] && mv ~/.claude/statusline-command.sh ~/.claude/statusline-command.sh.bak

# Copy from the repo:
cp claude-settings/settings.json ~/.claude/settings.json
cp claude-settings/statusline-command.sh ~/.claude/statusline-command.sh
```

Note: with copies, edits made via Claude Code only change the local file — to share them across machines, copy the updated file back into `claude-settings/` and commit. If you'd rather have edits flow through to the repo automatically, swap `cp` for `ln -s` and use absolute paths (e.g. `"$(pwd)/claude-settings/settings.json"`).

Then run `claude` and authenticate.
