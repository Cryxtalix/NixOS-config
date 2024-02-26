{ ... }:

{
  users = {
    mutableUsers = false;
    extraGroups = {
      vboxusers.members = [ "user-with-access-to-virtualbox" ];
    };

    users = {
      cryxtalix = {
        description = "Main user";
        isNormalUser = true;
        hashedPassword = "$y$j9T$YgyOvaKbDgbYy4QLR5k/L1$JFoAyqp0etqD/FsMjubdjTBQ5PV/nr/e89GFVCZjAm/";
        extraGroups = [
          "networkmanager"
          "wheel"
          "podman"
          "vboxusers"
        ];
      };
    };
  };
}