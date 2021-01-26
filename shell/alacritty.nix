{ config, pkgs, lib, ... }:
let vars = import ../constants.nix;
in {
  programs.alacritty = {
    enable = true;
    settings = {
      env.TERM = "xterm-256color";
      background_opacity = 1;

      window = {
        dynamic_title = true;
        dynamic_padding = true;
        decorations = "full";
        dimensions = {
          lines = 0;
          columns = 0;
        };
        padding = {
          x = 5;
          y = 5;
        };
      };

      scrolling = {
        history = 10000;
        multiplier = 3;
      };

      mouse = { hide_when_typing = true; };
      #selection = { save_to_clipboard = true; };

      key_bindings = [
        # Clear terminal
        {
          key = "L";
          mods = "Control";
          chars = "\\x0c";
        }
      ];

      font = vars.font;
      cursor = { style = "Block"; };
      colors = {
        primary = {
          background = "0x${vars.colors.base00}";
          foreground = "0x${vars.colors.base05}";
        };
        cursor = {
          text = "0x${vars.colors.base00}";
          cursor = "0x${vars.colors.base0D}";
        };
        normal = {
          black = "0x${vars.colors.base00}";
          red = "0x${vars.colors.base08}";
          green = "0x${vars.colors.base0B}";
          yellow = "0x${vars.colors.base0A}";
          blue = "0x${vars.colors.base0D}";
          magenta = "0x${vars.colors.base0E}";
          cyan = "0x${vars.colors.base0C}";
          white = "0x${vars.colors.base05}";
        };
        bright = {
          black = "0x${vars.colors.base03}";
          red = "0x${vars.colors.base09}";
          green = "0x${vars.colors.base01}";
          yellow = "0x${vars.colors.base02}";
          blue = "0x${vars.colors.base04}";
          magenta = "0x${vars.colors.base06}";
          cyan = "0x${vars.colors.base0F}";
          white = "0x${vars.colors.base07}";
        };
      };
    };
  };
}
