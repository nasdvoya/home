{
  ...
}:
{
  programs.zellij = {
    enable = true;
    enableBashIntegration = true;
    # extraConfig = builtins.readFile ./wezterm/wezterm.lua;
  };
}
