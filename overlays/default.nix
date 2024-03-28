final: prev: 
{
  foliate = prev.foliate.overrideAttrs (old: {
    src = prev.fetchFromGitHub {
      owner = "johnfactotum";
      repo = "foliate";
      rev = "refs/tags/3.1.0";
      hash = "sha256-6cymAqQxHHoTgzEyUKXC7zV/lUEJfIG+54+tLsc9iHo=";
      fetchSubmodules = true;
    };
  });
}