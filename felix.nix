{ config, pkgs, lib, ... }:
let
  vars = import ./constants.nix;
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
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
      pavucontrol pasystray # pulseaudio
      pcmanfm # filebrowser
      libnotify # used for notifications
      ncdu # checks system size

      # compiler
      gnumake

      # terminal
      fd ripgrep
      xclip
      python3 poetry
      #tectonic # latex builder
      cargo
      nodejs yarn
      unstable.nodePackages.expo-cli
      # preact-cli global installation
      tmate
      ranger
      nnn
      # TODO fix taskell
      #taskell
      # useful terminal tools
      termdown # terminal countdown
      hyperfine # performance test tool
      tectonic # latex

      # k8s
      kubectl kubernetes-helm
      kubie
      #kubectx # TODO kubectx not working
      #thefuck # TODO integration into shell via module
      universal-ctags
      docker-compose
      podman-compose

      # programs
      firefox # TODO replace with programs.firefox
      ferdi
      insync # google drive sync
      blender
      veracrypt
      vlc
      unityhub
      zotero
      android-studio
      zoom-us

      #obsidian # gui for knowledge base
      #yuzu-ea # nintendo switch emulator
      # TODO asesprite calibre lossless-cut noisetorch screenkey vlc wireshark

      # temp
      #texlive.combined.scheme-basic# latex
      python38Packages.pygments
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
