self: super: {
  breeze-cursor = self.stdenv.mkDerivation rec {
    pname = "hyperion";
    version = "0.1.0";

    # TODO add meta data
    # TODO fetch specific version
    src = builtins.fetchGit {
      url = "https://github.com/hyperion-project/hyperion.ng.git";
      fetchSubmodules = true;
    };

    buildInputs = with self.pkgs; [
      cmake
    ];

    buildPhase = ''
      ls
    '';

    installPhase = ''
      echo "instsall"
    '';
  };
}
