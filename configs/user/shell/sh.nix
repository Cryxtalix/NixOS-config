{ config, lib, pkgs, is_nixos, configDir, ... }:
  let 
    shellAliases_default = {
      ll = "ls -al";
      nix-flake-up = "nix flake update --flake " + configDir;
      nv-gpu = "watch -n1 nvidia-smi";
      print_test = "echo sops.secrets.example_key";
    };

    shellAliases_nixos = {
      nix-cg = "sudo nix-collect-garbage --delete-older-than 7d";
    };
      
    shellAliases_nixpm = {
      nix-cg = "nix-collect-garbage --delete-older-than 7d";
    };

    initExtra_default = ''
      export PS1='\[\e[1m\][ \[\e[96m\]\w \[\e[39m\]]\\$ \[\e[0m\]'
      nix-dev() {
        nix develop ${configDir}/.#"$1"
      }
    '';

    initExtra_nixos = ''
      nix-system-up() {
        sudo nixos-rebuild switch --flake ${configDir}/.#"$1"
      }
      nix-full-up() {
        nix-flake-up && nix-system-up "$1" && nix-home-up "$2"
      }
    '';

    initExtra_nixpm = ''
      nix-home-up() {
        home-manager switch --flake ${configDir}/.#"$1"
      }
      nix-full-up() {
        nix-flake-up && nix-home-up "$1"
      }
    '';
  in
{
  programs.bash = {
    enable = true;
    
    shellAliases = if is_nixos then (
      lib.mkMerge [shellAliases_default shellAliases_nixos]
    ) else (
      lib.mkMerge [shellAliases_default shellAliases_nixpm]
    );

    sessionVariables = {

    };

    initExtra = if is_nixos then (
      lib.mkMerge [initExtra_default initExtra_nixos]
    ) else (
      lib.mkMerge [initExtra_default initExtra_nixpm]
    );
  };
}

