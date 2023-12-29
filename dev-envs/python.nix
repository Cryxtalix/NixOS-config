{ self, pkgs }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    python3
    mypy
  ] ++ 
  (with pkgs.python311Packages; [
    pip
    numpy
  ]);
  shellHook = ''
    echo "Started Python development environment..."
  '';
}