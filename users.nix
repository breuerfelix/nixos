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
      extraGroups = [ "wheel" "networkmanager" "audio" "dialout" ]; # libvirtd
    };
  };

  nix.allowedUsers = [ "felix" ];

  home-manager = {
    # TODO Are you sure you want to use *BOTH* options here?
    useUserPackages = true;
    useGlobalPkgs = true;
  };

  # Home-manager configuration for user felix
  home-manager.users.felix = import ./felix-home-config.nix;
}
