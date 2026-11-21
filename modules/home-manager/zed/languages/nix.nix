{pkgs, ...}: {
  programs.zed-editor = {
    extensions = ["nix"];

    extraPackages = with pkgs; [
      nil
      alejandra
    ];

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
