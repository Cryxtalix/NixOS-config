{
  description = "Nix Develop flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
  };

  outputs = { self, nixpkgs }: 
  let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
  in 
  {
    c = import ./languages/c.nix { inherit self pkgs; };
    python = import ./languages/python.nix { inherit self pkgs; };
  };
}