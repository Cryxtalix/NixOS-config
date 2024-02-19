{ pkgs }:
  
pkgs.mkShell {
  buildInputs = with pkgs; [
    gcc.cc.lib
    cmake
  ];
  shellHook = ''
    echo "Started C development environment..."
    export PS1='\[\e[1m\](Nix-shell)[ \[\e[96m\]\w \[\e[39m\]]\\$ \[\e[0m\]'
  '';
}