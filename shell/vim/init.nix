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

      # language servers
      #nodePackages.typescript
      #nodePackages.typescript-language-server
      #rnix-lsp
      #gopls
    ];
    plugins = with pkgs.vimPlugins; [
      vim-which-key

      # lsp
      #nvim-lspconfig
      #vim-vsnip
      #nvim-compe
      #nvim-web-devicons
      #(plugin "nvim-autopairs" "windwp/nvim-autopairs")

      # coc
      coc-nvim

      nvim-treesitter
      # TODO fix context
      #nvim-treesitter-context

      vim-airline
      fzfWrapper
      fzf-vim
      (plugin "colorizer-lua" "norcalli/nvim-colorizer.lua")
      (plugin "clever-f" "rhysd/clever-f.vim")
      # TODO fix wilder (:UpdateRemotePlugins does not work)
      #(plugin "wilder" "gelguy/wilder.nvim")
      vim-better-whitespace
      vim-sleuth
      nerdcommenter

      # TODO lazyload
      vimwiki
      vim-grammarous
      (plugin "startuptime" "dstein64/vim-startuptime")
      (plugin "vim-todo" "wsdjeg/vim-todo")
      nerdtree

      # TODO configure nvim tree lua
      #nvim-tree-lua
    ];
  };
}
