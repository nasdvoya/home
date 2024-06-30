{ config, pkgs, lib, ... }:
{
  programs.broot = {
    enable = true;
    enableBashIntegration = true;
    settings = {
      modal = true;
      verbs = [
        { invocation = "edit"; shortcut = "e"; execution = "/home/fiddlydigits/.nix-profile/bin/nvim {file}" ; }
      ];

    };
  };
}

