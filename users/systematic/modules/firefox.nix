{
  inputs,
  lib,
  pkgs,
  ...
}: {
  programs.firefox = {
    enable = true;

    profiles.configured = {
      search = {
        force = true;
        default = "DuckDuckGo";

        engines = {
          "Bing".metaData.hidden = true;
          "Wikipedia (en)".metaData.hidden = true;

          "Google".metaData.alias = "@g";

          "YouTube" = {
            definedAliases = ["@youtube" "@yt"];
            iconUpdateURL = "https://www.youtube.com/s/desktop/8b6c1f4c/img/favicon_144x144.png";

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

          "NixOS Packages" = {
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

          "NixOS Options" = {
            definedAliases = ["@nixopts" "@no"];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";

            urls = [
              {
                template = "https://search.nixos.org/options";
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

          "Home Manager Options" = {
            definedAliases = ["@homemanager" "@hm"];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";

            urls = [
              {
                template = "https://home-manager-options.extranix.com";
                params = [
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

      userChrome =
        (lib.concatStrings (map (file: "@import url(\"${inputs.firefox-csshacks}/chrome/${file}.css\");\n") [
          "iconized_content_context_menu"
          "iconized_main_menu"
          "iconized_tabs_context_menu"
          "iconized_textbox_context_menu"
        ]))
        + ''
          .titlebar-spacer[type="post-tabs"] {
              display: none !important;
          }
        '';

      extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
        darkreader
        return-youtube-dislikes
        sponsorblock
        ublock-origin
      ];

      settings = {
        "extensions.autoDisableScopes" = 0;
        "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
        "widget.use-xdg-desktop-portal.file-picker" = 1;
        "signon.rememberSignons" = false;
        "browser.toolbars.bookmarks.visibility" = "never";

        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "svg.context-properties.content.enabled" = true;
        "layers.acceleration.force-enabled" = true;
        "gfx.webrender.all" = true;

        "sidebar.revamp" = true;
        "sidebar.verticalTabs" = true;
      };
    };

    policies = {
      AppAutoUpdate = false;
      BackgroundAppUpdate = false;
      DisableFirefoxStudies = true;
      DisableProfileImport = true;
      DisableProfileRefresh = true;
      DisableSetDesktopBackground = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DisableFormHistory = true;
      DontCheckDefaultBrowser = true;
      OfferToSaveLogins = false;
      EnableTrackingProtection = {
        Value = true;
        Cryptomining = true;
        Fingerprinting = true;
        EmailTracking = true;
      };
      EncryptedMediaExtensions.Enabled = true;
      ExtensionUpdate = false;
      NoDefaultBookmarks = true;
      PasswordManagerEnabled = false;
      SanitizeOnShutdown.Downloads = true;
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
