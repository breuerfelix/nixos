{ config, pkgs, lib, ... }:
let
  unstable = import <nixos-unstable> {};
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
    viAlias = true;
    withNodeJs = true;
    withPython = true;
    withPython3 = true;
    withRuby = true;
    # decided to move the config into files
    # to get syntaxhighlighting (had config in plugins before)
    extraConfig = builtins.concatStringsSep "\n" [
      (lib.strings.fileContents ./base.vim)
      (lib.strings.fileContents ./plugins.vim)
      (lib.strings.fileContents ./coc.vim)
      # include ./lsp.lua and ./lsp.vim for neovim nightly lsp
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

      # extra language servers
      rnix-lsp
      terraform-lsp
    ];
    plugins = with unstable.vimPlugins; [
      vim-which-key

      # lsp
      #nvim-lspconfig
      #vim-vsnip
      #nvim-compe
      #(plugin "nvim-autopairs" "windwp/nvim-autopairs")

      # coc
      coc-nvim
      coc-fzf
      vimtex

      nvim-treesitter
      (plugin "nvim-ts-rainbow" "p00f/nvim-ts-rainbow") # bracket highlighting

      # TODO fix context
      #nvim-treesitter-context

      # telescope
      (plugin "lua-popup" "nvim-lua/popup.nvim")
      (plugin "lua-plenary" "nvim-lua/plenary.nvim")
      (plugin "nvim-telescope" "nvim-telescope/telescope.nvim")
      nvim-web-devicons

      vim-airline
      fzfWrapper
      fzf-vim
      (plugin "colorizer-lua" "norcalli/nvim-colorizer.lua")
      (plugin "clever-f" "rhysd/clever-f.vim")
      # TODO fix wilder (:UpdateRemotePlugins does not work)
      #(plugin "wilder" "gelguy/wilder.nvim")
      vim-better-whitespace
      vim-sleuth
      vim-smoothie
      nerdcommenter

      emmet-vim

      # TODO lazyload
      vimwiki
      vim-grammarous
      (plugin "startuptime" "dstein64/vim-startuptime")
      (plugin "vim-todo" "wsdjeg/vim-todo")
      goyo-vim
      limelight-vim

      # TODO configure nvim tree lua
      nerdtree
      #nvim-tree-lua

      vim-devicons
    ];
  };
}
