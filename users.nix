{ config, pkgs, lib, ... }:
let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
  home-manager = builtins.fetchGit {
    url = "https://github.com/rycee/home-manager.git";
    ref = "release-20.09";
  };
in {
  imports = [
    (import "${home-manager}/nixos")
    ./overlays/gtk-theme.nix
    ./overlays/breeze-cursor.nix
  ];

  security.sudo.wheelNeedsPassword = false;

  programs = {
    # database for gtk applications
    dconf.enable = true;
    nm-applet.enable = true;
    npm.enable = true;
    # used to access phone via usb
    adb.enable = true;

    # gaming
    steam.enable = false;

    # screen locker
    # TODO use screenlocker
    #slock.enable = true;

    # picks up shell alias
    zsh.enable = true;
  };

  services = {
    greenclip.enable = true;
    teamviewer.enable = true;
    synergy = {
      server = {
        enable = false;
        # TODO create this file
        #configFile = "/etc/nixos/desktop/synergy.conf";
      };
    };
  };

  virtualisation = {
    libvirtd.enable = true;
    podman.enable = true;
    docker = {
      enable = true;
      # use podman if possible
      enableOnBoot = false;
      autoPrune = {
        enable = true;
        dates = "monthly";
        flags = [ "--all" ];
      };
    };

    virtualbox.host = {
      enable = true;
      enableExtensionPack = true;
    };
  };

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
  };

  # specific user configurations
  users = {
    users.felix = {
      isNormalUser = true;
      home = "/home/felix";
      shell = pkgs.zsh;
      description = "scriptworld";
      extraGroups = [
        "wheel" "networkmanager"
        "audio" "dialout"
        "docker" "libvirtd" "vboxusers"
        "adbusers" # usb debugging
        "video" # permission to change backlight
      ];
    };
  };

  home-manager.users.felix = import ./felix.nix;
  nix.allowedUsers = [ "felix" ];

  # use neovim nightly
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    }))
  ];

  # unstable package overrides
  nixpkgs.config.packageOverrides = pkgs: {
    fzf = unstable.fzf;
    alacritty = unstable.alacritty;
  };
}
