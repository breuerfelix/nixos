{ config, pkgs, lib, ... }:
let vars = import ../constants.nix;
in {
  imports = [
    ./i3.nix
    ./xdg.nix
    ./dunst.nix
  ];

  gtk = {
    enable = true;

    font = {
      name = "Source Sans Pro 10";
      package = pkgs.source-sans-pro;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    theme = {
      name = "Generated";
      package = pkgs.generated-gtk-theme;
    };

    gtk3.extraConfig.gtk-cursor-theme-name = "breeze";
  };

  programs = {
    rofi = {
      # TODO generate theme
      enable = true;
      cycle = true;
      #font = vars.font.name;
      lines = 5;
      theme = ./rofi.rasi;
      extraConfig = {
        kb-remove-to-eol = "";
        kb-accept-entry = "Return";
        kb-row-up = "Control+k";
        kb-row-down = "Control+j";
      };
    };

    firefox = {
      enable = true;
      # TODO fix this error message "profile is not accessible"
      #profiles.felix = {
        #id = 4711;
        #isDefault = true;
        #settings = {
          #"browser.fullscreen.autohide" = false;
          #"ui.context_menus.after_mouseup" = true;
        #};
      #};
    };

    chromium = {
      enable = true;
      extensions = [
        { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin
      ];
    };

    obs-studio = {
      enable = true;
      #plugins = [ pkgs.obs-linuxbrowser ];
    };
  };

  services = {
    flameshot.enable = true;

    redshift = {
      enable = true;
      tray = true;
      # germany -> kölle
      latitude = "50.935173";
      longitude = "6.953101";
      brightness = {
        night = "0.8";
        day = "1";
      };
      temperature = {
        night = 3700;
        day = 5500;
      };
    };

    polybar = {
      enable = true;
      package = pkgs.polybar.override {
        i3GapsSupport = true;
        alsaSupport = true;
      };
      config = ./polybar.ini;
      script = "polybar bar &";
    };
  };
}
