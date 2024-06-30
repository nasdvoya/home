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

      (lib.mkIf config.desktopEnvironment.enable {
        ".config/tofi" = {
          source = ./tofi;
          recursive = true;
        };

        ".config/mako/" = {
          source = ./mako;
          recursive = true;
        };

        ".config/swaylock/" = {
          source = ./swaylock;
          recursive = true;
        };

        ".config/wlogout/" = {
          source = ./wlogout;
          recursive = true;
        };

        ".config/waybar/" = {
          source = ./waybar;
          recursive = true;
        };

        ".config/hypr/" = {
          source = ./hypr;
          recursive = true;
        };

        ".config/dot-config/" = {
          source = ./dot-config;
          recursive = true;
        };
      })
    ];
  };
}
