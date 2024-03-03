{
  imports = [
    ./hardware-configuration.nix
    ./packages.nix
    ../../../modules/users.nix
    ../../../modules/sops-nix.nix
    ../../../modules/networking.nix {networking.use_networkmanager = false;}
    ../../../modules/git-daemon.nix
  ];

  system.stateVersion = "23.11"; # Do not change
}
