{ ... }:

{

  services.syncthing = {
    enable = true;
    dataDir = "/synced";
    configDir = "/synced/Nix/persist/appdata/syncthing";
    user = "klaymore";
    group = "users";
    overrideDevices = true;
    overrideFolders = true;
    settings.devices = {
      "server" = { id = "NKDY5RS-AQHE4RN-FEA37A3-ZP4ZWYJ-ODIWZ3V-75LNZ4E-2H57JKJ-LCQ2SA6"; };
      "pc" = { id = "YN2VCWJ-KOISEL2-4IJKGK4-3AVQSBJ-ZWPNLPS-AUBCY5Q-MYWTZWU-6LIU2AL"; };
      "laptop" = { id = "NIOZEVB-77F44UB-NTNFBCT-CRGPRRZ-YT73MD6-TFZ77XH-PFDTJWR-JHU7QQE"; };
      "acer" = { id = "EDKZG5I-43A6ULK-GVGYZYG-74DZIZF-BDR7MKI-EAT6SJG-QQA5IAG-TZUWOAL"; };
      "portable" = { id = "XE2345I-O43URZS-PSHU7ND-27FP3MQ-OZDHQBP-GVQ6MX6-74TSRBX-2VOMGQY"; };
      "pixel" = { id = "TM2BIPF-O53YVKR-56UEPPB-E5CU3GC-SX2YXZK-LMQEKG7-F74KCLH-CHFWGAW"; };
      "pinephone" = { id = "4XLSS5A-V4FMDW7-SY4F7Y2-EG5KCTD-PMGPYHN-QKP32VU-DKKU6VC-MIOUTAU"; };
      "winpc" = { id = "D2GJW3Q-SGTTOT7-ZSP6B77-CJPN6CA-U3YEITS-REIXCVN-5FEKP3P-JK56RQE"; };
      "cDesk" = { id = "RLFHUVQ-HXAGZ54-DGEN2S3-YRHRWID-D6Q4S4B-PNOCIDP-T2NNWZP-GPY5NQG"; };
      "masterkitty" = { id = "GDGLT7J-TG3BPIS-HL72SHH-32R7W6K-IMHPBP6-WQI5MKS-FPGX2LA-A7QKMAW"; };
    };

  };

}
