{inputs, ...}: {
  flake.modules.nixos.greeter = {pkgs, ...}: {
    imports = [inputs.noctalia-greeter.nixosModules.default];

    programs.noctalia-greeter = {
      enable = true;

      # Optional configuration
      greeter-args = "--session niri";
      settings = {
        appearance.scheme = "Rosé Pine";
        keyboard.layout = "us";
        auth.allow_empty_password = true;
        cursor = {
          theme = "Bibata-Modern-Ice";
          size = 24;
          path = "${pkgs.bibata-cursors}/share/icons";
        };
      };
    };
  };
}
