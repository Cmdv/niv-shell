{ sources ? import ./nix/sources.nix
, haskellNix ? import sources."haskell.nix" { }
, nixpkgsSrc ? haskellNix.sources.nixpkgs-2003, compiler ? "ghc884" }:
let
  overlays = haskellNix.nixpkgsArgs.overlays ++ [
    (self: super:
      let inherit (super) lib;
      in {
        haskell-nix = super.haskell-nix // {
          custom-tools = super.haskell-nix.custom-tools // {
            haskell-language-server."0.3.0" = args:
              (super.haskell-nix.cabalProject (args // {
                name = "haskell-language-server";
                src = super.fetchFromGitHub {
                  owner = "haskell";
                  repo = "haskell-language-server";
                  rev = "066ce8b94f3be66a011818f748ecb6c6ab7974b8";
                  sha256 =
                    "0yip8r448r2bfzarwddn4j6jfr4hjwwrn9apb4jyd38fin2am48d";
                  fetchSubmodules = true;
                };
                modules =
                  [{ packages.haskell-language-server.doCheck = false; }];
              })).haskell-language-server.components.exes.haskell-language-server;
          };
        };
      })
  ];

  pkgs = import nixpkgsSrc {
    inherit overlays;
    inherit (haskellNix.nixpkgsArgs) config;
  };

in pkgs.haskell-nix.cabalProject {
  compiler-nix-name = compiler;
  src = pkgs.haskell-nix.haskellLib.cleanGit {
    name = "haskell-nix-template";
    src = ./.;
  };
}
