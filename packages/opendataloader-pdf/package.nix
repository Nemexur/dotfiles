{
  lib,
  python314Packages,
  fetchPypi,
  jdk25_headless,
}:
with python314Packages;
  buildPythonPackage rec {
    pname = "opendataloader_pdf";
    version = "2.5.0";
    pyproject = true;

    src = fetchPypi {
      inherit pname version;
      hash = "sha256-bnf4dvkO5FxnFoyNefOb2f+MXIWoha6Hmi5qvAqrqHg=";
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
