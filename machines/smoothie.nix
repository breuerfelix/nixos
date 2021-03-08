{ config, lib, pkgs, modulesPath, ... }: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    "${builtins.fetchGit { url = "https://github.com/NixOS/nixos-hardware.git"; }}/lenovo/thinkpad/t490"
    ../common.nix
  ];

  # touchpad drivers
  services = {
    #thinkfan.enable = true;
    thermald.enable = true;
    xserver = {
      #synaptics.enable = true;
      videoDrivers = [ "intel" ];
    };
  };

  environment.etc."sysconfig/lm_sensors".text = ''
    HWMON_MODULES="coretemp"
  '';

  networking = {
    hostName = "smoothie";
    interfaces = {
      enp0s31f6.useDHCP = true;
      wlp0s20f3.useDHCP = true;
    };
  };

  boot = {
    loader.grub = {
      enable = true;
      version = 2;
      device = "nodev";
      efiSupport = true;
    };

    loader.efi.canTouchEfiVariables = true;
    cleanTmpDir = true;

    initrd = {
      kernelModules = [ "dm-snapshot" "coretemp" ];
      availableKernelModules = [
        "xhci_pci" "nvme" "usb_storage"
        "sd_mod" "sdhci_pci"
      ];

      luks.devices.root = {
        device = "/dev/disk/by-label/luks";
        preLVM = true;
        allowDiscards = true;
      };
    };

    kernelModules = [ "kvm-intel" ];
    #kernelPackages = pkgs.linuxPackages_5_10;
    extraModulePackages = [ ];
    # enables thinkfan control
    extraModprobeConfig = ''
      options thinkpad_acpi fan_control=1 experimental=1
    '';
  };

  # TODO by label
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/664abbd4-f9f6-4319-89a6-cde8fa6b3a85";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/505E-64F4";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/cc92ae77-fbb7-49fd-bdf0-adde340897f5"; }
    ];

  #hardware = {
    # high-resolution display
    #video.hidpi.enable = lib.mkDefault true;
    # disable until linux 5.10 (support for amd 5600x)
    # BIOS handles fan control
    #fancontrol.enable = false;
  #};

  powerManagement = {
    cpuFreqGovernor = lib.mkDefault "powersave";
    powertop.enable = true;
  };
}