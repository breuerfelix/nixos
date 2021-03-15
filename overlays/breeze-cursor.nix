{ config, pkgs, lib, ... }: {
  nixpkgs.overlays = [
    (self: super: {
      breeze-cursor = self.stdenv.mkDerivation rec {
        pname = "breeze-cursor";
        version = "0.1.0";

        src = builtins.fetchGit {
          url = "https://github.com/KDE/breeze.git";
        };

        buildInputs = with pkgs; [
          xorg.xcursorgen
          pkgs.inkscape
        ];

        dontDropIconThemeCache = true;

        buildPhase = ''
          cd cursors/Breeze; bash build.sh; cd -
          cd cursors/Breeze_Snow; bash build.sh; cd -
        '';

        installPhase = ''
          install -d $out/share/icons/Breeze/cursors
          cp -a cursors/Breeze/Breeze/cursors/* $out/share/icons/Breeze/cursors
          install -Dm644 cursors/Breeze/Breeze/index.theme $out/share/icons/Breeze/index.theme

          install -d $out/share/icons/Breeze-Snow/cursors
          cp -a cursors/Breeze_Snow/Breeze_Snow/cursors/* $out/share/icons/Breeze-Snow/cursors
          install -Dm644 cursors/Breeze_Snow/Breeze_Snow/index.theme $out/share/icons/Breeze-Snow/index.theme
        '';
      };
    })
  ];
}
