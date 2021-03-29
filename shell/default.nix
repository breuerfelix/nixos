{ config, pkgs, lib, ... }:
let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in {
  imports = [
    ./alacritty.nix
    ./zsh.nix
    ./vim/init.nix
    ./tmux.nix
    ./git.nix
  ];

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
      showCpuFrequency = true;
      showCpuUsage = true;
      showProgramPath = false;
    };

    fzf = {
      enable = true;
      defaultCommand = "fd --type f --hidden --follow --exclude .git --exclude .vim --exclude .cache";
      defaultOptions = [
        "--border sharp"
        "--inline-info"
      ];
    };

    go = {
      enable = true;
      # relative to $HOME
      goPath = "go";
    };
  };

  # setting the go path
  home = {
    # TODO refer to $HOME
    sessionPath = [ "/home/felix/go/bin" ];
    sessionVariables.GOROOT = [ "${pkgs.go.out}/share/go" ];
  };

}
