# Rails Gradle Sample

## Install

1. Gradle

	```
	brew install gradle
	```

2. JRuby

	```
	brew install jruby
	jruby -v
	```

## Java

```
cd kotlin
gradle init --type java-application
rm -rf src/main/java/
rm -rf src/test/java/
mkdir src/main/kotlin
mkdir src/test/kotlin
# edit build.gradle
# create hello.HelloKt
gradle run
```

`build/classes/kotlin/main` に `*.class` が作られる

```
gradle jar
```

`build/libs` に `*.jar` が作られる



## Gems

	build/gems/binに、railsコマンドが入る

	```
	gradle -q jrubyPrepare
	```

## View tasks

```
gradle -q tasks
```

```
gradle tasks --all
```

## Build

```
gradle build
```

## Rails

### Railsのバージョンを表示
```
./rails.sh -v
```

### Railsプロジェクトの作成
```
./rails.sh new . # README.mdは作らない
```

### 開発用のサーバ向けのバンドルを追加

* 最初、serverを起動するとエラーになる
	```
	% ./rails.sh server
	gems_home=/Users/kogahirotaka/develop/gradle/kotlin-rails/kotlin/build/gems
	rails_path=/Users/kogahirotaka/develop/gradle/kotlin-rails/kotlin/build/gems/bin/rails
	=> Booting Puma
	=> Rails 5.2.1 application starting in development
	=> Run `rails server -h` for more startup options
	Exiting
	LoadError: Could not load the 'listen' gem. Add `gem 'listen'` to the development group of your Gemfile
	```

* 入ってないことを確認
	```
	cat Gemfile.lock | grep 'listen'
	```

* 記述を追加する
	```Gemfile
	# Add development
	group :development do
		gem 'listen', '~> 3.1.5'
		# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
		gem 'spring'
		gem 'spring-watcher-listen', '~> 2.0.0'
	end
	```

* インストール
	```
	./bundle.sh install
	```

### Railsサーバの起動
```
./rails.sh server 
```

### Railsサーバにアクセス
- http://localhost:3000

### データベース作成
 - database.ymlに設定されたデータベースを作成
```
./rake.sh db:create
```

### アプリケーションの雛形（scaffold）の生成
 - PRIMARY KEYの"id"カラムは自動生成
```
./rails.sh generate scaffold Article title:string content:text
```

### テーブルのマイグレーションを実施
 - scaffoldで自動生成された`db\migrate\〜_create_articles.rb`が利用される
```
./rake.sh db:migrate
```

### Railsアプリケーションにアクセス
- http://localhost:3000/articles/

## Kotlin

### コントローラから`*.kt`を呼び出し

`kotlin-rails/app/controllers/articles_controller.rb` に下記を追記

```rb
# 先頭に追加
require 'java'
require './kotlin/build/libs/kotlin.jar'
import 'hello.HelloKt'

# before_actionメソッド内に記述
HelloKt.test()
```

標準出力に「Test, RailsKotlin!!!」と表示される
