{
  description = "MyFlake";

  outputs = { self, nixpkgs, ... }@inputs:
    let
      lib = nixpkgs.lib;
      configDir = "~/NixOS-config"; # Path of this file
      timezone = "Asia/Singapore";
      locale = "en_SG.UTF-8";
      username = "cryxtalix";
    in
  {
    nixosConfigurations = 
      let
        /**
        * Function: Makes NixOS configs
        * Arguments: 2
        *
        * hostname: Hostname of system and determines folder of config in ./hosts/system/.
        * system(str) - Machine architecture. E.g. "x86_64-linux".
        */
        mkNixosConfig = hostname: system: lib.nixosSystem {
          inherit system;
          modules = [
            (./hosts/system/${hostname}/configuration.nix)
            inputs.sops-nix.nixosModules.sops
          ];
          specialArgs = {
            inherit timezone locale username hostname;
          };
        };
      in
    {
      swift3 = mkNixosConfig "AcerSwift3" "x86_64-linux";
      nixvm = mkNixosConfig "NixVM" "x86_64-linux";  
    };

    homeConfigurations = 
      let
        /**
        * Function: Makes standalone home-manager configs.
        * Arguments: 3
        *
        * name(str) - Determines folder of config in ./hosts/home/. E.g. "default".
        * system(str) - Machine architecture. E.g. "x86_64-linux".
        * is_nixos(bool) - Whether home-manager is installed on nixos.
        */
        mkHomeConfig = name: system: is_nixos: inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          modules = [ 
            ./hosts/home/${name}/home.nix 
          ] 
          ++ 
          (if (!is_nixos) then [
            inputs.sops-nix.homeManagerModules.sops
          ] else []);
          extraSpecialArgs = {
            pkgs_unstable = inputs.nixpkgs-unstable.legacyPackages.${system};
            inherit username configDir is_nixos;
          };
        };
      in
    {
      os_default = mkHomeConfig "default" "x86_64-linux" true;
      default = mkHomeConfig "default" "x86_64-linux" false;
      os_minimal = mkHomeConfig "minimal" "x86_64-linux" true;
      minimal = mkHomeConfig "minimal" "x86_64-linux" false;
    };

    # Development environments
    c = import ./dev-envs/c.nix {pkgs = nixpkgs.legacyPackages."x86_64-linux";};
    python = import ./dev-envs/python.nix {pkgs = nixpkgs.legacyPackages."x86_64-linux";};
    esp = import ./dev-envs/esp.nix {pkgs = nixpkgs.legacyPackages."x86_64-linux";};
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
