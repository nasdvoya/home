{...}: {
  programs.wezterm = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = false;
    extraConfig = builtins.readFile ./wezterm/wezterm.lua;
  };
}
