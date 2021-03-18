{ config, pkgs, ... }: {
  imports = [ ./users.nix ];

  # channels -> add them with SUDO !
  # sudo nix-channel --list
  # sudo nix-channel --add <channel> <name>
  # sudo nix-channel --update
  # nixos https://nixos.org/channels/nixos-20.09
  # nixos-unstable https://nixos.org/channels/nixos-unstable


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
    firewall = {
      enable = true;
      allowPing = false;
      # used for synergy
      allowedTCPPorts = [ 24800 ];
    };

    # nmcli device wifi -> lists available wifi networks
    # nmcli device wifi connect "<wifi name>" password <wifi password>
    # -> connects to a new wifi network
    useDHCP = false;
    networkmanager.enable = true;

    hosts = {
      "173.212.222.231" = [ "con" "contabo" ];
      "185.113.124.212" = [ "ics" ];
      "185.113.124.20" = [ "the" ];
    };
  };

  time.timeZone = "Europe/Berlin";

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
      nb = "sudo nixos-rebuild switch -I nixos-config=/etc/nixos/machines/$(hostname).nix";
      nbu = "sudo nixos-rebuild switch -I nixos-config=/etc/nixos/machines/$(hostname).nix --upgrade";
      clean = "rm -rf ~/.local/share/Trash/files/* && sudo nix-collect-garbage";
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
        # this fixes audio stuttering
        # when using bluetooth headset + bluetooth mouse at the same time
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

  services.xserver = {
    enable = true;

    layout = "eu";
    # replaces capslock with control
    xkbOptions = "ctrl:nocaps";

    # resolution of UI elements
    dpi = 115;

    # keyboard repeat time
    autoRepeatInterval = 35;
    autoRepeatDelay = 320;

    # used to let home-manager handle xsession
    desktopManager = {
      xterm.enable = false;
      # wallpaper at ~./background-image will be used
      wallpaper.mode = "fill";
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
