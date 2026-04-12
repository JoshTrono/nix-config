{ inputs, config, pkgs, lib, ... }:

{
    imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # inputs.self.nixosModules.example

    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
    ./common/default.nix
  ];
 nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      inputs.self.overlays.additions
      inputs.self.overlays.modifications
      inputs.self.overlays.unstable-packages
      inputs.self.overlays.old-stable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Opinionated: disable global registry
      flake-registry = "";
      # Workaround for https://github.com/NixOS/nix/issues/9574
      nix-path = config.nix.nixPath;
    };
    # Opinionated: disable channels
    channel.enable = false;

    # Opinionated: make flake registry and nix path match flake inputs
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # System basics
  system.stateVersion = "25.11";

  networking.hostName = "server";

  # Enable networking (DHCP default)
  networking.useDHCP = lib.mkDefault true;

  # No GUI at all
  services.xserver.enable = false;
    services.fail2ban.enable = true;
  # OpenSSH hardened
  services.openssh = {
    enable = true;

    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      PubkeyAuthentication = true;
      AllowUsers = [ "joshua" ];

      # Optional hardening
      AllowAgentForwarding = "no";
    };
  };
  #   services.endlessh = {
  #   enable = true;
  #   port = 22;
  #   openFirewall = true;
  # };

  # Your user
  users.users.joshua = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILz2Ia+QZMdd09DC78gdD3hRTOOuQKr6bQAmNKID2GjJ joshua@Zeus"
    ];
  };

  # Sudo (optional but typical)
  security.sudo.wheelNeedsPassword = false;

  # Firewall
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 ];
  };

  # Minimal system packages (optional)
  environment.systemPackages = with pkgs; [
    git
    vim
  ];
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/joshua/nix-config"; # sets NH_OS_FLAKE variable for you
  };
  # Reduce unnecessary services
  documentation.enable = false;
  services.printing.enable = false;
  hardware.pulseaudio.enable = false;

  # Timezone (set yours)
  time.timeZone = "America/New_York";
}