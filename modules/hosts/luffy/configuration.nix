{inputs, ...}: {
  flake.modules.nixos.luffy = {
    imports = with inputs.self.modules.nixos;
      [
        # Minimal
        nix
        home-manager
        systemPackages

        # System Settings
        audio
        bluetooth
        boot
        fingerprint
        trackpoint
        fwupd
        fonts
        gaming
        locale
        networkmanager
        printing
        sysprof
        zram
        xdg
        podman
        docker

        # Services
        kanata
        security
        ssh

        # Programs
        niri
        noctalia
        gnome
        gnupg
        kde
        manpage
        thunar
      ]
      ++ [inputs.self.modules.generic.systemConstants]
      ++ [
        inputs.nixos-hardware.nixosModules.lenovo-thinkpad-p14s-amd-gen5
        {power-optim.service = "tuned";}
        {xdgSettings.terminalDesktop = ["com.mitchellh.ghostty.desktop" "kitty.desktop"];}
      ];
  };
}
