{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true;
    shellAliases = {
      print_hello = "echo hello";
    };
  };
}