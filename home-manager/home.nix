# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    ./tmux/tmux.nix
    ./nvim/nvim.nix
    ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don"t want unfree packages
      allowUnfree = true;
    };
  };

  # TODO: Set your username
  home = {
    username = "antti";
    homeDirectory = "/home/antti";
  };
 
  # git
  programs.git = {
    enable = true;
    userName = "Antti Rae";
    userEmail = "anttirae@gmail.com";
  };  


  # Add stuff for your user as you see fit:
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    initExtra = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    historySubstringSearch.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "history-substring-search"
        "colored-man-pages"
        "docker"
        "direnv"
        "kubectl"
        "kubectx"
      ];
    };
    
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerline10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = ./p10k;
        file = "p10k.zsh";
      }

    ];


  };

  programs.vscode = {
    enable = true;

    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      vscodevim.vim
      jdinhlife.gruvbox
      yzhang.markdown-all-in-one
    ];
    userSettings = {
      "editor.minimap.enabled" = "false";
      "workbench.colorTheme" = "Gruvbox Dark Medium";
    };
  };
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [ 
    steam 
    firefox
    alacritty
    alacritty-theme
    discord
    tidal-dl
    tidal-hifi
    thunderbird
    gnome3.gnome-tweaks
    gnome.gnome-system-monitor
    gnomeExtensions.blur-my-shell
    gnomeExtensions.forge
    gnomeExtensions.auto-move-windows
    gnomeExtensions.quick-settings-tweaker
    jetbrains-mono
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    zsh-powerlevel10k
    fd
    fzf
    ripgrep
    go
    python3
    devenv
    age
    ];


  # Enable home-manager
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";

  programs.alacritty = {
    enable = true;
    
    settings = {
      import = with pkgs.alacritty-theme; [
        
      ];
      window = {
        opacity = 0.9;
        decorations = "None";
        padding = {
          x = 2;
          y = 2;
        };
      };
      font.normal = {
        family = "JetBrainsMonoNerdFont";
      };
      colors.primary = {
        background = "#0f0f0f";
      };
      font = {
        size = 11;
      };
    };
  };
  
  dconf = {
    enable = true;
    settings."org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = with pkgs.gnomeExtensions; [
        blur-my-shell.extensionUuid
        forge.extensionUuid
        auto-move-windows.extensionUuid
        quick-settings-tweaker.extensionUuid
      ];
    };
    settings."org/gnome/shell/extensions/auto-move-windows" = {
      application-list = [
        com.mastermindzh.tidal-hifi.desktop:4
        com.discordapp.Discord.desktop:3
        steam.desktop:3
        org.mozilla.Thunderbird.desktop:4
      ];
    };
    settings."org/gnome/shell/wm/preferences" = {
      action-middle-click-titlebar="toggle-maximize";
      action-right-click-titlebar="menu";
      focus-mode="click";
      num-workspaces=5;
      resize-with-right-button = true;
      mouse-button-modifier = "<Super>";
    };
    settings."org/gnome/mutter" = {
      dynamic-workspaces=false;
    };

    settings."org/gnome/mutter/keybindings" = {
      switch-monitor=[];
    };
    
    settings."org/gnome/shell/extensions/forge" = {
      auto-split-enabled=false;
      focus-border-toggle=true;
      move-pointer-focus-enabled=false;
      preview-hint-enabled=true;
      quick-settings-enabled=true;
      showtab-decoration-enabled=false;
      split-border-toggle=true;
      stacked-tiling-mode-enabled=false;
      tabbed-tiling-mode-enabled=true;
      tiling-mode-enabled=true;
      window-gap-hidden-on-single=true;
      window-gap-size=lib.hm.gvariant.mkUint32 1;
      workspace-skip-tile="";
    };
    
    settings."org/gnome/shell/extensions/forge/keybindings" = {
      con-split-horizontal=["<Super>z"];
      con-split-layout-toggle=["<Super>g"];
      con-split-vertical=["<Super>v"];
      con-stacked-layout-toggle=[];
      con-tabbed-layout-toggle=["<Shift><Super>t"];
      con-tabbed-showtab-decoration-toggle=["<Control><Alt>y"];
      focus-border-toggle=[];
      mod-mask-mouse-tile="Super";
      prefs-tiling-toggle=["<Super>w"];
      window-focus-down=["<Super>j"];
      window-focus-left=["<Super>h"];
      window-focus-right=["<Super>l"];
      window-focus-up=["<Super>k"];
      window-gap-size-decrease=["<Control><Super>minus"];
      window-gap-size-increase=["<Control><Super>plus"];
      window-move-down=["<Shift><Super>j"];
      window-move-left=["<Shift><Super>h"];
      window-move-right=["<Shift><Super>l"];
      window-move-up=["<Shift><Super>k"];
      window-resize-bottom-decrease=["<Shift><Control><Super>i"];
      window-resize-bottom-increase=["<Control><Super>u"];
      window-resize-left-decrease=["<Shift><Control><Super>o"];
      window-resize-left-increase=["<Control><Super>y"];
      window-resize-right-decrease=["<Shift><Control><Super>y"];
      window-resize-right-increase=["<Control><Super>o"];
      window-resize-top-decrease=["<Shift><Control><Super>u"];
      window-resize-top-increase=["<Control><Super>i"];
      window-snap-center=["<Control><Alt>c"];
      window-snap-one-third-left=["<Control><Alt>d"];
      window-snap-one-third-right=["<Control><Alt>g"];
      window-snap-two-third-left=["<Control><Alt>e"];
      window-snap-two-third-right=["<Control><Alt>t"];
      window-swap-last-active=[];
      window-swap-down=["<Control><Super>j"];
      window-swap-left=["<Control><Super>h"];
      window-swap-right=["<Control><Super>l"];
      window-swap-up=["<Control><Super>k"];
      window-toggle-always-float=["<Shift><Super>c"];
      window-toggle-float=["<Super>c"];
      workspace-active-tile-toggle=["<Shift><Super>w"];
    };
    settings."org/gnome/desktop/input-sources" = {
      mru-sources = ["(xkb, eu)"];
      sources = [ (lib.gvariant.mkTuple [ "xkb" "eu"] )];
      show-all-sources = true;
    };
    settings."org/gnome/desktop/interface" = {
      cursor-theme = "Adwaita";
      enable-animations = true;
      clock-format = "24h";
      clock-show-seconds = true;
      clock-show-weekday = true;
      font-hinting = "slight";
      toolkit-accessibility = false;
      color-scheme = "prefer-dark";
    };

    settings."org/gnome/desktop/wm/keybindings" = {
      close=["<Super>x"];
      minimize=[];
      move-to-monitor-down=["<Super><Shift>Down"];
      move-to-monitor-left=["<Super><Shift>Left"];
      move-to-monitor-right=["<Super><Shift>Right"];
      move-to-monitor-up=["<Super><Shift>Up"];
      move-to-workspace-1=["<Shift><Super>1"];
      move-to-workspace-2=["<Shift><Super>2"];
      move-to-workspace-3=["<Shift><Super>3"];
      move-to-workspace-4=["<Shift><Super>4"];
      switch-applications=["<Super>Tab" "<Alt>Tab"];
      switch-applications-backward=["<Shift><Super>Tab" "<Shift><Alt>Tab"];
      switch-group=["<Super>Above_Tab" "<Alt>Above_Tab"];
      switch-group-backward=["<Shift><Super>Above_Tab" "<Shift><Alt>Above_Tab"];
      switch-panels=["<Control><Alt>Tab"];
      switch-panels-backward=["<Shift><Control><Alt>Tab"];
      switch-to-workspace-1=["<Super>1"];
      switch-to-workspace-2=["<Super>2"];
      switch-to-workspace-3=["<Super>3"];
      switch-to-workspace-4=["<Super>4"];
      switch-to-workspace-5=["<Super>5"];
      switch-to-workspace-last=["<Super>End"];
      switch-to-workspace-left=["<Super>Page_Up" "<Super><Alt>Left" "<Control><Alt>Left"];
      switch-to-workspace-right=["<Super>Page_Down" "<Super><Alt>Right" "<Control><Alt>Right"];
      toggle-fullscreen=["<Shift><Control><Alt><Super>t"];
      switch-tp-application-1=[];
      switch-tp-application-2=[];
      switch-tp-application-3=[];
      switch-tp-application-4=[];
    };

    settings."org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        binding="<Super>Return";
        command="alacritty";
        name="start alacritty";
    };

    settings."org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
        binding="<Super>p";
        command="firefox";
        name="start firefox";
    };

    settings."org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
      ];
      mic-mute="F8";
      next="<Super>period";
      play="<Super>slash";
      previous="<Super>comma";
      home=[];
      www=[];
      screensaver=["<Super>esc"];
    };
  };
}
