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
        - check schema.rb to confirm changes
    - ## Create articles model
        - create article.rb on app/models/
        - add code:
            ```rb
                class Article < ApplicationRecord

                end
            ```
        - open rails console: rails console or rails c
        - test connection to articles table:
            - Articles.all
                - executes a sql query and returns []
    - ## Create articles using rails console
        - First method
            - Article.create(title: "first article", description: "lorem ipsum")
        - Second method
            - article = Article.new
            - article.title = "second article"
            - article.description = "second description"
            - article.save
            - article - to check object
        - Third method
            - article = Article.new(title: "third article", description: "lorem ipsum")
            - article.save
        - Article.all
        - exit
    - ## Rest of CRUD functions
        - Read:
            - Article.find(2) - returns article with id 2
            - Article.last
            - article = Article.find(2)
            - Article.find(2).title or Article.last.title or article.title ...
        - Update:
            - article.title = "edited second title"
            - article.save
        - Delete: 
            - article.destroy
		- ## Add constraints to Article model
			- add to article.rb:
				`validates :title, presence: true`
			- rails c
				- reload!
				- article = Article.new
				- article.save
					- returns false
				- article.errors.full_messages
					- returns ["Title can't be blank"]
			- add `validates :description, presence: true`
			- articles.rb at this point:
				```rb
				class Article < ApplicationRecord
					validates :title, presence: true, length: { minimum: 6, maximum: 100 }
					validates :description, presence: true, length: { minimum: 10, maximum: 300 }
				end
				```
		- ## Show articles
			- add to routes.rb:
				- `resources :articles, only: [:show]`
			- rails routes --expanded
				- to check routes
		- ## Build the controller without magic
			- create articles_controller.rb
				```rb
				class ArticlesController < ApplicationController
					def show
							
					end
				end
				```
			- create articles/ on views/
				- create show.html.erb
				- to evaluate ruby code on .html.erb
					- <% [code] %>
				- to evaluate and run ruby code on .html.erb
					- <%= [code] %>
		- ## Debugger
			- insert 'debugger' in code to stop execution there.
			- example:
				```rb
				class ArticlesController < ApplicationController
					def show
						debugger
						@article = Article.find(params[:id])			
					end
				end
				```
			- opens a debug console
			- `params[:id]` to show what param is being received



---

- Useful Things
    - Change view to preview .md files
        - ctrl + shift + v