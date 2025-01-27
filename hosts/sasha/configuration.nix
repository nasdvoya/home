{ pkgs, ... }:
# let
#   roq = import /home/sasha/Github/nasdvoya/dotnet-binary-derivation/qor/default.nix {
#     inherit (pkgs)
#       stdenv
#       lib
#       autoPatchelfHook
#       zlib
#       icu
#       ;
#   };
# in
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../modules/services
  ];

  # systemd.services.qor = {
  #   enable = false;
  #   description = ".NET Service";
  #   after = [ "network.target" ];
  #   wantedBy = [ "multi-user.target" ];
  #
  #   serviceConfig = {
  #     ExecStart = "${roq}/qor";
  #     Restart = "always";
  #     User = "sasha";
  #     Group = "users";
  #     WorkingDirectory = "${roq}";
  #     Environment = "DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1";
  #     StandardOutput = "journal";
  #     StandardError = "journal";
  #   };
  # };

  programs.nix-ld.enable = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  nix = {
    # package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # Set your time zone.
  time.timeZone = "Europe/Lisbon";
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_PT.UTF-8";
    LC_IDENTIFICATION = "pt_PT.UTF-8";
    LC_MEASUREMENT = "pt_PT.UTF-8";
    LC_MONETARY = "pt_PT.UTF-8";
    LC_NAME = "pt_PT.UTF-8";
    LC_NUMERIC = "pt_PT.UTF-8";
    LC_PAPER = "pt_PT.UTF-8";
    LC_TELEPHONE = "pt_PT.UTF-8";
    LC_TIME = "pt_PT.UTF-8";
  };

  # Services
  services.twingate.enable = true;
  services.dnsmasq.enable = true;
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  # Activate the X11
  # services.xserver.displayManager.gdm.wayland = false;

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "pt";
    xkb.variant = "nodeadkeys";
  };

  # Configure console keymap
  console.keyMap = "pt-latin1";
  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sasha = {
    isNormalUser = true;
    description = "Sasha";
    extraGroups = [
      "networkmanager"
      "wheel"
      "dialout"
      "podman"
      "docker"
    ];
    packages = with pkgs; [ ];
  };

  nixpkgs.config.allowUnfree = true;
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };
  environment.systemPackages = with pkgs; [ ];

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;
  system.stateVersion = "24.05"; # Did you read the comment?appstream
  networking = {
    useDHCP = false;
    enableIPv6 = false;
    nameservers = [
      "8.8.8.8"
      "8.8.4.4"
    ];
    # bridges = {
    #   "br0" = {
    #     interfaces = [ "enp0s31f6" ];
    #   };
    # };
  };
  networking.interfaces.enp0s31f6.useDHCP = true;
  networking.interfaces.enp0s31f6.ipv4.addresses = [
    {
      address = "192.168.1.20";
      prefixLength = 24;
    }
  ];
}
