{ config, lib, pkgs, is_nixos, configDir, home_profile, ... }:
  let 
    shellAliases_default = {
      ll = "ls -al";
      flake-up = "nix flake update --flake " + configDir;
      nv-gpu = "watch -n1 nvidia-smi";
    };

    shellAliases_nixos = {
    };
      
    shellAliases_nixpm = {
    };

    initExtra_default = ''
      export PS1='\[\e[1m\][ \[\e[96m\]\w \[\e[39m\]]\\$ \[\e[0m\]'
      nix-dev() {
        nix develop ${configDir}/.#"$1"
      }
    '';

    initExtra_nixos = ''
      system-up() {
        sudo nixos-rebuild switch --flake ${configDir}/.#"$1"
      }
      full-up() {
        flake-up && system-up "$1" && home-up "$2"
      }
    '';

    initExtra_nixpm = ''
      home-up() {
        home-manager switch --flake ${configDir}/.#"$1"
      }
      full-up() {
        flake-up && home-up "$1"
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

