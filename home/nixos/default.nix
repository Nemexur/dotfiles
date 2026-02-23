{
  myVars,
  username ? myVars.username,
  ...
}: {
  imports = [../base];

  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "25.11";
  };

  # enable management of XDG base directories on macOS.
  xdg.enable = true;
}
