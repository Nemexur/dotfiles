{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule {
  pname = "yknotify";
  version = "0.0.0";

  src = fetchFromGitHub {
    owner = "noperator";
    repo = "yknotify";
    rev = "0c773bdadedb137d02d95c79430fa5e0442c9950";
    hash = "sha256-AhTr3lzYS6z1XoqVC2IIdJoDVdWajrbGhOe20dVQrGQ=";
  };

  vendorHash = null;
  ldflags = ["-s" "-w"];

  meta = {
    mainProgram = "yknotify";
    homepage = "https://github.com/noperator/yknotify";
    description = "Notify when YubiKey needs touch on macOS";
    longDescription = ''
      yknotify watches macOS logs (via log stream CLI command) for events that I've determined,
      through trial and error, are heuristically associated with the YubiKey waiting for touch.
      I primarily use the FIDO2 and OpenPGP features and haven't tested other applications listed
      in ykman info (e.g., Yubico OTP, FIDO U2F, OATH, PIV, YubiHSM Auth).
    '';
    platforms = lib.platforms.darwin;
  };
}
