# My NixOS Configuration
My configuration uses flakes and standalone Home-Manager. In order to support multiple machines and profiles, my code prioritises modularity and reusable code. Sops-nix is used to handle secrets such as user passwords and wifi credentials. Also included is a github workflow to check nixos configuration outputs for errors.

This document will document some features of the config.

## Index
[Helpful bash aliases](./bash_aliases.md)

[Installing Nix package manager on other distros](./installing_nix_pm.md)

[Running an SSH git server](./git_server.md)