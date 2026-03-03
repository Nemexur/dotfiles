{pkgs, ...}: {
  programs.rofi = {
    enable = true;
    font = "Lilex Nerd Font";
    terminal = "${pkgs.ghostty}/bin/ghostty";
  };
}
