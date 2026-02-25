{
  lib,
  config,
  ...
}: let
  cfg = config.modules.nixos-desktop.kanata;
in {
  options.modules.nixos-desktop = {
    kanata = {
      enable = lib.mkEnableOption "Kanata Keyboard Remapping";
    };
  };

  config = lib.mkIf cfg.enable {
    # Enable the uinput module
    boot.kernelModules = ["uinput"];

    # Enable uinput
    hardware.uinput.enable = true;

    # Set up udev rules for uinput
    services.udev.extraRules = ''
      KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
    '';

    # Ensure the uinput group exists
    users.groups.uinput = {};

    # Add the Kanata service user to necessary groups
    systemd.services.kanata-internalKeyboard.serviceConfig = {
      SupplementaryGroups = [
        "input"
        "uinput"
      ];
    };

    services.kanata = {
      enable = true;
      keyboards = {
        internalKeyboard = {
          extraDefCfg = "process-unmapped-keys yes";
          config = ''
            (defvar
              tap-time 100
              hold-time 200
            )

            (defsrc
              tab \
              ret caps
              f h j k l
            )

            (defalias
              ;; Tab/BackSlash -> Alt when Held
              tab-alt (tap-hold-press $tap-time $hold-time tab lalt)
              bksl-alt (tap-hold-press $tap-time $hold-time \ lalt)
              ;; Enter -> Enter/Control
              enter-ctrl (tap-hold-press $tap-time $hold-time ret lctl)
              ;; CapsLock -> Escape/Controlll
              caps-ctrl (tap-hold-press $tap-time $hold-time esc lctl)
              ;; Enable HJKL when F is pressed
              f-hjkl (tap-hold $tap-time $hold-time f (layer-while-held move))
            )

            (deflayer base
              @tab-alt
              @bksl-alt
              @enter-ctrl
              @caps-ctrl
              @f-hjkl h j k l
            )

            (deflayer move
              _ _ _ _ _
              left down up right
            )
          '';
        };
      };
    };
  };
}
