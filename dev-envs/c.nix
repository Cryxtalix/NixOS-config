{ pkgs, linux-style }:
  
pkgs.mkShell {
  buildInputs = with pkgs; [
    gcc.cc.lib
    clang-tools
    cmake
  ];
  shellHook = ''
    format() {
      clang-format -i -style=file:${linux-style} "$1"
    }
    export PS1='\[\e[1m\](C)[ \[\e[96m\]\w \[\e[39m\]]\\$ \[\e[0m\]'
    echo "Started C development environment..."
  '';
}
