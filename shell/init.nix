{ config, pkgs, lib, ... }:
let vars = import ../constants.nix;
in {
  imports = [
    ./alacritty.nix
    ./fish.nix
    ./vim.nix
    ./tmux.nix
    ./git.nix
    ./fzf.nix
  ];

  programs = {
    autojump = {
      enable = true;
      enableFishIntegration = true;
    };

    lsd = {
      enable = true;
      enableAliases = true;
    };

    bat = {
      enable = true;
      # TODO check if theme gets picked up
      config = { theme = "base16"; };
    };

    htop = {
      enable = true;
      treeView = true;
    };
  };
}
