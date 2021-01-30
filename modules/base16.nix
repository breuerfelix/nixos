{ config, lib, pkgs, ...}:

with lib;

let
  cfg = config.programs.base16;
in {
  options = {
    programs.base16 = {
      enable = mkOption {
        default = false;
        description = ''
          Whether to enable base16 colors.
        '';
      };
      colors = mkOption {
        type = types.submodule {
          options = {
            base00 = mkOption { type = types.str; };
            base01 = mkOption { type = types.str; };
            base02 = mkOption { type = types.str; };
            base03 = mkOption { type = types.str; };
            base04 = mkOption { type = types.str; };
            base05 = mkOption { type = types.str; };
            base06 = mkOption { type = types.str; };
            base07 = mkOption { type = types.str; };
            base08 = mkOption { type = types.str; };
            base09 = mkOption { type = types.str; };
            base0A = mkOption { type = types.str; };
            base0B = mkOption { type = types.str; };
            base0C = mkOption { type = types.str; };
            base0D = mkOption { type = types.str; };
            base0E = mkOption { type = types.str; };
            base0F = mkOption { type = types.str; };
          };
        };
        default = { };
        description = ''
          Base16 colorset. TODO example
        '';
      };
      alacritty = mkOption {
        default = false;
        description = ''
          Alacritty integration.
        '';
      };
      xresources = mkOption {
        default = false;
        description = ''
          Xresources integration.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    # https://github.com/aaron-williamson/base16-alacritty/blob/master/templates/default-256.mustache
    programs.alacritty.settings.colors = with cfg.colors; mkIf cfg.alacritty {
      primary = {
        background = "0x${base00}";
        foreground = "0x${base05}";
      };
      cursor = {
        text = "0x${base00}";
        cursor = "0x${base05}";
      };
      normal = {
        black = "0x${base00}";
        red = "0x${base08}";
        green = "0x${base0B}";
        yellow = "0x${base0A}";
        blue = "0x${base0D}";
        magenta = "0x${base0E}";
        cyan = "0x${base0C}";
        white = "0x${base05}";
      };
      bright = {
        black = "0x${base03}";
        red = "0x${base08}";
        green = "0x${base0B}";
        yellow = "0x${base0A}";
        blue = "0x${base0D}";
        magenta = "0x${base0E}";
        cyan = "0x${base0C}";
        white = "0x${base07}";
      };
      indexed_colors = [
        { index = 16; color = "0x${base09}"; }
        { index = 17; color = "0x${base0F}"; }
        { index = 18; color = "0x${base01}"; }
        { index = 19; color = "0x${base02}"; }
        { index = 20; color = "0x${base04}"; }
        { index = 21; color = "0x${base06}"; }
      ];
    };

    # https://github.com/pinpox/base16-xresources/blob/master/templates/default-256.mustache
    xresources.extraConfig = with cfg.colors; mkIf cfg.xresources ''
      #define base00 #${base00}
      #define base01 #${base01}
      #define base02 #${base02}
      #define base03 #${base03}
      #define base04 #${base04}
      #define base05 #${base05}
      #define base06 #${base06}
      #define base07 #${base07}
      #define base08 #${base08}
      #define base09 #${base09}
      #define base0A #${base0A}
      #define base0B #${base0B}
      #define base0C #${base0C}
      #define base0D #${base0D}
      #define base0E #${base0E}
      #define base0F #${base0F}

      *foreground:   base05
      #ifdef background_opacity
      *background:   [background_opacity]base00
      #else
      *background:   base00
      #endif
      *cursorColor:  base05

      *color0:       base00
      *color1:       base08
      *color2:       base0B
      *color3:       base0A
      *color4:       base0D
      *color5:       base0E
      *color6:       base0C
      *color7:       base05

      *color8:       base03
      *color9:       base08
      *color10:      base0B
      *color11:      base0A
      *color12:      base0D
      *color13:      base0E
      *color14:      base0C
      *color15:      base07

      *color16:      base09
      *color17:      base0F
      *color18:      base01
      *color19:      base02
      *color20:      base04
      *color21:      base06
    '';
  };
}
