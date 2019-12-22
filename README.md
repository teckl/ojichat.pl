
# ojichat.pl

## なんだこれは

おじさんがLINEやメールで送ってきそうな文を生成するコマンド[ojichat](https://github.com/greymd/ojichat) のPerl移植版です。

## インストール

```bash
go get -u github.com/greymd/ojichat
```


## 使い方

```
$ ./ojichat.pl

$ ./ojichat.pl -h
Usage:
    ojichat [options] [<name>]

    Options:

        -h, --help      ヘルプを表示.
        -V, --version   バージョンを表示.<br>
        -e <number>     絵文字/顔文字の最大連続数 [default: 4].
        -p <level>      句読点挿入頻度レベル [min:0, max:3] [default: 0].
```

### Docker

```sh
$ docker run --rm  ojichat.pl

```

## License
MIT

