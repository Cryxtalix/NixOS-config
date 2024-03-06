{ pkgs, pkgs_unstable, user, is_nixos, ... }:

{
  imports = [
    ../../../packages

    # Select DE configs
    ../../../packages/DE/gnome.nix
  ];

  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true; # Do not change
  targets.genericLinux.enable = if is_nixos then false else true;

  home = {
    username = user.username;
    homeDirectory = user.homeDir;
    stateVersion = "23.11"; # Do not change

    packages = with pkgs; [
      distrobox
      firefox
      podman
    ]
    ++
    (if is_nixos then with pkgs; [
      # Only when NixOS
    ]
    else with pkgs; [
      # Only when not NixOS
      git-crypt
      sops
    ]);

    file = {
      # dotfiles
    };

    sessionVariables = {
      # EDITOR = "emacs";
    };
  };
}
