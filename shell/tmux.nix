{ config, pkgs, lib, ... }:
let unstable = import <nixos-unstable> {};
in {
  programs.tmux = {
    enable = true;
    plugins = with unstable; [ tmuxPlugins.nord ];
    shortcut = "o";
    baseIndex = 1;
    escapeTime = 0;
    historyLimit = 10000;
    keyMode = "vi";
    terminal = "screen-256color";
    extraConfig = lib.strings.fileContents ./.tmux.conf;
  };
}
