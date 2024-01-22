{ config, lib, pkgs, is_nixos, configDir, home_profile, ... }:
  let 
    default = {
      ll = "ls -al";
      flake-up = "nix flake update --flake " + configDir;
      home-up = "home-manager switch --flake " + configDir + "#" + home_profile;
    };

    # Bash commands for NixOS only
    nixos = {
      system-up = "sudo nixos-rebuild switch --flake " + configDir;
    };
      
    # Bash commands for Nix PM only
    pm-only = {
      full-up = "flake-up && home-up";
    };
  in
{
  programs.bash = {
    enable = true;
    
    shellAliases = if is_nixos then (
      lib.mkMerge [default nixos]
    ) else (
      lib.mkMerge [default pm-only]
    );

    sessionVariables = {

    };

    initExtra = ''
      export PS1='\[\e[1m\][ \[\e[96m\]\w \[\e[39m\]]\\$ \[\e[0m\]'
      nix-dev() {
        nix develop ${configDir}/.#"$1"
      }
    '';
  };
}

