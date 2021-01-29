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
        "text/uri-list" = [ "firefox.desktop" "chromium.desktop" ];
        "text/html" = [ "firefox.desktop" "chromium.desktop" ];
        "x-scheme-handler/http" = [ "firefox.desktop" "chromium.desktop" ];
        "x-scheme-handler/https" = [ "firefox.desktop" "chromium.desktop" ];
        "x-scheme-handler/about" = [ "firefox.desktop" "chromium.desktop" ];
        "x-scheme-handler/unknown" = [ "firefox.desktop" "chromium.desktop" ];
      };
    };
  };
}
