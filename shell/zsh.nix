{ config, pkgs, lib, ... }: {
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    autocd = true;
    dotDir = ".config/zsh";
    #defaultKeymap = ""; #vicmd or viins

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    history = {
      expireDuplicatesFirst = true;
      ignoreDups = true;
      ignoreSpace = false;
      save = 20000;
      size = 20000;
      share = true;
    };

    initExtraBeforeCompInit = ''
      eval "$(starship init zsh)"
    '';
    initExtra = ''
      path+=$HOME/.local/bin
      source /secrets/environment.bash

      # make libgc++ available in the terminal
      export LD_LIBRARY_PATH=${lib.makeLibraryPath [pkgs.stdenv.cc.cc]}

      bindkey '^e' edit-command-line
      bindkey '^ ' autosuggest-accept
      bindkey '^k' up-line-or-search
      bindkey '^j' down-line-or-search

      bindkey '^r' fzf-history-widget
      bindkey '^f' fzf-file-widget

      function watch() {
          while sleep 1
          do clear
              $*
          done
      }

      function cd() {
          builtin cd $*
          lsd
      }

      function mkd() {
          mkdir $1
          builtin cd $1
      }

      function take() { builtin cd $(mktemp -d) }
      function vit() { nvim $(mktemp) }

      function lgc() { git commit --signoff -m "$*" }

      function clone() { git clone git@$1.git }

      function gclone() { clone github.com:$1 }

      function bclone() { gclone breuerfelix/$1 }

      function gsm() { git submodule foreach "$* || :" }

      function lg() {
          git add --all
          git commit --signoff -a -m "$*"
          git push
      }

      function dci() { docker inspect $(docker-compose ps -q $1) }
    '';

    #dirHashes = {
    #dl = "$HOME/Downloads";
    #};

    shellAliases = {
      # builtins
      size = "du -sh";
      cp = "cp -i";
      mkdir = "mkdir -p";
      df = "df -h";
      free = "free -h";
      du = "du -sh";
      susu = "sudo su";
      op = "xdg-open";
      del = "rm -rf";
      sdel = "sudo rm -rf";
      lst = "ls --tree -I .git";
      lsl = "ls -l";
      lsa = "ls -a";
      null = "/dev/null";
      tu = "tmux";
      tmux = "tmux -u";

      g = "git";
      gst = "git status";
      gdi = "git diff";
      gdh = "git diff HEAD";

      # overrides
      cat = "bat";
      ssh = "TERM=screen ssh";

      # progrrams
      kc = "kubectl";
      kci = "kubie";
      dk = "docker";
      dc = "docker-compose";
      pd = "podman";
      pc = "podman-compose";
      sc = "sudo systemctl";
      py = "python";
      poe = "poetry";
      pi = "python -m pip";
      fb = "pcmanfm .";
      space = "ncdu";
      ca = "cargo";
      tf = "terraform";
      diff = "delta";
      nr = "npm run";

      # terminal cheat sheet
      cht = "cht.sh";
      # lists node_modules folder and their size
      npkill = "npx npkill";

      # utilities
      psf = "ps -aux | grep";
      lsf = "ls | grep";
      search = "sudo fd . '/' | grep"; # TODO replace with ripgrep
      shut = "sudo shutdown -h now";
      tssh = "ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null";
      caps = "xdotool key Caps_Lock";
      ew = "nvim -c ':cd ~/vimwiki' ~/vimwiki";
      weather = "curl -4 http://wttr.in/Koeln";

      dklocal = "docker run --rm -it -v `PWD`:/usr/workdir --workdir=/usr/workdir";
      dkclean = "docker container rm $(docker container ls -aq)";
      gclean = "git fetch -p && for branch in $(git branch -vv | grep ': gone]' | awk '{print $1}'); do git branch -D $branch; done";
    };

    plugins = [
      {
        name = "fast-syntax-highlighting";
        file = "fast-syntax-highlighting.plugin.zsh";
        src = "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions";
      }
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = "${pkgs.zsh-nix-shell}/share/zsh-nix-shell";
      }
    ];
    prezto = {
      enable = true;
      caseSensitive = false;
      utility.safeOps = true;
      editor = {
        dotExpansion = true;
        keymap = "vi";
      };
      python = {
        #virtualenvInitialize = true;
        #virtualenvAutoSwitch = true;
      };

      pmodules = [
        "autosuggestions"
        "completion"
        "directory"
        "editor"
        "git"
        "terminal"
      ];
    };
  };
}
