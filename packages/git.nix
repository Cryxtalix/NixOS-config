{ user, ... }:

{
  programs.git = {
    enable = true;
    userName = user.git.username;
    userEmail = user.git.email;
    signing = {
      key = null;
      signByDefault = true;
      #gpgPath = "path to gpg executable";
    };
  };
}