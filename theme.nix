{
  colors = {
    background = "#0D0F12";
    foreground = "#E0E7FF";
    cursor     = "#FFAD33";
    selection  = "#3A4D94";
    
    black   = "#15171C"; 
    red     = "#FF2E50"; 
    green   = "#A8FF50"; 
    yellow  = "#FFB320"; 
    blue    = "#4A8CFF"; 
    magenta = "#B05CFF"; 
    cyan    = "#00E0FF"; 
    white   = "#AAB6E0"; 

    brightBlack   = "#4A526E"; 
    brightRed     = "#FF5575"; 
    brightGreen   = "#C4FF8A"; 
    brightYellow  = "#FFCC66"; 
    brightBlue    = "#7AA5FF"; 
    brightMagenta = "#C685FF"; 
    brightCyan    = "#55F2FF"; 
    brightWhite   = "#FFFFFF";

    # Additional Colors
    darkGreen    = "#547F28";
    turquoise    = "#50E3C2";
    darkYellow   = "#ACA33A";
  };

  apps = {
    fastfetch = {
      borders = "90";
      system = "yellow";
      host = "green";
      wm = "blue";
    };
    mango = {
      focuscolor = "0x516c93ff";
    };
    waybar = {
      height = 35;
      margin = 8;
      fontSize = 12;
    };
  };

  fonts = {
    main = {
      name = "JetBrains Mono";
      size = 11;
      pkg = "jetbrains-mono";
    };
    symbols = {
      name = "Symbols Nerd Font";
      pkg = "nerd-fonts.symbols-only";
    };
  };
}
