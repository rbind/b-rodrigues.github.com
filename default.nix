let
 pkgs = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/976fa3369d722e76f37c77493d99829540d43845.tar.gz") {};
 hugo = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/ff5f7f9588322ee9c49178e4ddb4b82ff1d1f641.tar.gz") {};
  
  system_packages = builtins.attrValues {
    inherit (pkgs) 
      R
      glibcLocales
      nix;
  };

  rpkgs = builtins.attrValues {
    inherit (pkgs.rPackages) 
      blogdown
      ;
  };

in

pkgs.mkShell {
  LOCALE_ARCHIVE = if pkgs.system == "x86_64-linux" then  "${pkgs.glibcLocales}/lib/locale/locale-archive" else "";
  LANG = "en_US.UTF-8";
   LC_ALL = "en_US.UTF-8";
   LC_TIME = "en_US.UTF-8";
   LC_MONETARY = "en_US.UTF-8";
   LC_PAPER = "en_US.UTF-8";
   LC_MEASUREMENT = "en_US.UTF-8";

  buildInputs = [ rpkgs system_packages hugo.hugo ];
  
}