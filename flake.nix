{
  description = "MyFlake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager";
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

    linux-style = {
      url = "https://raw.githubusercontent.com/torvalds/linux/master/.clang-format";
      flake = false;
    };

    nixpkgs-esp-dev = {
      type = "github";
      owner = "mirrexagon";
      repo = "nixpkgs-esp-dev";
      rev = "7972602ad6bff6c87ec84b0467acfc7ea2046501";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      mkNixosConfigurations = { hostname, system ? "x86_64-linux", user_profile ? "main" }: 
      nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/system/${hostname}
          ./user/${user_profile}/users.nix
          (import ./overlays)
          inputs.sops-nix.nixosModules.sops
        ];
        specialArgs = {
          user = import ./user/${user_profile};
          inherit hostname user_profile;
        };
      };

      mkHomeConfigurations = { profile, system ? "x86_64-linux", is_nixos, user_profile ? "main" }: 
      inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [ 
          ./hosts/home/${profile}
          (import ./overlays)
        ];
        extraSpecialArgs = {
          user = import ./user/${user_profile};
          wallpaper_source = inputs.wallpaper;
          inherit is_nixos;
        };
      };
    in
  {
    nixosConfigurations = {
      swift3 = mkNixosConfigurations {hostname = "AcerSwift3";};
      nixvm = mkNixosConfigurations {hostname = "NixVM";};
      rpi4 = mkNixosConfigurations {hostname = "RPI4"; system = "aarch64-linux";};
    };

    homeConfigurations = {
      default = mkHomeConfigurations {profile = "default"; is_nixos = true;};
      pm-default = mkHomeConfigurations {profile = "default"; is_nixos = false;};
      minimal = mkHomeConfigurations {profile = "minimal"; is_nixos = true;};
      pm-minimal = mkHomeConfigurations {profile = "minimal"; is_nixos = false;};
    };
  }
  //
  (let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages."${system}";
    linux-style = inputs.linux-style;
    nixpkgs-esp-dev = inputs.nixpkgs-esp-dev;
  in 
  {
    # Development environments
    c = import ./dev-envs/c.nix {inherit pkgs linux-style;};
    python = import ./dev-envs/python.nix {inherit pkgs;};
    esp = import ./dev-envs/esp.nix {inherit nixpkgs-esp-dev system nixpkgs linux-style;};
    mkdocs = import ./dev-envs/mkdocs.nix {inherit pkgs;};
  });
}
