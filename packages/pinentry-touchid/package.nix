{
  lib,
  buildGoModule,
  fetchFromGitHub,
  nix-update-script,
}:
buildGoModule rec {
  pname = "pinentry-touchid";
  version = "0.0.3";

  src = fetchFromGitHub {
    owner = "jorgelbg";
    repo = "pinentry-touchid";
    rev = "v${version}";
    hash = "sha256-XMcJjVVAp5drLMVTShITl0v6uVazrG1/23dVerrsoj4=";
  };

  vendorHash = "sha256-PJJoTnA9WXzH9Yv/oZfwyjjcbvJwpXxX81vpzTtXWxU=";

  subPackages = ["."];

  env.CGO_ENABLED = 1;

  ldflags = ["-s" "-w"];

  passthru.updateScript = nix-update-script {};

  # Keychain tests cannot run inside the Nix sandbox
  doCheck = false;

  meta = {
    mainProgram = "pinentry-touchid";
    homepage = "https://github.com/jorgelbg/pinentry-touchid";
    description = "Custom GPG pinentry program for macOS.";
    longDescription = ''
      Custom GPG pinentry program for macOS that allows using Touch ID
      for fetching the password from the macOS keychain.
    '';
    license = lib.licenses.asl20;
    platforms = lib.platforms.darwin;
  };
}
