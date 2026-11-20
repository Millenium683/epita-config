{ ... }:

{
    programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        type = "small"; 
        padding = {
          top = 0;
          left = 1;
          right = 2;
        };
      };
      display = {
        disableLinewrap = true;
        separator = ": ";
      };
    };
  };
}
