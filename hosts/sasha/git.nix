{
  ...
}:
{
  programs.git = {
    # Defaults 
    enable = true;
    userName = "sasha";
    userEmail = "nasdvoya@proton.me";
    aliases = {
      l = "log --pretty=format:'%C(#cccc00)%h %Cred%ad %Creset%<(60,trunc)%s%C(auto)%d %C(magenta)%<(15,trunc)%an' --date=format:'%y%m%d'";
      dblame = "blame -w -C";
      b = "branch --format='%(color:#cccc00)%(objectname:short) %(color:red)%(committerdate:short) %(color:bold white)%(refname:short)'";
    };
    extraConfig = {
      core = {
        sshCommand = "ssh -i ~/.ssh/nasdvoya";
      };
      branch = {
        sort = "-committerdate";
      };
    };
    signing = {
      key = "4C9C9371782546C3"; # Correct GPG key ID
      signByDefault = true;
    };

    includes = [
      {
        contents = {
          user = {
            email = "sashawork@sashawork.org";
          };
          core = {
            sshCommand = "ssh -i ~/.ssh/sasha_work";
          };
        };
        condition = "gitdir:~/Work/";
      }
    ];
  };
}
