{
  inputs,
  pkgs,
  lib,
  ...
}: {
  imports = [inputs.spicetify-nix.homeManagerModules.default];

  programs.spicetify = let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  in {
    enable = true;

    enabledExtensions = with spicePkgs.extensions; [
      adblock
    ];
  };

  # https://github.com/NixOS/nixpkgs/issues/404502#issuecomment-3304356653
  home.activation.disableSpotifyUpdates =
    lib.mkIf pkgs.stdenv.hostPlatform.isDarwin
    (lib.hm.dag.entryAfter ["writeBoundary"] ''
      SPOTIFY_UPDATE_DIR=~/Library/Application\ Support/Spotify/PersistentCache/Update
      if ! /usr/bin/stat -f "%Sf" "$SPOTIFY_UPDATE_DIR" 2> /dev/null | grep -q uchg; then
      rm -rf "$SPOTIFY_UPDATE_DIR"
      mkdir -p "$SPOTIFY_UPDATE_DIR"
      /usr/bin/chflags uchg "$SPOTIFY_UPDATE_DIR"
      fi
    '');
}
