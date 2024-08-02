{ config, pkgs, lib, ... }:
{
  programs.wezterm = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = false;
    extraConfig = builtins.readFile ./wezterm/wezterm.lua;
  };

  home.file.".config/wezterm/session_manager.lua".source = ./wezterm/session_manager.lua;
}
