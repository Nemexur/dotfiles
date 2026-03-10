{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # system call monitoring
    strace
    lsof

    # powerful tracing tool
    bpftrace

    # system monitoring
    sysstat
    iotop-c
    iftop
    sysbench
    systemctl-tui

    # system tools
    pciutils # lspci
    usbutils # lsusb
    hdparm # for disk performance, command
  ];
  services.fwupd.enable = true;
}
