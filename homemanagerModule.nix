{ lib, pkgs, ...}: 
let 
    linker = lib.fileContents "${pkgs.binutils}/nix-support/dynamic-linker"; 
in
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    withNodeJs = true;
    withPython3 = true;
    #Nix ld also needs to be enabled in system config
    extraWrapperArgs = [
      "--suffix"
      "NIX_LD_LIBRARY_PATH"
      ":"
      #If you need other libraries for you DAP's etc add them here
      "${lib.makeLibraryPath [pkgs.stdenv.cc.cc pkgs.zlib]}"
      "--set"
      "NIX_LD"
      "${linker}"
    ];
  };
}
