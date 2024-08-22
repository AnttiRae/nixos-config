{ config, pkgs, ... }:

let 
in {
    programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "tmux-256color";
    baseIndex = 1;

    keyMode = "vi";
    mouse = true;

    plugins = with pkgs; [
        {
            plugin = tmuxPlugins.resurrect;
            extraConfig = ''
            set -g @resurrect-capture-pane-contents 'on'
            '';
        }
        {
            plugin = tmuxPlugins.sensible;
        }
        {
            plugin = tmuxPlugins.tmux-fzf;
        }
        {
            plugin = tmuxPlugins.power-theme;
        }       
        {
            plugin = tmuxPlugins.continuum;
        }       
    ];
    extraConfig = ''
    set-option -g status-position top
    set-option -g status-right ""
    set -g detach-on-destroy off
    bind v copy-mode
    bind h select-pane -L
    bind j select-pane -D
    bind k select-pane -U
    bind l select-pane -R
    FZF_DEFAULT_OPTS='
    --color=fg:#dc8e8e,fg+:#d0d0d0,bg:#121212,bg+:#262626
    --color=hl:#5f87af,hl+:#5fd7ff,info:#afaf87,marker:#87ff00
    --color=prompt:#d7005f,spinner:#af5fff,pointer:#af5fff,header:#87afaf
    --color=border:#262626,label:#aeaeae,query:#d9d9d9
    --border="rounded" --border-label="" --preview-window="border-rounded" --prompt="> "
    --marker=">" --pointer="◆" --separator="─" --scrollbar="│"'
    TMUX_FZF_OPTIONS="-p -w 85% -h 75% -m"

    bind-key "t" run-shell -b "${pkgs.tmuxPlugins.tmux-fzf}/share/tmux-plugins/tmux-fzf/scripts/session.sh switch"
    bind-key "T" run-shell -b "${pkgs.tmuxPlugins.tmux-fzf}/share/tmux-plugins/tmux-fzf/scripts/session.sh"

    '';
    };
}