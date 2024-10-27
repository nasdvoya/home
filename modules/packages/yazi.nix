{
  config,
  pkgs,
  lib,
  ...
}:

{
  programs.yazi = {
    enable = true;
    settings = {
      manager = {
        show_hidden = true;
      };
    };
  };
}
