{pkgs, ...}: {
  programs.zsh.enable = true;
  environment.shells = with pkgs; [bashInteractive zsh];
  users.defaultUserShell = pkgs.zsh;
}
