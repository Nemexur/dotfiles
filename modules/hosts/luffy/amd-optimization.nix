{
  flake.modules.nixos.luffy = {pkgs, ...}: {
    boot.kernelParams = [
      "iommu=pt" # IOMMU passthrough for better performance
    ];

    # Force amdgpu driver early load
    boot.initrd.kernelModules = ["amdgpu"];

    hardware = {
      enableAllFirmware = true;
      graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [
          # Vulkan support (moved from system packages)
          vulkan-loader

          # Video acceleration (Note: VPE disabled, using software encoding)
          libva-utils # VA-API utilities
          libva-vdpau-driver # VA-API to VDPAU translation
          libvdpau-va-gl # VDPAU support
        ];
      };
    };
  };
}
