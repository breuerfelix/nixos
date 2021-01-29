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
        dimensions = { lines = 0; columns = 0; };
        padding = { x = 5; y = 5; };
      };

      scrolling = {
        history = 10000;
        multiplier = 3;
      };

      mouse = { hide_when_typing = true; };

      key_bindings = [
        { # clear terminal
          key = "L";
          mods = "Control";
          chars = "\\x0c";
        }
      ];

      font = vars.terminalFont;
      cursor = { style = "Block"; };
      colors = with vars.colors; {
        primary = {
          background = "0x${base00}";
          foreground = "0x${base05}";
        };
        cursor = {
          text = "0x${base00}";
          cursor = "0x${base0D}";
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
          red = "0x${base09}";
          green = "0x${base01}";
          yellow = "0x${base02}";
          blue = "0x${base04}";
          magenta = "0x${base06}";
          cyan = "0x${base0F}";
          white = "0x${base07}";
        };
      };
    };
  };
}
