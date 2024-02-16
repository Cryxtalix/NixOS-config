{ pkgs }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    gcc.cc.lib
    cmake
  ];
  shellHook = ''
    echo "Started C development environment..."
  '';
}