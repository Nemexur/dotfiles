let
  genericPkg = {pkgs, ...}: {
    fonts.packages = with pkgs; [
      font-awesome

      # nerdfonts
      nerd-fonts.symbols-only
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
      nerd-fonts.iosevka
      nerd-fonts.lilex
    ];
  };
in {
  flake.modules.nixos.fonts = genericPkg;
  flake.modules.darwin.fonts = genericPkg;
}
