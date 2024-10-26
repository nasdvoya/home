{ pkgs, pkgs-unstable, ... }:

let
  pkgJson = builtins.fromJSON (builtins.readFile ./packages.json);
  jsonPkgs = map (packageName: pkgs.${packageName}) pkgJson.packages;
  stablePkgs = with pkgs; [
    xclip zip unzip zoxide
    ranger xdotool firefox
    appimage-run obsidian pinentry-gnome3
    libreoffice
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" "FiraCode" "VictorMono" ]; })
  ];
  unstablePkgs = with pkgs-unstable; [
    neovim fzf fd ripgrep 
    nil unison-ucm
    lua-language-server lua
    yarn nodejs_22 gcc google-chrome
    mqttui just commit-mono
    mqtt-explorer usbutils
    tree cachix slack jetbrains.rust-rover
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
  home.packages = stablePkgs ++ unstablePkgs ++ jsonPkgs ;

  
  # Enable custom modules
  desktopEnvironment.enable = true;

  # Let Home Manager install and manage itself.
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
