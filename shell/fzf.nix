{ config, pkgs, lib, ... }:
let vars = import ../constants.nix;
in {
  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
    defaultCommand = "fd --type f --hidden --follow --exclude .git --exclude .vim --exclude .cache";
    defaultOptions = with vars.colors; [
      "--border"
      "--inline-info"
      "--color 'fg:#${base04}'" # Text
      "--color 'bg:#${base00}'" # Background
      "--color 'preview-fg:#${base04}'" # Preview window text
      "--color 'preview-bg:#${base00}'" # Preview window background
      "--color 'hl:#${base0D}'" # Highlighted substrings
      "--color 'fg+:#${base06}'" # Text (current line)
      "--color 'bg+:#${base01}'" # Background (current line)
      "--color 'gutter:#${base00}'" # Gutter on the left (defaults to bg+)
      "--color 'hl+:#${base0D}'" # Highlighted substrings (current line)
      "--color 'info:#${base0A}'" # Info line (match counters)
      "--color 'border:#${base0C}'" # Border around the window (--border and --preview)
      "--color 'prompt:#${base0A}'" # Prompt
      "--color 'pointer:#${base0C}'" # Pointer to the current line
      "--color 'marker:#${base0C}'" # Multi-select marker
      "--color 'spinner:#${base0C}'" # Streaming input indicator
      "--color 'header:#${base0D}'" # Header
    ];
  };
}
