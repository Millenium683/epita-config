#!/bin/sh

set -e
home-manager switch -b "backup-$(date +%s)" --impure --flake github:Millenium683/epita-config#epita

# Append config hook to EPITA's ~/.bashrc without overwriting its contents
if [ -L "$HOME/.bashrc" ]; then
  if [ -e "$HOME/.bashrc" ]; then
    tmp_bashrc=$(mktemp)
    cat "$HOME/.bashrc" > "$tmp_bashrc"
    rm -f "$HOME/.bashrc"
    mv "$tmp_bashrc" "$HOME/.bashrc"
    chmod u+w "$HOME/.bashrc"
  else
    rm -f "$HOME/.bashrc"
  fi
elif [ -f "$HOME/.bashrc" ] && [ ! -w "$HOME/.bashrc" ]; then
  chmod u+w "$HOME/.bashrc"
fi

HOOK='[ -f "$HOME/.config/epita-bash/extra.sh" ] && source "$HOME/.config/epita-bash/extra.sh"'
if ! grep -Fq "$HOOK" "$HOME/.bashrc" 2>/dev/null; then
  printf '\n# epita-config\n%s\n' "$HOOK" >> "$HOME/.bashrc"
fi

exec mango
