{ config, pkgs, lib, ... }: {
  imports = [
    <home-manager/nixos>
    ./desktop/gtk-theme.nix
  ];

  security.sudo.wheelNeedsPassword = false;

  programs = {
    # database for gtk applications
    dconf.enable = true;
    # picks up shell alias
    fish.enable = true;
  };

  services = {
    greenclip.enable = true;
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
      extraGroups = [ "wheel" "networkmanager" "audio" "dialout" ];
    };
  };

  home-manager.users.felix = import ./felix.nix;
  nix.allowedUsers = [ "felix" ];
}
