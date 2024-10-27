{ pkgs, pkgs-unstable, ... }:

let
  pkgJson = builtins.fromJSON (builtins.readFile ./packages.json);
  jsonPkgs = map (packageName: pkgs.${packageName}) pkgJson.packages;
  stablePkgs = with pkgs; [
    xclip
    zip
    unzip
    zoxide
    ranger
    xdotool
    firefox
    appimage-run
    obsidian
    pinentry-gnome3
    libreoffice
    (pkgs.nerdfonts.override {
      fonts = [
        "JetBrainsMono"
        "FiraCode"
        "VictorMono"
      ];
    })
  ];
  unstablePkgs = with pkgs-unstable; [
    neovim
    google-chrome
    mqttui
    commit-mono
    mqtt-explorer
    cachix
    slack
    jetbrains.rust-rover
    # Tooling
    live-server
    tree
    just
    usbutils
    fzf
    fd
    ripgrep
    yarn
    nodejs_22
    gcc
    # Language Servers
    lua-language-server
    lua
    omnisharp-roslyn
    vscode-langservers-extracted
    tailwindcss-language-server
    nil
    unison-ucm
    nixfmt-rfc-style
    htmx-lsp
    rust-analyzer
  ];
in

{
  imports = [
    ../../modules/packages
    ../../modules/dotfiles
    ../../tools/script-builder.nix
    ./git.nix
  ];

  home.username = "sasha";
  home.homeDirectory = "/home/sasha";
  home.sessionVariables = {
    EDITOR = "nvim";
  };
  home.packages = stablePkgs ++ unstablePkgs ++ jsonPkgs;

  # Enable custom modules
  desktopEnvironment.enable = true;
  programs.home-manager.enable = true;
  home.stateVersion = "24.05";

  dconf.settings = {
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
      ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>t";
      command = "wezterm-gui start --always-new-process";
      name = "Close window";
    };
  };
}
