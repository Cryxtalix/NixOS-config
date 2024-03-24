{ pkgs, linux-style }:
let
  nixpkgs-esp-dev = builtins.fetchGit {
    url = "https://github.com/mirrexagon/nixpkgs-esp-dev.git";
    rev = "7972602ad6bff6c87ec84b0467acfc7ea2046501";
  };
in
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
    . $HOME/esp-idf/export.sh
    alias bfm="idf.py build && idf.py flash && idf.py monitor"
    alias bf="idf.py build && idf.py flash"
    alias b="idf.py build"
    alias f="idf.py flash"
    alias m="idf.py monitor"
    format() {
      clang-format -i -style=file:${linux-style} "$1"
    }
    export PS1='\[\e[1m\](ESPIDF)[ \[\e[96m\]\w \[\e[39m\]]\\$ \[\e[0m\]'
    echo "Started ESP32 development environment..."
  '';
}
