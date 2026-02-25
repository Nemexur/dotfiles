{pkgs, ...}: {
  programs.ghostty = {
    enable = true;
    package =
      if pkgs.stdenv.isDarwin
      then pkgs.hello # pkgs.ghostty is currently broken on darwin
      else pkgs.ghostty; # the stable version
    enableZshIntegration = true;
    installBatSyntax = true;
    settings = {
      theme = "Dracula";
      font-family = "JetBrainsMono NF";
      font-size = if pkgs.stdenv.isDarwin then 15 else 12;

      background-opacity = 0.8;
      background-blur = 8;

      macos-option-as-alt = true;
    };
  };
}
