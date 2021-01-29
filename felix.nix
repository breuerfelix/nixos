{ config, pkgs, lib, ... }:
let vars = import ./constants.nix;
in {
  imports = [
    ./shell/init.nix
    ./desktop/init.nix
  ];

  programs.home-manager.enable = true;
  manual.manpages.enable = true;
  # allow installation of fonts
  fonts.fontconfig.enable = true;

  home = {
    keyboard.layout = "eu";
    sessionVariables.GTK_THEME = "Generated";

    packages = with pkgs; [
      # system
      nerdfonts corefonts
      pavucontrol
      pcmanfm
      libnotify
      # terminal
      fd ripgrep
      xclip
      python3 poetry
      # k8s
      kubectl kubernetes-helm
      kubie istioctl
      #kubectx # TODO kubectx not working
      #thefuck # TODO integration into shell via module
      universal-ctags
      podman podman-compose
      bitwarden-cli
      # programs
      ferdi
      blender
      veracrypt
      # TODO asesprite calibre lossless-cut noisetorch screenkey vlc wireshark
    ];
  };
}
