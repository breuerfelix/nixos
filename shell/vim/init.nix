{ config, pkgs, lib, ... }:
let unstable = import <nixos-unstable> {}; in
let
  master = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/master.tar.gz") {};
  plugin = name: repo: unstable.vimUtils.buildVimPluginFrom2Nix {
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
      (lib.strings.fileContents ./lsp.vim)
      #(lib.strings.fileContents ./coc.vim)
      ''
        lua << EOF
        ${lib.strings.fileContents ./config.lua}
        ${lib.strings.fileContents ./lsp.lua}

        -- TODO fix this
        -- setup omnisharp lsp
        -- nvim_lsp = require('lspconfig')
        local pid = vim.fn.getpid()
        local omnisharp_bin = "${master.omnisharp-roslyn}/bin/omnisharp"
        nvim_lsp.omnisharp.setup{
            cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) };
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

      # for telescope
      # TODO add telescope
      #bat ripgrep fd

      # pdfviewer for latex
      zathura xdotool

      # extra language servers
      #rnix-lsp TODO fix slow closing time of neovim
      terraform-lsp
      nodePackages.typescript nodePackages.typescript-language-server
      gopls
      texlab
      nodePackages.pyright
      dotnet-sdk_3 # TODO fix
    ];
    plugins = with unstable.vimPlugins; [
      vim-which-key

      # lsp
      (plugin "lsp" "neovim/nvim-lspconfig")
      #vim-vsnip
      (plugin "compe" "hrsh7th/nvim-compe")
      (plugin "delimitMate" "Raimondi/delimitMate")
      # get vimtex going

      # coc
      #coc-nvim
      #coc-fzf
      vimtex

      # syntax highlighting
      (plugin "nvim-treesitter" "nvim-treesitter/nvim-treesitter")
      (plugin "nvim-ts-rainbow" "p00f/nvim-ts-rainbow") # bracket highlighting

      # TODO fix context
      #nvim-treesitter-context

      # telescope
      #(plugin "lua-popup" "nvim-lua/popup.nvim")
      #(plugin "lua-plenary" "nvim-lua/plenary.nvim")
      #(plugin "nvim-telescope" "nvim-telescope/telescope.nvim")
      # TODO get these going
      #(plugin "nvim-web-devicons" "kyazdani42/nvim-web-devicons")
      #(plugin "nvim-nonicons" "yamatsum/nvim-nonicons")

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
      (plugin "tagalong" "AndrewRadev/tagalong.vim")
      (plugin "codi" "metakirby5/codi.vim")

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

      # TODO maybe replace with nvim web devicons
      vim-devicons
    ];
  };
}
