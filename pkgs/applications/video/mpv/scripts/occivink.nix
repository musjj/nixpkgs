{ lib
, stdenvNoCC
, fetchFromGitHub
}:

let
  script = { n, ... }@p:
    stdenvNoCC.mkDerivation (lib.attrsets.recursiveUpdate {
      pname = "mpv_${n}";
      passthru.scriptName = "${n}.lua";

      src = fetchFromGitHub {
        owner = "occivink";
        repo = "mpv-scripts";
        rev = "af360f332897dda907644480f785336bc93facf1";
        hash = "sha256-KdCrUkJpbxxqmyUHksVVc8KdMn8ivJeUA2eerFZfEE8=";
      };
      version = "unstable-2022-10-02";

      dontBuild = true;
      installPhase = ''
        mkdir -p $out/share/mpv/scripts
        cp -r scripts/${n}.lua $out/share/mpv/scripts/
      '';

      meta = with lib; {
        homepage = "https://github.com/occivink/mpv-scripts";
        license = licenses.unlicense;
        platforms = platforms.all;
        maintainers = with maintainers; [ nicoo ];
      };

      outputHashAlgo = "sha256";
      outputHashMode = "recursive";
    } p);

in
{

  # Usage: `pkgs.mpv.override { scripts = [ pkgs.mpvScripts.seekTo ]; }`

  crop = script {
    n = "crop";
    meta.description = "Crop the current video in a visual manner";
    outputHash = "sha256-/uaTCtV8Aanvnxrt8afBbO4uu2xp8Ec6DxApMb+fg2s=";
  };

  encode = script {
    n = "encode";
    meta.description = "Make an extract of the video currently playing using ffmpeg";
    outputHash = "sha256-yK/DV0cpGhl4Uobl7xA1myZiECJpsShrHnsJftBqzAY=";
  };

  seekTo = script {
    n = "seek-to";
    meta.description = "Mpv script for seeking to a specific position";
    outputHash = "sha256-3RlbtUivmeoR9TZ6rABiZSd5jd2lFv/8p/4irHMLshs=";
  };

  blacklistExtensions = script {
    n = "blacklist-extensions";
    meta.description = "Automatically remove playlist entries based on their extension.";
    outputHash = "sha256-qw9lz8ofmvvh23F9aWLxiU4YofY+YflRETu+nxMhvVE=";
  };

  blurEdges = script {
    n = "blur-edges";
    meta.description = "Fills the black bars on the side of a video with a blurred copy of its edges";
    outputHash = "sha256-nPa8msoQqLM33HDGkdSBnekXh1Gl389Y5G28fpaCJgA=";
  };

  misc = script {
    n = "misc";
    meta.description = "Some commands that are too simple to warrant their own script";
    outputHash = "sha256-eDi5t7WQjz/7jIj6mG0T9dP5OYJx82v5P7H2cWuPHkI=";
  };

}
