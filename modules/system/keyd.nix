{ config, lib, pkgs, ... }:

{

  config = lib.mkIf config.klaymore.system.keyd.enable {

    # https://github.com/amjadodeh/arabic-transliteration-keyd-setup
    # ln -s "$(nix-build '<nixpkgs>' --attr keyd --no-out-link)/share/keyd/keyd.compose" "$HOME/.XCompose"
    # services.keyd.enable = true;
    # services.keyd.keyboards.default = {
    #   ids = [ "*" ];
    #   extraConfig = ''
    #     [main]
    #     esc+x = toggle(hiragana)
        
    #     [hiragana]
    #     a = あ
    #     i = い
    #     u = う
    #     e = え
    #     o = お

    #     k+a = か
    #     k+i = き
    #     k+u = く
    #     k+e = け
    #     k+o = こ
    #     g+a = が
    #     g+i = ぎ
    #     g+u = ぐ
    #     g+e = げ
    #     g+o = ご

    #     s+a = さ
    #     s+i = し
    #     s+u = す
    #     s+e = せ
    #     s+o = そ
    #     z+a = ざ
    #     z+i = じ
    #     z+u = ず
    #     z+e = ぜ
    #     z+o = ぞ

    #     t+a = た
    #     t+i = ち
    #     t+u = つ
    #     t+e = て
    #     t+o = と
    #     d+a = だ
    #     d+i = ぢ
    #     d+u = づ
    #     d+e = で
    #     d+o = ど

    #     n+a = な
    #     n+i = に
    #     n+u = ぬ
    #     n+e = ね
    #     n+o = の
    #     m+a = ま
    #     m+i = み
    #     m+u = む
    #     m+e = め
    #     m+o = も

    #     h+a = は
    #     h+i = ひ
    #     h+u = ふ
    #     f+u = ふ
    #     h+e = へ
    #     h+o = ほ
    #     b+a = ば
    #     b+i = び
    #     b+u = ぶ
    #     b+e = べ
    #     b+o = ぼ
    #     p+a = ぱ
    #     p+i = ぴ
    #     p+u = ぷ
    #     p+e = ぺ
    #     p+o = ぽ

    #     y+a = や
    #     y+u = ゆ
    #     y+e = macro(いえ)
    #     y+o = よ
    #     j+a = や
    #     j+u = ゆ
    #     j+e = macro(いえ)
    #     j+o = よ

    #     l+a = ら
    #     l+i = り
    #     l+u = る
    #     l+e = れ
    #     l+o = ろ
    #     r+a = ら
    #     r+i = り
    #     r+u = る
    #     r+e = れ
    #     r+o = ろ

    #     w+a = わ
    #     w+i = ゐ
    #     w+e = ゑ
    #     w+o = を
    #     v+a = ゃ
    #     v+u = ゅ
    #     v+o = ょ
    #     v+i = っ
    #     n = ん
    #     [ = ［
    #     ] = ］
    #     "+[ = 【
    #     "+] = 】
    #     '+[ = 【
    #     '+] = 】
    #     , = 、
    #   '';
    # };


    # services.kmonad = {
    #   enable = true;
    #    keyboards = {
    #     myKMonadOutput = {
    #       device = "/dev/input/by-id/usb-E-Signal_GIGABYTE_Keyboard-event-kbd";
    #       config = ''
    #         (defcfg
    #           ;; For Linux
    #           input  (device-file "/dev/input/by-id/usb-E-Signal_GIGABYTE_Keyboard-event-kbd")
    #           output (uinput-sink "MyKMonadOutput")

    #           ;; Comment this is you want unhandled events not to be emitted
    #           fallthrough true

    #           ;; Set this to false to disable any command-execution in KMonad
    #           allow-cmd false
    #         )

    #         (defsrc
    #           grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
    #           tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
    #           caps a    s    d    f    g    h    j    k    l    ;    '    ret
    #           lsft z    x    c    v    b    n    m    ,    .    /    rsft
    #           lctl lmet lalt           spc            ralt rmet cmp  rctl
    #         )
            
    #         (deflayer qwerty
    #           grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
    #           tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
    #           caps a    s    d    f    g    h    j    k    l    ;    '    ret
    #           lsft z    x    c    v    b    n    m    ,    .    /    rsft
    #           lctl lmet lalt           spc            @sym rmet cmp  rctl
    #         )

    #         (defalias
    #           sym (layer-toggle symbols)
    #         )

    #         (deflayer symbols
    #           _    _    _    _    _    _    _    _    _    _    _    _    _    _
    #           _    ä    é    ©    ゆ   󱤺    _    _    _    _    _    _    _    _
    #           _    +'   +~   +`   +^   _    _    _    _    _    _    _    _
    #           _    +"   +,   _    _    _    _    _    _    _    _    _
    #           _    _    _              _              _    _    _    _
    #         )
    #       '';
    #     };
    #   };
    # }; 


    # Keyd: no private use unicode support (yet). No unicode in Steam but oh well. Only supports ~67 macros or something before stops working. discord and vscode iffy, maybe only in xwayland?
    # Kanata: unicode should work using ctrl+shift+U if ibus running - not in neovide. Better key rebinding config format.
    # KMonmad: no chord support, unicode enters "a instead of ä and japanese / 󱥠󱥔 breaks config.
    # ibus: works in Steam, in Kitty but not Neovide. Works Emacs with kinda strange preview

    # no Unicode support: ydotool, dotool
    # no Plasma support: wtype, wlrctl

  };

}