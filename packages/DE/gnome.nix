{ pkgs, configDir, ... }:

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
        color-scheme = "prefer-dark";
        enable-hot-corners = false;
      };
      "org/gnome/desktop/background" = {
        picture-uri = "${configDir}/wallpapers/tarantula.png";
        picture-uri-dark = "${configDir}/wallpapers/tarantula.png";
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