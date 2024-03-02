{
  imports = [
    ./hardware-configuration.nix
    ../../../modules/users.nix
    ../../../modules/sops-nix.nix
    ../../../modules/networking.nix {networking.use_networkmanager = false;}
    ./packages.nix
  ];

  system.stateVersion = "23.11"; # Do not change
}
