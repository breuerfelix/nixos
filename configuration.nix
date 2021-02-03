{ config, pkgs, ... }: {
  imports = [
    ./hardware.nix
    ./users.nix
  ];

  system.stateVersion = "20.09";
  nixpkgs.config.allowUnfree = true;

  nix = {
    allowedUsers = [ "root" ];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  networking = {
    hostName = "rocky";
    useDHCP = false;
    networkmanager.enable = true;
    interfaces.wlp7s0.useDHCP = true;

    hosts = {
      "173.212.222.231" = [ "con" "contabo" ];
      "185.113.124.212" = [ "ics" ];
    };
  };

  time = {
    timeZone = "Europe/Berlin";
    # windows handles time in dual boot
    hardwareClockInLocalTime = true;
  };

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # use neovim nightly
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    }))
  ];

  environment = {
    # completion for zsh
    pathsToLink = [ "/share/zsh" ];

    systemPackages = with pkgs; [
      curl htop
      git neovim-nightly
    ];

    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    # only nixos specific aliases here
    shellAliases = {
      ne = "nvim -c ':cd /etc/nixos' /etc/nixos";
      nb = "sudo nixos-rebuild switch";
      nbu = "nix-channel --update && sudo nixos-rebuild switch --upgrade";
      clean = "nix-collect-garbage";
      nsh = "nix-shell";
    };
  };

  services.blueman.enable = true;
  sound.enable = true;
  hardware = {
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
      extraModules = [ pkgs.pulseaudio-modules-bt ];
    };

    bluetooth.enable = true;
  };

  # wallpaper at ~./background-image will be used
  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
    layout = "eu";
    dpi = 115;

    # used to let home-manager handle xsession
    desktopManager = {
      xterm.enable = false;
      session = [{
        name = "home-manager";
        start = ''
          ${pkgs.runtimeShell} $HOME/.hm-xsession &
          waitPID=$!
        '';
      }];
    };

    # automatically logs in my user
    # enables logging out manually
    displayManager = {
      autoLogin = {
        enable = true;
        user = "felix";
      };

      lightdm.enable = true;
    };
  };
}
