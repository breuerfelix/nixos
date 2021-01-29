{ config, pkgs, lib, ... }:
let vars = import ../constants.nix;
in {
  xdg = {
    enable = true;
    # target paths use ~/.config as base path
    configFile = {
      coc_settings = {
        target = "nvim/coc-settings.json";
        source = ../shell/coc-settings.json;
      };
    };

    mime.enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = {
        "text/uri-list" = [ "firefox.desktop" ];
        #"text/x-uri" = [ "firefox.desktop" ];
      };
    };
  };
}
