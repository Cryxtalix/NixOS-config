{ self, pkgs }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    python3
    mypy
  ] ++ 
  (with pkgs.python311Packages; [
    # pip packages
    pip
    numpy
    matplotlib
    scikit-learn
    pandas
    seaborn
  ]);
  shellHook = ''
    echo "Started Python development environment..."
  '';
}