{ config, pkgs, lib, ... }:
{
  programs.helix = {
    enable = true; 
    languages = [ "lua" "csharp" ];
  };
}

