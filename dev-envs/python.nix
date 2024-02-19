{ pkgs }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    python3
    mypy
  ] ++ 
  (with pkgs.python311Packages; [
    # pip packages
    pip
    ninja
    numpy
    matplotlib
    scikit-learn
    pandas
    seaborn
    jupyter
    ipython
  ]);
  shellHook = ''
    echo "Started Python development environment..."
    export PS1='\[\e[1m\](Nix-shell)[ \[\e[96m\]\w \[\e[39m\]]\\$ \[\e[0m\]'
  '';
}
