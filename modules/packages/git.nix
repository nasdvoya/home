{ config, pkgs, lib, ... }:
{
  programs.git = {
    # Defaults 
    enable = true;
    userName = "sasha";
    userEmail = "nasdvoya@proton.me";
    extraConfig = {
      core = { sshCommand = "ssh -i ~/.ssh/nasdvoya"; };
    };
    # signing = {
    #   # Help here
    # };
    # Work
    includes = [
      { contents = { 
          user = { email = "sashawork@sashawork.org"; }; 
          core = { sshCommand = "ssh -i ~/.ssh/sasha_work"; };
        };
        condition = "gitdir:~/Work/";
      }
    ];
  };
}
