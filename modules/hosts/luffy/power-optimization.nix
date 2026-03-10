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
      settings = {
        DISK_IDLE_SECS_ON_AC = 0;
        DISK_IDLE_SECS_ON_BAT = 2;
        MAX_LOST_WORK_SECS_ON_AC = 15;
        MAX_LOST_WORK_SECS_ON_BAT = 60;
        CPU_DRIVER_OPMODE_ON_AC = "passive";
        CPU_DRIVER_OPMODE_ON_BAT = "passive";
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_SCALING_MIN_FREQ_ON_AC = 400000;
        CPU_SCALING_MAX_FREQ_ON_AC = 5130000;
        CPU_SCALING_MIN_FREQ_ON_BAT = 400000;
        CPU_SCALING_MAX_FREQ_ON_BAT = 1000000;
        CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 30;
        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;
        CPU_HWP_DYN_BOOST_ON_AC = 1;
        CPU_HWP_DYN_BOOST_ON_BAT = 0;
        NMI_WATCHDOG = 0;
        PLATFORM_PROFILE_ON_AC = "performance";
        PLATFORM_PROFILE_ON_BAT = "low-power";
        MEM_SLEEP_ON_AC = "s2idle";
        MEM_SLEEP_ON_BAT = "s2idle";
        DISK_DEVICES = "nvme0n1 sda";
        DISK_APM_LEVEL_ON_AC = "254 254";
        DISK_APM_LEVEL_ON_BAT = "128 128";
        SATA_LINKPWR_ON_AC = "med_power_with_dipm max_performance";
        SATA_LINKPWR_ON_BAT = "med_power_with_dipm max_performance";
        AHCI_RUNTIME_PM_TIMEOUT = 15;
        AMDGPU_ABM_LEVEL_ON_AC = 0;
        AMDGPU_ABM_LEVEL_ON_BAT = 3;
        RADEON_DPM_PERF_LEVEL_ON_AC = "auto";
        RADEON_DPM_PERF_LEVEL_ON_BAT = "low";
        RADEON_DPM_STATE_ON_AC = "performance";
        RADEON_DPM_STATE_ON_BAT = "battery";
        RADEON_POWER_PROFILE_ON_AC = "default";
        RADEON_POWER_PROFILE_ON_BAT = "low";
        WIFI_PWR_ON_AC = "off";
        WIFI_PWR_ON_BAT = "off";
        WOL_DISABLE = "Y";
        SOUND_POWER_SAVE_ON_AC = 0;
        SOUND_POWER_SAVE_ON_BAT = 0;
        SOUND_POWER_SAVE_CONTROLLER = "N";
        PCIE_ASPM_ON_AC = "performance";
        PCIE_ASPM_ON_BAT = "performance";
        RUNTIME_PM_ON_AC = "on";
        RUNTIME_PM_ON_BAT = "auto";
        USB_AUTOSUSPEND = 1;
        USB_EXCLUDE_AUDIO = 1;
        USB_EXCLUDE_BTUSB = 1;
        USB_EXCLUDE_PHONE = 0;
        USB_EXCLUDE_PRINTER = 1;
        USB_EXCLUDE_WWAN = 0;
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
          systemd.sleep.extraConfig = ''
            AllowSuspend=yes
            AllowHibernation=yes
            AllowHybridSleep=yes
            AllowSuspendThenHibernate=yes
            HibernateDelaySec=1800
          '';
          services.logind.settings.Login = {
            HandlePowerKey = "ignore";
            HandleLidSwitch = "suspend-then-hibernate";
            HandleLidSwitchExternalPower = "suspend-then-hibernate";
            HandleLidSwitchDocked = "suspend-then-hibernate";
          };

          powerManagement = {
            enable = true;
            powertop.enable = true;
          };
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
