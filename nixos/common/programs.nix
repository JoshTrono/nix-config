{pkgs,...}:
{
 environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  nix-init
  discord
  vscodium
  direnv
  heroic
  mangohud
  winetricks
  wineWowPackages.stable
  jetbrains.rider
  android-tools
  android-studio
  distrobox
  nixfmt



  #cosmic
  #cosmic-ext-tweaks
  #cosmic-ext-applet-caffeine
  #cosmic-ext-applet-external-monitor-brightness

#gnome
    # gnomeExtensions.tiling-assistant
    # gnomeExtensions.dash-to-dock
    # gnomeExtensions.dash-to-panel
    # gnomeExtensions.arc-menu
    # gnomeExtensions.user-themes
    # gnomeExtensions.blur-my-shell
    # gnomeExtensions.appindicator

    # dracula-theme
    # yaru-theme
    # dconf-editor
    # gnome-tweaks

    gearlever

  ];

  #networking.firewall.enable = true;
  #security.apparmor.enable = true;
  #services.mullvad-vpn.enable = true;
  #services.mullvad-vpn.package = pkgs.mullvad-vpn;

programs.appimage = {
  enable = true;
  binfmt = true;
};

services.flatpak.packages = [
    #{ appId = "com.brave.Browser"; origin = "flathub";  }
    "com.obsproject.Studio"
    "io.gpt4all.gpt4all"
  ];

services.flatpak.enable = true;


      programs.firefox.enable = true;
      programs.ladybird.enable = true;

      programs.nix-ld.enable = true;
programs.nix-ld.libraries = with pkgs; [
  stdenv.cc.cc.lib
  zlib
  libz
  python312Packages.zstd
  zstd
  libGL
  glib
  glibc
  # Add other common libs here if needed
];
}
