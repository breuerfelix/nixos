{ config, pkgs, lib, ... }: {
  programs.neovim = {
    enable = true;
    withNodeJs = true;
    withPython = true;
    withPython3 = true;
    withRuby = true;
    configure = {
      # TODO generate base16 scheme
      customRC = lib.strings.concatStrings [
        (lib.strings.fileContents ./base.vim)
        (lib.strings.fileContents ./plugins.vim)
      ];
    };
  };
}
