
# ojichat.pl

## なんだこれは

おじさんがLINEやメールで送ってきそうな文を生成するコマンド[ojichat](https://github.com/greymd/ojichat) のPerl移植版です。

## 使い方

```
$ ./ojichat.pl
はるなﾁｬﾝ、ヤッホー😃😍😃♥ (^o^)何してるのかい🤔✋❓❗❓😜⁉️金曜日は仕事〜🤔✋❓❗❓😜⁉️今日はよく休んでね😎😴🛌🙂
$ ./ojichat.pl -h
Usage:
    ojichat [options] [<name>]

    Options:

        -h, --help      ヘルプを表示.
        -V, --version   バージョンを表示.<br>
        -e <number>     絵文字/顔文字の最大連続数 [default: 4].
        -p <level>      句読点挿入頻度レベル [min:0, max:3] [default: 0].

# 文言には特定の人名が含まれることもあるが、第一引数で指定可能。
$ ./ojichat.pl ラーメン
ラーメンちゃんは、スタイルがいいね❗😚😂😍今から寝ようと思ってたのに、目が覚めちゃったよ❗😚😂😍どうしてくれるんだ❗😚😂😍

# -e オプションの数字を大きくすることで、絵文字/顔文字がより連続で含まれやすくなる。
$ ./ojichat.pl  -e 10
くれぐれも体調に気をつけて🛌✋😙😴😒(＃￣З￣)😎(^^;;😪🤑僕は、すごく心配だよ(^_^;😓(・_・;(◎ ＿◎;)😰^^;💔😭(-_-;)😥そんなときは、美味しいもの食べて、元気出さなきゃだね💕(^з<)😂😚😘（笑）😄😆😋❗

$ ./ojichat.pl  -e 0
えみチャン、ヤッホー。何してるのかい。今日は楽しい時間をありがとうね。すごく、楽しかったよ。
```

## Docker

```sh
$ docker build -t ojichat.pl .
$ docker run --rm ojichat.pl
祈星ちゃん、オッハー(^_^)😊(^o^)(^з<)イタリアン🍝好きかな（￣ー￣?）🤔😜⁉️✋❓今日も大変だったんだね😢(◎ ＿◎;)💦😣
```

## License
MIT

