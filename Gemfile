source 'https://rubygems.org'

gem 'rails', '3.2.8'
gem 'thin'
gem 'pry-rails'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'twitter-bootstrap-rails', :git => 'git://github.com/seyhunak/twitter-bootstrap-rails.git'
end

group :development, :test do
  gem 'pg'
  gem 'rspec-rails'
  gem 'simplecov', :require => false
  gem 'shoulda-matchers'
  gem 'quiet_assets'
  gem 'capybara'
  gem 'fabrication'
  gem 'faker'
end

group :test do
  gem 'shoulda'
  gem 'spork-rails'
  gem 'guard-rspec'
  gem 'guard-spork'
  gem 'guard-jasmine'
  gem 'database_cleaner'
  gem 'debugger'
end

group :production do
  gem 'pg'
end

gem 'jquery-rails'
gem "therubyracer"
gem "less-rails"
gem 'devise'
gem 'cancan'
gem 'rolify'
gem 'bootstrap-datepicker-rails', :require => 'bootstrap-datepicker-rails',
                                  :git => 'git://github.com/Nerian/bootstrap-datepicker-rails.git'

