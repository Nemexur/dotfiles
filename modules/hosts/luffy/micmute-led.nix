{
  # F4 mic-mute LED fix for ThinkPad P14s Gen 6 AMD.
  #
  # The internal mic is the AMD ACP digital mic (hw:acppdmmach); PipeWire mutes
  # it purely in software. The platform::micmute LED, however, is driven by the
  # kernel `audio-micmute` trigger, which snd_ctl_led binds to the *analog*
  # Realtek ALC257 "Capture Switch". Nothing ever touches that control, so it
  # stays muted and the LED is stuck on forever.
  #
  # Fix: detach every control from the mic LED tracker and force the LED off.
  flake.modules.nixos.luffy = {
    systemd.services.micmute-led-off = {
      description = "Disable the always-on ThinkPad mic-mute LED";
      wantedBy = ["multi-user.target"];
      after = ["sound.target"];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
      };
      script = ''
        set -u
        led=/sys/class/leds/platform::micmute/brightness
        base=/sys/class/sound/ctl-led/mic

        # Sound cards may register slightly after sound.target; give them a moment.
        for _ in $(seq 1 20); do
          [ -d "$base" ] && break
          sleep 0.5
        done
        [ -d "$base" ] || exit 0

        # Detach every ALSA control currently bound to the mic LED tracker.
        for card in "$base"/card*; do
          [ -e "$card/list" ] || continue
          for numid in $(cat "$card/list"); do
            echo "$numid" > "$card/detach" || true
          done
        done

        [ -w "$led" ] && echo 0 > "$led"
        exit 0
      '';
    };
  };
}
