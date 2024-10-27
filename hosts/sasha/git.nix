{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs.git = {
    # Defaults 
    enable = true;
    userName = "sasha";
    userEmail = "nasdvoya@proton.me";
    extraConfig = {
      core = {
        sshCommand = "ssh -i ~/.ssh/nasdvoya";
      };
    };
    signing = {
      key = "4C9C9371782546C3"; # Correct GPG key ID
      signByDefault = true;
    };
  };
}
