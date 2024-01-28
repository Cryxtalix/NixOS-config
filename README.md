# My NixOS Configuration
Uses standalone home-manager and flakes.

## To update flake:
*Fetches latest versions of nixpkgs and dependencies*

$ `nix-flake-up`

## To upgrade system packages:
$ `nix-system-up <system_profile_name>`

## To upgrade home packages:
$ `nix-home-up <home_profile_name>`

## Or to update and upgrade entire system:
* For NixOS systems:
 * $ `nix-full-up <system_profile_name> <home_profile_name>`

* For Nix Package Manager systems:
 * $ `nix-full-up <home_profile_name>`

## To collect garbage and free resources from nix-store:
$ `nix-cg`

## To start development environment:
*Convenient env, use dev templates for project specific envs*

$ `nix-dev <choice_of_language>`

# For nix package manager on another distro:
**Ensure git is installed!**
1. Install nix from https://nixos.org/download with `sh <(curl -L https://nixos.org/nix/install) --no-daemon`
2. Add home-manager channel: `nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz home-manager`
3. Update nix-channels: `nix-channel --update`
4. Install home-manager: `nix-shell '<home-manager>' -A install`
5. Create folder with `mkdir ~/.config/nix`
6. Create config file with `echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf`
7. Run: `git clone https://github.com/Cryxtalix/NixOS-config && cd ~/NixOS-config`
8. Run: `home-manager switch -b backup --flake .#<your-home-profile>`