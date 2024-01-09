{ self, pkgs }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    gcc.cc.lib
    cmake
    python3
  ] ++ 
  (with pkgs.python311Packages; [
    # pip packages
    pip
    ninja
  ]);
  shellHook = ''
    . $HOME/Workspace/ESP32/esp-idf/export.sh
    echo "Started Python development environment..."
  '';
}
