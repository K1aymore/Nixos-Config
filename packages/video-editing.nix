{ pkgs, nixpkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    davinci-resolve
    #cinelerra
    #olive-editor
    #shotcut
    #flowblade
  ];

  nixpkgs.overlays = with import nixpkgs { system = "x86_64-linux"; }; [
    (final: prev: {
      davinci-resolve = prev.davinci-resolve.overrideAttrs (old: {

        davinci = (
          stdenv.mkDerivation rec {
            pname = "davinci-resolve";
            version = "18.1.4";

            nativeBuildInputs = [
              (appimage-run.override { buildFHSEnv = buildFHSEnvChroot; })
              addOpenGLRunpath
              copyDesktopItems
              unzip
            ];

            # Pretty sure, there are missing dependencies ...
            buildInputs = [
              libGLU
              xorg.libXxf86vm
            ];

            src = runCommandLocal "${pname}-src.zip"
              rec {
                outputHashMode = "recursive";
                outputHashAlgo = "sha256";
                outputHash = "sha256-u9SD814h/ULy0vXxChZUnko2xZdFCelR9u7UImV6MYo=";

                impureEnvVars = lib.fetchers.proxyImpureEnvVars;

                nativeBuildInputs = [ curl ];

                # ENV VARS
                SSL_CERT_FILE = "${cacert}/etc/ssl/certs/ca-bundle.crt";

                # Get linux.downloadId from HTTP response on https://www.blackmagicdesign.com/products/davinciresolve
                DOWNLOADID = "6449dc76e0b845bcb7399964b00a3ec4";
                REFERID = "263d62f31cbb49e0868005059abcb0c9";
                SITEURL = "https://www.blackmagicdesign.com/api/register/us/download/${DOWNLOADID}";

                USERAGENT = builtins.concatStringsSep " " [
                  "User-Agent: Mozilla/5.0 (X11; Linux ${stdenv.targetPlatform.linuxArch})"
                  "AppleWebKit/537.36 (KHTML, like Gecko)"
                  "Chrome/77.0.3865.75"
                  "Safari/537.36"
                ];

                REQJSON = builtins.toJSON {
                  "firstname" = "NixOS";
                  "lastname" = "Linux";
                  "email" = "someone@nixos.org";
                  "phone" = "+31 71 452 5670";
                  "country" = "nl";
                  "street" = "Hogeweide 346";
                  "state" = "Province of Utrecht";
                  "city" = "Utrecht";
                  "product" = "DaVinci Resolve";
                };

              } ''
              RESOLVEURL=$(curl \
                --silent \
                --header 'Host: www.blackmagicdesign.com' \
                --header 'Accept: application/json, text/plain, */*' \
                --header 'Origin: https://www.blackmagicdesign.com' \
                --header "$USERAGENT" \
                --header 'Content-Type: application/json;charset=UTF-8' \
                --header "Referer: https://www.blackmagicdesign.com/support/download/$REFERID/Linux" \
                --header 'Accept-Encoding: gzip, deflate, br' \
                --header 'Accept-Language: en-US,en;q=0.9' \
                --header 'Authority: www.blackmagicdesign.com' \
                --header 'Cookie: _ga=GA1.2.1849503966.1518103294; _gid=GA1.2.953840595.1518103294' \
                --data-ascii "$REQJSON" \
                --compressed \
                "$SITEURL")

              curl \
                --retry 3 --retry-delay 3 \
                --header "Upgrade-Insecure-Requests: 1" \
                --header "$USERAGENT" \
                --header "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8" \
                --header "Accept-Language: en-US,en;q=0.9" \
                --compressed \
                "$RESOLVEURL" \
                > $out
            '';

            # The unpack phase won't generate a directory
            setSourceRoot = ''
              sourceRoot=$PWD
            '';

            installPhase = ''
              runHook preInstall

              export HOME=$PWD/home
              mkdir -p $HOME

              mkdir -p $out
              appimage-run ./DaVinci_Resolve_${version}_Linux.run -i -y -n -C $out

              mkdir -p $out/{configs,DolbyVision,easyDCP,Fairlight,GPUCache,logs,Media,"Resolve Disk Database",.crashreport,.license,.LUT}
              runHook postInstall
            '';

            dontStrip = true;

            postFixup = ''
              for program in $out/bin/*; do
                isELF "$program" || continue
                addOpenGLRunpath "$program"
              done

              for program in $out/libs/*; do
                isELF "$program" || continue
                if [[ "$program" != *"libcudnn_cnn_infer"* ]];then
                  echo $program
                  addOpenGLRunpath "$program"
                fi
              done
              ln -s $out/libs/libcrypto.so.1.1 $out/libs/libcrypt.so.1
            '';

            desktopItems = [
              (makeDesktopItem {
                name = "davinci-resolve";
                desktopName = "Davinci Resolve";
                genericName = "Video Editor";
                exec = "resolve";
                # icon = "DV_Resolve";
                comment = "Professional video editing, color, effects and audio post-processing";
                categories = [
                  "AudioVideo"
                  "AudioVideoEditing"
                  "Video"
                  "Graphics"
                ];
              })
            ];
          }
        );


      });
    })
  ];



}
