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
      homeDir = "/home/${username}";
      configDir = "${homeDir}/NixOS-config";

      mkNixosConfigurations = { hostname, system }: 
      lib.nixosSystem {
        inherit system;
        modules = [
          (./hosts/system/${hostname})
          inputs.sops-nix.nixosModules.sops
        ];
        specialArgs = {
          inherit timezone locale homeDir hostname;
        };
      };

      mkHomeConfigurations = { name, system, is_nixos }: 
      inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [ 
          ./hosts/home/${name}/home.nix 
        ];
        extraSpecialArgs = {
          pkgs_unstable = inputs.nixpkgs-unstable.legacyPackages.${system};
          inherit username homeDir configDir is_nixos wallpaper;
        };
      };

      wallpaper = inputs.wallpaper + "/carina.png";
      timezone = "Asia/Singapore";
      locale = "en_SG.UTF-8";
      username = "cryxtalix";
    in
  {
    nixosConfigurations = {
      swift3 = mkNixosConfigurations {hostname = "AcerSwift3"; system = "x86_64-linux";};
      nixvm = mkNixosConfigurations {hostname = "NixVM"; system = "x86_64-linux";};
      rpi4 = mkNixosConfigurations {hostname = "RPI4"; system = "aarch64-linux";};
    };

    homeConfigurations = {
      os-default = mkHomeConfigurations {name = "default"; system = "x86_64-linux"; is_nixos = true;};
      default = mkHomeConfigurations {name = "default"; system = "x86_64-linux"; is_nixos = false;};
      os-minimal = mkHomeConfigurations {name = "minimal"; system = "x86_64-linux"; is_nixos = true;};
      minimal = mkHomeConfigurations {name = "minimal"; system = "x86_64-linux"; is_nixos = false;};
    };

    # Development shells
    c = import ./dev-envs/c.nix {pkgs = nixpkgs.legacyPackages."x86_64-linux";};
    python = import ./dev-envs/python.nix {pkgs = nixpkgs.legacyPackages."x86_64-linux";};
    esp = import ./dev-envs/esp.nix {pkgs = nixpkgs.legacyPackages."x86_64-linux";};
  };
}