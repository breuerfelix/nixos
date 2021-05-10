{ config, pkgs, lib, ... }: {
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

      #font = let fontname = "Sauce Code Pro Nerd Font"; in {
      font = let fontname = "Recursive Mono Linear Static"; in {
        normal = { family = fontname; style = "Medium"; };
        bold = { family = fontname; style = "Bold"; };
        italic = { family = fontname; style = "Semibold Italic"; };
        size = 11;
      };
      cursor.style = "Block";
      #cursor.style = { blinking = "Always"; blink_interval = 500; };
    };
  };
}
