{ config, pkgs, lib, ... }:
let vars = import ../constants.nix;
in {
  xresources.properties = {
    "color0" = "#${vars.colors.base00}";
    "color1" = "#${vars.colors.base01}";
    "color2" = "#${vars.colors.base02}";
    "color3" = "#${vars.colors.base03}";
    "color4" = "#${vars.colors.base04}";
    "color5" = "#${vars.colors.base05}";
    "color6" = "#${vars.colors.base06}";
    "color7" = "#${vars.colors.base07}";
    "color8" = "#${vars.colors.base08}";
    "color9" = "#${vars.colors.base09}";
    "color10" = "#${vars.colors.base0A}";
    "color11" = "#${vars.colors.base0B}";
    "color12" = "#${vars.colors.base0C}";
    "color13" = "#${vars.colors.base0D}";
    "color14" = "#${vars.colors.base0E}";
    "color15" = "#${vars.colors.base0F}";
  };
}

