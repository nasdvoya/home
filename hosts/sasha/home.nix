{
  pkgs,
  pkgs-unstable,
  ...
}: let
  pkgJson = builtins.fromJSON (builtins.readFile ./packages.json);
  jsonPkgs = map (packageName: pkgs.${packageName}) pkgJson.packages;
  stablePkgs = with pkgs; [
    lazydocker
    zoxide
    tmux
    ranger
    neovim
    nixos-generators
    nixos-anywhere
    postgresql_17
    # Tooling / Languages
    live-server
    jq
    yarn
    nodejs_22
    lua
    patchelf
    htop-vim
    nix-serve
    tree
    just
    fzf
    fd
    ripgrep
    devenv
    msbuild
    typescript
    roslyn
    # Language Servers
    typescript-language-server
    svelte-language-server
    jdt-language-server
    lua-language-server
    nodePackages.bash-language-server
    roslyn-ls
    vscode-langservers-extracted
    tailwindcss-language-server
    nil
    unison-ucm
    nixfmt-rfc-style
    htmx-lsp
    elixir-ls
    next-ls
    # Code formatters
    alejandra
    stylua
    nodePackages.prettier
    prettierd
    shfmt
    csharpier
    # Fonts
    (pkgs.nerdfonts.override {
      fonts = [
        "JetBrainsMono"
        "FiraCode"
        "VictorMono"
      ];
    })
  ];
  unstablePkgs = with pkgs-unstable; [
  ];
in {
  imports = [
    ../../modules/packages
    ../../modules/dotfiles
    ../../tools/script-builder.nix
    ./git.nix
  ];

  home.username = "sasha";
  home.homeDirectory = "/home/sasha";
  home.sessionVariables = {
    EDITOR = "nvim";
  };
  home.packages = stablePkgs ++ unstablePkgs ++ jsonPkgs;

  # Enable custom modules
  desktopEnvironment.enable = true;
  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
}
