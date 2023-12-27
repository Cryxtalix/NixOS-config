{ self, pkgs }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    python3
    mypy
    python311Packages.jupyter-core
  ];
  shellHook = ''
    echo "Started Python development environment..."
  '';
}