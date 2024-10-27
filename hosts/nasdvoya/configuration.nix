{
  config,
  lib,
  pkgs,
  ...
}:
let
  user = "nasdvoya";
in
{
  imports = [
    # include NixOS-WSL modules
    #<nixos-wsl/modules>
  ];

  wsl.enable = true;
  wsl.defaultUser = user;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  environment.systemPackages = with pkgs; [ ];

  users.users.${user} = {
    isNormalUser = true;
    description = "nasdvoya";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "lxd"
    ];
    packages = with pkgs; [ ];
  };

  networking.firewall.enable = true;

  system.stateVersion = "23.11"; # Did you read the comment?
}
