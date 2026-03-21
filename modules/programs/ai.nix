{
  flake.modules.homeManager.ai = {pkgs, ...}: {
    home.packages = with pkgs.unstable; [
      opencode
    ];
  };
}
