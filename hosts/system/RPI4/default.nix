{
  imports = [
    ./hardware-configuration.nix
    ./packages.nix
    ../../../modules/sops-nix.nix
    ../../../modules/networking.nix
    ../../../modules/git-daemon.nix
  ];

  networking.use_networkmanager = false;
  system.stateVersion = "23.11"; # Do not change
}
