{ ... }:

{
  programs.bash = {
    enable = true;
    enableCompletion = true;

    historyControl = [ "ignoredups" "ignorespace" ];
    historySize = 10000;
    historyFileSize = 20000;

    shellAliases = {
      ll = "ls -la --color=auto";
      la = "ls -A --color=auto";
      l = "ls -CF --color=auto";
      ls = "ls --color=auto";
      grep = "grep --color=auto";
      ".." = "cd ..";
      "..." = "cd ../..";
      v = "nvim";
      ff = "fastfetch";
      gs = "git status";
      gd = "git diff";
      gl = "git log --oneline --graph --decorate -n 15";
    };
  };
}
