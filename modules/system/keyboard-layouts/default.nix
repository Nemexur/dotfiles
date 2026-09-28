{
  flake.modules.darwin.russianTypeWriterLayout = {
    system.activationScripts.keyboard.text = let
      keyboardLayouts = ./_Russian-TypeWriter.bundle;
    in ''
      echo "Installing keyboard layout"

      mkdir -p "/Library/Keyboard Layouts"
      rm -rf "/Library/Keyboard Layouts/$(basename ${keyboardLayouts})"
      cp -r "${keyboardLayouts}" "/Library/Keyboard Layouts/"
    '';
  };
}
