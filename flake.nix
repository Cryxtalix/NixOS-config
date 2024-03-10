{
  description = "MyFlake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wallpaper = {
      url = "github:Cryxtalix/Wallpapers";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      lib = nixpkgs.lib;

      mkNixosConfigurations = { hostname, system, user_profile ? "main" }: 
      lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/system/${hostname}
          ./user/${user_profile}/users.nix
          inputs.sops-nix.nixosModules.sops
        ];
        specialArgs = {
          user = import ./user/${user_profile};
          inherit hostname;
        };
      };

      mkHomeConfigurations = { profile, system, is_nixos, user_profile ? "main" }: 
      inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [ 
          ./hosts/home/${profile}
        ];
        extraSpecialArgs = {
          pkgs_unstable = inputs.nixpkgs-unstable.legacyPackages.${system};
          user = import ./user/${user_profile};
          wallpaper_source = inputs.wallpaper;
          inherit is_nixos;
        };
      };
    in
  {
    nixosConfigurations = {
      swift3 = mkNixosConfigurations {hostname = "AcerSwift3"; system = "x86_64-linux";};
      nixvm = mkNixosConfigurations {hostname = "NixVM"; system = "x86_64-linux";};
      rpi4 = mkNixosConfigurations {hostname = "RPI4"; system = "aarch64-linux";};
    };

    homeConfigurations = {
      os-default = mkHomeConfigurations {profile = "default"; system = "x86_64-linux"; is_nixos = true;};
      default = mkHomeConfigurations {profile = "default"; system = "x86_64-linux"; is_nixos = false;};
      os-minimal = mkHomeConfigurations {profile = "minimal"; system = "x86_64-linux"; is_nixos = true;};
      minimal = mkHomeConfigurations {profile = "minimal"; system = "x86_64-linux"; is_nixos = false;};
    };

    # Development shells
    c = import ./dev-envs/c.nix {pkgs = nixpkgs.legacyPackages."x86_64-linux";};
    python = import ./dev-envs/python.nix {pkgs = nixpkgs.legacyPackages."x86_64-linux";};
    esp = import ./dev-envs/esp.nix {pkgs = nixpkgs.legacyPackages."x86_64-linux";};
  };
}