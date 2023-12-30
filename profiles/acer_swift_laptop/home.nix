{ config, pkgs, name, username, configDir, ... }:

{
  nixpkgs.config.allowUnfree = true;

  home.username = username;
  home.homeDirectory = "/home/" + username;
  home.stateVersion = "23.11"; # Do not change
  programs.home-manager.enable = true; # Do not change

  # Programs added here are managed by home-manager
  imports = [
    ../../user/shell/sh.nix
    ../../user/editor/neovim.nix
    #../../user/editor/nix-direnv.nix
  ];

  home.packages = with pkgs; [
    arduino
    bottles
    discord
    ffmpeg
    firefox
    gnomeExtensions.blur-my-shell
    gnomeExtensions.gsconnect
    #gnomeExtensions.prime-helper
    lutris
    marker
    steam
    telegram-desktop
    virtualbox
    virt-manager
    vscode
    wineWowPackages.stable
    winetricks
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/cryxtalix/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };
}
