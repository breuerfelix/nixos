{ config, lib, pkgs, ...}:

with lib;

let
  cfg = config.programs.base16;
in {
  options = {
    programs.base16 = {
      enable = mkEnableOption "base16 colors.";
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
      dunst = mkOption {
        default = false;
        description = ''
          Dunst integration.
        '';
      };
      i3 = mkOption {
        default = false;
        description = ''
          i3 integration.
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

  # TODO make cfg.colors available in whole config
  # error: infinite recursion encountered when using config = with cfg.color
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

    # TODO convert to actual i3 home-manager config
    xsession.windowManager.i3.extraConfig = with cfg.colors; mkIf cfg.i3 ''
      set $base00 #${base00}
      set $base01 #${base01}
      set $base02 #${base02}
      set $base03 #${base03}
      set $base04 #${base04}
      set $base05 #${base05}
      set $base06 #${base06}
      set $base07 #${base07}
      set $base08 #${base08}
      set $base09 #${base09}
      set $base0A #${base0A}
      set $base0B #${base0B}
      set $base0C #${base0C}
      set $base0D #${base0D}
      set $base0E #${base0E}
      set $base0F #${base0F}

      # TODO implement bar in actual home-manager config with i3Bar = true
      #bar {
        #colors {
          #background $base00
          #separator  $base01
          #statusline $base04
          ## State             Border  BG      Text
          #focused_workspace   $base05 $base0D $base00
          #active_workspace    $base05 $base03 $base00
          #inactive_workspace  $base03 $base01 $base05
          #urgent_workspace    $base08 $base08 $base00
          #binding_mode        $base00 $base0A $base00
        #}
      #}

      # Property Name         Border  BG      Text    Indicator Child Border
      client.focused          $base05 $base0D $base00 $base0D $base0C
      client.focused_inactive $base01 $base01 $base05 $base03 $base01
      client.unfocused        $base01 $base00 $base05 $base01 $base01
      client.urgent           $base08 $base08 $base00 $base08 $base08
      client.placeholder      $base00 $base00 $base05 $base00 $base00
      client.background       $base07
    '';

    # https://github.com/khamer/base16-dunst/blob/master/templates/default.mustache
    services.dunst.settings = with cfg.colors; mkIf cfg.dunst {
      global = {
        frame_color = "#${base05}";
        separator_color = "#${base05}";
      };
      urgency_low = {
          background = "#${base01}";
          foreground = "#${base03}";
      };
      urgency_normal = {
          background = "#${base02}";
          foreground = "#${base05}";
      };
      urgency_critical = {
          background = "#${base08}";
          foreground = "#${base06}";
      };
    };
  }; # end config
}
