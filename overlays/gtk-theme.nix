{ config, pkgs, lib, ... }:
let
  vars = import ../constants.nix;
  materia-theme = builtins.fetchGit {
    url = "https://github.com/nana-4/materia-theme.git";
    # TODO built on latest master
    ref = "v20200916";
  };
  materia_colors = pkgs.writeTextFile {
    name = "gtk-generated-colors";
    text = with vars.colors; ''
      BTN_BG=${base02}
      BTN_FG=${base06}

      FG=${base05}
      BG=${base00}

      HDR_BTN_BG=${base01}
      HDR_BTN_FG=${base05}

      ACCENT_BG=${base0B}
      ACCENT_FG=${base00}

      HDR_FG=${base05}
      HDR_BG=${base02}

      MATERIA_SURFACE=${base02}
      MATERIA_VIEW=${base01}

      MENU_BG=${base02}
      MENU_FG=${base06}

      SEL_BG=${base0D}
      SEL_FG=${base0E}

      TXT_BG=${base02}
      TXT_FG=${base06}

      WM_BORDER_FOCUS=${base05}
      WM_BORDER_UNFOCUS=${base03}

      UNITY_DEFAULT_LAUNCHER_STYLE=False
      NAME=generated
      MATERIA_COLOR_VARIANT=dark
      MATERIA_STYLE_COMPACT=True
    '';
  };
in {
  # you can't run this in the home-manager
  # with home-manager.useGlobalPkgs = true;
  nixpkgs.overlays = [
    (self: super: {
      generated-gtk-theme = self.stdenv.mkDerivation rec {
        name = "generated-gtk-theme";
        src = materia-theme;
        buildInputs = with self; [ sassc bc which inkscape optipng ];
        installPhase = ''
          HOME=/build
          chmod 777 -R .
          patchShebangs .
          mkdir -p $out/share/themes
          substituteInPlace change_color.sh --replace "\$HOME/.themes" "$out/share/themes"
          echo "Changing colours:"
          ./change_color.sh -o Generated ${materia_colors}
          chmod 555 -R .
        '';
      };
    })
  ];
}
