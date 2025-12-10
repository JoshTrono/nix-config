{pkgs,...}:
{
  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "Yaru-blue-dark";
      icon-theme = "Yaru-blue-dark";
      cursor-theme = "Yaru";

    };
    settings."org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = with pkgs.gnomeExtensions; [
        blur-my-shell.extensionUuid
        tiling-assistant.extensionUuid
        dash-to-dock.extensionUuid
        user-themes.extensionUuid
        blur-my-shell.extensionUuid
        appindicator.extensionUuid
      ];
    };
    settings = {
      "org/gnome/desktop/wm/preferences" = {
        button-layout = "appmenu:minimize,maximize,close";
      };
      "org/gnome/mutter" = {
        "experimental-features" = [ "scale-monitor-framebuffer" ];
      };
      "org/gnome/desktop/peripherals/mouse" = {
        "accel-profile" = "flat";
      };
      "org/gnome/desktop/peripherals/touchpad" = {
        "accel-profile" = "flat";
      };
    };
  };
  }