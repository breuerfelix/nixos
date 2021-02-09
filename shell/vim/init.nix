{ config, pkgs, lib, ... }:
let
  plugin = name: repo: pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "vim-plugin-${name}";
    version = "git";
    src = builtins.fetchGit {
      url = "https://github.com/${repo}.git";
    };
  };
in {
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    withNodeJs = true;
    withPython = true;
    withPython3 = true;
    withRuby = true;
    # decided to move the config into files
    # to get syntaxhighlighting (had config in plugins before)
    extraConfig = builtins.concatStringsSep "\n" [
      (lib.strings.fileContents ./base.vim)
      (lib.strings.fileContents ./plugins.vim)
      ''
        lua << EOF
        ${lib.strings.fileContents ./config.lua}
        EOF
      ''
    ];
    extraPackages = with pkgs; [
      # for compilation of treesitter
      gcc clang curl git
      # for telescope
      # TODO add telescope
      #bat ripgrep fd
      # language servers
      nodePackages.typescript
      nodePackages.typescript-language-server
      rnix-lsp
      gopls
    ];
    plugins = with pkgs.vimPlugins; [
      vim-which-key
      nvim-lspconfig
      nvim-treesitter
      # TODO fix context
      #nvim-treesitter-context
      vim-vsnip
      nvim-compe
      nvim-web-devicons
      vim-airline
      fzfWrapper
      fzf-vim
      (plugin "colorizer-lua" "norcalli/nvim-colorizer.lua")
      (plugin "nvim-autopairs" "windwp/nvim-autopairs")
      nerdtree
      # TODO configure nvim tree lua
      #nvim-tree-lua
      (plugin "clever-f" "rhysd/clever-f.vim")
      (plugin "vim-todo" "wsdjeg/vim-todo")
      (plugin "startuptime" "dstein64/vim-startuptime")
      vim-better-whitespace
      vim-sleuth
      nerdcommenter
      (plugin "wilder" "gelguy/wilder.nvim")
      vimwiki
    ];
  };
}
