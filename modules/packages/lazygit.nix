{ config, pkgs, lib, ... }:
{
  programs.lazygit = {
    enable = true;
    settings = {
      os = {
        editPreset = "nvim";
      };
    };
  };
}
