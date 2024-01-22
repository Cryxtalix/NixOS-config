{ config, lib, pkgs, is_nixos, configDir, home_profile, ... }:
  let 
    shellAliases_default = {
      ll = "ls -al";
      flake-up = "nix flake update --flake " + configDir;
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
    '';

    initExtra_nixpm = ''
      home-up() {
        home-manager switch --flake ${configDir}/.#"$1"
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

