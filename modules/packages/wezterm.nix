{ config, pkgs, lib, ... }:
{
  programs.wezterm = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = false;
    extraConfig = builtins.readFile ./wezterm/wezterm.lua;
  };

  home.file.".config/wezterm/wezterm-session-manager/session-manager.lua".source = ./wezterm/session-manager.lua;
}
