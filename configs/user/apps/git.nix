{ config, pkgs, username, email, ... }:

{
  programs.git = {
    enable = true;
    userName = "Cryxtalix";
    userEmail = "fgx8p9t@protonmail.com";
  };
}