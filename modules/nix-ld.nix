{ config, lib, pkgs, ... }:
with lib;
{
  options.modules = {
    nix-ld.enable = lib.mkEnableOption "Enables nix-ld";
  };

  config = mkIf config.modules.nix-ld.enable {
    programs.nix-ld = {
      enable = true;
      libraries = with pkgs; [
        # Add any missing dynamic libraries for unpackaged
        # programs here, not in environment.systemPackages
      ];
    };
  };
}