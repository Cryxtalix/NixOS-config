# My NixOS Configuration
Uses standalone home-manager and flakes.

## To update flake:
*Fetches latest versions of nixpkgs and dependencies*

$ `flake-up`

## To upgrade system packages:
$ `system-up <system_profile_name>`

## To upgrade home packages:
$ `home-up <home_profile_name>`

## Or to update and upgrade entire system:
* For NixOS systems:
 * $ `full-up <system_profile_name> <home_profile_name>`

* For Nix Package Manager systems:
 * $ `full-up <home_profile_name>`

## To start development environment:
*Convenient env, use dev templates for project specific envs*

$ `nix-dev <choice_of_language>`

# For nix package manager on another distro:
1. Install nix from `https://nixos.org/download`
2. Add home-manager channel: `nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz home-manager`
3. Update nix-channels: `nix-channel --update`
4. Install home-manager: `nix-shell '<home-manager>' -A install`
5. Go to ~/.config/nix/ creating the folders if they do not exist
6. Create config file with ` echo "experimental-features = nix-command flakes" >> nix.conf`
7. Run: `git clone https://github.com/Cryxtalix/NixOS-config && cd ~/NixOS-config`
8. Open flake.nix in a text editor. Change the attributes. Be sure to set `is_nixos = false;`
9. Run: `home-manager switch -b backup --flake .#username`