{ config, pkgs, configDir, ... }:
  
{
  programs.bash = {
    enable = true;
    shellAliases = {
      print_test = "echo " + configDir;
      nix-flake-up = "nix flake update " + configDir;
      nix-system-up = "sudo nixos-rebuild switch --flake " + configDir;
      nix-home-up = "home-manager switch --flake " + configDir;
      nix-full-up = "nix-flake-up && nix-system-up && nix-home-up";
    };
    initExtra = ''
      nix-dev() {
        nix develop ${configDir}/.#"$1"
      }
    '';
  };
}