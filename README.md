## ビルドの仕方

```
$ bundle install --path vendor/bundle
$ cp config.yml.sample config.yml
$ vim config.yml # いい感じにいじる。Rakefile からしか参照されていないので、そっちを見ると何が起きるのかわかると思います。
$ bundle exec rake
```

無償版のpixateを使う場合、Rakefileの以下の部分をコメントアウトするのかもしれません。もしかするとmotion-pixateのバージョンアップが必要かも（調べてません）

```
    app.pixate.user = config['pixate']['user']
    app.pixate.key  = config['pixate']['key']
```


## 使い方

1. 写真を撮る or アルバムから選択する
1. Twitter の共有シートがすぐに出ますので、投稿する
1. [#RubyFriends](http://rubyfriends.com) に掲載される

テスト時には #RubyFriends のタグを消すか、Twitter にシェアしないように気をつけてください。


## 再起動無しで CSS の変更を反映させる

添付の `pixate_server` スクリプトにより、CSS の変更を即時反映させることが可能です。

実機でも、同一ネットワーク上にあれば可能です。うまくいかない場合、アプリ、サーバの再起動をして試してみてください。

MacRuby のインストールが必要です。


```
# サーバの起動
$ ./pixate_server resources/default.css
```