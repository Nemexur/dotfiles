{
  flake.modules.darwin.systemPackages = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      mas
    ];
  };
}
