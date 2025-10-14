{ config, lib, pkgs, ... }:

{

  config = lib.mkIf config.klaymore.system.kanata.enable {

    # Keyd: no private use unicode support (yet). No unicode in Steam but oh well. Only supports ~67 macros or something before stops working. discord and vscode iffy, maybe only in xwayland?
    # Kanata: unicode should work using ctrl+shift+U if ibus running - not in neovide. Better key rebinding config format.
    # KMonmad: no chord support, unicode enters "a instead of ä and japanese / 󱥠󱥔 breaks config.
    # ibus: works in Steam, in Kitty but not Neovide. Works Emacs with kinda strange preview

    # no Unicode support: ydotool, dotool
    # no Plasma support: wtype, wlrctl


    services.kanata.enable = true;
    services.kanata.keyboards.default.extraDefCfg = ''
      concurrent-tap-hold yes
    '';
    services.kanata.keyboards.default.config = ''
      (defsrc
        esc
        grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
        tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
        caps a    s    d    f    g    h    j    k    l    ;    '    ret
        lsft z    x    c    v    b    n    m    ,    .    /    rsft
        lctl lmet lalt           spc            ralt rmet cmp  rctl
      )

      (deflayer qwerty
        esc
        grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
        tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
        caps a    s    d    f    g    h    j    k    l    ;    '    ret
        @sft z    x    c    v    b    n    m    ,    .    /    rsft
        lctl lmet lalt           spc            @qgr rmet cmp  rctl
      )

      (defchordsv2
        (esc q) (layer-switch qwerty) 200 first-release ()
        (esc c) (layer-switch colemak) 200 first-release ()
        (esc w) (layer-switch colemak-wide-dh) 200 first-release ()
        (esc j) (layer-switch hiragana) 200 first-release ()
      )

      (defalias
        caps bspc
        sft (one-shot 2000 lsft)
        qgr (layer-toggle qwerty-symbols)
      )

      (deflayer qwerty-symbols
        _
        _    _    _    _    _    _    _    _    _    _    _    _    _    _
        _    🔣ä  🔣é  🔣©  🔣ゆ 🔣󱤺 _    _    _    _    _    _    _    _
        _    _    _    _    _    _    _    _    _    _    _    _    _
        _    _    _    _    _    _    _    _    _    _    _    _
        _    _    _              _              _    _    _    _
      )


      (deflayer colemak
        esc
        grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
        tab  q    w    f    p    g    j    l    u    y    ;    [    ]    \
        caps a    r    s    t    d    h    n    e    i    o    '    ret
        @sft z    x    c    v    b    k    m    ,    .    /    rsft
        lctl lmet lalt           spc            ralt rmet cmp  rctl
      )

      (deflayer colemak-wide-dh
        esc
        grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
        tab  q    w    f    p    b    @sft j    l    u    y    ;    '    \
        caps a    r    s    t    g    @sft m    n    e    i    o    ret
        z    x    c    d    v    [    ]    k    h    ,    .    /
        lctl lmet lalt           spc            ralt rmet cmp  rctl
      )



      (deflayer hiragana
        esc
        grv  1    2    3    4    5    6    7    8    9    0    @j-  XX   bspc
        tab  XX   @jw  @je  @jr  @jt  @jy  @ju  @ji  @jo  @jp  @j[  @j]  XX
        caps @ja  @js  @jd  XX   @jg  @jh  @jj  @jk  @jl  @j;  @j'  ret
        lsft @jz  XX   XX   @jv  @jb  @jn  @jm  @j,  @j.  XX   rsft
        lctl lmet lalt           spc            ralt rmet cmp  rctl
      )

      (defalias
        ja (chord hiragana a)   ji (chord hiragana i)   ju (chord hiragana u)
        je (chord hiragana e)   jo (chord hiragana o)

        jk (chord hiragana k)   jg (chord hiragana g)
        js (chord hiragana s)   jz (chord hiragana z)
        jt (chord hiragana t)   jd (chord hiragana d)
        jn (chord hiragana n)   jm (chord hiragana m)
        jh (chord hiragana h)   jb (chord hiragana b)   jp (chord hiragana p)
        jr (chord hiragana r)   jl (chord hiragana r)
        jy (chord hiragana y)   jj (chord hiragana y)
        jw (chord hiragana w)   jv (chord hiragana v)

        j[ (chord hiragana [)   j] (chord hiragana ])   j' (chord hiragana q)
        j, 🔣、   j. 🔣。   j- 🔣ー   j; 🔣󱦝
      )

      (defchords hiragana 1000
        (a  ) 🔣あ    (i  ) 🔣い    (u  ) 🔣う    (e  ) 🔣え    (o  ) 🔣お
        
        (k a) 🔣か    (k i) 🔣き    (k u) 🔣く    (k e) 🔣け    (k o) 🔣こ
        (g a) 🔣が    (g i) 🔣ぎ    (g u) 🔣ぐ    (g e) 🔣げ    (g o) 🔣ご
        (s a) 🔣さ    (s i) 🔣し    (s u) 🔣す    (s e) 🔣せ    (s o) 🔣そ    (s h i) 🔣し
        (z a) 🔣ざ    (z i) 🔣じ    (z u) 🔣ず    (z e) 🔣ぜ    (z o) 🔣ぞ
        (t a) 🔣た    (t i) 🔣ち    (t u) 🔣つ    (t e) 🔣て    (t o) 🔣と    (t s u) 🔣つ
        (d a) 🔣だ    (d i) 🔣ぢ    (d u) 🔣づ    (d e) 🔣で    (d o) 🔣ど

        (n a) 🔣な    (n i) 🔣に    (n u) 🔣ぬ    (n e) 🔣ね    (n o) 🔣の

        (h a) 🔣は    (h i) 🔣ひ    (h u) 🔣ふ    (h e) 🔣へ    (h o) 🔣ほ
        (b a) 🔣ば    (b i) 🔣び    (b u) 🔣ぶ    (b e) 🔣べ    (b o) 🔣ぼ
        (p a) 🔣ぱ    (p i) 🔣ぴ    (p u) 🔣ぷ    (p e) 🔣ぺ    (p o) 🔣ぽ

        (m a) 🔣ま    (m i) 🔣み    (m u) 🔣む    (m e) 🔣め    (m o) 🔣も
        (y a) 🔣や                  (y u) 🔣ゆ                  (y o) 🔣よ
        (r a) 🔣ら    (r i) 🔣り    (r u) 🔣る    (r e) 🔣れ    (r o) 🔣ろ
        (w a) 🔣わ    (w i) 🔣ゐ                  (w e) 🔣ゑ    (w o) 🔣を

        (v a) 🔣ゃ    (v i) 🔣っ    (v u) 🔣ゅ                  (v o) 🔣ょ
        (n  ) 🔣ん    ([  ) 🔣［    (]  ) 🔣］    (q [) 🔣「    (q ]) 🔣」
      )

    '';





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

  };
}