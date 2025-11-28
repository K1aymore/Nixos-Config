{ config, lib, pkgs, ... }:

{

  config = let 
    chord-time = "1000";
    tap-hold-delay = "200";
    tap-dance-delay = "275";
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
      process-unmapped-keys yes
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
        grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
        tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
        @cap a    s    d    f    g    h    j    k    l    ;    '    ret
        lsft z    x    c    v    b    n    m    ,    .    /    rsft
        lctl lmet lalt           spc            ralt rmet cmp  rctl
      )

      (defalias
        esc (tap-hold-press ${tap-dance-delay} 500 esc (layer-while-held esc))
        cap bspc
        qgr (layer-while-held qwerty-symbols)
        6^ (tap-hold 0 ${tap-hold-delay} 6 AG-6)
        7^ (tap-hold 0 ${tap-hold-delay} 7 🔣ŭ)
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
        — AG-S--   – AG--     … AG-S-/
        ä AG-a     å AG-w     ö AG-o
        Ä AG-S-a   Å AG-S-w   Ö AG-S-o
        é AG-g     É AG-S-g
        ĉ (macro AG-6 c)     ĝ (macro AG-6 g)     ĥ (macro AG-6 h)
        ĵ (macro AG-6 j)     ŝ (macro AG-6 s)
        Ĉ (macro AG-6 S-c)   Ĝ (macro AG-6 S-g)   Ĥ (macro AG-6 S-h)
        Ĵ (macro AG-6 S-j)   Ŝ (macro AG-6 S-s)
      )

      (deflayer qwerty-symbols
        _
        _    _    _    _    _    _    _    _    _    _    _    _    _    _
        _    _    _    _    _    _    _    _    _    _    _    _    _    _
        _    _    _    _    _    _    _    _    _    _    _    _    _
        _    _    _    _    _    _    _    _    _    _    @…   _
        _    _    _              _              _    _    _    _
      )





      ;; COLEMAK

      (deflayer colemak
        @esc
        grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
        tab  q    w    f    p    g    j    l    u    y    ;    [    ]    \
        @cap a    r    s    t    d    h    n    e    i    o    '    ret
        lsft z    x    c    v    b    k    m    ,    .    /    rsft
        lctl lmet lalt           spc            ralt rmet cmp  rctl
      )

      (deflayer colemak-wide-dh
        @esc
        grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
        tab  q    w    f    p    b    🔣þ  j    l    u    y    [    ]    \
        @cap a    r    @shs @crt g    @ö   m    @crn @she i    o    ret
        @shz x    c    d    v    @ä   @å   k    h    ,    .    /
        lctl lmet lalt           @spc          @wgr rmet cmp  rctl
      )

      (deflayermap (wide-sft)
        ;; TODO: doesn't re-press shift after release
        ralt (multi (release-key lsft) (layer-while-held wide-ag-sft))
        y 🔣Þ
      )

      (defalias
        crt (tap-hold 0 ${tap-hold-delay} t lctl)
        shs (tap-hold 0 ${tap-hold-delay} s (multi lsft (layer-while-held wide-sft)))
        alr (tap-hold 0 ${tap-hold-delay} r lalt)
        mea (tap-hold 0 ${tap-hold-delay} a lmet)
        crn (tap-hold 0 ${tap-hold-delay} n lctl)
        she (tap-hold 0 ${tap-hold-delay} e (multi lsft (layer-while-held wide-sft)))
        ali (tap-hold 0 ${tap-hold-delay} i lalt)
        meo (tap-hold 0 ${tap-hold-delay} o lmet)

        shz (tap-hold-press 0 ${tap-hold-delay} z (multi lsft (layer-while-held wide-sft)))

        wgr (tap-hold-press 0 ${tap-hold-delay} rpt (layer-while-held wide-ag))
        spc (tap-hold ${tap-dance-delay} ${tap-hold-delay} spc (layer-while-held wide-extend))
      )



      (deflayer wide-ag
        @esc
        grv  1    2    3    4    5    6    7    8    9    0    @—   XX   bspc
        tab  XX   XX   XX   XX   XX   XX   XX   S-;  🔣ŭ  @é   XX   XX   \
        @cap @å   @ö   @gsŝ @ä   @ĝ   XX   S-[  ;    @gs= S-'  '    ret
        @gsh XX   @ĉ   S-9  S-0  XX   XX   S-]  @ĥ   @ĵ   @…   XX
        lctl lmet lalt           spc            ralt rmet cmp  rctl
      )

      (deflayer wide-ag-sft
        @esc
        grv  1    2    3    4    5    6    7    8    9    0    @–   XX   bspc
        tab  XX   XX   XX   XX   XX   XX   XX   XX   🔣Ŭ  @É   XX   XX   S-\
        @cap @Å   @Ö   @Ŝ   @Ä   @Ĝ   XX   [    S-;  XX   XX   XX   ret
        lsft XX   @Ĉ   XX   XX   XX   XX   ]    @Ĥ   @Ĵ   XX   XX
        lctl lmet lalt           spc            ralt rmet cmp  rctl
      )

      (defalias
        gsh (layer-while-held wide-ag-sft)
        gsŝ (tap-hold 0 ${tap-hold-delay} (macro AG-6 s) (layer-while-held wide-ag-sft))
        gs= (tap-hold 0 ${tap-hold-delay} =              (layer-while-held wide-ag-sft))
      )

      (deflayer wide-extend
        @esc
        grv  1    2    3    4    5    6    7    8    9    0    XX   XX   bspc
        tab  XX   XX   XX   XX   XX   XX   XX   XX   XX   XX   XX   XX   XX
        @cap XX   XX   lsft lctl XX   XX   XX   left down up   rght ret
        lsft XX   XX   XX   XX   XX   XX   XX   XX   XX   XX   XX
        lctl lmet lalt           spc            ralt rmet cmp  rctl
      )



      ;; HIRAGANA

      (deflayermap hiragana
        esc @esc    caps @cap    lctl (multi lctl (layer-while-held qwerty))
        , 🔣、   . 🔣。   - 🔣ー   ; 🔣󱦝

        ${lib.concatMapStrings (c: "${c} (chord hiragana ${c})\n")
          (lib.stringToCharacters "abcdefghikmnoprstuvwyz[]'")
        }
        j (chord hiragana y)    l (chord hiragana r)
        q 🔣っ    x XX

        1 🔣一   2 🔣二   3 🔣三   4 🔣四   5 🔣五   6 🔣六   7 🔣七   8 🔣八   9 🔣九
        0 (tap-dance ${tap-dance-delay} (🔣零 🔣十 🔣百 🔣千 🔣万))
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
        (s h i) 🔣し  (t s u) 🔣つ  (s  ) 🔣す    (c i) 🔣ち    (c h i) 🔣ち  (f u) 🔣ふ
        (n  ) 🔣ん    ([  ) 🔣［    (]  ) 🔣］    (' [) 🔣「     (' ]) 🔣」
      )



      (deflayermap katakana
        esc @esc    caps @cap    lctl (multi lctl (layer-while-held qwerty))
        , 🔣、   . 🔣。   - 🔣ー   ; 🔣󱦝

        ${lib.concatMapStrings (c: "${c} (chord katakana ${c})\n")
          (lib.stringToCharacters "abcdefghikmnoprstuvwyz[]'")
        }
        j (chord katakana y)    l (chord katakana r)
        q 🔣ッ    x XX

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
        (s h i) 🔣シ  (t s u) 🔣ツ  (s  ) 🔣ス    (c i) 🔣チ    (c h i) 🔣チ  (f u) 🔣フ
        (n  ) 🔣ン    ([  ) 🔣［    (]  ) 🔣］    (' [) 🔣「     (' ]) 🔣」
      )



      ${with builtins; let
        # based on https://web.archive.org/web/20210118014238/https://wyub.github.io/tokipona/sitelenike/tokiponalili
        list = [
        [ "󱤀" "a"  ] [ "󱤔" "kl" ] [ "󱤨" "li" ] [ "󱤼" "mt" ] [ "󱥐" "in" ] [ "󱥤" "su" ] [ "󱥾" "to" ]
        [ "󱤁" "ak" ] [ "󱤕" "ka" ] [ "󱤩" "lj" ] [ "󱤽" "np" ] [ "󱥑" "pi" ] [ "󱥥" "sa" ] [ "󱥹" "iw" ]
        [ "󱤂" "al" ] [ "󱤖" "km" ] [ "󱤪" "lu" ] [ "󱤾" "na" ] [ "󱥒" "oa" ] [ "󱥦" "ui" ] [ "󱥸" "nk" ]
        [ "󱤃" "as" ] [ "󱤗" "ks" ] [ "󱤫" "lo" ] [ "󱤿" "ns" ] [ "󱥓" "oi" ] [ "󱥧" "ta" ] [ "󱥽" "os" ]
        [ "󱤄" "ai" ] [ "󱤘" "ke" ] [ "󱤬" "ln" ] [ "󱥀" "ne" ] [ "󱥔" "po" ] [ "󱥨" "ts" ] [ "󱥻" "ip" ]
        [ "󱤅" "ap" ] [ "󱤙" "k"  ] [ "󱤭" "u"  ] [ "󱥁" "n"  ] [ "󱥕" "pu" ] [ "󱥩" "tw" ] [ "󱦀" "kj" ]
        [ "󱤆" "at" ] [ "󱤚" "ki" ] [ "󱤮" "lk" ] [ "󱥂" "nm" ] [ "󱥖" "="  ] [ "󱥪" "tl" ] [ "󱥖" "==" ]
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
      #                 ^ group by first character      ^ only 2-char long words
      singles = groupBy (l: substring 0 1 (elemAt l 1)) (filter (l: stringLength (elemAt l 1) == 1) list);
      #                  ^ first character               ^ only single char words
      in
      # Base keybinds, plus held leader keys to switch to other layers
      ''
        (deflayermap sitelen-pona
          esc @esc    caps @cap    lctl (multi lctl (layer-while-held qwerty))
          lsft (layer-while-held sitelen-pona-sft)
          / 🔣‍  ;; zero width joiner
          . 🔣󱦜
          ; 🔣󱦝
          [ 🔣󱦐
          ] 🔣󱦑

          ${lib.concatMapAttrsStringSep "" (name: list: ''
            ${name} (tap-hold-press 0 ${tap-hold-delay} 🔣${elemAt (elemAt singles.${name} 0) 0} (layer-while-held sp-${name}))
          '') groups}
        )

        (deflayermap sitelen-pona-sft
          [ 🔣󱦗  ;; start of long glyph
          ] 🔣󱦘  ;; end of long glyph
          - 🔣󱦕  ;; stacking combiner
          = 🔣󱦖  ;; scaling combiner
        )
      ''
      +
      # Generate different layers for second keypress
      (lib.concatMapAttrsStringSep "\n" (name: group: ''
        (deflayermap (sp-${name})
          ${lib.concatMapStringsSep "    " (touple:
            substring 1 2 (elemAt touple 1) + " 🔣" + elemAt touple 0
          ) group}
        )
      '') groups)

      }
     
  '';

  };
}
