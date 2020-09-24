# Haskell project setup with [haskell.nix][]

This template was generated using the following steps:

## Add cachix binary cache

```sh
cachix use iohk
```

Note: you should run the above as trusted user, otherwise you'll need to manually add the entry to `trusted-substituters` in `/etc/nix/nix.conf`

## Set up [`niv`](https://github.com/nmattia/niv)

```sh
niv init
```

## Add These Nix files

- [default.nix](./default.nix)
- [shell.nix](./shell.nix)


## Set up cabal project

```sh
nix-shell -p cabal-install --command 'cabal init --cabal-version=2.4 --license=MIT -p niv-shell'
```

Edit the generated .cabal file. Example in [niv-shell.cabal](./niv-shell.cabal).

## Create git repository and initial commit

Haskell.nix relies on git, so you must set up the git repository and commit the .cabal file before `nix-shell` will work.

```sh
git add .
git commit -m "Add haskell.nix skeleton"
```

## Test nix-shell

```sh
nix-shell
```

## Enable lorri (optional)

```sh
lorri init
```

[haskell.nix]: https://github.com/input-output-hk/haskell.nix
