{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = inputs @ {...}: {
    devShells.x86_64-linux.default = let
      pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
    in
      pkgs.mkShellNoCC {
        packages = [
          pkgs.git
          pkgs.quickshell
          pkgs.kdePackages.qtdeclarative
        ];
        QMLLS_BUILD_DIRS = "${pkgs.kdePackages.qtdeclarative}/lib/qt-6/qml/:${pkgs.quickshell}/lib/qt-6/qml/";

        name = "qofi-dev-shell";
      };
  };
}
