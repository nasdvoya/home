{ config, pkgs, lib, ... }:

{
  options = {
    desktopEnvironment.enable = lib.mkEnableOption "Enable WM configuration.";
  };

  config = {
    home.file = lib.mkMerge [
      {
        # Always include nvim configuration
        ".config/nvim/" = {
          source = ./nvim;
          recursive = true;
        };
      }
    ];
  };
}
