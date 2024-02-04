{
  description = "MyFlake";

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, sops-nix, ... }:

    let
      # System settings
      lib = nixpkgs.lib;
      pkgs = import nixpkgs { inherit system; };
      pkgs_unstable = import nixpkgs-unstable { inherit system; };
      system = "x86_64-linux";
      timezone = "Asia/Singapore";
      locale = "en_SG.UTF-8";

      # User settings
      username = "cryxtalix";
      configDir = "~/NixOS-config"; # Path of this file
    in

  {
    nixosConfigurations = {

      swift3 = lib.nixosSystem {
        inherit system;
        modules = [
          (./configs/system/AcerSwift3/configuration.nix)
          sops-nix.nixosModules.sops
        ];
        specialArgs = {
          inherit timezone locale username;
          hostname = "AcerSwift3";
        };
      };

      nixvm = lib.nixosSystem {
        inherit system;
        modules = [
          (./configs/system/NixVM/configuration.nix)
          sops-nix.nixosModules.sops
        ];
        specialArgs = {
          inherit timezone locale username;
          hostname = "NixVM";
        };
      };
      
    };

    homeConfigurations = {

      os-default = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          (./configs/home/default/home.nix)
        ];
        extraSpecialArgs = {
          inherit pkgs_unstable username configDir;
          is_nixos = true;
        };
      };

      default = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          (./configs/home/default/home.nix)
          (./configs/home/modules/sops.nix)
          sops-nix.homeManagerModules.sops
        ];
        extraSpecialArgs = {
          inherit pkgs_unstable username configDir;
          is_nixos = false;
        };
      };

      os-minimal = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          (./configs/home/minimal/home.nix)
        ];
        extraSpecialArgs = {
          inherit pkgs_unstable username configDir;
          is_nixos = true;
        };
      };

      minimal = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          (./configs/home/minimal/home.nix)
          (./configs/home/modules/sops.nix)
          sops-nix.homeManagerModules.sops
        ];
        extraSpecialArgs = {
          inherit pkgs_unstable username configDir;
          is_nixos = true;
        };
      };

    };

    # Development environments
    c = import ./dev-envs/c.nix { inherit self pkgs; };
    python = import ./dev-envs/python.nix { inherit self pkgs; };
    esp = import ./dev-envs/esp.nix { inherit self pkgs; };
  };

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
  };

}
