{
  lib,
  python314Packages,
  fetchPypi,
  jdk25_headless,
}:
with python314Packages;
  buildPythonPackage rec {
    pname = "opendataloader_pdf";
    version = "2.5.7";
    pyproject = true;

    src = fetchPypi {
      inherit pname version;
      hash = "sha256-Evyu3QPUYnklprVibgk0Sk3reILzlkHMkCAystLdwrA=";
    };

    propagatedBuildInputs = [jdk25_headless];

    build-system = [setuptools wheel hatchling];

    meta = {
      description = "PDF Parser for AI-ready data";
      homepage = "https://github.com/opendataloader-project/opendataloader-pdf";
      changelog = "https://github.com/opendataloader-project/opendataloader-pdf/blob/${src.version}/CHANGELOG.md";
      license = lib.licenses.asl20;
      mainProgram = "opendataloader_pdf";
    };
  }
