{ config, pkgs, lib, ... }: {
  programs.neovim = {
    enable = true;
    withNodeJs = true;
    withPython = true;
    withPython3 = true;
    withRuby = true;
    configure = {
      customRC = lib.strings.concatStrings [
        (lib.strings.fileContents /etc/nixos/shell/base.vim)
        (lib.strings.fileContents /etc/nixos/shell/plugins.vim)
      ];
    };
  };
}
