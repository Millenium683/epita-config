{ inputs, pkgs, lib, ... }:

let
  username = builtins.getEnv "USER";
in
{
  imports = [
    ./mango.nix
    ./waybar.nix
    ./neovim.nix
    ./fastfetch.nix
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "24.11";

  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
        jetbrains-mono
        nerd-fonts.symbols-only
        wmenu
        swaylock
        swayidle
        (writeShellScriptBin "i3lock" ''
            (
                sleep 3600
                systemctl poweroff
            ) &
            TIMER_PID=$!

        ${pkgs.swaylock}/bin/swaylock \
            --pam-service i3lock \
            --color 0D0F12 \
            --inside-color 15171C \
            --ring-color 4A8CFF \
            --key-hl-color A8FF50 \
            --bs-hl-color FF2E50 \
            --text-color E0E7FF

        kill "$TIMER_PID" 2>/dev/null || true
        '')
        (writeShellScriptBin "powermenu" ''
        choice=$(printf "Logout\nReboot\nShutdown" | wmenu -p "Session:")
        case "$choice" in
            Logout) loginctl terminate-session "$XDG_SESSION_ID" ;;
            Reboot) systemctl reboot ;;
            Shutdown) systemctl poweroff ;;
        esac
        '')
        (writeShellScriptBin "set-wallpaper" ''
          if [ -z "$1" ] || [ ! -f "$1" ]; then
            echo "Usage: set-wallpaper <path/to/image.png|jpg>"
            exit 1
          fi
          ext="''${1##*.}"
          ext="''${ext,,}"
          if [ "$ext" != "png" ] && [ "$ext" != "jpg" ]; then
            echo "Unsupported format (please use .png or .jpg)"
            exit 1
          fi
          rm -f "$HOME/afs/wallpaper.png" "$HOME/afs/wallpaper.jpg"
          cp "$1" "$HOME/afs/wallpaper.$ext"
          pkill swaybg || true
          ${pkgs.swaybg}/bin/swaybg -i "$HOME/afs/wallpaper.$ext" -m fill >/dev/null 2>&1 &
        '')
        (writeShellScriptBin "alacritty-fetch" ''
          exec alacritty -e sh -c 'fastfetch; exec "''${SHELL:-bash}"'
        '')
  ];
}
