{
  imports = [
    ./hardware-configuration.nix
    ./packages.nix
    ../../../modules
    
    # Select DE
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
