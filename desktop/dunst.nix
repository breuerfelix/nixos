{ config, pkgs, lib, ... }:
let vars = import ../constants.nix;
in {
  services.dunst = {
    enable = true;
    iconTheme = {
      name = vars.icons.name;
      package = pkgs."${vars.icons.packageName}";
      size = "32x32";
    };

    settings = with vars.colors; {
      global = {
        word_wrap = true;
        show_age_threshold = 60;
        idle_threshold = 120;

        padding = 8;
        horizontal_padding = 10;
        frame_width = 2;

        format = "%s %p\\n%b";
        geometry = "0x4-25+35";

        font = vars.font.name;
        frame_color = "#${base05}";
        separator_color = "#${base05}";
      };
      urgency_low = {
          background = "#${base01}";
          foreground = "#${base03}";
          timeout = 10;
      };
      urgency_normal = {
          background = "#${base02}";
          foreground = "#${base05}";
          timeout = 10;
      };
      urgency_critical = {
          background = "#${base08}";
          foreground = "#${base06}";
          timeout = 0;
      };
    };
  };
}
