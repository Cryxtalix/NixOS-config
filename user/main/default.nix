let
  username = "cryxtalix";
  filename = "NixOS-config";
in
{
  username = username;
  timezone = "Asia/Singapore";
  locale = "en_SG.UTF-8";
  homeDir = "/home/${username}";
  configDir = "/home/${username}/${filename}";
  wallpaper = "tarantula.png";
  git = {
    username = "Cryxtalix";
    email = "fgx8p9t@protonmail.com";
  };
}