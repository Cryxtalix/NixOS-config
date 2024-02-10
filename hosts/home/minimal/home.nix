{ config, lib, pkgs, pkgs_unstable, username, is_nixos, configDir, ... }:
  let
    pkgs_general = with pkgs; [
      distrobox
      firefox
      podman
    ];

    pkgs_nixos = with pkgs; [
      
    ];

    pkgs_not_nixos = with pkgs; [
      sops
    ];
  in
{
  imports = [
    ../../../packages
  ];

  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true; # Do not change
  targets.genericLinux.enable = if is_nixos then false else true;

  home = {
    username = username;
    homeDirectory = "/home/${username}";
    stateVersion = "23.11"; # Do not change

    packages = if is_nixos then (
      lib.mkMerge [pkgs_general pkgs_nixos]
    ) else (
      lib.mkMerge [pkgs_general pkgs_not_nixos]
    );

    file = {
      # dotfiles
    };

    sessionVariables = {
      # EDITOR = "emacs";
    };
  };

  /* sops = {
    age.keyFile = "/home/${username}/.config/sops/age/keys.txt";
    defaultSopsFile = ../../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";

    defaultSymlinkPath = "/run/user/1000/secrets";
    defaultSecretsMountPoint = "/run/user/1000/secrets.d";

    #secrets.example_key = {};
    # cat /run/user/1000/secrets/example_key
  };
  # Starts my_service only after sops-nix.service
  # systemd.user.services.my_service.Unit.After = [ "sops-nix.service" ]; */
}
