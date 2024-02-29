{
  imports = [
    ./hardware-configuration.nix
    ./users.nix
    ./packages.nix
    ./networking.nix
    ./sops-nix.nix
  ];

  system.stateVersion = "23.11"; # Do not change
}
