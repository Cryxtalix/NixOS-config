{ pkgs, user, is_nixos, ... }:

{
  imports = [
    ./packages.nix
    ../../../packages

    # Select DE configs
    ../../../packages/DE/gnome.nix
  ];

  programs.home-manager.enable = true; # Do not change
  targets.genericLinux.enable = if is_nixos then false else true;

  home = {
    username = user.username;
    homeDirectory = user.homeDir;
    stateVersion = "23.11"; # Do not change

    sessionVariables = {
      # EDITOR = "emacs";
    };
  };
}
