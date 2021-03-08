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
      zip unzip p7zip
      translate-shell # used for rofi-translate
      bind # dns utils
      telnet nmap
      #qmk_firmware # flash keyboard marked as broken
      betterlockscreen
      gotop # htop alternative
      unstable.bottom # htop alternative
      #grc # colored log output TODO fix this

      # compiler
      gnumake
      gcc

      # terminal
      fd ripgrep
      xclip
      gitAndTools.delta
      unstable.starship # cross-shell prompt
      cht-sh # interactive terminal cheat sheet

      cargo # rust

      # node tools
      nodejs yarn # npm is built into nodejs
      unstable.nodePackages.expo-cli
      # TODO preact-cli global installation

      # python tool
      python38Full poetry # python
      #python38Packages.pip

      tmate
      ranger
      nnn
      # TODO fix taskell
      #taskell

      # useful terminal tools
      termdown # terminal countdown
      hyperfine # performance test tool
      tectonic # latex compiler
      python38Packages.pygments # latex syntac highlighting

      # k8s
      kubectl kubernetes-helm
      kubie
      #kubectx # TODO kubectx not working
      #thefuck # TODO integration into shell via module
      universal-ctags
      docker-compose
      podman-compose

      # programs
      nitrogen # wallpaper manager
      firefox # TODO replace with programs.firefox
      ferdi # messenger all-in-one
      insync # google drive sync
      blender
      veracrypt # cross-platform drive encryption
      vlc # media player
      unityhub
      zotero # latex bib manager
      android-studio
      zoom-us
      teamviewer
      #quicksynergy # share mouse and keyboard events
      synergy

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
