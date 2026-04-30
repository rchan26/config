#!/usr/bin/env bash
input=$(cat)

# ANSI color codes
RESET='\033[0m'
BOLD='\033[1m'
BLUE='\033[34m'
MAGENTA='\033[35m'
CYAN='\033[36m'
GREEN='\033[32m'
YELLOW='\033[33m'
RED='\033[31m'
DIM='\033[2m'

cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // ""')
folder=$(basename "$cwd")

git_branch=""
if git -C "$cwd" rev-parse --git-dir > /dev/null 2>&1; then
  git_branch=$(git -C "$cwd" --no-optional-locks symbolic-ref --short HEAD 2>/dev/null || git -C "$cwd" --no-optional-locks rev-parse --short HEAD 2>/dev/null)
fi

model=$(echo "$input" | jq -r '.model.display_name // ""')

used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

five=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
week=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')

# Returns an ANSI color code based on a percentage value (low=green, mid=yellow, high=red)
pct_color() {
  local pct=$1
  local val
  val=$(printf "%.0f" "$pct")
  if [ "$val" -ge 80 ]; then
    printf '%s' "$RED"
  elif [ "$val" -ge 50 ]; then
    printf '%s' "$YELLOW"
  else
    printf '%s' "$GREEN"
  fi
}

# Renders a compact 8-block progress bar using block characters
# Usage: progress_bar <percentage>
progress_bar() {
  local pct=$1
  local total=8
  local val
  val=$(printf "%.0f" "$pct")
  local filled=$(( val * total / 100 ))
  local color
  color=$(pct_color "$pct")
  local bar=""
  local i=0
  while [ $i -lt $total ]; do
    if [ $i -lt $filled ]; then
      bar="${bar}▓"
    else
      bar="${bar}░"
    fi
    i=$(( i + 1 ))
  done
  printf '%b%s%b' "$color" "$bar" "$RESET"
}

# Build the status line

# Folder (blue)
parts=$(printf '%b%s%b' "$BLUE" "$folder" "$RESET")

# Git branch (magenta)
if [ -n "$git_branch" ]; then
  parts="${parts} $(printf '%b(%s)%b' "$MAGENTA" "$git_branch" "$RESET")"
fi

# Context usage progress bar
if [ -n "$used" ]; then
  ctx_used=$(printf "%.0f" "$used")
  bar=$(progress_bar "$used")
  color=$(pct_color "$used")
  parts="${parts} $(printf '%b|%b' "$DIM" "$RESET") ctx:${bar}$(printf '%b%s%%%b' "$color" "$ctx_used" "$RESET")"
fi

# 5-hour rate limit progress bar
if [ -n "$five" ]; then
  five_val=$(printf "%.0f" "$five")
  bar=$(progress_bar "$five")
  color=$(pct_color "$five")
  parts="${parts} $(printf '%b|%b' "$DIM" "$RESET") 5h:${bar}$(printf '%b%s%%%b' "$color" "$five_val" "$RESET")"
fi

# 7-day rate limit as colored percentage only
if [ -n "$week" ]; then
  week_val=$(printf "%.0f" "$week")
  color=$(pct_color "$week")
  parts="${parts} $(printf '%b|%b' "$DIM" "$RESET") 7d:$(printf '%b%s%%%b' "$color" "$week_val" "$RESET")"
fi

# Model name (cyan)
if [ -n "$model" ]; then
  parts="${parts} $(printf '%b|%b' "$DIM" "$RESET") $(printf '%b%s%b' "$CYAN" "$model" "$RESET")"
fi

printf "%b" "$parts"
