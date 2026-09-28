{
  flake.modules.nixos.networkmanager = {
    networking.wireless.iwd.enable = true;
    networking.networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };
  };

  flake.modules.homeManager.networkmanager = {pkgs, ...}: {
    home.packages = with pkgs; [
      bluetui
      wireguard-tools
      networkmanagerapplet
    ];
  };
}
