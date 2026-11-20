{ config, pkgs, inputs, ... }:

let 
  theme = import ./theme.nix;
in
{
  imports = [ inputs.mango.hmModules.mango ];

  wayland.windowManager.mango = {
    enable = true;
    package = pkgs.mango;

    autostart_sh = ''
      dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
      if [ -f "$HOME/afs/wallpaper.png" ]; then
        ${pkgs.swaybg}/bin/swaybg -i "$HOME/afs/wallpaper.png" -m fill &
      elif [ -f "$HOME/afs/wallpaper.jpg" ]; then
        ${pkgs.swaybg}/bin/swaybg -i "$HOME/afs/wallpaper.jpg" -m fill &
      else
        ${pkgs.swaybg}/bin/swaybg -c "${theme.colors.background}" &
      fi
      waybar &
    '';

    settings = {
      # Window Rules
      border_radius = 6;
      border_px = 2;
      focus_color = theme.apps.mango.focuscolor;
      blur = 1;
      blur_optimized = 1;
      blur_params_radius = 5;
      gap_outer_horizontal = 5; # Horizontal outer gap
      gap_outer_vertical = 5; # Vertical outer gap

      # Layer Rules
      blur_layer = 1;
      layer_rule = [
        "no_blur:1,layer_name:rofi"
        "no_blur:1,layer_name:mako"
        "no_blur:1,layer_name:swayosd"
        "no_blur:1,layer_name:slurp"
      ];

      # Animations
      animations = 1;
      layer_animations = 1;
      layer_animation_type_open = "slide";
      layer_animation_type_close = "slide";
      
      animation_duration_open = 400;
      animation_duration_close = 200;

      animation_curve_open = "0.16, 1, 0.3, 1";
      animation_curve_close = "0.5, 0, 1, 1";
      animation_curve_move = "0.25, 1, 0.5, 1";

      # Keyboard Settings
      xkb_rules_layout = "us";

      bind = [
        # Global Keybinds
        "super,Return,spawn,alacritty"
        "super+shift,q,smartkillclient"
        "super,d,spawn,wmenu-run"
        "super+shift,e,spawn,powermenu"

        # Navigation Keybinds
        "super,Left,focusdir,left"
        "super,Right,focusdir,right"
        "super,Up,focusdir,up"
        "super,Down,focusdir,down"

        "super+shift,Left,exchange_client,left"
        "super+shift,Right,exchange_client,right"
        "super+shift,Up,exchange_client,up"
        "super+shift,Down,exchange_client,down"

        "super+shift,t,setlayout,tile"
        "super+shift,c,setlayout,center_tile"
        "super+shift,f,setlayout,fair"
        "super+shift,s,setlayout,scroller"

        "super,Space,togglefloating"
        "ALT,Tab,toggleoverview"

        # Tag Keybinds
        "super,1,view,1"
        "super,2,view,2"
        "super,3,view,3"
        "super,4,view,4"
        "super,5,view,5"
        "super,6,view,6"
        "super,7,view,7"
        "super,8,view,8"
        "super,9,view,9"

        "super+shift,1,toggletag,1"
        "super+shift,2,toggletag,2"
        "super+shift,3,toggletag,3"
        "super+shift,4,toggletag,4"
        "super+shift,5,toggletag,5"
        "super+shift,6,toggletag,6"
        "super+shift,7,toggletag,7"
        "super+shift,8,toggletag,8"
        "super+shift,9,toggletag,9"
      ];

      mousebind = [
        "super,btn_left,moveresize,curmove"
        "super,btn_right,moveresize,curresize"
      ];
    };
  };
}
