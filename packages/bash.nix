{ is_nixos, configDir, ... }:

{
  programs.bash = {
    enable = true;
    
    shellAliases = {
      ll = "ls -al";
      c = "clear";
      nix-flake-up = "(cd ${configDir} && nix flake update)";
      nv-gpu = "watch -n1 nvidia-smi";
    } 
    // 
    (if is_nixos then {
      # Only when NixOS
      nix-cg = "sudo nix-collect-garbage --delete-older-than 7d";
    } 
    else {
      # Only when not NixOS
      nix-cg = "nix-collect-garbage --delete-older-than 7d";
    });

    sessionVariables = {

    };

    initExtra = ''
      export PS1='\[\e[1m\][ \[\e[96m\]\w \[\e[39m\]]\\$ \[\e[0m\]'
      nix-dev() {
        nix develop ${configDir}/.#"$1"
      }
      nix-home-up() {
        home-manager switch --flake ${configDir}/.#"$1"
      }
    ''
    +
    # Only when NixOS
    (if is_nixos then ''
      nix-system-up() {
        sudo nixos-rebuild switch --flake ${configDir}/.#"$1"
      }
      nix-full-up() {
        nix-flake-up && nix-system-up "$1" && nix-home-up "$2"
      }
    '' 
    # Only when not NixOS
    else ''
      nix-full-up() {
        nix-flake-up && nix-home-up "$1"
      }
    '');
  };
}