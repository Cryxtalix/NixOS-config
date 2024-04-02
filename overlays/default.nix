{ config, lib, pkgs, ...}:

{
  nixpkgs.overlays = [
    (final: prev: {
      vscode = prev.vscode.overrideAttrs (old: {
        version = "1.85.2";
        rev = "8b3775030ed1a69b13e4f4c628c612102e30a681";
        src = prev.fetchurl {
          name = "VSCode_1.85.2_linux-x64.tar.gz";
          url = "https://update.code.visualstudio.com/1.85.2/linux-x64/stable";
          sha256 = "0v702nvv971rwv1grp921ys2d1ig0aq0di7idc1lfikl5ka9b4wa";
        };
      });
    })

    (final: prev: {
      proton-ge-805 = prev.proton-ge-bin.overrideAttrs (old: {
        pname = "proton-ge-805";
        version = "GE-Proton8-5";
        src = prev.fetchzip {
          url = "https://github.com/GloriousEggroll/proton-ge-custom/releases/download/GE-Proton8-5/GE-Proton8-5.tar.gz";
          hash = "sha256-NqBzKonCYH+hNpVZzDhrVf+r2i6EwLG/IFBXjE2mC7s=";
        };
        passthru.updateScript = "";
      });
    })
  ];
}