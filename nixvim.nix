{ inputs, pkgs, ... }:

let
  theme = import ./theme.nix;
in
{
  imports = [ inputs.nixvim.homeModules.nixvim ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withPython3 = false;
    withRuby = false;
    withNodeJs = false;
    withPerl = false;

    nixpkgs.source = inputs.nixpkgs;

    colorschemes.base16 = {
      enable = true;
      colorscheme = {
        # Background and text
        base00 = theme.colors.background;
        base05 = theme.colors.foreground;

        # Interface
        base01 = theme.colors.black;
        base02 = theme.colors.selection;
        base03 = theme.colors.brightBlack;
        base04 = theme.colors.white;
        base06 = theme.colors.brightWhite;
        base07 = theme.colors.brightWhite;

        # Syntax
        base08 = theme.colors.white;
        base09 = theme.colors.cursor;
        base0A = theme.colors.yellow;
        base0B = theme.colors.green;
        base0C = theme.colors.cyan;
        base0D = theme.colors.blue;
        base0E = theme.colors.magenta;
        base0F = theme.colors.red;
      };
    };

    plugins = {
      # Status bar
      lualine = {
        enable = true;
        settings.options.theme = "base16";
      };

      # Icons
      web-devicons.enable = true;

      # Indent guides
      indent-blankline.enable = true;

      # Advanced syntax color (grammaires limitées pour garder la flake légère)
      treesitter = {
        enable = true;
        grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          c
          cpp
          python
          bash
          nix
          make
          markdown
        ];
        settings = {
          highlight.enable = true;
          indent.enable = true;
        };
      };
    };

    opts = {
      number = true;
      cursorline = true;
      relativenumber = true;
      shiftwidth = 4;
      tabstop = 4;
      expandtab = true;
      termguicolors = true;
    };

    globals.mapleader = " ";
  };
}
