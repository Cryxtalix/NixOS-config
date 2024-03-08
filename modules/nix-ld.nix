{ config, lib, pkgs, ... }:

{
  options.custom = {
    nix-ld.enable = lib.mkEnableOption "Enables nix-ld";
  };

  config = {
    programs.nix-ld = {
      enable = true;
      libraries = with pkgs; [
        # Add any missing dynamic libraries for unpackaged
        # programs here, not in environment.systemPackages
      ];
    };
  };
}