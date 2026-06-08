{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
}:
buildNpmPackage (finalAttrs: {
  pname = "pi-acp";
  version = "0.0.27";

  src = fetchFromGitHub {
    owner = "svkozak";
    repo = "pi-acp";
    tag = "v${finalAttrs.version}";
    hash = "sha256-Bb7qQkELDY175ZNmJD70LzmkcmoQL1LWAnfIxN+ttso=";
  };

  npmDepsHash = "sha256-EmzhcvVzrirlKh57Tl4BKVG4XLkAgdaYgdhMfpZVbRI=";

  meta = {
    description = "ACP adapter for pi coding agent";
    homepage = "https://github.com/svkozak/pi-acp";
    license = lib.licenses.mit;
    mainProgram = "pi-acp";
  };
})
