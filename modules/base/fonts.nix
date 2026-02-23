{pkgs, ...}: {
  fonts.packages = with pkgs; [
    font-awesome

    # nerdfonts
    nerd-fonts.symbols-only
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.iosevka
  ];
}
