{
  flake.modules.homeManager.codex = {pkgs, ...}: {
    programs.npm.enable = true;
    programs.codex = {
      enable = true;
      package = pkgs.unstable.codex;
    };
  };
}
