{ pkgs, username, wallpaper, ... }:

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
        ];
      };
      "org/gnome/desktop/interface" = {
        clock-show-weekday = true;
        color-scheme = "prefer-dark";
        enable-hot-corners = false;
        show-battery-percentage = true;
      };
      "org/gnome/desktop/background" = {
        picture-uri = "/home/${username}/.config/wallpaper.png";
        picture-uri-dark = "/home/${username}/.config/wallpaper.png";
      };
      "org/gnome/desktop/wm/keybindings" = {
        cycle-windows = ["<Super>w"];
        move-to-monitor-left = ["<Shift><Super>1"];
        move-to-monitor-right = ["<Shift><Super>2"];
        switch-to-workspace-left = ["<Super>1"];
        switch-to-workspace-right = ["<Super>2"];
      };
    };
  };

  home.packages = with pkgs.gnomeExtensions; [
    alphabetical-app-grid
    blur-my-shell
    caffeine
    gsconnect # Check https://userbase.kde.org/KDEConnect#Troubleshooting
  ];

  home.file."./.config/wallpaper.png" = {
    source = "${wallpaper}";
  };
}