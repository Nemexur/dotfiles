{
  lib,
  python313Packages,
  fetchPypi,
  jdk25_headless,
}:
with python313Packages;
  buildPythonPackage rec {
    pname = "opendataloader_pdf";
    version = "2.4.7";
    pyproject = true;

    src = fetchPypi {
      inherit pname version;
      hash = "sha256-oW6ZXy9SbXBgRSGNnjWaMfUDcaC8DjuxvBWrtGfAj7c=";
    };

    propagatedBuildInputs = [jdk25_headless];

    build-system = [setuptools wheel hatchling];

    meta = {
      description = "PDF Parser for AI-ready data";
      homepage = "https://github.com/opendataloader-project/opendataloader-pdf";
      changelog = "https://github.com/opendataloader-project/opendataloader-pdf/blob/${src.tag}/CHANGELOG.md";
      license = lib.licenses.asl20;
      mainProgram = "opendataloader_pdf";
    };
  }
