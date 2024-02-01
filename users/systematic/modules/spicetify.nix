{inputs, ...}: {
  imports = [inputs.spicetify.homeManagerModule];

  programs.spicetify = let
    spicePkgs = inputs.spicetify.packages.x86_64-linux.default;
  in {
    enable = true;

    enabledExtensions = with spicePkgs.extensions; [
      adblock
      shuffle
      popupLyrics
      keyboardShortcut
      trashbin
    ];
  };
}
