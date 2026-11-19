{ config, pkgs, inputs, ... }:

let
  theme = import ./theme.nix;
in
{
  programs.waybar = {
    enable = true;

    package = pkgs.waybar.override {
      cavaSupport = false;
      mpdSupport = false;
      mprisSupport = false;
      wireplumberSupport = false;
      sndioSupport = false;
      jackSupport = false;
      rfkillSupport = false;
      evdevSupport = false;
      upowerSupport = false;
      experimentalPatches = false;
    };
    
    settings = {
      mainBar = {
        layer = "top";
        position = "bottom";
        height = theme.apps.waybar.height;
        margin-left = theme.apps.waybar.margin;
        margin-right = theme.apps.waybar.margin;
        margin-bottom = theme.apps.waybar.margin;
        
        modules-left = [ "mango/workspaces" "mango/window" ];
        modules-right = [ "mango/layout" "mango/language" "network" "bluetooth" "pulseaudio" "tray" "clock" ];

        "mango/workspaces" = {
          disable-markup = false;
          format = "{icon}";
          hide-empty = true;
          format-icons = {
            "1" = "";
          };
        };

        "mango/window" = {
          format = "{title}";
          expand = true;
          icon = true;
        };

        "mango/layout" = {
          format = " {symbol}";
          "format-T" = " Tiling";
          "format-CT" = " Center Tiling";
          "format-F" = " Fair";
          "format-S" = " Scrolling";
        };
        
        "mango/language" = {
          format = " <span text-transform='uppercase'>{short}</span>";
          on-click = "toggle-vkbd";
        };

        "pulseaudio" = {
          format = "{icon} {volume}%";
          format-muted = "󰝟 Muted";
          format-icons = {
            default = [ "󰕿" "󰖀" "󰕾" ];
          };
        };
      
        "network" = {
          interval = 30;
          format-wifi = "󰖩 {essid}";
          format-disconnected = "󰖪";
          format-ethernet = "󰈁 {essid}";
          tooltip-format = " {bandwidthDownBytes} |  {bandwidthUpBytes} : {ipaddr}";
        };

        "bluetooth" = {
          format = " {status}";
          format-disabled = "󰂲";
          format-connected = "󰂱 {device_alias}";
          tooltip-format = "{num_connections} device(s) connected";
          tooltip-format-connected = "{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias} - {device_address}";
        };

        "clock" = {
          tooltip-format = "{:%A %d %B %Y}";
        };
      };
    };

    style = ''
      * {
        font-family: "${theme.fonts.main.name}";
        font-size: ${toString theme.apps.waybar.fontSize}px;
        border: none;
        border-radius: 0;
      }

      window#waybar {
        background-color: alpha(${theme.colors.background}, 0.2);
        color: ${theme.colors.foreground};
        border-radius: 8px;
      }

      tooltip {
        background-color: ${theme.colors.background};
        border: 1px solid ${theme.colors.foreground};
        border-radius: 8px;
      }
    
      tooltip label {
        font-size: 10px;
        padding: 1px 2px;
        color: ${theme.colors.foreground};
      }

      #workspaces button {
        padding: 0 10px;
        color: ${theme.colors.foreground};
        background-color: transparent;
      }

      #workspaces button:first-child {
        border-top-left-radius: 8px;
        border-bottom-left-radius: 8px;
      }

      #workspaces button:hover {
        background: none;
        text-shadow: none;
        box-shadow: none;
        -gtk-icon-shadow: none;
        -gtk-icon-effect: none;
        background-color: ${theme.colors.darkGreen};
        color: ${theme.colors.foreground};
      }

      #workspaces button.active {
        background-color: transparent;
        color: ${theme.colors.yellow};
        border-bottom: 2px solid ${theme.colors.green};
      }
 
      #workspaces button.active:hover {
        background-color: ${theme.colors.darkGreen};
        color: ${theme.colors.yellow};
        text-shadow: none;
        box-shadow: none;
        -gtk-icon-shadow: none;
        -gtk-icon-effect: none;
      }

      #workspaces button.urgent {
        background-color: transparent;
        color: ${theme.colors.foreground};
      }

      #clock, #pulseaudio, #network, #bluetooth, #tray, #window, #language {
        padding: 0 10px;
        margin: 0 5px;
      }

      #window {
        color: ${theme.colors.foreground};
      }

      #clock {
        color: ${theme.colors.green};
        font-weight: bold;
      }

      #pulseaudio {
        color: ${theme.colors.foreground};
      }

      #pulseaudio.muted {
        color: ${theme.colors.yellow};
      }

      #network {
        color: ${theme.colors.foreground};
      }

      #bluetooth {
        color: ${theme.colors.foreground};
      }

      #bluetooth.connected {
        color: ${theme.colors.green};
      }
    '';
  };
}
