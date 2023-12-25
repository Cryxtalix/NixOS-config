{ self, pkgs }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    gcc.cc.lib
  ];
  shellHook = ''
    echo "Started C development environment..."
  '';
}