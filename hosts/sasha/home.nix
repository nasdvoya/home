{ config, pkgs, ... }:

let
  packageListJson = builtins.fromJSON (builtins.readFile ./packages.json);
  packageList = packageListJson.packages;
  dynamicPackages = map (packageName: pkgs.${packageName}) packageList;
  staticPackages = with pkgs; [
    xclip zip unzip zoxide
    gcc ranger xdotool firefox
    fzf
    
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];
in

{
 
  imports = [ 
    ../../modules/packages
    ../../modules/dotfiles
  ];

  home.username = "sasha";
  home.homeDirectory = "/home/sasha";
  home.sessionVariables = {
    EDITOR = "nvim";
  };
  home.packages = staticPackages ++ dynamicPackages;
   
  # Enable custom modules
  desktopEnvironment.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  home.stateVersion = "24.05";

}
