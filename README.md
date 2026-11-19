# Welcome to your new EPITA's config
<img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSZvPi0HkU5Ufv1065pf84EysQoC5BmfUX8yCUY3YJgPtx6p3i-_XdbcJY&s=10" alt="NixOS Logo" width="200"/>

## Flake Content :
 - Mango Window Manager (dwm based)
 - Neovim
 - Waybar
 - SwayBG

## Space Needed : 
__~400Mo__ Compressed / 1.6Go Decompressed


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

## Featured Repositories :
[MangoWM](https://github.com/mangowm/mango) \
[Neovim](https://github.com/neovim/neovim) \
[Waybar](https://github.com/alexays/waybar) \
[SwayBG](https://github.com/swaywm/swaybg) 

