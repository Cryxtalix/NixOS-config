{ is_nixos, ... }:

{
  /* services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryFlavor = "gnome3"; # https://search.nixos.org/options?channel=23.11&show=programs.gnupg.agent.pinentryFlavor&from=0&size=50&sort=relevance&type=packages&query=gnupg.agent
  }; */

  # OR

  /* services.gnome-keyring.enable = true;

  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "gnome3";
  }; */


  home.file = {
    ".gnupg/gpg.conf".text = ''
      use-agent 
      pinentry-mode loopback
    '';

    # 86400 = 1 day
    # 604800 = 1 week
    ".gnupg/gpg-agent.conf".text = ''
      allow-loopback-pinentry

      # Passphrase Cache (seconds)
      
      default-cache-ttl 86400
      max-cache-ttl 86400
    '';
  };
}