{
  flake.modules.darwin.systemPackages = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      karabiner-bin # TODO
      mas
    ];
  };
}
