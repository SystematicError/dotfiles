{inputs, ...}: {
  imports = [inputs.spicetify-nix.homeManagerModules.default];

  programs.spicetify = let
    spicePkgs = inputs.spicetify-nix.legacyPackages.x86_64-linux;
  in {
    enable = true;

    enabledExtensions = with spicePkgs.extensions; [
      adblock
      trashbin
      beautifulLyrics
      betterGenres
    ];
  };
}
