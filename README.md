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
1. [#RubyFriend](http://rubyfriends.com) に掲載される

テスト時には #RubyFriend のタグを消すか、Twitter にシェアしないように気をつけてください。
