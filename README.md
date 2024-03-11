# NixOS Config
My configuration uses flakes and standalone Home-Manager. In order to support multiple machines and profiles, my code prioritises modularity and reusable code. Sops-nix is used to handle secrets such as user passwords and wifi credentials. Also included is a GitHub workflow to check nixos configuration outputs for errors, and another for deploying the documentation to GitHub Pages.

Read more on:
https://cryxtalix.github.io/NixOS-config/