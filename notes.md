- # Steps to make this app:
    - ## Basic setup
        - rails new alpha-blog
        - rails generate controller pages
        - In case of mistake 
            - rails destroy controller pages
        - alpha_blog\config\routes.rb
            -   ```rb
                Rails.application.routes.draw do
                    root 'pages#home'
                    get 'about', to: 'pages#about'
                end 
                ```
        - alpha_blog\app\controllers\pages_controller.rb
            ```rb
                class PagesController < ApplicationController
                    def home
                    end
                    def about 
                    end
                end
            ```
        - create home.htm.erb and about.html.erb
            - alpha_blog\app\views\pages\
    - ## Production prep and deploy
        - Remove sqlitee gem from top of Gemfile to within group `:development, :test do` block
            ```rb
                group :development, :test do
                    gem "sqlite3", "~> 1.4"
                    gem "debug", platforms: %i[ mri mingw x64_mingw ]
                end
            ```  
        - Create a group production with postgressql gem
            ```rb
                group :production do
                    gem 'pg'
                end
            ```
        - bundle install --without production
            ```
            [DEPRECATED] The `--without` flag is deprecated because it relies on being remembered across bundler invocations, which bundler will no longer do in future versions. Instead please use `bundle config set --local without 'production'`, and stop using this flag
            ```
        - bundle config set --local without 'production'
        - ## Heroku CLI install
            - npm install -g heroku
            - heroku --version
        - ## Heroku deploy
            - heroku login
            - heroku create
            - commit all changes
            - **git push heroku main**
            - heroku rename newname
            - heroku open
    - ## Rails naming conventions
        - Model name: article
        - Article model file name: article.rb
        - Article model class name: Article
        - Table name: articles
    - ## Generate a migration file
        - rails generate migration create_articles
        - add `t.string :title` to db\migrate\20221026131032_create_articles.rb
        - rails db:migrate
        - to undo the last migration:
            - rails db:rollback
        - **to make changes to the database setup we should create a new migration file**
            - don`t change the existing migration file!!!
        - rails generate migration add_description_to_articles
        - change db\migrate\20221026132222_add_description_to_articles.rb to:
            ```rb
                class AddDescriptionToArticles < ActiveRecord::Migration[7.0]
                    def change
                        add_column :articles, :description, :text 
                    end
                end
            ```


---

- Useful Things
    - Change view to preview .md files
        - ctrl + shift + v