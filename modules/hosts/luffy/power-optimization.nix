{
  flake.modules.nixos.luffy = {
    lib,
    config,
    ...
  }: let
    tunedOptions = {
      enable = true;
      settings.dynamic_tuning = true;
      ppdSupport = true;
      ppdSettings.main.default = "balanced";
    };
    # https://wiki.archlinux.org/title/Lenovo_ThinkPad_P14s_(AMD)_Gen_6
    tlpOptions = {
      enable = true;
      pd.enable = true;

      settings = {
        # CPU
        CPU_DRIVER_OPMODE_ON_AC = "active";
        CPU_DRIVER_OPMODE_ON_BAT = "active";

        CPU_SCALING_GOVERNOR_ON_AC = "powersave";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";

        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 1;

        # Firmware / thermal policy
        PLATFORM_PROFILE_ON_AC = "balanced-performance performance";
        PLATFORM_PROFILE_ON_BAT = "balanced";
        NMI_WATCHDOG = 0;

        # NVMe / storage runtime PM
        AHCI_RUNTIME_PM_ON_AC = "on";
        AHCI_RUNTIME_PM_ON_BAT = "auto";
        AHCI_RUNTIME_PM_TIMEOUT = 15;

        # AMD GPU
        RADEON_DPM_PERF_LEVEL_ON_AC = "auto";
        RADEON_DPM_PERF_LEVEL_ON_BAT = "auto";

        AMDGPU_ABM_LEVEL_ON_AC = 0;
        AMDGPU_ABM_LEVEL_ON_BAT = 1;

        # Networking
        WIFI_PWR_ON_AC = "off";
        WIFI_PWR_ON_BAT = "on";
        WOL_DISABLE = "Y";

        # Audio
        # True/1/Y cause crackles.
        SOUND_POWER_SAVE_ON_AC = 0;
        SOUND_POWER_SAVE_ON_BAT = 0;
        SOUND_POWER_SAVE_CONTROLLER = "N";

        # PCIe
        PCIE_ASPM_ON_AC = "default";
        PCIE_ASPM_ON_BAT = "default";

        RUNTIME_PM_ON_AC = "on";
        RUNTIME_PM_ON_BAT = "auto";

        # Keep the Ryzen HD-Audio controller permanently powered on battery too.
        # Otherwise it causes crackles.
        RUNTIME_PM_DISABLE = "c4:00.6";

        # USB
        USB_AUTOSUSPEND = 1;
        USB_EXCLUDE_AUDIO = 1;
        USB_EXCLUDE_BTUSB = 1;
        USB_EXCLUDE_PHONE = 0;
        USB_EXCLUDE_PRINTER = 1;
        USB_EXCLUDE_WWAN = 0;

        # Battery health
        START_CHARGE_THRESH_BAT0 = 40;
        STOP_CHARGE_THRESH_BAT0 = 80;
        RESTORE_THRESHOLDS_ON_BAT = 1;
      };
    };
  in {
    options.power-optim = {
      service = lib.mkOption {
        type = lib.types.enum ["tlp" "tuned"];
        default = "tuned";
        description = "Power Management Service. Either TLP or TuneD";
      };
    };

    config = let
      cfg = config.power-optim;
    in
      lib.mkMerge [
        {
          # Hybrid Sleep
          boot.kernelParams = ["resume=/dev/disk/by-uuid/891a3444-c438-46f8-9a38-f74d69623da5"];
          systemd.sleep.settings.Sleep = {
            AllowSuspend = "yes";
            AllowHibernation = "yes";
            AllowHybridSleep = "yes";
            AllowSuspendThenHibernate = "yes";
            HibernateDelaySec = 1800;
          };
          services.logind.settings.Login = {
            HandlePowerKey = "ignore";
            HandleLidSwitch = "suspend-then-hibernate";
            HandleLidSwitchExternalPower = "suspend-then-hibernate";
            HandleLidSwitchDocked = "suspend-then-hibernate";
          };

          powerManagement.enable = true;
          services.upower.enable = true;
          services.power-profiles-daemon.enable = false;
        }

        (lib.mkIf (cfg.service == "tlp") {
          services.tuned.enable = false;
          services.tlp = tlpOptions;
        })

        (lib.mkIf (cfg.service == "tuned") {
          services.tlp.enable = false;
          services.tuned = tunedOptions;
        })
      ];
  };
}
