{ config, pkgs, lib, ... }: {
  programs.neovim = {
    enable = true;
    withNodeJs = true;
    withPython = true;
    withPython3 = true;
    withRuby = true;
    extraConfig = lib.strings.concatStrings [
      (lib.strings.fileContents ./base.vim)
      (lib.strings.fileContents ./plugins.vim)
    ];
  };
}
