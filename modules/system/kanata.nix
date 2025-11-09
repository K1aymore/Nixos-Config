{ config, lib, pkgs, ... }:

{

  config = let 
    chord-time = "1000";
    tap-hold-delay = "200";
  in  lib.mkIf config.klaymore.system.kanata.enable {

    # Keyd: no private use unicode support (yet). No unicode in Steam but oh well. Only supports ~67 macros or something before stops working. discord and vscode iffy, maybe only in xwayland?
    # Kanata: unicode should work using ctrl+shift+U if ibus running - not in neovide sometimes. Better key rebinding config format.
    # KMonmad: no chord support, unicode enters "a instead of ä and japanese / 󱥠󱥔 breaks config.
    # ibus: works in Steam, in Kitty but not Neovide. Works Emacs with kinda strange preview

    # no Unicode support: ydotool, dotool
    # no Plasma support: wtype, wlrctl

    environment.systemPackages = with pkgs; [ 
      ibus
    ];


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
        @esc
        grv  1    2    3    4    5    @6^  @7^  8    9    0    -    =    bspc
        tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
        @cap a    s    d    f    g    h    j    k    l    ;    '    ret
        lsft z    x    c    v    b    n    m    ,    .    /    rsft
        lctl lmet lalt           spc            ralt rmet cmp  rctl
      )

      (defalias
        esc (tap-hold-press 200 500 esc (layer-while-held esc))
        cap bspc
        sft (one-shot 1000 lsft)
        qgr (layer-while-held qwerty-symbols)
        6^ (tap-hold-press 200 500 6 AG-6)
        7^ (tap-hold-press 200 500 7 🔣ŭ)
      )


      (deflayer esc
        XX
        XX   XX   XX   XX   XX   XX   XX   XX   XX   XX   XX   XX   XX   XX
        XX   @␛q  @␛w  XX   XX   XX   XX   XX   XX   XX   @␛p  XX   XX   XX
        XX   XX   XX   XX   XX   XX   XX   @␛j  @␛k  XX   XX   XX   XX
        XX   XX   XX   @␛c  XX   XX   XX   XX   XX   XX   XX   XX
        XX   XX   XX             XX             XX   XX   XX   XX
      )

      (defalias
        ␛q (layer-switch qwerty)
        ␛c (layer-switch colemak)
        ␛w (layer-switch colemak-wide-dh)
        ␛j (layer-switch hiragana)
        ␛k (layer-switch katakana)
        ␛p (layer-switch sitelen-pona)

        ;; for EurKey
        ä AG-a
        å AG-w
        ö AG-o
      )

      (deflayer qwerty-symbols
        _
        _    _    _    _    _    _    _    _    _    _    _    _    _    _
        _    _    _    _    _    _    _    _    _    _    _    _    _    _
        _    _    _    _    _    _    _    _    _    _    _    _    _
        _    _    _    _    _    _    _    _    _    _    🔣…  _
        _    _    _              _              _    _    _    _
      )


      (deflayer colemak
        @esc
        grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
        tab  q    w    f    p    g    j    l    u    y    ;    [    ]    \
        @cap a    r    s    t    d    h    n    e    i    o    '    ret
        @sft z    x    c    v    b    k    m    ,    .    /    rsft
        lctl lmet lalt           spc            ralt rmet cmp  rctl
      )

      (deflayer colemak-wide-dh
        @esc
        grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
        tab  q    w    f    p    b    🔣þ  j    l    u    y    ;    '    \
        @cap a    r    @shs @crt g    @ö   m    @crn @she i    o    ret
        @shz x    c    d    v    @å   @ä   k    h    ,    .    /
        lctl lmet lalt           spc            @wgr rmet cmp  rctl
      )

      (defalias
        crt (tap-hold 0 ${tap-hold-delay} t lctl)
        shs (tap-hold 0 ${tap-hold-delay} s lsft)
        alr (tap-hold 0 ${tap-hold-delay} r lalt)
        mea (tap-hold 0 ${tap-hold-delay} a lmet)
        crn (tap-hold 0 ${tap-hold-delay} n lctl)
        she (tap-hold 0 ${tap-hold-delay} e lsft)
        ali (tap-hold 0 ${tap-hold-delay} i lalt)
        meo (tap-hold 0 ${tap-hold-delay} o lmet)

        shz (tap-hold-press 0 ${tap-hold-delay} z lsft)

        wgr (layer-while-held wide-altgr)
        … (tap-dance-eager 400 (. (macro bspc 🔣…)))
      )

      (deflayer wide-altgr
        @esc
        grv  1    2    3    4    5    6    7    8    9    0    XX   XX   bspc
        tab  q    w    f    p    b    XX   j    l    u    y    ;    XX    \
        @cap -    =    S-9  [    g    XX   m    ]    S-0  '    \    ret
        lsft x    c    d    v    XX   XX   k    h    ,    🔣…  /
        lctl lmet lalt           spc            ralt rmet cmp  rctl
      )

      (deflayer wide-altgr-sft
        @esc
        grv  1    2    3    4    5    6    7    8    9    0    XX   XX   bspc
        tab  q    w    f    p    b    XX   j    l    u    y    ;    XX    \
        @cap -    =    XX   {    g    XX   m    }    XX   '    \    ret
        lsft x    c    d    v    XX   XX   k    h    ,    🔣…  /
        lctl lmet lalt           spc            ralt rmet cmp  rctl
      )





      (deflayer hiragana
        @esc
        grv  1    2    3    4    5    6    7    8    9    0    @j-  XX   bspc
        tab  XX   @jw  @je  @jr  @jt  @jy  @ju  @ji  @jo  @jp  @j[  @j]  XX
        @cap @ja  @js  @jd  XX   @jg  @jh  @jj  @jk  @jl  @j;  @j'  ret
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
        (s a) 🔣さ    (s i) 🔣し    (s u) 🔣す    (s e) 🔣せ    (s o) 🔣そ
        (z a) 🔣ざ    (z i) 🔣じ    (z u) 🔣ず    (z e) 🔣ぜ    (z o) 🔣ぞ
        (t a) 🔣た    (t i) 🔣ち    (t u) 🔣つ    (t e) 🔣て    (t o) 🔣と
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
        (s h i) 🔣し  (t s u) 🔣つ  (s  ) 🔣す
        (n  ) 🔣ん    ([  ) 🔣［    (]  ) 🔣］    (q [) 🔣「    (q ]) 🔣」
      )



      (deflayer katakana
        @esc
        grv  1    2    3    4    5    6    7    8    9    0    @k-  XX   bspc
        tab  XX   @kw  @ke  @kr  @kt  @ky  @ku  @ki  @ko  @kp  @k[  @k]  XX
        @cap @ka  @ks  @kd  XX   @kg  @kh  @kj  @kk  @kl  @k;  @k'  ret
        lsft @kz  XX   XX   @kv  @kb  @kn  @km  @k,  @k.  XX   rsft
        lctl lmet lalt           spc            ralt rmet cmp  rctl
      )

      (defalias
        ka (chord katakana a)   ki (chord katakana i)   ku (chord katakana u)
        ke (chord katakana e)   ko (chord katakana o)

        kk (chord katakana k)   kg (chord katakana g)
        ks (chord katakana s)   kz (chord katakana z)
        kt (chord katakana t)   kd (chord katakana d)
        kn (chord katakana n)   km (chord katakana m)
        kh (chord katakana h)   kb (chord katakana b)   kp (chord katakana p)
        kr (chord katakana r)   kl (chord katakana r)
        ky (chord katakana y)   kj (chord katakana y)
        kw (chord katakana w)   kv (chord katakana v)

        k[ (chord katakana [)   k] (chord katakana ])   k' (chord katakana q)
        k, 🔣、   k. 🔣。   k- 🔣ー   k; 🔣󱦝
      )

      (defchords katakana 1000
        (a  ) 🔣ア    (i  ) 🔣イ    (u  ) 🔣ウ    (e  ) 🔣エ    (o  ) 🔣オ

        (k a) 🔣カ    (k i) 🔣キ    (k u) 🔣ク    (k e) 🔣ケ    (k o) 🔣コ
        (g a) 🔣ガ    (g i) 🔣ギ    (g u) 🔣グ    (g e) 🔣ゲ    (g o) 🔣ゴ
        (s a) 🔣サ    (s i) 🔣シ    (s u) 🔣ス    (s e) 🔣セ    (s o) 🔣ソ
        (z a) 🔣ザ    (z i) 🔣ジ    (z u) 🔣ズ    (z e) 🔣ゼ    (z o) 🔣ゾ
        (t a) 🔣タ    (t i) 🔣チ    (t u) 🔣ツ    (t e) 🔣テ    (t o) 🔣ト
        (d a) 🔣ダ    (d i) 🔣ヂ    (d u) 🔣ヅ    (d e) 🔣デ    (d o) 🔣ド

        (n a) 🔣ナ    (n i) 🔣ニ    (n u) 🔣ヌ    (n e) 🔣ネ    (n o) 🔣ノ

        (h a) 🔣ハ    (h i) 🔣ヒ    (h u) 🔣フ    (h e) 🔣ヘ    (h o) 🔣ホ
        (b a) 🔣バ    (b i) 🔣ビ    (b u) 🔣ブ    (b e) 🔣ベ    (b o) 🔣ボ
        (p a) 🔣パ    (p i) 🔣ピ    (p u) 🔣プ    (p e) 🔣ペ    (p o) 🔣ポ

        (m a) 🔣マ    (m i) 🔣ミ    (m u) 🔣ム    (m e) 🔣メ    (m o) 🔣モ
        (y a) 🔣ヤ                  (y u) 🔣ユ                  (y o) 🔣ヨ
        (r a) 🔣ラ    (r i) 🔣リ    (r u) 🔣ル    (r e) 🔣レ    (r o) 🔣ロ
        (w a) 🔣ワ    (w i) 🔣ヰ                  (w e) 🔣ヱ    (w o) 🔣ヲ

        (v a) 🔣ャ    (v i) 🔣ッ    (v u) 🔣ュ                  (v o) 🔣ョ
        (s h i) 🔣シ  (t s u) 🔣ツ  (s  ) 🔣ス
        (n  ) 🔣ン    ([  ) 🔣［    (]  ) 🔣］    (q [) 🔣「    (q ]) 🔣」
      )


      ${with builtins; let
        list = [
        [ "󱤀" "a"  ] [ "󱤔" "kl" ] [ "󱤨" "li" ] [ "󱤼" "mt" ] [ "󱥐" "in" ] [ "󱥤" "su" ] [ "󱥾" "to" ]
        [ "󱤁" "ak" ] [ "󱤕" "ka" ] [ "󱤩" "lj" ] [ "󱤽" "np" ] [ "󱥑" "pi" ] [ "󱥥" "up" ] [ "󱥹" "iw" ]
        [ "󱤂" "al" ] [ "󱤖" "km" ] [ "󱤪" "lu" ] [ "󱤾" "na" ] [ "󱥒" "oa" ] [ "󱥦" "ui" ] [ "󱥸" "nk" ]
        [ "󱤃" "as" ] [ "󱤗" "ks" ] [ "󱤫" "lo" ] [ "󱤿" "ns" ] [ "󱥓" "oi" ] [ "󱥧" "ta" ] [ "󱥽" "os" ]
        [ "󱤄" "ai" ] [ "󱤘" "ke" ] [ "󱤬" "ln" ] [ "󱥀" "ne" ] [ "󱥔" "po" ] [ "󱥨" "ts" ] [ "󱥻" "ip" ]
        [ "󱤅" "ap" ] [ "󱤙" "k"  ] [ "󱤭" "u"  ] [ "󱥁" "n"  ] [ "󱥕" "pu" ] [ "󱥩" "tw" ] [ "󱦀" "kj" ]
        [ "󱤆" "at" ] [ "󱤚" "ki" ] [ "󱤮" "lk" ] [ "󱥂" "nm" ] [ "󱥖" "sa" ] [ "󱥪" "tl" ]
        [ "󱤇" "an" ] [ "󱤛" "kw" ] [ "󱤯" "ua" ] [ "󱥃" "no" ] [ "󱥗" "se" ] [ "󱥫" "tn" ] 
        [ "󱤈" "aw" ] [ "󱤜" "ko" ] [ "󱤰" "ma" ] [ "󱥄" "o"  ] [ "󱥘" "el" ] [ "󱥬" "tk" ]
        [ "󱤉" "e"  ] [ "󱤝" "kn" ] [ "󱤱" "m2" ] [ "󱥅" "ol" ] [ "󱥙" "sm" ] [ "󱥭" "tm" ]
        [ "󱤊" "en" ] [ "󱤞" "ku" ] [ "󱤲" "m4" ] [ "󱥆" "on" ] [ "󱥚" "wi" ] [ "󱥮" "t"  ]
        [ "󱤋" "es" ] [ "󱤟" "kp" ] [ "󱤳" "me" ] [ "󱥇" "op" ] [ "󱥛" "sj" ] [ "󱥯" "un" ]
        [ "󱤌" "io" ] [ "󱤠" "kt" ] [ "󱤴" "m"  ] [ "󱥈" "pk" ] [ "󱥜" "sk" ] [ "󱥰" "ut" ]
        [ "󱤍" "ik" ] [ "󱤡" "la" ] [ "󱤵" "mj" ] [ "󱥉" "pl" ] [ "󱥝" "sn" ] [ "󱥱" "ul" ]
        [ "󱤎" "i"  ] [ "󱤢" "lp" ] [ "󱤶" "mk" ] [ "󱥊" "ps" ] [ "󱥞" "s"  ] [ "󱥲" "wl" ]
        [ "󱤏" "is" ] [ "󱤣" "ls" ] [ "󱤷" "mo" ] [ "󱥋" "px" ] [ "󱥟" "sp" ] [ "󱥳" "wn" ]
        [ "󱤐" "jk" ] [ "󱤤" "lw" ] [ "󱤸" "ms" ] [ "󱥌" "pa" ] [ "󱥠" "si" ] [ "󱥴" "ws" ]
        [ "󱤑" "j"  ] [ "󱤥" "le" ] [ "󱤹" "mu" ] [ "󱥍" "p"  ] [ "󱥡" "so" ] [ "󱥵" "wa" ]
        [ "󱤒" "jl" ] [ "󱤦" "lt" ] [ "󱤺" "mn" ] [ "󱥎" "pn" ] [ "󱥢" "sw" ] [ "󱥶" "wk" ]
        [ "󱤓" "jo" ] [ "󱤧" "l"  ] [ "󱤻" "mi" ] [ "󱥏" "pm" ] [ "󱥣" "sl" ] [ "󱥷" "w"  ]
      ];

      groups = groupBy (l: substring 0 1 (elemAt l 1)) (filter (l: stringLength (elemAt l 1) > 1) list);
      singles = groupBy (l: substring 0 1 (elemAt l 1)) (filter (l: stringLength (elemAt l 1) == 1) list);
      in
      ''
        (deflayermap sitelen-pona
          esc @esc
          . 🔣󱦜
          ; 🔣󱦝
          [ 🔣󱦐
          ] 🔣󱦑

          ${lib.concatMapAttrsStringSep "" (name: list: ''
            ${name} (tap-hold-press 0 ${tap-hold-delay} 🔣${elemAt (elemAt singles.${name} 0) 0} (layer-while-held sp-${name}))
          '') groups}
        )
      ''

      +

      (lib.concatMapAttrsStringSep "\n" (name: list: ''
        (deflayermap (sp-${name})
          ${lib.concatMapStringsSep "    " (touple:
            substring 1 2 (elemAt touple 1) + " 🔣" + elemAt touple 0
          ) list}
        )
      '') groups)

      }
     
  '';

  };
}
