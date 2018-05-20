source 'https://rubygems.org'
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Rails
gem 'rails'
gem 'bootsnap' # config/boot.rb

# debug
group :development do
  gem 'spring'
  gem 'spring-watcher-listen'
  gem 'better_errors' # エラー画面をデバッグしやすい形に整形してくれるGem
  gem 'binding_of_caller' # メソッド呼び出し元の binding で eval することができる（better_errors用）
  gem 'pry-rails' # https://qiita.com/silmisilon/items/8e08435204d8d08d09ff
  gem 'pry-byebug' # http://blog.toshimaru.net/rails-pry-byebug/
  gem 'pry-coolline'
  gem 'pry-doc' # ソースコードリーディング支援 https://qiita.com/joker1007/items/42f00b12c65bbec0e50a
  gem 'byebug'
  gem 'web-console'
  gem 'listen' # ファイルの変更を検知してそれをフックに何か処理ができるgem https://suin.io/536
  gem 'awesome_print' # デバッグに便利な表示メソッドを提供する gem
end

# Utility
gem 'dotenv-rails'
# gem 'trailblazer-rails' # ModelやControllerからビジネスロジックが無くなり3、Fat ModelやFat Controller問題が発生しない https://qiita.com/kazekyo/items/7594d71bc3e4934089b0
gem 'jp_prefecture'
# gem 'geocoder' # 地図情報をあれやこれや
gem 'money-rails' # お金のケタ区切り https://qiita.com/kento1218@github/items/b404aafff754af32db68
# gem 'letter_opener' # アプリ開発中にメールを確認する方法
# gem 'roadie-rails' # HTMLメールを送る
gem 'whenever'
gem 'rubocop'
gem 'guard-rubocop'
gem 'webpacker' # bundle exec rails webpacker:install

# Controller
# gem 'retryable' # 例外処理の回数を指定した処理が書ける https://qiita.com/giiko_/items/311a9d3869912daa9128
gem 'draper' # ビューのロジックをプレゼンテーション層へ委譲する

# Middleware
gem 'sidekiq'
gem 'sinatra', require: false
gem 'sidekiq-scheduler'
gem 'redis-namespace'
gem 'unicorn'
# gem 'rufo'
gem 'redis'
gem 'active_model_serializers' # Web API

# System
gem 'foreman'
gem 'turbolinks'
gem 'bundler-audit' # gemの脆弱性をチェックする
gem 'brakeman' # Railsのセキュリティチェックを行う
gem 'global' # config/global/ に設定ファイルを書くためのgem https://doruby.jp/users/maya/entries/%E3%80%90Rails%E3%80%91gem--global-%E3%81%AE%E4%BD%BF%E3%81%84%E6%96%B9%E3%80%90global%E3%80%91
# gem 'pundit' # ユーザにより動作を分けたいときに便利なgem
gem 'devise'

# Model
gem 'sqlite3'
gem 'mysql2'
gem 'bullet' # N+1問題の検出 https://maetoo11.hatenablog.com/entry/2016/03/14/212524
gem 'paranoia' # 論理削除支援 https://github.com/rubysherpas/paranoia
gem 'annotate' # schemaをmodelに書き出してくれる https://techracho.bpsinc.jp/ikeda-kazuyuki/2014_08_29/18876
gem 'groupdate' # モデルの日時を簡単にグルーピングできる https://github.com/ankane/groupdate
gem 'activerecord-import' # BULK INSERT をするための gem https://qiita.com/xend/items/79184ded56158ea1b97a
# gem 'hirb'          # モデルの出力結果を表形式で表示するGem
# gem 'hirb-unicode'  # 日本語などマルチバイト文字の出力時の出力結果のずれに対応
# gem 'paranoia' # 2018年にもなって論理削除はあり得ない

# View
gem 'slim-rails'
gem 'sass-rails'
gem 'simple_form'
gem 'uglifier' # UglifyJS2 という JavaScript のコード軽量化ライブラリを、Ruby で簡単に使えるようにした gem
gem 'jbuilder'
# gem 'active_model_serializers'
gem 'ransack'
# gem 'chartkick'
gem 'kaminari'
# gem 'materialize-sass'
# gem 'material_icons'
gem 'activeadmin' # いい感じのAdmin画面を作る https://qiita.com/hkusu/items/3b0fb7f94a254e2ed6fd
# gem 'view_source_map' # (by r7kamura) Rails、レンダリングされたHTMLのどこがどのpartialから来たのかをコメントとして埋める http://r7kamura.hatenablog.com/entry/2012/12/04/141911
# gem 'sitemap_generator' # https://qiita.com/hirotakasasaki/items/2c183dee5d890d5ab57a
# gem 'wicked_pdf' # PDF生成 https://qiita.com/simukappu/items/ab061a3ae5be8036488a

# Test
group :development do
  gem 'rspec-rails'
  gem 'guard-rspec'
  gem 'rspec-power_assert'
  gem 'rspec-parameterized'
  gem 'rspec-retry'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'database_rewinder' # (by amatsuda) Rspecのテスト後に、 Createで作成したTestデータをデータベースから削除する http://takapi86.hatenablog.com/entry/2017/04/02/164117
  gem 'database_cleaner'
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'timecop' # 日時のテスト http://ruby-rails.hatenadiary.com/entry/20141218/1418901424
  gem 'rack-mini-profiler' # 左上に実行時間が出る https://wonderwall.hatenablog.com/entry/2015/08/16/160845
  gem 'webmock'
  gem 'vcr' # Webmock支援 http://morizyun.github.io/blog/webmock-vcr-gem-rails/
  gem 'rspec-request_describer' # APIテストのため https://qiita.com/izumin5210/items/de614b5b5b2c44486e87
  gem 'json_spec' # JSONテストのため http://ohs30359.hatenablog.com/entry/2016/09/06/232738
  gem 'rspec-json_matcher' # JSONテストのため https://qiita.com/ma2shita/items/a75e43512b43cde712e6
  # gem 'autodoc' # APIドキュメント作成 https://qiita.com/Yarimizu14/items/82b67f9ee4fc5177096f
end

# Deploy
gem 'capistrano'
gem 'capistrano-rails'
gem 'capistrano-bundler'
gem 'capistrano-rbenv'
gem 'capistrano3-unicorn'

# Others
gem 'faraday'
gem "shrine"
gem 'smarter_csv'
