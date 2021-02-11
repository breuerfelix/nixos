{ config, pkgs, lib, ... }: {
  imports = [
    <home-manager/nixos>
    ./desktop/gtk-theme.nix
  ];

  security.sudo.wheelNeedsPassword = false;

  programs = {
    # database for gtk applications
    dconf.enable = true;
    nm-applet.enable = true;
    npm.enable = true;
    adb.enable = true;

    # picks up shell alias
    fish.enable = true;
    zsh.enable = true;
  };

  services = {
    greenclip.enable = true;
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
  };

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
  };

  # specific user configurations
  users = {
    #defaultUserShell = pkgs.fish;
    users.felix = {
      isNormalUser = true;
      home = "/home/felix";
      shell = pkgs.fish;
      description = "scriptworld";
      extraGroups = [
        "wheel" "networkmanager"
        "audio" "dialout"
        "docker" "libvirtd"
        "adbusers"
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
}
