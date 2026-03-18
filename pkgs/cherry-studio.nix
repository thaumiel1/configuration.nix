{ pkgs, lib, ... }:

let
  pname = "cherry-studio";
  version = "1.8.0";

  src = pkgs.fetchurl {
    url = "https://github.com/CherryHQ/cherry-studio/releases/download/v${version}/Cherry-Studio-${version}-x86_64.AppImage";
    hash = "sha256-uWP+HNPsxZJsymoouqDu4X9a+bOBvnl1neTZXkKMtbY="; # replace with prefetch output
  };

  appimageContents = pkgs.appimageTools.extractType2 { inherit pname version src; };
in
pkgs.appimageTools.wrapType2 {
  inherit pname version src;

  extraInstallCommands = ''
    install -m 444 -D \
      ${appimageContents}/usr/share/applications/cherry-studio.desktop \
      $out/share/applications/cherry-studio.desktop
    substituteInPlace $out/share/applications/cherry-studio.desktop \
      --replace 'Exec=AppRun' 'Exec=cherry-studio'
    cp -r ${appimageContents}/usr/share/icons $out/share
  '';
}
