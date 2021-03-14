{ config, pkgs, lib, ... }: {
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
    obs-studio.enable = true;

    rofi = {
      enable = true;
      cycle = true;
      font = "FuraMono Nerd Font Mono 12";
      lines = 5;
      # TODO generate theme
      # TODO use with config.lib.formats.rasi;
      theme = ./rofi.rasi;
      # new config when using unstable
      #extraConfig = {
        #kb-remove-to-eol = "";
        #kb-accept-entry = "Return";
        #kb-row-up = "Control+k";
        #kb-row-down = "Control+j";
      #};
      extraConfig = ''
        kb-remove-to-eol: "";
        kb-accept-entry: "Return";
        kb-row-up: "Control+k";
        kb-row-down: "Control+j";
      '';
    };

    # TODO fix firefox
    #firefox = {
      #enable = true;
      #enableAdobeFlash = false;
      # TODO fix this error message "profile is not accessible"
      #profiles.felix = {
        #id = 4711;
        #isDefault = true;
        #settings = {
          #"browser.fullscreen.autohide" = false;
          #"ui.context_menus.after_mouseup" = true;
        #};
      #};
    #};

    chromium = {
      enable = true;
      #extensions = [
        #{ id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin
      #];
      extensions = [
        "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
      ];
    };
  };

  services = {
    flameshot.enable = true;
    picom = {
      enable = true;
      vSync = true;
      backend = "glx";
      experimentalBackends = true;
      #shadow = true;
      #noDNDShadow = false;
      #noDockShadow = true;
      #shadowExclude = [ "class_g = 'i3-frame'" ];
    };

    redshift = {
      enable = true;
      tray = true;
      # germany -> kölle
      latitude = "50.935173";
      longitude = "6.953101";
      brightness = {
        day = "1";
        night = "0.8";
      };
      #settings.redshift = {
        #brightness-night = "0.8";
        #brightness-day = "1";
      #};
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

      # i3 handles launching polybar
      # at the time nix launches polybar
      # there is no information about monitors available
      script = "exit 0";
    };
  };
}
