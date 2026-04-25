{
  lib,
  python313Packages,
  fetchPypi,
  jdk25_headless,
}:
with python313Packages;
  buildPythonPackage rec {
    pname = "opendataloader_pdf";
    version = "2.3.0";
    pyproject = true;

    src = fetchPypi {
      inherit pname version;
      hash = "sha256-SrsHN8cLa2pCsEdIlFtZjzd20q97sm7Sde0eHyZinuI=";
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
