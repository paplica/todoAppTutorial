## 講義用メモ 

### railsアプリを作成する

Gemfile作成
```
> bundle init 
```

Gemfile書き換え
```
- # gem 'rails', '~> 5.2.0'
+ gem 'rails', '~> 5.2.0'
```

gemたちをインストール
```  
> bundle install
```

railsアプリを入れる
```
> bundle exec rails new --skip-turbolinks --skip-test .
```
---

### deviseを導入する

Gemfileに追記
```
# Devise
gem 'devise'
gem 'omniauth-twitter'
```

新規gemちゃんインストール
```
> bundle install
```

deviseをgenerateする
```
> bundle exec rails g devise:install
```

そしたらこんな表示でる
```
===============================================================================

Some setup you must do manually if you haven't yet:

  1. Ensure you have defined default url options in your environments files. Here
     is an example of default_url_options appropriate for a development environment
     in config/environments/development.rb:

       config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

     In production, :host should be set to the actual host of your application.

  2. Ensure you have defined root_url to *something* in your config/routes.rb.
     For example:

       root to: "home#index"

  3. Ensure you have flash messages in app/views/layouts/application.html.erb.
     For example:

       <p class="notice"><%= notice %></p>
       <p class="alert"><%= alert %></p>

  4. You can copy Devise views (for customization) to your app by running:

       rails g devise:views

===============================================================================
```

それに従って書き換える
```config/environments/development.rb
# mailer setting
config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
```

controllerとりあえず作成
```
> bundle rails g controller Homes index
```

参考の記事
https://qiita.com/cigalecigales/items/f4274088f20832252374

