{
  description = "MyFlake";

  outputs = { self, nixpkgs, home-manager, ... }:

    let
    /* 
    DO NOT KEEP PASSWORDS AND API KEYS HERE! Use proper secrets encryption like:
    sops-nix: https://github.com/Mic92/sops-nix
    OR
    agenix: https://github.com/ryantm/agenix
    */
      # System settings
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};
      system = "x86_64-linux";
      hostname = "nixos";
      timezone = "Asia/Singapore";
      locale = "en_SG.UTF-8";

      # User settings
      name = "Cryxtalix";
      username = "cryxtalix";
      email = "fgx8p9t@protonmail.com";

      # Likely to change when switching profiles
      profile = "acer_swift_laptop";
      is_nixos = false; # Set "false" if only using nix package manager on other distro
      use_default_home = true; # Set "true" to use home.nix file in ./profile/defaults
      configDir = "~/NixOS-config"; # Path of this file
    in

  {
    nixosConfigurations = if is_nixos then {
      hostname = lib.nixosSystem {
        inherit system;
        modules = [
          (./profiles + "/${profile}" + /configuration.nix)
        ];
        specialArgs = {
          inherit timezone;
          inherit locale;
          inherit name;
          inherit hostname;
        };
      };
    } else {};

    homeConfigurations = {
      username = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = if use_default_home then [
          (./profiles/defaults/home.nix)
        ] else if !use_default_home then [
          (./profiles + "/${profile}" + /home.nix)
        ] else [];
        extraSpecialArgs = {
          inherit name;
          inherit username;
          inherit email;
          inherit is_nixos;
          inherit configDir;
        };
      };
    };

    # Development environments
    c = import ./dev-envs/c.nix { inherit self pkgs; };
    python = import ./dev-envs/python.nix { inherit self pkgs; };
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

}
