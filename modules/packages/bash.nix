{ config, pkgs, lib, ... }:
{
  programs.bash = {
    enable = true;
    profileExtra = builtins.readFile ./bash/.profile;
    logoutExtra = builtins.readFile ./bash/.bash_logout;
    bashrcExtra = builtins.readFile ./bash/.bashrc;
    shellAliases = {
      ## MISC
      # Add an "alert" alias for long running commands.  Use like so:
      # sleep 10; alert
      alert = "notify-send --urgency=low -i $([ $? = 0 ] && echo terminal || echo error) \"\$([ \$? = 0 ] && echo \"Success\" || echo \"Error\")\" \"\$*\"";
      cp = "cp -i";
      mv = "mv -i";
      rm = "rm -i";
      ll = "ls -alF";
      la = "ls -A";
      l = "ls -CF";
      vim = "nvim";
      vi = "nvim";
      rebuild = "sudo nixos-rebuild switch --flake /home/$(whoami)/Github/home#$(whoami)";
      # Programs
      code = "code --ozone-platform=wayland";
      notes = "obsidian --ozone-platform=wayland";
      mqtt = "/home/$(whoami)/Apps/MQTTExplorer.AppImage";
      # SSH
      ssh-docs = "ssh -i ~/.ssh/sasha_d_ocean root@192.168.100.3";
      ssh-rita = "ssh -i ~/.ssh/sasha_d_ocean root@192.168.100.5";
      ssh-backend = "ssh -i ~/.ssh/sasha_d_ocean root@192.168.100.4";
      ssh-frontend = "ssh -i ~/.ssh/sasha_d_ocean root@192.168.100.6";
      ssh-downloads = "ssh -i ~/.ssh/sasha_d_ocean root@192.168.100.7";
      ssh-raspy = "ssh -i ~/.ssh/id_rsa_raspy pi@192.168.2.200";
      ssh-personal_digitalocean = "ssh -i ~/.ssh/personal_digitalocean root@64.226.69.51";
      # GIT
      lg = "lazygit"; g = "git";
      ga = "git add"; gaa = "git add *";
      gc = "git commit"; gcm = "git commit -m"; gca = "git commit -am";
      gpl = "git pull"; gps = "git push"; gs = "git status";
      gd = "git diff"; gch = "git checkout"; gnb = "git checkout -b";
      gac = "git add . && git commit"; grs = "git restore --staged .";
      gre = "git restore"; gr = "git remote"; gcl = "git clone";
      gt = "git ls-tree -r master --name-only";
      gb = "git branch"; gbl = "git branch --list"; gm = "git merge";
      gf = "git fetch";
    };
  };
}
