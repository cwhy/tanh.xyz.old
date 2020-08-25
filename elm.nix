with import <nixpkgs> {};

stdenv.mkDerivation {

  name = "elm";

  buildInputs = [
    nodejs
    vips
    elmPackages.elm-format
    elmPackages.elm
    yarn
  ];
}
