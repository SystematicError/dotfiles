{pkgs, ...}: {
  home.packages = with pkgs; [
    nil
    alejandra
  ];

  programs.zed-editor = {
    extensions = ["nix"];

    userSettings = {
      "languages" = {
        "Nix" = {
          "language_servers" = ["nil" "!nixd"];
        };
      };

      "lsp" = {
        "nil" = {
          "initialization_options" = {
            "formatting" = {
              "command" = ["alejandra" "--quiet" "--"];
            };
          };
        };
      };
    };
  };
}
