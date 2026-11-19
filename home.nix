{ inputs, pkgs, lib, ... }:

{
  imports = [
    ./mango.nix
    ./waybar.nix
    ./nixvim.nix
  ];

  home.username = "jules.hoeltzel";
  home.homeDirectory = "/home/jules.hoeltzel";
  home.stateVersion = "24.11";

  programs.home-manager.enable = true;

  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
        nerd-fonts.jetbrains-mono
        wmenu
        (writeShellScriptBin "powermenu" ''
        choice=$(printf "Logout\nReboot\nShutdown" | wmenu -p "Session:")
        case "$choice" in
            Logout) loginctl terminate-session "$XDG_SESSION_ID" ;;
            Reboot) systemctl reboot ;;
            Shutdown) systemctl poweroff ;;
        esac
        '')
  ];
}
