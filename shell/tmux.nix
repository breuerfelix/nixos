{ config, pkgs, lib, ... }:
let vars = import ../constants.nix;
in {
  programs.tmux = {
    enable = true;
    plugins = with pkgs; [ tmuxPlugins.nord ];
    extraConfig =
      lib.strings.fileContents ./.tmux.conf;
  };
}
