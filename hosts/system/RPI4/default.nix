{
  imports = [
    ./hardware-configuration.nix
    ./packages.nix
    ../../../modules
  ];

  modules = {
    firewall = {
      enable = true;
    };
    git-daemon.enable = true;
    wifi = {
      enable = true;
    };
  };
}
