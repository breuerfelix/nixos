{ config, pkgs, lib, ... }: {

  imports = [ <home-manager/nixos> ];

  security.sudo.wheelNeedsPassword = false;

  # Additional system users
  users = {
    defaultUserShell = pkgs.fish;
    users.felix = {
      isNormalUser = true;
      home = "/home/felix";
      description = "Felix Breuer";
      extraGroups = [ "wheel" "networkmanager" "audio" "dialout" ];
    };
  };

  nix.allowedUsers = [ "felix" ];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
  };

  # Home-manager configuration for user felix
  home-manager.users.felix = import ./felix.nix;
}
