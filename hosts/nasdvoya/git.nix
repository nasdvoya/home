{...}: {
  programs.git = {
    # Defaults
    enable = true;
    userName = "nasdvoya";
    userEmail = "nasdvoya@proton.me";
    extraConfig = {
      core = {
        sshCommand = "ssh -i ~/.ssh/nasdvoya";
      };
    };
    signing = {
      key = "983B625FEE5065D9"; # Correct GPG key ID
      signByDefault = true;
    };
  };
}
