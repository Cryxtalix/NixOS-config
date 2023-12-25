{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true;
    shellAliases = {
      print_hello = "echo hello";
    };
    initExtra = ''
      nix-dev() {
        nix develop ~/.flakes/dev_envs/.#"$1"
      }
    '';
  };
}