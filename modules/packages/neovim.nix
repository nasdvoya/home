{ config, pkgs, lib, ... }:
{
  programs.neovim = {
    enable = true;
    extraPackages = with pkgs; [
       ripgrep
       fd
       fzf
       nil
       rustc
       cargo
       lua-language-server
       lua
    ];
  };
}
