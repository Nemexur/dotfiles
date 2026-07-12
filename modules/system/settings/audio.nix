{
  flake.modules.nixos.audio = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      easyeffects
      alsa-utils
    ];

    security.rtkit.enable = true;
    services.pulseaudio.enable = false;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}
