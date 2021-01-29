{ config, pkgs, lib, ... }:
let vars = import ../constants.nix;
in {
  xsession = {
    enable = true;
    # script gets generated by nixos
    scriptPath = ".hm-xsession";
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      # disable generation of default config
      config = null;
      extraConfig = with vars.colors; lib.strings.concatStrings [
        (lib.strings.fileContents ./i3.config)
        ''
          # base16 colorscheme
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

          # Property Name         Border  BG      Text    Indicator Child Border
          client.focused          $base05 $base0D $base00 $base0D $base0C
          client.focused_inactive $base01 $base01 $base05 $base03 $base01
          client.unfocused        $base01 $base00 $base05 $base01 $base01
          client.urgent           $base08 $base08 $base00 $base08 $base08
          client.placeholder      $base00 $base00 $base05 $base00 $base00
          client.background       $base07
        ''
      ];
    };
  };
}