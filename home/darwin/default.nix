{
  pkgs,
  myVars,
  username ? myVars.username,
  ...
}: {
  imports = [../base ./karabiner];

  # enable management of XDG base directories on macOS.
  xdg.enable = true;

  home = {
    inherit username;
    homeDirectory = "/Users/${username}";
    stateVersion = "25.11";

    packages = with pkgs; [
      # Tools
      m-cli
      numi
      stats
      rectangle

      # Video Player
      iina

      # GUI Apps
      terminal-notifier
      pinentry_mac
    ];
  };
}
