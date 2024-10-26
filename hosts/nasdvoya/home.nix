{ pkgs, pkgs-unstable, ... }:

let
  pkgJson = builtins.fromJSON (builtins.readFile ./packages.json);
  jsonPkgs = map (packageName: pkgs.${packageName}) pkgJson.packages;
  stablePkgs = with pkgs; [
    xclip zip unzip zoxide
    ranger xdotool 
    appimage-run obsidian
    wslu
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];
  unstablePkgs = with pkgs-unstable; [
    neovim fzf fd ripgrep 
    nil 
    lua-language-server lua
    yarn nodejs_22 gcc google-chrome
    mqttui just
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
  home.packages = stablePkgs ++ unstablePkgs ++ jsonPkgs ;

  # Enable custom modules
  desktopEnvironment.enable = true;
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  
  home.stateVersion = "24.05";
}
