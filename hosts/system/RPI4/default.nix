{
  imports = [
    ./hardware-configuration.nix
    ../../../modules/users.nix
    ../../../modules/sops-nix.nix
    ./packages.nix
    ./networking.nix
    #./sops-nix.nix
    #./users.nix
  ];

  system.stateVersion = "23.11"; # Do not change
}
