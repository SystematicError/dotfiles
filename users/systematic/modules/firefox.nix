{
  inputs,
  pkgs,
  ...
}: {
  programs.firefox = {
    enable = true;

    profiles.frosted = {
      extensions.packages = with inputs.firefox-addons.packages.${pkgs.system}; [
        darkreader
        return-youtube-dislikes
        sponsorblock
        ublock-origin
      ];

      settings = {
        "extensions.autoDisableScopes" = 0;

        "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";

        "layers.acceleration.force-enabled" = true;
        "gfx.webrender.all" = true;

        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "svg.context-properties.content.enabled" = true;

        "widget.use-xdg-desktop-portal.file-picker" = 1;
        "widget.gtk.non-native-titlebar-buttons.enabled" = false;
        "widget.gtk.rounded-bottom-corners.enabled" = true;

        "browser.toolbars.bookmarks.visibility" = "never";
        "browser.tabs.groups.enabled" = true;
        "sidebar.revamp" = true;
        "sidebar.verticalTabs" = true;
        "sidebar.main.tools" = "aichat,history,bookmarks";
        "sidebar.revamp.round-content-area" = true;
      };

      userChrome = ''
        .titlebar-spacer[type="post-tabs"] {
            display: none !important;
        }
      '';

      search = {
        force = true;
        default = "ddg";
        privateDefault = "ddg";

        engines = {
          bing.metaData.hidden = true;

          google.metaData.alias = "@g";
          wikipedia.metaData.alias = "@wk";

          youtube = {
            definedAliases = ["@youtube" "@yt"];
            iconUpdateURL = "https://youtube.com/favicon.ico";
            updateInterval = 7 * 24 * 60 * 60 * 1000;

            urls = [
              {
                template = "https://www.youtube.com/results";
                params = [
                  {
                    name = "search_query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };

          "Nix Packages" = {
            definedAliases = ["@nixpkgs" "@np"];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";

            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "channel";
                    value = "unstable";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };
        };
      };
    };

    # Check https://mozilla.github.io/policy-templates for all policies
    policies = {
      AppAutoUpdate = false;

      DontCheckDefaultBrowser = true;

      EncryptedMediaExtensions.Enabled = true;

      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DisableFormHistory = true;

      EnableTrackingProtection = {
        Value = true;
        Cryptomining = true;
        Fingerprinting = true;
        EmailTracking = true;
      };

      DisablePocket = true;
      DisableSetDesktopBackground = true;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      PasswordManagerEnabled = false;

      FirefoxHome = {
        TopSites = false;
        SponsoredTopSites = false;
        Highlights = false;
        Pocket = false;
        SponsoredPocket = false;
        Snippets = false;
      };

      UserMessaging = {
        ExtensionRecommendations = false;
        FeatureRecommendations = false;
        MoreFromMozilla = false;
        SkipOnboarding = true;
        WhatsNew = false;
      };
    };
  };
}
