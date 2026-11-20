{ config, pkgs, ... }:

let
  theme = import ./theme.nix;
in
{
  home.packages = [ pkgs.mango ];

  xdg.configFile."mango/autostart.sh" = {
    executable = true;
    text = ''
      #!/bin/sh
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
  };

  xdg.configFile."mango/config.conf".text = ''
    exec-once=${config.xdg.configHome}/mango/autostart.sh

    # Window Rules
    border_radius=6
    border_px=2
    focus_color=${theme.apps.mango.focuscolor}
    blur=1
    blur_optimized=1
    blur_params_radius=5
    gap_outer_horizontal=5
    gap_outer_vertical=5

    # Layer Rules
    blur_layer=1
    layer_rule=no_blur:1,layer_name:rofi
    layer_rule=no_blur:1,layer_name:mako
    layer_rule=no_blur:1,layer_name:swayosd
    layer_rule=no_blur:1,layer_name:slurp

    # Animations
    animations=1
    layer_animations=1
    layer_animation_type_open=slide
    layer_animation_type_close=slide
    animation_duration_open=400
    animation_duration_close=200
    animation_curve_open=0.16, 1, 0.3, 1
    animation_curve_close=0.5, 0, 1, 1
    animation_curve_move=0.25, 1, 0.5, 1

    # Keyboard Settings
    xkb_rules_layout=us

    # Global Keybinds
    bind=super,Return,spawn,alacritty
    bind=super+shift,q,smartkillclient
    bind=super,d,spawn,wmenu-run
    bind=super+shift,e,spawn,powermenu

    # Navigation Keybinds
    bind=super,Left,focusdir,left
    bind=super,Right,focusdir,right
    bind=super,Up,focusdir,up
    bind=super,Down,focusdir,down

    bind=super+shift,Left,exchange_client,left
    bind=super+shift,Right,exchange_client,right
    bind=super+shift,Up,exchange_client,up
    bind=super+shift,Down,exchange_client,down

    bind=super+shift,t,setlayout,tile
    bind=super+shift,c,setlayout,center_tile
    bind=super+shift,f,setlayout,fair
    bind=super+shift,s,setlayout,scroller

    bind=super,Space,togglefloating
    bind=ALT,Tab,toggleoverview

    # Tag Keybinds
    bind=super,1,view,1
    bind=super,2,view,2
    bind=super,3,view,3
    bind=super,4,view,4
    bind=super,5,view,5
    bind=super,6,view,6
    bind=super,7,view,7
    bind=super,8,view,8
    bind=super,9,view,9

    bind=super+shift,1,toggletag,1
    bind=super+shift,2,toggletag,2
    bind=super+shift,3,toggletag,3
    bind=super+shift,4,toggletag,4
    bind=super+shift,5,toggletag,5
    bind=super+shift,6,toggletag,6
    bind=super+shift,7,toggletag,7
    bind=super+shift,8,toggletag,8
    bind=super+shift,9,toggletag,9

    # Mousebinds
    mousebind=super,btn_left,moveresize,curmove
    mousebind=super,btn_right,moveresize,curresize
  '';
}
