{...}: {
  programs.git = {
    # Defaults
    enable = true;
    userName = "sasha";
    userEmail = "nasdvoya@proton.me";
    aliases = {
      l = "log --pretty=format:'%C(#cccc00)%h %Cred%ad %Creset%<(60,trunc)%s%C(auto)%d %C(magenta)%<(15,trunc)%an' --date=format:'%d/%m/%y %H:%M:%S'";
      dblame = "blame -w -C";
      b = "branch --format='%(color:#cccc00)%(objectname:short) %(color:red)%(committerdate:format:%d/%m/%y %H:%M:%S) %(color:bold white)%(refname:short)'";
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
      key = "388BE66EA3ACEA9C";
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
