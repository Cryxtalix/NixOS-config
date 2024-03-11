{ pkgs }:
  
pkgs.mkShell {
  buildInputs = with pkgs.python311Packages; [
    mkdocs
    mkdocs-material
  ];
  shellHook = ''
    export PS1='\[\e[1m\](Mkdocs)[ \[\e[96m\]\w \[\e[39m\]]\\$ \[\e[0m\]'
    echo "Started MkDocs environment..."
  '';
}
