{ pkgs }:

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
    alias idfa="idf.py build && idf.py flash && idf.py monitor"
    alias idfbf="idf.py build && idf.py flash"
    alias idfb="idf.py build"
    alias idff="idf.py flash"
    alias idfm="idf.py monitor"
    echo "Started ESP32 development environment..."
    export PS1='\[\e[1m\](Nix-shell)[ \[\e[96m\]\w \[\e[39m\]]\\$ \[\e[0m\]'
  '';
}
