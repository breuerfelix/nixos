{ config, pkgs, lib, ... }:
let vars = import ./constants.nix;
in {
  imports = [
    ./modules/base16.nix
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
      pavucontrol pasystray
      pcmanfm
      libnotify
      # terminal
      fd ripgrep
      xclip
      python3 poetry
      gnumake
      nodejs yarn
      nodePackages.expo-cli
      tmate
      ranger
      nnn
      # TODO fix taskell
      #taskell
      # useful terminal tools
      termdown # terminal countdown
      hyperfine # performance test tool

      # k8s
      kubectl kubernetes-helm
      kubie
      #kubectx # TODO kubectx not working
      #thefuck # TODO integration into shell via module
      universal-ctags
      docker-compose
      podman-compose

      # programs
      firefox # TODO replace with programs.
      ferdi
      blender
      veracrypt
      vlc
      unityhub
      zotero
      android-studio

      #obsidian # gui for knowledge base
      #yuzu-ea # nintendo switch emulator
      # TODO asesprite calibre lossless-cut noisetorch screenkey vlc wireshark
    ];
  };

  programs.base16 = {
    enable = true;
    colors = vars.colors;

    alacritty = true;
    xresources = true;
    i3 = true;
    dunst = true;
    fzf = true;
    neovim = true;
    neovim_airline = true;
    #tmux = true;
  };
}
