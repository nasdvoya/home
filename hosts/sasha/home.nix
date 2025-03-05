{
  pkgs,
  pkgs-unstable,
  ...
}: let
  stablePkgs = with pkgs; [
    lazydocker
    zoxide
    tmux
    ranger
    neovim
    postgresql_17
    # Tools
    jq
    yarn
    live-server
    nodejs_23
    patchelf
    nixos-generators
    nixos-anywhere
    tree
    just
    fzf
    fd
    ripgrep
    devenv
    msbuild
    nix-serve
    # Languages
    lua
    typescript
    nil
    unison-ucm
    # Language Servers
    typescript-language-server
    svelte-language-server
    jdt-language-server
    lua-language-server
    nodePackages.bash-language-server
    roslyn-ls
    vscode-langservers-extracted
    tailwindcss-language-server
    htmx-lsp
    elixir-ls
    next-ls
    pyright
    # Code formatters
    alejandra
    nixfmt-rfc-style
    nodePackages.prettier
    prettierd
    shfmt
    csharpier
    black # python
    # Fonts
    (pkgs.nerdfonts.override {
      fonts = [
        "JetBrainsMono"
        "VictorMono"
      ];
    })
  ];
  unstablePkgs = with pkgs-unstable; [
    stylua
  ];
in {
  imports = [
    ../../modules/packages
    ../../modules/dotfiles
    ./git.nix
  ];

  home.username = "sasha";
  home.homeDirectory = "/home/sasha";
  home.sessionVariables = {
    EDITOR = "nvim";
  };
  home.packages = stablePkgs ++ unstablePkgs;

  # Enable custom modules
  desktopEnvironment.enable = true;
  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
}
