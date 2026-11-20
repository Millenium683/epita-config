{ ... }:

let
  theme = import ./theme.nix;
in
{
    programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        type = "builtin";
        source = "nixos";
        color = {
          "1" = theme.colors.yellow;      
          "2" = theme.colors.green;
          "3" = theme.colors.yellow;
          "4" = theme.colors.green;
          "5" = theme.colors.yellow;
          "6" = theme.colors.green;
        };
        padding = {
          top = 0;
          left = 1;
          right = 2;
        };
      };
      display = {
        disableLinewrap = true;
        separator = ": ";
        color = {
          keys = theme.colors.cursor;   
          title = theme.colors.green;    
          separator = theme.colors.green;   
          output = theme.colors.foreground; 
        };
      };
      modules = [
        {
          type = "title";
          color = {
            user = theme.colors.green;
            at = theme.colors.foreground;
            host = theme.colors.cursor;
          };
        }
        "separator"
        "os"
        "host"
        "kernel"
        "uptime"
        "display"
        "wm"
        "shell"
        "terminal"
        "terminalfont"
        "cpu"
        "gpu"
        "memory"
        "disk"
        "localip"
      ];
    };
  };
}
