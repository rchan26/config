# Claude Code settings

`settings.json` and `statusline-command.sh` live here so they can be
shared across machines. On this machine they are symlinked into
`~/.claude/`, so edits made via Claude Code (or by hand) update the
repo directly.

## Set up on a new machine

Back up anything already there, then symlink these files into `~/.claude/`:

```bash
mkdir -p ~/.claude

# Back up existing files if present
[ -e ~/.claude/settings.json ] && mv ~/.claude/settings.json ~/.claude/settings.json.bak
[ -e ~/.claude/statusline-command.sh ] && mv ~/.claude/statusline-command.sh ~/.claude/statusline-command.sh.bak

# Symlink from the repo
ln -s ~/config/claude-settings/settings.json ~/.claude/settings.json
ln -s ~/config/claude-settings/statusline-command.sh ~/.claude/statusline-command.sh
```

If you'd rather have plain copies (no symlinks), swap `ln -s` for `cp`.

Then run `claude` and authenticate — credentials are not stored in this repo.
