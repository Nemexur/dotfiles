{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    wl-clipboard
    wf-recorder
  ];
}
