{ homeDir, username, ... }:

{
  sops = {
    age.keyFile = "${homeDir}/.config/sops/age/keys.txt";
    defaultSopsFile = ../../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
      
    secrets = {
      
    };
  };
}