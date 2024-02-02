{
  inputs,
  pkgs,
  ...
}: {
  home.file = {
    firefox-cascade = {
      target = ".mozilla/firefox/configured/chrome/cascade";
      source = "${inputs.firefox-cascade}/chrome/includes";
    };

    firefox-tcr = {
      target = ".mozilla/firefox/configured/chrome/cascade-tcr.css";
      source = "${inputs.firefox-cascade}/integrations/tabcenter-reborn/cascade-tcr.css";
    };
  };

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
                template = "https://mipmip.github.io/home-manager-option-search";
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

      extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
        ublock-origin
        darkreader
        sponsorblock
        return-youtube-dislikes
        bitwarden
        tabcenter-reborn
        tabliss
        privacy-badger
      ];

      userChrome = ''
        @import 'cascade/cascade-config-mouse.css';
        @import 'cascade/cascade-colours.css';
        @import 'cascade/cascade-layout.css';
        @import 'cascade/cascade-responsive.css';
        @import 'cascade/cascade-floating-panel.css';
        @import 'cascade/cascade-nav-bar.css';
        @import 'cascade/cascade-tabs.css';
        @import 'cascade-tcr.css';
      '';

      settings = {
        "extensions.autoDisableScopes" = 0;
        "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "widget.use-xdg-desktop-portal.file-picker" = 1;
        "signon.rememberSignons" = false;
      };
    };
  };
}
