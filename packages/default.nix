{ is_nixos, ... }:

{
  imports = [
    ./bash.nix
    ./git.nix
    ./gnupg.nix
    ./neovim/install-only.nix
    ./nix-direnv.nix
  ]
  ++ 
  (if is_nixos then [
    ./nix-ld.nix
  ] else [

  ]);
}