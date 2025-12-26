{inputs, ...}: {
  imports = [inputs.nixcord.homeModules.nixcord];

  programs.nixcord = {
    enable = true;

    discord.enable = false;
    vesktop.enable = true;

    config.plugins = {
      alwaysTrust.enable = true;
      callTimer.enable = true;
      ClearURLs.enable = true;
      crashHandler.enable = true;
      disableCallIdle.enable = true;
      experiments.enable = true;
      fakeNitro.enable = true;
      mentionAvatars.enable = true;
      noReplyMention.enable = true;
      openInApp.enable = true;
      shikiCodeblocks.enable = true;
      spotifyCrack.enable = true;
      unindent.enable = true;
      unsuppressEmbeds.enable = true;
      validUser.enable = true;
      volumeBooster.enable = true;
      youtubeAdblock.enable = true;
      webKeybinds.enable = true;
      webScreenShareFixes.enable = true;
    };
  };
}
