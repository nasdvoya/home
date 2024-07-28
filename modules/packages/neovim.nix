{ config, pkgs, lib, ... }:
{
  programs.neovim = {
    enable = true;
    extraPackages = with pkgs; [
       ripgrep
       fd
       nil
       rustc
       cargo
       lua-language-server
    ];
  };
}
