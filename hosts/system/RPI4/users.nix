{ config, ... }:

{
  users = {
    mutableUsers = false;

    users = {
      rpi4 = {
        description = "Main user";
        isNormalUser = true;
        #hashedPassword = "$y$j9T$YgyOvaKbDgbYy4QLR5k/L1$JFoAyqp0etqD/FsMjubdjTBQ5PV/nr/e89GFVCZjAm/";
        hashedPasswordFile = config.sops.secrets.cryxtalix_password.path;
        extraGroups = [ 
          "wheel"
        ];
      };
    };
  };

  sops.secrets.cryxtalix_password.neededForUsers = true;
}