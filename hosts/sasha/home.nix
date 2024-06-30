{ self, pkgs, inputs, ... }:

let
  packageListJson = builtins.fromJSON (builtins.readFile ./packages.json);
  packageList = packageListJson.packages;
  dynamicPackages = map (packageName: pkgs.${packageName}) packageList;
  staticPackages = with pkgs; [
    # System & Desktop
    wlogout xdg-desktop-portal-hyprland pamixer grim slurp wl-clipboard nwg-displays wlr-randr 
    xfce.thunar nwg-look fluent-gtk-theme swaybg tofi brightnessctl 
    # CLI tools
    htop zip neofetch unzip lazygit xclip pavucontrol bluetuith ranger zoxide 
    sops
    # General
    mqttui helix neovim fzf ripgrep sqlite yarn nixos-generators qbittorrent
    gnome.gnome-boxes obsidian
    # Fixes & Misc
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    nixgl.nixGLIntel # GL fix
  ];

in

{
  imports = [ 
    ../../modules/packages
    ../../modules/dotfiles
    ../../tools/script-builder.nix
    inputs.sops-nix.homeManagerModules.sops
  ];
  # systemd.user.services.mbsync.Unit.After = [ "sops-nix.service" ];
  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/user/.config/sops/age/keys.txt";
    #secrets."myservice/my_subdir/my_secret" = { };
  };

  fonts.fontconfig.enable = true;
  home.sessionVariables = {
    EDITOR = "nvim";
  };
  home.username = "sasha";
  home.homeDirectory = "/home/sasha";
  home.stateVersion = "23.11";
  home.packages = staticPackages ++ dynamicPackages;
  
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  
  # Enable custom modules
  desktopEnvironment.enable = true;
}
