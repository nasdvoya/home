{
  pkgs,
  pkgs-unstable,
  ...
}: let
  pkgJson = builtins.fromJSON (builtins.readFile ./packages.json);
  jsonPkgs = map (packageName: pkgs.${packageName}) pkgJson.packages;
  stablePkgs = with pkgs; [
    xclip
    zip
    unzip
    zoxide
    ranger
    xdotool
    firefox
    appimage-run
    obsidian
    pinentry-gnome3
    libreoffice
    pax-utils
    evince
    file
    qemu
    quickemu
    neovim
    tmux
    pgcli
    cachix
    icu
    steam-run
    nixos-generators
    nixos-anywhere
    usbimager
    # Tooling / Languages
    jq
    yarn
    nodejs_22
    lua
    cmake
    gnumake
    rust-analyzer
    distrobox
    netcoredbg
    patchelf
    (
      with dotnetCorePackages;
        combinePackages [
          sdk_6_0
          sdk_7_0
          sdk_8_0
          sdk_9_0
        ]
    )
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
    google-chrome
    ghostty
    mqttui
    commit-mono
    mqtt-explorer
    slack
    jetbrains.rust-rover
    jetbrains.rider
    # Tooling
    htop-vim
    nix-serve
    live-server
    tree
    just
    usbutils
    fzf
    fd
    ripgrep
    gcc
    devenv
    msbuild
    roslyn
    # Language Servers
    lua-language-server
    nodePackages.bash-language-server
    roslyn-ls
    vscode-langservers-extracted
    tailwindcss-language-server
    nil
    unison-ucm
    nixfmt-rfc-style
    htmx-lsp
    # Code formatters
    alejandra
    stylua
    nodePackages.prettier
    prettierd
    shfmt
    csharpier
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

  dconf.settings = {
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
      ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>t";
      command = "alacritty";
      name = "Open terminal";
    };
  };
}
