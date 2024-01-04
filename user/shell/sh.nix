{ config, lib, pkgs, is_nixos, configDir, ... }:
  let 
    default = {
      print_dir = "echo " + configDir;
      nix-flake-up = "nix flake update --flake " + configDir;
      nix-home-up = "home-manager switch --flake " + configDir + "#username";
    };

    # Bash commands for NixOS only
    nixos = {
      nix-system-up = "sudo nixos-rebuild switch --flake " + configDir + "#hostname";
      nix-full-up = "nix-flake-up && nix-system-up && nix-home-up";
      isnixos = "echo YES";
    };
      
    # Bash commands for other distros
    home-only = {
      nix-full-up = "nix-flake-up && nix-home-up";
      isnixos = "echo NO";
    };
  in
{
  programs.bash = {
    enable = true;
    
    shellAliases = if is_nixos then (
      lib.mkMerge [default nixos]
    ) else (
      lib.mkMerge [default home-only]
    );

    initExtra = ''
      export PS1='\[\e[1m\][ \[\e[96m\]\w \[\e[39m\]]\\$ \[\e[0m\]'
      nix-dev() {
        nix develop ${configDir}/.#"$1"
      }
    '';
  };
}
