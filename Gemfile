ruby '2.4.0'

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.2'

gem 'dotenv-rails', groups: [:development, :test]

# Use PostgreSQL as the database for Active Record
gem 'pg'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

# # Better DB seeding. https://github.com/james2m/seedbank
gem 'seedbank'

# A library for generating fake data such as names, addresses, and phone numbers.
gem 'faker'

# Rack Middleware for handling Cross-Origin Resource Sharing (CORS), which makes cross-origin AJAX possible.
gem 'rack-cors'

# A pure ruby implementation of the RFC 7519 OAuth JSON Web Token (JWT) standard. http://jwt.github.io/ruby-jwt/
gem 'jwt'

# Form objects decoupled from models. http://www.trailblazer.to/gems/reform
gem 'reform-rails'

# Simple, efficient background processing for Ruby. http://sidekiq.org
gem 'sidekiq'

# Official integration library for using Rails and ActionMailer with the Postmark HTTP API.
gem 'postmark-rails'

# Used to generate dynmaic portions of agreement pdfs
gem 'prawn'

# Exception tracking and logging from Ruby to Rollbar.
gem 'rollbar'

# Convert numbers to words using I18N.
gem 'numbers_and_words'

# Bootstrap 4 Ruby Gem for Rails / Sprockets and Compass.
gem 'bootstrap', '~> 4.0.0.alpha6'

# Font-Awesome Sass gem for use in Ruby/Rails projects. https://github.com/FortAwesome/font-awesome-sass
gem 'font-awesome-sass', '~> 4.7.0'

# Flexible authentication solution for Rails with Warden. https://github.com/plataformatec/devise
gem 'devise'

# An invitation strategy for devise. https://github.com/scambra/devise_invitable
gem 'devise_invitable'

# Minimal authorization through OO design and pure Ruby classes. https://github.com/elabs/pundit
gem 'pundit'

# Rails form builder for Bootstrap. https://github.com/bootstrap-ruby/rails-bootstrap-forms
# TODO: Switch to official release when Bootstrap 4 final is out and this gem has been updated.
gem 'bootstrap_form', github: 'bootstrap-ruby/rails-bootstrap-forms', branch: 'bootstrap-v4'

source 'https://rails-assets.org' do
  # A positioning engine to make overlays, tooltips and dropdowns better. Required by Bootstrap. https://github.com/HubSpot/tether
  gem 'rails-assets-tether', '>= 1.3.3'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri

  # RSpec for Rails-3+ http://relishapp.com/rspec/rspec-rails
  gem 'rspec-rails'

  # A library for setting up Ruby objects as test data https://github.com/thoughtbot/factory_girl_rails
  gem 'factory_girl_rails', require: false

  # An IRB alternative and runtime developer console. https://github.com/pry/pry-rails
  gem 'pry-rails'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'

  gem 'listen', '~> 3.0.5'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # Preview mail in the browser instead of sending.
  gem 'letter_opener'

  # Gives letter_opener an interface for browsing sent emails.
  gem 'letter_opener_web'
end

group :test do
  # Code coverage for Ruby 1.9+. https://github.com/colszowka/simplecov
  gem 'simplecov', require: false

  # Coveralls for Ruby. https://coveralls.io
  gem 'coveralls', require: false

  # Acceptance test framework for web applications. http://teamcapybara.github.io/capybara
  gem 'capybara', require: false

  # A PhantomJS driver for Capybara. https://github.com/teampoltergeist/poltergeist
  gem 'poltergeist', require: false

  # Automatically save screen shots when a Capybara scenario fails. https://github.com/mattheworiordan/capybara-screenshot
  gem 'capybara-screenshot', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
