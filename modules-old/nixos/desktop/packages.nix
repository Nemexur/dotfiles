{pkgs-unstable, ...}: {
  environment.systemPackages = with pkgs-unstable; [
    easyeffects
    alsa-utils
    wl-clipboard
    wf-recorder
  ];
}
