{ pkgs, lib, ... }:

let
  theme = import ./theme.nix;
  hex = color: lib.removePrefix "#" color;

  lockTimer = pkgs.writeShellScriptBin "epita-lock-timer" ''
    START_FILE="/tmp/epita-lock-start-$USER"
    if [ -f "$START_FILE" ]; then
      start=$(cat "$START_FILE")
      now=$(date +%s)
      elapsed=$((now - start))
      [ "$elapsed" -lt 0 ] && elapsed=0
      printf "%02d:%02d\n" $((elapsed / 3600)) $(((elapsed % 3600) / 60))
    else
      echo "00:00"
    fi
  '';

  lockStatus = pkgs.writeShellScriptBin "epita-lock-status" ''
    START_FILE="/tmp/epita-lock-start-$USER"
    if [ -f "$START_FILE" ]; then
      start=$(cat "$START_FILE")
      now=$(date +%s)
      rem=$((3600 - (now - start)))
      if [ "$rem" -le 0 ]; then
        echo "1h atteinte - deconnexion..."
      elif [ "$rem" -lt 60 ]; then
        echo "Deconnexion auto dans < 1 min"
      else
        printf "Deconnexion auto dans %d min\n" $(((rem + 59) / 60))
      fi
    else
      echo "Deconnexion auto apres 01:00"
    fi
  '';

  i3lockWrapper = pkgs.writeShellScriptBin "i3lock" ''
    if ${pkgs.procps}/bin/pgrep -x hyprlock >/dev/null 2>&1; then
      exit 0
    fi

    START_FILE="/tmp/epita-lock-start-$USER"
    date +%s > "$START_FILE"

    (
      sleep 3600
      if ${pkgs.procps}/bin/pgrep -x hyprlock >/dev/null 2>&1; then
        loginctl terminate-session "$XDG_SESSION_ID" 2>/dev/null || loginctl terminate-user "$USER"
      fi
    ) &
    TIMER_PID=$!

    ${pkgs.hyprlock}/bin/hyprlock --config "$HOME/.config/hypr/hyprlock.conf"

    ${pkgs.procps}/bin/pkill -P "$TIMER_PID" 2>/dev/null || true
    kill "$TIMER_PID" 2>/dev/null || true
    rm -f "$START_FILE"
  '';
in
{
  home.packages = [
    pkgs.hyprlock
    i3lockWrapper
  ];

  xdg.configFile."hypr/hyprlock.conf" = {
    force = true;
    text = ''
      general {
        hide_cursor = true
        ignore_empty_input = true
      }

      auth {
        pam {
          enabled = true
          module = i3lock
        }
      }

      background {
        monitor =
        color = rgb(${hex theme.colors.background})
      }

      # Lock elapsed time (HH:MM)
      label {
        monitor =
        text = cmd[update:1000] ${lockTimer}/bin/epita-lock-timer
        color = rgb(${hex theme.colors.blue})
        font_size = 90
        font_family = ${theme.fonts.main.name}
        position = 0, 140
        halign = center
        valign = center
      }

      # Subtitle for lock timer
      label {
        monitor =
        text = Session verrouillee (HH:MM)
        color = rgb(${hex theme.colors.comment})
        font_size = 14
        font_family = ${theme.fonts.main.name}
        position = 0, 65
        halign = center
        valign = center
      }

      # Session login
      label {
        monitor =
        text = 󰀄  $USER
        color = rgb(${hex theme.colors.magenta})
        font_size = 24
        font_family = ${theme.fonts.main.name}
        position = 0, 15
        halign = center
        valign = center
      }

      # Password input
      input-field {
        monitor =
        size = 320, 50
        outline_thickness = 2
        dots_size = 0.25
        dots_spacing = 0.2
        dots_center = true
        outer_color = rgb(${hex theme.colors.blue})
        inner_color = rgb(${hex theme.colors.backgroundAlt})
        font_color = rgb(${hex theme.colors.foreground})
        check_color = rgb(${hex theme.colors.yellow})
        fail_color = rgb(${hex theme.colors.red})
        fade_on_empty = false
        placeholder_text = <span foreground="##${hex theme.colors.comment}">Mot de passe...</span>
        fail_text = <i>$FAIL ($ATTEMPTS)</i>
        rounding = 8
        position = 0, -65
        halign = center
        valign = center
      }

      # Auto-logout countdown (1h)
      label {
        monitor =
        text = cmd[update:1000] ${lockStatus}/bin/epita-lock-status
        color = rgb(${hex theme.colors.cyan})
        font_size = 14
        font_family = ${theme.fonts.main.name}
        position = 0, -135
        halign = center
        valign = center
      }
    '';
  };
}
