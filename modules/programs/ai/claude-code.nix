{
  flake.modules.homeManager.claude-code = {pkgs, ...}: {
    programs.npm.enable = true;
    programs.claude-code = {
      enable = true;
      package = pkgs.unstable.claude-code;
    };
  };
}
