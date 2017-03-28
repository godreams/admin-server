ruby '2.4.1'

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0'

gem 'dotenv-rails', '~> 2.2', groups: [:development, :test]

# Use PostgreSQL as the database for Active Record
gem 'pg', '~> 0.19'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '~> 3.1'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails', '~> 4.2'
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
gem 'seedbank', '~> 0.4'

# A library for generating fake data such as names, addresses, and phone numbers.
gem 'faker', '~> 1.7'

# Rack Middleware for handling Cross-Origin Resource Sharing (CORS), which makes cross-origin AJAX possible.
gem 'rack-cors', '~> 0.4'

# A pure ruby implementation of the RFC 7519 OAuth JSON Web Token (JWT) standard. http://jwt.github.io/ruby-jwt/
gem 'jwt', '~> 1.5'

# Form objects decoupled from models. http://www.trailblazer.to/gems/reform
gem 'reform-rails', '~> 0.1'

# Simple, efficient background processing for Ruby. http://sidekiq.org
gem 'sidekiq', '~> 4.2'

# Official integration library for using Rails and ActionMailer with the Postmark HTTP API.
gem 'postmark-rails', '~> 0.15'

# Used to generate dynmaic portions of agreement pdfs
gem 'prawn', '~> 2.1'

# Exception tracking and logging from Ruby to Rollbar.
gem 'rollbar', '~> 2.14'

# Convert numbers to words using I18N.
gem 'numbers_and_words', '~> 0.10'

# Bootstrap 4 Ruby Gem for Rails / Sprockets and Compass.
gem 'bootstrap', '~> 4.0.0.alpha6'

# Font-Awesome Sass gem for use in Ruby/Rails projects. https://github.com/FortAwesome/font-awesome-sass
gem 'font-awesome-sass', '~> 4.7.0'

# Flexible authentication solution for Rails with Warden. https://github.com/plataformatec/devise
gem 'devise', '~> 4.2'

# An invitation strategy for devise. https://github.com/scambra/devise_invitable
gem 'devise_invitable', '~> 1.7'

# Minimal authorization through OO design and pure Ruby classes. https://github.com/elabs/pundit
gem 'pundit', '~> 1.1'

# Rails form builder for Bootstrap. https://github.com/bootstrap-ruby/rails-bootstrap-forms
# TODO: Switch to official release when Bootstrap 4 final is out and this gem has been updated.
gem 'bootstrap_form', '~> 2.6', github: 'bootstrap-ruby/rails-bootstrap-forms', branch: 'bootstrap-v4'

# Track changes to your models' data. Good for auditing or versioning. https://github.com/airblade/paper_trail
gem 'paper_trail', '~> 6.0'

source 'https://rails-assets.org' do
  # A positioning engine to make overlays, tooltips and dropdowns better. Required by Bootstrap. https://github.com/HubSpot/tether
  gem 'rails-assets-tether', '~> 1.3'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', '~> 9.0', platform: :mri

  # RSpec for Rails-3+ http://relishapp.com/rspec/rspec-rails
  gem 'rspec-rails', '~> 3.5'

  # A library for setting up Ruby objects as test data https://github.com/thoughtbot/factory_girl_rails
  gem 'factory_girl_rails', '~> 4.8', require: false

  # An IRB alternative and runtime developer console. https://github.com/pry/pry-rails
  gem 'pry-rails', '~> 0.3'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '~> 3.3'

  gem 'listen', '~> 3.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring', '~> 2.0'
  gem 'spring-watcher-listen', '~> 2.0'

  # Preview mail in the browser instead of sending.
  gem 'letter_opener', '~> 1.4'

  # Gives letter_opener an interface for browsing sent emails.
  gem 'letter_opener_web', '~> 1.3'

  # A Ruby static code analyzer, based on the community Ruby style guide. http://rubocop.readthedocs.io
  gem 'rubocop', '~> 0.47', require: false
end

group :test do
  # Code coverage for Ruby 1.9+. https://github.com/colszowka/simplecov
  gem 'simplecov', '~> 0.12', require: false

  # Coveralls for Ruby. https://coveralls.io
  gem 'coveralls', '~> 0.8', require: false

  # Acceptance test framework for web applications. http://teamcapybara.github.io/capybara
  gem 'capybara', '~> 2.13', require: false

  # A PhantomJS driver for Capybara. https://github.com/teampoltergeist/poltergeist
  gem 'poltergeist', '~> 1.14', require: false

  # Automatically save screen shots when a Capybara scenario fails. https://github.com/mattheworiordan/capybara-screenshot
  gem 'capybara-screenshot', '~> 1.0', require: false

  # Test ActionMailer and Mailer messages with Capybara. https://github.com/DockYard/capybara-email
  gem 'capybara-email', '~> 2.5', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
