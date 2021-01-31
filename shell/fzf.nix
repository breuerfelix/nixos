{ config, pkgs, lib, ... }: {
  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
    defaultCommand = "fd --type f --hidden --follow --exclude .git --exclude .vim --exclude .cache";
    defaultOptions = [
      "--border"
      "--inline-info"
    ];
  };
}
