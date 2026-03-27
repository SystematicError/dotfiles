{...}: let
  CapsLock = 30064771129;
  Escape = 30064771113;

  mapKeys = src: dst: {
    HIDKeyboardModifierMappingSrc = src;
    HIDKeyboardModifierMappingDst = dst;
  };
in {
  system.keyboard = {
    enableKeyMapping = true;

    userKeyMapping = [
      (mapKeys CapsLock Escape)
      (mapKeys Escape CapsLock)
    ];
  };
}
