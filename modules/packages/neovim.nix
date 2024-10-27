{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs.neovim = {
    enable = true;
    extraPackages = with pkgs; [
      ripgrep
      fd
      fzf
      nil
      lua-language-server
      lua
      rust-analyzer
    ];
  };
}
