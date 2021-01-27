{ config, pkgs, lib, ... }:
let vars = import ./constants.nix;
in {
  imports = [
    ./shell/alacritty.nix
    ./shell/fish.nix
    ./shell/vim.nix
    ./desktop/xresources.nix
    ./desktop/i3.nix
  ];

  programs.home-manager.enable = true;
  manual.manpages.enable = true;
  # allow installation of fonts
  fonts.fontconfig.enable = true;

  home = {
    keyboard.layout = "eu";
    sessionVariables.GTK_THEME = "Generated";

    packages = with pkgs; [
      # system
      nerdfonts corefonts
      pavucontrol
      pcmanfm
      libnotify
      # terminal
      fd ripgrep
      xclip
      #thefuck # TODO integration into shell via module
      universal-ctags
      podman podman-compose
      bitwarden-cli
      # programs
      ferdi
      blender
      veracrypt
      # TODO asesprite chrome calibre lossless cut noisetorch screenkey vlc wireshark
    ];
  };

  gtk = {
    enable = true;

    font = {
      name = vars.font.name;
      package = pkgs."${vars.font.packageName}";
    };

    iconTheme = {
      name = vars.icons.name;
      package = pkgs."${vars.icons.packageName}";
    };

    theme = {
      name = "Generated";
      package = pkgs.generated-gtk-theme;
    };

    gtk3.extraConfig.gtk-cursor-theme-name = "breeze";
  };

  programs = {
    git = {
      enable = true;
      delta.enable = true;
      userEmail = "fbreuer@pm.me";
      userName = "Felix Breuer";
      # TODO add signing
      aliases = {
        cm = "commit";
        di = "diff";
        dh = "diff HEAD";
        pu = "pull";
        st = "status -sb";
        co = "checkout";
        fe = "fetch";
        gr = "grep -in";
        re = "rebase -i";
      };
      ignores = [
        ".idea" ".vs" ".vsc" ".vscode" # ide
        ".DS_Store" # mac
        "node_modules" "npm-debug.log" # npm
        "__pycache__" "*.pyc" # python
        ".ipynb_checkpoints" # jupyter
        "__sapper__" # svelte
      ];
      extraConfig = {
        init = { defaultBranch = "main"; };
        pull = {
          ff = false;
          commit = false;
          rebase = true;
        };
      };
    };

    autojump = {
      enable = true;
      enableFishIntegration = true;
    };

    lsd = {
      enable = true;
      enableAliases = true;
    };

    bat = {
      enable = true;
      # TODO check if theme gets picked up
      config = { theme = "base16"; };
    };

    htop = {
      enable = true;
      treeView = true;
    };

    tmux = {
      enable = true;
      plugins = with pkgs; [ tmuxPlugins.nord ];
      extraConfig =
        lib.strings.fileContents ./shell/.tmux.conf;
    };

    fzf = {
      enable = true;
      enableFishIntegration = true;
      defaultCommand = "fd --type f --hidden --follow --exclude .git --exclude .vim --exclude .cache";
    };

    rofi = {
      enable = true;
      theme = "/etc/nixos/desktop/rofi.rasi";
      extraConfig = {
        kb-remove-to-eol = "";
        kb-accept-entry = "Return";
        kb-row-up = "Control+k";
        kb-row-down = "Control+j";
      };
    };

    firefox = {
      enable = true;
      # TODO fix this error message "profile is not accessible"
      #profiles.felix = {
        #id = 4711;
        #isDefault = true;
        #settings = {
          #"browser.fullscreen.autohide" = false;
          #"ui.context_menus.after_mouseup" = true;
        #};
      #};
    };

    obs-studio = {
      enable = true;
      #plugins = [ pkgs.obs-linuxbrowser ];
    };
  };

  services = {
    flameshot.enable = true;

    dunst = {
      enable = true;
      iconTheme = {
        name = vars.icons.name;
        package = pkgs."${vars.icons.packageName}";
        size = "32x32";
      };
      settings = {
        global = {
          word_wrap = true;
          show_age_threshold = 60;
          idle_threshold = 120;

          padding = 8;
          horizontal_padding = 10;
          frame_width = 2;

          format = "%s %p\\n%b";
          geometry = "0x4-25+35";

          font = vars.font.name;
          frame_color = "#${vars.colors.base05}";
          separator_color = "#${vars.colors.base05}";
        };
        urgency_low = {
            background = "#${vars.colors.base01}";
            foreground = "#${vars.colors.base03}";
            timeout = 10;
        };
        urgency_normal = {
            background = "#${vars.colors.base02}";
            foreground = "#${vars.colors.base05}";
            timeout = 10;
        };
        urgency_critical = {
            background = "#${vars.colors.base08}";
            foreground = "#${vars.colors.base06}";
            timeout = 0;
        };
      };
    };

    redshift = {
      enable = true;
      tray = true;
      # germany -> kölle
      latitude = "50.935173";
      longitude = "6.953101";
      brightness = {
        night = "0.8";
        day = "1";
      };
      temperature = {
        night = 3700;
        day = 5500;
      };
    };

    polybar = {
      enable = true;
      package = pkgs.polybar.override {
        i3GapsSupport = true;
        alsaSupport = true;
      };
      config = "/etc/nixos/desktop/polybar";
      script = "polybar bar &";
    };
  };
}
