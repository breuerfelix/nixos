{ config, pkgs, lib, ... }:
let vars = import ../constants.nix;
in {
  programs.tmux = {
    enable = true;
    plugins = with pkgs; [ tmuxPlugins.nord ];
    extraConfig = with vars.colors; lib.strings.concatStrings [
      (lib.strings.fileContents ./.tmux.conf)
      #''
        ## Status update interval
        #set -g status-interval 1

        ## Basic status bar colors
        #set -g status-style fg=#${base06},bg=#${base01}

        ## Left side of status bar
        #set -g status-left-style bg=default,fg=default
        #set -g status-left-length 150
        #set -g status-left "#[fg=#${base01},bg=#${base0B},bold] #S #[fg=#${base0B},bg=#${base02},nobold]#[fg=#${base06},bg=#${base02}] #(whoami) #[fg=#${base02},bg=#${base04}]#[fg=#${base07},bg=#${base04}] #I:#P #[fg=#${base04},bg=default,nobold] #{pane_current_command} #{simple_git_status}"

        ## Right side of status bar
        #set -g status-right-style bg=default,fg=default
        #set -g status-right-length 150
        #set -g status-right "#[fg=#${base0C}]#{pane_current_path} #[fg=#${base04},bg=default]#[fg=#${base07},bg=#${base04}] %H:%M:%S #[fg=#${base02},bg=#${base04}]#[fg=#${base06},bg=#${base02}] %d-%b-%y #[fg=#${base0C},bg=#${base02}]#[fg=#${base01},bg=#${base0C},bold] #H "

        ## Window status
        #set -g window-status-format " #I:#W#F "
        #set -g window-status-current-format " #[fg=#${base01},bg=#${base0B}] #I:#W#F "

        ## Current window status
        #set -g window-status-current-style bg=default,fg=default

        ## Window with activity status
        #set -g window-status-activity-style bg=default,fg=default

        ## Window separator
        #set -g window-status-separator ""

        ## Window status alignment
        #set -g status-justify centre

        ## Pane border
        #set -g pane-border-style bg=default,fg=#${base01}

        ## Active pane border
        #set -g pane-active-border-style bg=default,fg=#${base0D}

        ## Pane number indicator
        #set -g display-panes-colour default
        #set -g display-panes-active-colour default

        ## Clock mode
        #set -g clock-mode-colour #${base0D}
        #set -g clock-mode-style 12

        ## Message
        #set -g message-style bg=#${base09},fg=#${base01}

        ## Command message
        #set -g message-command-style bg=#${base09},fg=#${base01}

        ## Mode
        #set -g mode-style bg=#${base02},fg=#${base01}
      #''
    ];
  };
}
