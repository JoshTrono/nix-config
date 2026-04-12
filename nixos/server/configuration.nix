{ config, pkgs, lib, ... }:

{
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
    services.endlessh = {
    enable = true;
    port = 22;
    openFirewall = true;
  };

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

  # Reduce unnecessary services
  documentation.enable = false;
  services.printing.enable = false;
  sound.enable = false;
  hardware.pulseaudio.enable = false;

  # Timezone (set yours)
  time.timeZone = "America/New_York";
}