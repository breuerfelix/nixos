{ config, pkgs, lib, ... }: {
  programs.zsh = {
    enable = false;
    enableAutosuggestions = true;
    enableCompletion = true;
    autocd = true;
    dotDir = ".config/zsh";
    #defaultKeymap = ""; #vicmd or viins
    history = {
      expireDuplicatesFirst = true;
      ignoreDups = true;
      ignoreSpace = false;
      save = 20000;
      size = 20000;
      share = true;
    };

    dirHashes = {
      dl = "$HOME/Downloads";
    };

    shellAliases = {
      weather = "curl -4 http://wttr.in/Koeln";
      size = "du -sh";
      cp = "cp -i";
      kc = "kubectl";
      kci = "kubie";
      dk = "docker";
    };

    prezto = {
      enable = false;
      caseSensitive = false;
      utility.safeOps = true;
      editor = {
        dotExpansion = true;
        keymap = "vi";
      };
      prompt = {
        #showReturnVal = true;
        #theme = "";
      };
      python = {
        #virtualenvInitialize = true;
        #virtualenvAutoSwitch = true;
      };

      #pmodules = [];
    };
  };
}
