{inputs, ...}: {
  flake.modules.nixos.luffy = {
    imports = with inputs.self.modules.nixos;
      [
        # Minimal
        nix
        agenix
        home-manager
        systemPackages

        # System Settings
        age-rekey
        audio
        bluetooth
        boot
        greeter
        fingerprint
        trackpoint
        firmware
        fonts
        gaming
        locale
        networkmanager
        printing
        sysprof
        zram
        xdg
        podman

        # Services
        gnupg
        kanata
        security
        ssh
        v2raya

        # Programs
        niri
        gnome
        wayland
        manpage
        thunar
        yubikey
      ]
      ++ (with inputs.self.modules.generic; [
        systemConstants
        pkgs-by-name
      ])
      ++ [
        inputs.nixos-hardware.nixosModules.lenovo-thinkpad-p14s-amd-gen6
        {power-optim.service = "tuned";}
      ];
  };
}
