{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  gtk3,
  xdg-utils,
}:
stdenvNoCC.mkDerivation rec {
  pname = "morewaita-icon-theme";
  version = "48.1";

  src = fetchFromGitHub {
    owner = "somepaulo";
    repo = "MoreWaita";
    tag = "v${version}";
    hash = "sha256-18jI4hADVHC/WCmMTlA+VBuZ1jNGSxL+lO3GwWDiNoU=";
  };

  nativeBuildInputs = [
    gtk3
    xdg-utils
  ];

  installPhase = ''
    runHook preInstall

    install -d $out/share/icons/MoreWaita
    cp -r . $out/share/icons/MoreWaita
    gtk-update-icon-cache -f -t $out/share/icons/MoreWaita && xdg-desktop-menu forceupdate

    runHook postInstall
  '';

  meta = with lib; {
    description = "Adwaita style extra icons theme for Gnome Shell";
    homepage = "https://github.com/somepaulo/MoreWaita";
    license = with licenses; [ gpl3Only ];
    platforms = platforms.linux;
    maintainers = with maintainers; [ pkosel ];
  };
}
