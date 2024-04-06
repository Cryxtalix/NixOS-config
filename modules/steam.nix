{ config, lib, pkgs, ... }:
with lib;
{
  options.modules = {
    steam.enable = mkEnableOption "Install and configure Steam";
  };

  config = mkIf config.modules.steam.enable {
    programs.steam = {
      enable = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };
  };
}