let
  genericPkg = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      # Tools for backing up keys
      paperkey
      pgpdump

      # Yubico's official tools
      yubikey-manager
      yubikey-personalization
      yubico-piv-tool
    ];
  };
in {
  flake.modules.nixos.yubikey = {pkgs, ...}: {
    imports = [genericPkg];

    environment.systemPackages = with pkgs; [
      # Tools for backing up keys
      parted
      cryptsetup

      # Yubico's tools
      yubioath-flutter
    ];

    programs.yubikey-touch-detector.enable = true;
  };

  flake.modules.darwin.yubikey = {pkgs, ...}: let
    yknotifyLauncher = pkgs.writeShellApplication {
      name = "yknotify-launcher";
      runtimeInputs = with pkgs; [
        jq
        terminal-notifier
        local.yknotify
      ];
      text = ''
        LAST_NTFY=0

        while IFS= read -r line; do
          NOW="$(date +%s)"

          if [[ "$NOW" -le "$((LAST_NTFY + 2))" ]]; then
            continue
          fi

          LAST_NTFY="$NOW"

          message="$(echo "$line" | jq -r '.type')"

          terminal-notifier -title "yknotify" -message "$message"
        done < <(yknotify)
      '';
    };
  in {
    imports = [genericPkg];

    launchd.user.agents.yknotify = {
      serviceConfig = {
        Label = "com.user.yknotify";
        ProgramArguments = ["${yknotifyLauncher}/bin/yknotify-launcher"];

        RunAtLoad = true;
        KeepAlive = true;

        StandardOutPath = "/tmp/yknotify.out";
        StandardErrorPath = "/tmp/yknotify.err";
      };
    };
  };
}
