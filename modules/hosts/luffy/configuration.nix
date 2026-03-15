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
        audio
        bluetooth
        boot
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
        kanata
        security
        ssh

        # Programs
        niri
        gnome
        wayland
        manpage
        thunar
      ]
      ++ (with inputs.self.modules.generic; [
        systemConstants
        pkgs-by-name
        secrets
      ])
      ++ [
        inputs.nixos-hardware.nixosModules.lenovo-thinkpad-p14s-amd-gen5
        {power-optim.service = "tuned";}
      ];
  };
}
