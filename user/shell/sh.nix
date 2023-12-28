{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true;
    shellAliases = {
      print_hello = "echo hello";
      nix-flake-up = "nix flake update ~/.flakes";
      nix-system-up = "sudo nixos-rebuild switch --flake ~/.flakes";
      nix-home-up = "home-manager switch --flake ~/.flakes";
      nix-full-update = "nix-flake-up && nix-system-up && nix-home-up";
    };
    initExtra = ''
      nix-dev() {
        nix develop ~/.flakes/.#"$1"
      }
    '';
  };
}