{ config, lib, pkgs, user, ... }:
with lib;
{
  options.modules = {
    virtualbox.enable = mkEnableOption "Install and configure Oracle Virtualbox";
  };

  config = mkIf config.modules.virtualbox.enable {
    virtualisation = {
      libvirtd.enable = true;
      virtualbox = {
        host.enable = true;
        guest.enable = true;
        guest.x11 = true;
      };
    };
    users.extraGroups.vboxusers.members = [ "${user.username}" ];
  };
}