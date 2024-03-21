{ lib, pkgs, user, wallpaper_source, ... }:

{
  dconf = {
    enable = true;
    settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false;
        disabled-extensions = [];
        enabled-extensions = [
          "caffeine@patapon.info"
          "gsconnect@andyholmes.github.io"
          "AlphabeticalAppGrid@stuarthayhurst"
          "blur-my-shell@aunetx"
        ];
        favorite-apps = [
          "firefox.desktop"
          "org.gnome.Terminal.desktop"
          "org.gnome.Nautilus.desktop"
          "org.gnome.Calculator.desktop"
          "org.gnome.Console.desktop"
        ];
        last-selected-power-profile = "power-saver";
      };
      "org/gnome/desktop/interface" = {
        clock-format = "24h";
        clock-show-weekday = true;
        clock-show-date = true;
        color-scheme = "prefer-dark";
        enable-hot-corners = false;
        show-battery-percentage = true;
      };
      "org/gnome/desktop/background" = {
        picture-uri = "${wallpaper_source}/${user.wallpaper}";
        picture-uri-dark = "${wallpaper_source}/${user.wallpaper}";
      };
      "org/gnome/desktop/peripherals/touchpad" = {
        tap-to-click = true;
      };
      "org/gnome/desktop/session" = {
        idle-delay = lib.hm.gvariant.mkUint32 0;
      };
      "org/gnome/mutter" = {
        edge-tiling = true;
        dynamic-workspaces = true;
        workspaces-only-on-primary = true;
      };
      "org/gnome/settings-daemon/plugins/power" = {
        power-saver-profile-on-low-battery = true;
        sleep-inactive-battery-timeout = 1200;
        sleep-inactive-ac-type = "nothing";
        power-button-action = "nothing";
      };

      # Shortcuts
      "org/gnome/desktop/wm/keybindings" = {
        cycle-windows = ["<Super>w"];
        move-to-monitor-left = ["<Shift><Super>1"];
        move-to-monitor-right = ["<Shift><Super>2"];
        switch-to-workspace-left = ["<Super>1"];
        switch-to-workspace-right = ["<Super>2"];
      };
      # Custom shortcuts
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        binding = "<Super>Return";
        command = "kgx";
        name = "Terminal";
      };
      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        ];
      };
    };
  };

  home.packages = with pkgs.gnomeExtensions; [
    alphabetical-app-grid
    blur-my-shell
    caffeine
    gsconnect # Check https://userbase.kde.org/KDEConnect#Troubleshooting
  ];
}

# Guide:
# https://hoverbear.org/blog/declarative-gnome-configuration-in-nixos/
# https://determinate.systems/posts/declarative-gnome-configuration-with-nixos/