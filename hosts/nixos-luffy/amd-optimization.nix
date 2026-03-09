{pkgs-unstable, ...}: {
  boot.kernelParams = [
    # --- CPU & System ---
    "iommu=pt" # IOMMU passthrough for better performance

    # --- GPU: Kernel 6.18.2 + Aggressive Workarounds ---
    # Based on Arch Wiki (P14s Gen 6): https://wiki.archlinux.org/title/Lenovo_ThinkPad_P14s_(AMD)_Gen_6
    "amdgpu.dcdebugmask=0x10" # Arch Wiki: Fixes screen flickering & massive terminal lags

    # Aggressive workarounds for MES buffer saturation on Strix Point (gfx1150)
    "amdgpu.runpm=0" # Disable runtime PM - prevents GPU power state issues
    "amdgpu.mes=0" # Disable MES (Micro Engine Scheduler) - known to cause ring buffer hangs
    "amdgpu.gpu_recovery=1" # Enable GPU recovery on hangs
  ];

  # Force amdgpu driver early load
  boot.initrd.kernelModules = ["amdgpu"];

  hardware = {
    enableAllFirmware = true;
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs-unstable; [
        # Vulkan support (moved from system packages)
        vulkan-loader

        # Video acceleration (Note: VPE disabled, using software encoding)
        libva-utils # VA-API utilities
        libva-vdpau-driver # VA-API to VDPAU translation
        libvdpau-va-gl # VDPAU support
      ];
    };
  };
}
