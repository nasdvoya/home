{ pkgs, pkgs-unstable, ... }:

let
  pkgJson = builtins.fromJSON (builtins.readFile ./packages.json);
  jsonPkgs = map (packageName: pkgs.${packageName}) pkgJson.packages;
  stablePkgs = with pkgs; [
    xclip
    zip
    unzip
    unzip
    zoxide
    ranger
    xdotool
    appimage-run
    obsidian
    wslu
    tmux
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];
  unstablePkgs = with pkgs-unstable; [
    neovim
    fzf
    fd
    ripgrep
    yarn
    nodejs_22
    gcc
    google-chrome
    mqttui
    just
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

  home.username = "nasdvoya";
  home.homeDirectory = "/home/nasdvoya";
  home.sessionVariables = {
    EDITOR = "nvim";
  };
  home.packages = stablePkgs ++ unstablePkgs ++ jsonPkgs;

  desktopEnvironment.enable = true;
  programs.home-manager.enable = true;

  home.stateVersion = "24.05";
}
