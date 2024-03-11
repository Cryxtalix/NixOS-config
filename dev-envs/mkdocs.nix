{ pkgs }:
  
pkgs.mkShell {
  buildInputs = with pkgs.python311Packages; [
    mkdocs
    mkdocs-material
  ];
  shellHook = ''
    echo "Started MkDocs environment..."
    export PS1='\[\e[1m\](Nix-shell)[ \[\e[96m\]\w \[\e[39m\]]\\$ \[\e[0m\]'
  '';
}
