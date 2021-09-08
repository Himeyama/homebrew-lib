---
layout: page
---

# Bottles (バイナリパッケージ)

Bottles は、`brew install --build-bottle <formula>` で Formula をインストールし、`brew bottle <formula>` でボトリングすることで生成される。これは、Formula ファイルに挿入されるべき Bottle DSL を出力する。

## 使用方法
Bottle が利用可能であれば、`brew install <formula>` の際に自動的にダウンロードされ、注入される。これを無効にしたい場合は、`--build-from-source` を指定する。

Bottle は、ユーザーが要求した場合 (上記参照)、`pour_bottle?` で Formula が要求した場合、インストール時にオプションが指定された場合 (Bottle はすべてデフォルトのオプションでコンパイルされます)、Bottle が最新でない場合 (チェックサムがないなど)、Bottle の `cellar` が `:any` でない場合や現在の `HOMEBREW_CELLAR` と等しくない場合には使用されない。

## 作成
Bottle は [Brew Test Bot](https://docs.brew.sh/Brew-Test-Bot) を使って作成され、通常は Homebrew にプルリクエストを提出する際に作成される。`bottle do` ブロックは、メンテナーがプルリクエストをマージしたときに更新される。Homebrew 組織の Tap についてのアップロードやダウンロードは [GitHub Packages](https://github.com/orgs/Homebrew/packages) から行う。

## ファイルフォーマット
Bottle は、コンパイルされたバイナリのシンプルな gzip 形式の tar ファイル。あらゆるメタデータは、Formula の Bottle DSL と Bottle ファイル名に格納される (例: macOS バージョン、改訂番号）。

## Bottle DSL (Domain Specific Language)
Bottle には、Bottle の `do ... end` ブロックに含まれている Formula に使用する DSL がある。

> 簡単な (典型的な) 例:
```rb
bottle do
  sha256 arm64_big_sur: "a9ae578b05c3da46cedc07dd428d94a856aeae7f3ef80a0f405bf89b8cde893a"
  sha256 big_sur:       "5dc376aa20241233b76e2ec2c1d4e862443a0250916b2838a1ff871e8a6dc2c5"
  sha256 catalina:      "924afbbc16549d8c2b80544fd03104ff8c17a4b1460238e3ed17a1313391a2af"
  sha256 mojave:        "678d338adc7d6e8c352800fe03fc56660c796bd6da23eda2b1411fed18bd0d8d"
end
```

> 完全な例:
```rb
bottle do
  root_url "https://example.com"
  rebuild 4
  sha256 cellar: "/opt/homebrew/Cellar", arm64_big_sur: "a9ae578b05c3da46cedc07dd428d94a856aeae7f3ef80a0f405bf89b8cde893a"
  sha256 cellar: :any,                   big_sur:       "5dc376aa20241233b76e2ec2c1d4e862443a0250916b2838a1ff871e8a6dc2c5"
  sha256                                 catalina:      "924afbbc16549d8c2b80544fd03104ff8c17a4b1460238e3ed17a1313391a2af"
  sha256                                 mojave:        "678d338adc7d6e8c352800fe03fc56660c796bd6da23eda2b1411fed18bd0d8d"
end
```

### Root URL (`root_url`)
オプションで、Bottle の URL を計算するために使用される URL ルートを含む。デフォルトではこれは省略され、Homebrew のデフォルトの Bottle URL ルートが使用される。
これは、Bottle を提供したい場合や、デフォルトではない `HOMEBREW_CELLAR` に対応した Tap に便利だろう。

### Cellar (`cellar`)
オプションで、Bottle がビルドされた `HOMEBREW_CELLAR` の値を含む。
ほとんどのコンパイルされたソフトウェアは、コンパイルされた場所への参照を含んでいるため、ディスク上のどこかに単純に再配置することはできない。
この値が `:any` または `:any_skip_relocation` の場合、Bottle がインストールされた Cellar への参照を含んでいないため、どの Cellar にも安全にインストールできることを意味する。ボトルがデフォルトの `HOMEBREW_CELLAR` 用にコンパイルされている（すべてのデフォルトの Homebrew のものがそうであるように）場合、これは省略可能。

### リビルドバージョン (`rebuild`)
オプションで、Bottle のリビルドバージョンを含められる。
新しいパッチが適用された等の理由で、Bottle のバージョンを上げずに更新する必要がある場合があり、その場合リビルドの値は `1` 以上になる。

### チェックサム (`sha256`)
特定のバージョンの macOS 用の Bottle のSHA-256ハッシュが含まれる。

## Formula DSL
Formula DSLには、追加のメソッドが用意されている。

### Pour bottle (`pour_bottle?`)
オプションで、この数式に Bottle を使用するかどうかを決定する bool 値を返す。
例えば、別の Formula がデフォルト以外のオプションでコンパイルされている場合、
ボトルが破損する可能性があるため、このメソッドではそのような場合をチェックして `false` を返すことができる。

> 完全な例:
```ruby
pour_bottle? do
  reason "The bottle needs to be installed into #{Homebrew::DEFAULT_PREFIX}."
  satisfy { HOMEBREW_PREFIX.to_s == Homebrew::DEFAULT_PREFIX }
end
```

よく使われる `pour_bottle?` の条件は、
`pour_bottle?` メソッドのプリセットシンボルとして追加でき、次のように指定できる。

```ruby
pour_bottle? only_if: :clt_installed
```