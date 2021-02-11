{ config, pkgs, lib, ... }: {
  # TODO maybe switch back to zsh
  programs.fish = {
    enable = true;
    shellAliases = {
      weather = "curl -4 http://wttr.in/Koeln";
      size = "du -sh";
      cp = "cp -i";
      kc = "kubectl";
      kci = "kubie";
      dk = "docker";
      pd = "podman";
      nvi = "nvim -u /etc/nixos/shell/backup.vim";
      ew = "nvim -c ':cd ~/vimwiki' ~/vimwiki";
    };
    # TODO https://github.com/franciscolourenco/done
    interactiveShellInit = ''
      source /etc/nixos/shell/init.fish

      set fish_greeting

      # bindings
      bind \v up-or-search
      bind \n down-or-search
      bind -k nul forward-char
      bind \cE edit_command_buffer

      # colorscheme
      set -U fish_color_normal normal
      set -U fish_color_command 81a1c1
      set -U fish_color_quote a3be8c
      set -U fish_color_redirection b48ead
      set -U fish_color_end 88c0d0
      set -U fish_color_error ebcb8b
      set -U fish_color_param eceff4
      set -U fish_color_selection white --bold --background=brblack
      set -U fish_color_search_match bryellow --background=brblack
      set -U fish_color_history_current --bold
      set -U fish_color_operator 00a6b2
      set -U fish_color_escape 00a6b2
      set -U fish_color_cwd green
      set -U fish_color_cwd_root red
      set -U fish_color_valid_path --underline
      set -U fish_color_autosuggestion 4c566a
      set -U fish_color_user brgreen
      set -U fish_color_host normal
      set -U fish_color_cancel -r
      set -U fish_pager_color_completion normal
      set -U fish_pager_color_description B3A06D yellow
      set -U fish_pager_color_prefix white --bold --underline
      set -U fish_pager_color_progress brwhite --background=cyan
      set -U fish_color_match --background=brblue
      set -U fish_color_comment 434c5e

      # prompt
      function fish_prompt --description 'Write out the prompt'
        set -l last_pipestatus $pipestatus

        if not set -q __fish_git_prompt_show_informative_status
          set -g __fish_git_prompt_show_informative_status 1
        end
        if not set -q __fish_git_prompt_hide_untrackedfiles
          set -g __fish_git_prompt_hide_untrackedfiles 1
        end
        if not set -q __fish_git_prompt_color_branch
          set -g __fish_git_prompt_color_branch magenta --bold
        end
        if not set -q __fish_git_prompt_showupstream
          set -g __fish_git_prompt_showupstream "informative"
        end
        if not set -q __fish_git_prompt_char_upstream_ahead
          set -g __fish_git_prompt_char_upstream_ahead "↑"
        end
        if not set -q __fish_git_prompt_char_upstream_behind
          set -g __fish_git_prompt_char_upstream_behind "↓"
        end
        if not set -q __fish_git_prompt_char_upstream_prefix
          set -g __fish_git_prompt_char_upstream_prefix ""
        end
        if not set -q __fish_git_prompt_char_stagedstate
          set -g __fish_git_prompt_char_stagedstate "●"
        end
        if not set -q __fish_git_prompt_char_dirtystate
          #set -g __fish_git_prompt_char_dirtystate "✚"
          set -g __fish_git_prompt_char_dirtystate "+"
        end
        if not set -q __fish_git_prompt_char_untrackedfiles
          set -g __fish_git_prompt_char_untrackedfiles "…"
        end
        if not set -q __fish_git_prompt_char_invalidstate
          set -g __fish_git_prompt_char_invalidstate "✖"
        end
        if not set -q __fish_git_prompt_char_cleanstate
          set -g __fish_git_prompt_char_cleanstate "✔"
        end
        if not set -q __fish_git_prompt_color_dirtystate
          set -g __fish_git_prompt_color_dirtystate blue
        end
        if not set -q __fish_git_prompt_color_stagedstate
          set -g __fish_git_prompt_color_stagedstate yellow
        end
        if not set -q __fish_git_prompt_color_invalidstate
          set -g __fish_git_prompt_color_invalidstate red
        end
        if not set -q __fish_git_prompt_color_untrackedfiles
          set -g __fish_git_prompt_color_untrackedfiles $fish_color_normal
        end
        if not set -q __fish_git_prompt_color_cleanstate
          set -g __fish_git_prompt_color_cleanstate green --bold
        end

        set -l color_cwd
        set -l prefix
        set -l suffix

        switch "$USER"
          case root toor
            if set -q fish_color_cwd_root
              set color_cwd $fish_color_cwd_root
            else
              set color_cwd $fish_color_cwd
            end
            set suffix '#'
          case '*'
            set color_cwd $fish_color_cwd
            set suffix '$'
        end

        # PWD
        set_color $color_cwd
        echo -n (prompt_pwd)
        set_color normal

        printf '%s ' (fish_vcs_prompt)

        set -l pipestatus_string (__fish_print_pipestatus "[" "] " "|" (set_color $fish_color_status) (set_color --bold $fish_color_status) $last_pipestatus)
        echo -n $pipestatus_string
        set_color normal

        echo -n "$suffix "
      end
      funcsave fish_prompt
    '';
  };
}
