{ ... }:

{
  programs.git = {
    enable = true;
    userName = "Cryxtalix";
    userEmail = "fgx8p9t@protonmail.com";
    signing = {
      key = null;
      signByDefault = true;
      #gpgPath = "path to gpg executable";
    };
  };
}