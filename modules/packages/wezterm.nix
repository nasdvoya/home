{...}: {
  programs.wezterm = {
    enable = false;
    enableBashIntegration = true;
    enableZshIntegration = false;
    extraConfig = builtins.readFile ./wezterm/wezterm.lua;
  };
}
