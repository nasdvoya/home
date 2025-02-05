{...}: {
  programs.bash = {
    enable = true;
    profileExtra = builtins.readFile ./bash/.profile;
    logoutExtra = builtins.readFile ./bash/.bash_logout;
    bashrcExtra = builtins.readFile ./bash/.bashrc;
    shellAliases = {
      ## Misc
      cp = "cp -i";
      mv = "mv -i";
      rm = "rm -i";
      ll = "ls -alF";
      la = "ls -A";
      l = "ls -CF";
      vim = "nvim";
      vi = "nvim";
      vit = "NVIM_APPNAME=nvimexample nvim";
      rebuild = "home-manager switch --flake /home/$(whoami)/Github/nasdvoya/home#$(whoami)";
      # Programs
      # Git
      lg = "lazygit";
      g = "git";
      ga = "git add";
      gaa = "git add *";
      gc = "git commit";
      gcm = "git commit -m";
      gca = "git commit -am";
      gpl = "git pull";
      gps = "git push";
      gs = "git status";
      gd = "git diff";
      gch = "git checkout";
      gnb = "git checkout -b";
      gac = "git add . && git commit";
      grs = "git restore --staged .";
      gre = "git restore";
      gr = "git remote";
      gcl = "git clone";
      gt = "git ls-tree -r master --name-only";
      gb = "git branch";
      gbl = "git branch --list";
      gm = "git merge";
      gf = "git fetch";
    };
  };
}
