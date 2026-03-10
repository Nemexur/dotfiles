{
  flake.modules.nixos.networkmanager = {
    networking.networkmanager.enable = true;
  };

  flake.modules.homeManager.networkmanager = {pkgs, ...}: {
    home.packages = with pkgs; [
      networkmanagerapplet
    ];
  };
}
