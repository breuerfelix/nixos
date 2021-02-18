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
      options = "--delete-older-than 7d";
    };
  };

  networking = {
    hostName = "rocky";
    useDHCP = false;
    networkmanager.enable = true;
    # nmcli device wifi -> lists available wifi networks
    # nmcli device wifi connect "<wifi name>" password <wifi password>
    # -> connects to a new wifi network
    interfaces.wlp6s0.useDHCP = true;

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

  environment = {
    # completion for zsh
    pathsToLink = [ "/share/zsh" ];

    systemPackages = with pkgs; [
      curl htop
      git neovim
    ];

    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    # only nixos specific aliases here
    shellAliases = {
      ne = "nvim -c ':cd /etc/nixos' /etc/nixos";
      nb = "sudo nixos-rebuild switch";
      nbu = "sudo nixos-rebuild switch --upgrade-all";
      clean = "sudo nix-collect-garbage";
      nsh = "nix-shell";
    };
  };

  services.blueman.enable = true;
  sound.enable = true;

  hardware = {
    bluetooth.enable = true;
    pulseaudio = {
      enable = true;
      # use full build for bluetooth support
      package = pkgs.pulseaudioFull;
      extraModules = [ pkgs.pulseaudio-modules-bt ];
      daemon.config = {
        # this fixes audio stuttering with bluetooth headset + mouse
        default-sample-rate = 48000;
        default-fragments = 8;
        default-fragment-size-msec = 10;
        # TODO check if those values are also needed for this fix
        # source: https://forums.linuxmint.com/viewtopic.php?t=44862
        high-priority = "yes";
        nice-level = -15;
        realtime-scheduling = "yes";
        realtime-priority = 1;
      };
    };
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
