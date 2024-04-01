final: prev: 
{
  vscode = prev.vscode.overrideAttrs (old: {
    version = "1.85.2";
    rev = "8b3775030ed1a69b13e4f4c628c612102e30a681";

    src = prev.fetchurl {
      name = "VSCode_1.85.2_linux-x64.tar.gz";
      url = "https://update.code.visualstudio.com/1.85.2/linux-x64/stable";
      sha256 = "0v702nvv971rwv1grp921ys2d1ig0aq0di7idc1lfikl5ka9b4wa";
    };
  });
}