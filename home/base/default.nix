{pkgs, inputs, ...}: {
  imports = [./browser ./ghostty.nix ./starship.nix ./zsh.nix ./tmux.nix ./neovim ./nh.nix];
  home.packages = with pkgs; [gopass telegram-desktop manix];
}
