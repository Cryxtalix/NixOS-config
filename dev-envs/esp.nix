{ pkgs }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    gcc.cc.lib
    clang-tools
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
    alias bfm="idf.py build && idf.py flash && idf.py monitor"
    alias bf="idf.py build && idf.py flash"
    alias b="idf.py build"
    alias f="idf.py flash"
    alias m="idf.py monitor"
    echo "Started ESP32 development environment..."
    export PS1='\[\e[1m\](Nix-shell)[ \[\e[96m\]\w \[\e[39m\]]\\$ \[\e[0m\]'
  '';
}
