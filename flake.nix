{
  description = "MyFlake";

  outputs = { self, nixpkgs, home-manager, ... }:

    let
      # System settings
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};
      system = "x86_64-linux";
      hostname = "nixos";
      timezone = "Asia/Singapore";
      locale = "en_SG.UTF-8";
      configDir = "~/.flakes";

      # Profile
      # Change for different nix setups
      # Create folder of the same name in ./profiles
      profile = "acer_swift_laptop";
      is_nixos = true;

      # User settings
      name = "Cryxtalix";
      username = "cryxtalix";
      email = "fgx8p9t@protonmail.com";
    in

  {
    nixosConfigurations = if is_nixos then {
      nixos = lib.nixosSystem {
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
      cryxtalix = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          (./profiles + "/${profile}" + /home.nix)
        ];
        extraSpecialArgs = {
          inherit name;
          inherit username;
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