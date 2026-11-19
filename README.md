# Welcome to your new EPITA's config
<img src="https://gitlab.com/uploads/-/system/project/avatar/40517887/68747470733a2f2f692e696d6775722e636f6d2f367146436c41312e706e67.png" alt="NixOS Logo" width="200"/>

## Flake Content :
 - Mango Window Manager (dwm based)
 - Neovim
 - Waybar
 - SwayBG

## Space Needed : 
__~400Mo__ Compressed / 1.57Go Decompressed


## How to install :
```bash
home-manager switch -b backup --flake github:NydeTvs/epita-config#epita
```

## Features :
All the usual EPITA keybinds are kept :
- Win+D = Open drun (app launcher)
- Win+Return = Open terminal
- Win+Shift+Q = Close window

Other features were added to fit with wayland :

```
powermenu
set-wallpaper <path/to/image.png/jpg>
```

- powermenu : \ 
Win+Shift+E = Open powermenu (same behavior as usual but in wayland way)
- set-wallpaper : \
Param: path/to/a/image.png|jpg \
Allows you to dynamically change your wallpaper. Creates a copy of the image provided in afs so it is kept after reboot.

