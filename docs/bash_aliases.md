# Some helpful bash aliases
Here are some bash aliases to simplify performing NixOS cli functions. They are defined in the packages/bash.nix file.

### To update flake:
$ `nix-flake-up`

### To upgrade system packages:
$ `nix-system-up <system_profile_name>`

### To upgrade home packages:
$ `nix-home-up <home_profile_name>`

### Or to update and upgrade entire system:
* For NixOS systems:
 * $ `nix-full-up <system_profile_name> <home_profile_name>`

* For Nix Package Manager systems:
 * $ `nix-full-up <home_profile_name>`

### To collect garbage and free resources from nix-store:
$ `nix-cg`

### To start development environment:
*Convenient env, use dev templates for project specific envs*

$ `nix-dev <choice_of_language>`