## 講義用メモ

### railsアプリを作成する

Gemfile作成
```
> bundle init
```

Gemfile書き換え
```a.rb
-  # gem 'rails', '~> 5.2.0'
+  gem 'rails', '~> 5.2.0'
```

gemたちをインストール
```  
> bundle install --path vendor/bundler
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
> bundle exec rails g controller Home index
```

body直下に下記のものを加える。
```/app/views/layout/application.html.erb
  <body>
+   <p class="notice"><%= notice %></p>
+   <p class="alert"><%= alert %></p>
    <%= yield %>
  </body>
```

デバイスのviewを作成
```
> bundle exec rails g devise:views
```

参考の記事
https://qiita.com/cigalecigales/items/f4274088f20832252374

---

### User登録できるようにする

deviseのUserモデルの作成
```
> bundle exec rails g devise User
```

DBをマイグレーションする
```
> bundle exec rails db:migrate
```

viewに下記のものを追加

```/app/views/layout/application.html.erb
+ <nav>
+   <% if user_signed_in? %>
+     <strong><%= link_to current_user.username, pages_show_path %></strong>
+     <%= link_to 'プロフィール変更', edit_user_registration_path %>
+     <%= link_to 'ログアウト', destroy_user_session_path, method: :delete %>
+   <% else %>
+     <%= link_to 'サインアップ', new_user_registration_path %>
+     <%= link_to 'ログイン', new_user_session_path %>
+   <% end %>
+ </nav>
```

### Userにデフォルト以外のカラムを追加
今回はusernameを追加

usernameを追加するマイグレーションファイルの作成
```
bundle exec rails g migration username
```

そのマイグレーションファイルに`username`と`name`のカラムを追加する
```db/migrate/2018××××××××××××_username.rb
  class Username < ActiveRecord::Migration[5.2]
    def change
+     add_column :users, :name, :string
+     add_column :users, :username, :string
    end
  end
```

DBをマイグレーションする
```
> bundle exec rails db:migrate
```

登録するフォームを作る
```app/view/registration.html.erb
+ <div class="field">
+   <%= f.label :username %><br />
+   <%= f.text_field :username, autofocus: true, autocomplete: "username" %>
+ </div>
```

DBに登録できるようコントローラーに設定する
```app/controller/application_controller.rb
+   before_action :configure_permitted_parameters, if: :devise_controller?

+   protected
+     def configure_permitted_parameters
+       devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :username])
+     end  
```

viewに表示させる
```app/view/leyouts/application.html.erb
+  <% if user_signed_in? %>
+   こんにちは <%= current_user.username %>さん
+  <% end %>
```
