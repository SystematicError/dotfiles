{
  inputs,
  pkgs,
  ...
}: {
  programs.firefox = {
    enable = true;

    profiles.frosted = {
      extensions.packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
        adaptive-tab-bar-colour
        darkreader
        keepassxc-browser
        sponsorblock
        ublock-origin
        web-clipper-obsidian
      ];

      settings = {
        "extensions.autoDisableScopes" = 0;

        "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";

        "widget.use-xdg-desktop-portal.file-picker" = 1;

        "browser.toolbars.bookmarks.visibility" = "never";
        "sidebar.verticalTabs" = true;
        "sidebar.main.tools" = "history,bookmarks";
      };

      search = {
        force = true;
        default = "ddg";
        privateDefault = "ddg";

        engines = {
          google.metaData.alias = "@g";
          wikipedia.metaData.alias = "@wk";

          youtube = {
            definedAliases = ["@youtube" "@yt"];
            icon = "https://youtube.com/favicon.ico";
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
