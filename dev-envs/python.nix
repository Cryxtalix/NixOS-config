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
    export PS1='\[\e[1m\](Python)[ \[\e[96m\]\w \[\e[39m\]]\\$ \[\e[0m\]'
    echo "Started Python development environment..."
  '';
}
