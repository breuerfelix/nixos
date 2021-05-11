{ config, pkgs, lib, ... }:
let unstable = import <nixos-unstable> {}; in
let
  master = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/master.tar.gz") {};
  # installs a vim plugin from git with a given tag / branch
  pluginGit = ref: repo: unstable.vimUtils.buildVimPluginFrom2Nix {
    pname = "${lib.strings.sanitizeDerivationName repo}";
    version = ref;
    src = builtins.fetchGit {
      url = "https://github.com/${repo}.git";
      ref = ref;
    };
  };
  # always installs latest version
  plugin = pluginGit "HEAD";
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
      (lib.strings.fileContents ./lsp.vim)
      #(lib.strings.fileContents ./coc.vim)
      ''
        lua << EOF
        ${lib.strings.fileContents ./config.lua}
        ${lib.strings.fileContents ./lsp.lua}

        -- setup omnisharp lsp
        -- nvim_lsp = require('lspconfig')
        local pid = vim.fn.getpid()
        local omnisharp_bin = "${master.omnisharp-roslyn}/bin/omnisharp"
        nvim_lsp.omnisharp.setup{
            cmd = { omnisharp_bin, "--languageserver" };
            filetypes = { "cs", "vb" };
            init_options = {};
            root_dir = nvim_lsp.util.root_pattern("*.csproj", "*.sln");
        }
        EOF
      ''
    ];
    extraPackages = with unstable; [
      # TODO use unstable tree-sitter once version hits 19
      master.tree-sitter

      jq curl # rest.nvim

      # for telescope
      # TODO add telescope
      #bat ripgrep fd

      zathura xdotool # pdfviewer for latex

      # extra language servers
      #rnix-lsp TODO fix slow closing time of neovim
      terraform-lsp
      nodePackages.typescript nodePackages.typescript-language-server
      gopls
      texlab
      nodePackages.pyright
      rust-analyzer
    ];
    plugins = with unstable.vimPlugins; [
      vim-which-key

      # lsp
      (plugin "neovim/nvim-lspconfig")
      #vim-vsnip
      (plugin "hrsh7th/nvim-compe")
      (plugin "Raimondi/delimitMate") # auto bracket
      (plugin "nvim-lua/lsp_extensions.nvim") # rust inline hints

      vimtex

      # syntax highlighting
      (plugin "nvim-treesitter/nvim-treesitter")
      (plugin "p00f/nvim-ts-rainbow") # bracket highlighting

      # TODO fix context
      #nvim-treesitter-context

      # utilities
      #(plugin "lua-popup" "nvim-lua/popup.nvim")
      (plugin "nvim-lua/plenary.nvim")
      #(plugin "nvim-telescope" "nvim-telescope/telescope.nvim")
      (plugin "kyazdani42/nvim-web-devicons")

      # TODO get this going
      #(plugin "nvim-nonicons" "yamatsum/nvim-nonicons")

      # highlights current variable with underline
      (plugin "yamatsum/nvim-cursorline")
      (plugin "lewis6991/gitsigns.nvim")
      (pluginGit "lua" "lukas-reineke/indent-blankline.nvim")

      (plugin "hoob3rt/lualine.nvim")
      (plugin "akinsho/nvim-bufferline.lua")

      #vim-airline
      fzfWrapper
      fzf-vim
      (plugin "norcalli/nvim-colorizer.lua")
      #(plugin "clever-f" "rhysd/clever-f.vim")
      (plugin "rhysd/clever-f.vim")
      # TODO fix wilder (:UpdateRemotePlugins does not work)
      #(plugin "wilder" "gelguy/wilder.nvim")
      vim-better-whitespace
      vim-sleuth
      vim-smoothie
      nerdcommenter

      emmet-vim
      (plugin "AndrewRadev/tagalong.vim")
      (plugin "metakirby5/codi.vim")

      # TODO lazyload
      vimwiki
      vim-grammarous
      (plugin "dstein64/vim-startuptime")
      (plugin "wsdjeg/vim-todo")
      goyo-vim
      limelight-vim
      (plugin "NTBBloodbath/rest.nvim") # http client

      # TODO configure nvim tree lua
      nerdtree
      #nvim-tree-lua

      # TODO maybe replace with nvim web devicons
      vim-devicons

      # colorschemes
      #(plugin "tokyo" "folke/tokyonight.nvim")
    ];
  };
}
