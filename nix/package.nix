{
  lib,
  stdenvNoCC,
  # niri's layout struts, kept out of the working area
  struts ? {},
}: let
  strut = side: struts.${side} or 0;
in
  stdenvNoCC.mkDerivation {
    pname = "dux-column-width";
    inherit (lib.importJSON ../plugin/plugin.json) version;

    src = ../plugin;

    installPhase = ''
      runHook preInstall
      cp -r . $out
      substituteInPlace $out/ColumnWidthWidget.qml \
        --replace-fail @strutsX@ ${toString (strut "left" + strut "right")} \
        --replace-fail @strutsY@ ${toString (strut "top" + strut "bottom")}
      runHook postInstall
    '';
  }
