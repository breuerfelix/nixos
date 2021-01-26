{ config, pkgs, ... }: {

  imports = [ ./hardware.nix ./users.nix ];

  system.stateVersion = "20.09";

  boot = {
    # Use the GRUB 2 boot loader.
    loader.grub = {

      enable = true;
      version = 2;
      device = "nodev";
      efiSupport = true;
      # for detecting dual boot windows
      useOSProber = true;
    };

    loader.efi.canTouchEfiVariables = true;

    cleanTmpDir = true;
    initrd.luks.devices = {
      root = {
        device = "/dev/disk/by-label/luks";
        preLVM = true;
        allowDiscards = true;
      };
    };
  };

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
    networkmanager.enable = true;
    useDHCP = false;
    interfaces.wlp7s0.useDHCP = true;
  };

  time.timeZone = "Europe/Berlin";

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

  environment = {
    systemPackages = with pkgs; [
      curl htop
      git
      neovim
    ];

    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    # only nixos specific aliases here
    shellAliases = {
      ne = "nvim -c ':cd /etc/nixos' /etc/nixos";
      ns = "sudo nixos-rebuild switch";
      nsu = "sudo nixos-rebuild switch --upgrade";
      clean = "nix-collect-garbage";
    };
  };

  # sound
  # TODO fix bluetooth
  #services.blueman.enable = true;
  sound.enable = true;
  hardware = {
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
      #extraModules = [ pkgs.pulseaudio-modules-bt ];
    };

    #bluetooth.enable = true;
  };

  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
    layout = "eu";

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
