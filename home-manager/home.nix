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
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
      dracula-theme.theme-dracula
      yzhang.markdown-all-in-one
    ];
  };
  home.packages = with pkgs; [ 
    steam 
    gnome.gnome-system-monitor
    gnomeExtensions.blur-my-shell
    gnomeExtensions.forge
    ];

  # Enable home-manager
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";

  dconf = {
    enable = true;
    settings."org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = with pkgs.gnomeExtensions; [
        blur-my-shell.extensionUuid
        forge.extensionUuid
      ];
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
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
    settings."org/gnome/desktop/wm/keybindings" = {
      close = ["<Super>x"];
    };
  };
}
