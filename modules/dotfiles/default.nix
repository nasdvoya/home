{lib, ...}: {
  options = {
    desktopEnvironment.enable = lib.mkEnableOption "Enable WM configuration.";
  };

  config = {
    home.file = lib.mkMerge [
      {
        ".config/nvim/" = {
          source = ./nvim;
          recursive = true;
        };
        ".config/zellij/" = {
          source = ./zellij;
          recursive = true;
        };
        ".config/wezterm/" = {
          source = ./wezterm;
          recursive = true;
        };
        ".config/tmux/" = {
          source = ./tmux;
          recursive = true;
        };
      }
    ];
  };
}
