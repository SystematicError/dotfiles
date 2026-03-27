{pkgs, ...}: {
  home.packages = with pkgs; [
    bash-language-server
    shfmt

    basedpyright
  ];

  programs.zed-editor = {
    extensions = ["basher"];
  };
}
