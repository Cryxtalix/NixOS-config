{
  imports = [
    ./hardware-configuration.nix
    ./packages.nix
    ../../../modules
    
    # Select DE
  ];

  custom = {
    firewall.enable = true;
    git-daemon.enable = true;
    use_networkmanager = false;
    nix-ld.enable = false;
    nvidia_gpu.enable = false;
    sops-nix.enable = true;
    sound.enable = false;
  };

  system.stateVersion = "23.11"; # Do not change
}
