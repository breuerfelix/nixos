{ config, pkgs, lib, ... }:
let vars = import ../constants.nix;
in {
  imports = [
    ./alacritty.nix
    ./fish.nix
    ./zsh.nix
    ./vim/init.nix
    ./tmux.nix
    ./git.nix
  ];

  # TODO default.nix demo https://nixos.org/#asciinema-demo-example_3
  # shell integrations are enabled by default
  programs = {
    autojump.enable = true;
    jq.enable = true;

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

    fzf = {
      enable = true;
      defaultCommand = "fd --type f --hidden --follow --exclude .git --exclude .vim --exclude .cache";
      defaultOptions = [
        "--border"
        "--inline-info"
      ];
    };

    go = {
      enable = true;
    };
  };
}
