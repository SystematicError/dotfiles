{pkgs, ...}: {
  home.packages = with pkgs; [
    (ghc.withPackages (hsPkgs: with hsPkgs; [haskell-language-server]))
  ];

  programs.zed-editor = {
    extensions = ["haskell"];
  };
}
