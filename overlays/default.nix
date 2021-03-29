{ config, pkgs, lib, ... }:
let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in {
  # unstable package overrides
  nixpkgs.config.packageOverrides = pkgs: {
    fzf = unstable.fzf;
    alacritty = unstable.alacritty;
  };

  nixpkgs.overlays = [
    # use neovim nightly
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    }))
    (import ./breeze-cursor.nix)
    (import ./gtk-theme.nix)
  ];
}
