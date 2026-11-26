{ pkgs, ... }:

{
  xdg.configFile."epita-bash/extra.sh".text = ''
    # Starship prompt
    eval "$(${pkgs.starship}/bin/starship init bash)"
  '';
}
