{
  flake.modules.nixos.kanata = {
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
          extraDefCfg = ''
            process-unmapped-keys yes
            concurrent-tap-hold yes
          '';
          config = ''
            (defsrc
              grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
              tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
              caps a    s    d    f    g    h    j    k    l    ;    '    ret
              lsft z    x    c    v    b    n    m    ,    .    /    rsft
              lctl wkup lmet lalt           spc            ralt rmet rctl
            )

            (defvar
              tap-time 100
              hold-time 200
            )

            (defalias
              ;; Tab/BackSlash -> Alt when Held
              tab-alt (tap-hold-press $tap-time $hold-time tab alt)
              bksl-alt (tap-hold-press $tap-time $hold-time \ alt)
              ;; Return/Enter -> Enter/Control
              ret-ctrl (tap-hold-press $tap-time $hold-time ret lctl)
              ;; CapsLock -> Escape/Controlll
              caps-ctrl (tap-hold-press $tap-time $hold-time esc lctl)
              ;; Enable HJKL when F is pressed
              f-hjkl (tap-hold $tap-time $hold-time f (layer-while-held arrows))
            )

            (defchordsv2
              (lsft lmet f23) ralt 200 all-released ()
            )

            (deflayer base
              grv        1    2    3    4       5    6    7    8    9    0    -    =    bspc
              @tab-alt   q    w    e    r       t    y    u    i    o    p    [    ]    @bksl-alt
              @caps-ctrl a    s    d    @f-hjkl g    h    j    k    l    ;    '    @ret-ctrl
              lsft       z    x    c    v       b    n    m    ,    .    /    rsft
              lctl wkup lalt lmet           spc            rmet ralt rctl
            )

            (deflayer arrows
              _    _    _    _    _    _    _    _    _    _    _    _    _    _
              _    _    _    _    _    _    _    _    _    _    _    _    _    _
              _    _    _    _    _    _    left down up right  _    _    _
              _    _    _    _    _    _    _    _    _    _    _    _
              _    _    _    _              _              _    _    _
            )
          '';
        };
      };
    };
  };
}
