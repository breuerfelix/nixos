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
      defaultApplications =
        let browsers = [ "firefox.desktop" "chromium.desktop" ]; in {
          "text/uri-list" = browsers;
          "text/html" = browsers;
          "x-scheme-handler/http" = browsers;
          "x-scheme-handler/https" = browsers;
          "x-scheme-handler/about" = browsers;
          "x-scheme-handler/unknown" = browsers;
          "x-scheme-handler/discord" = [ "discord.desktop" ];
          "application/pdf" = browsers;
        };
    };
  };
}
