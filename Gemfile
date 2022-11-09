source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.6'

gem 'rails', '~> 7.0.3', '>= 7.0.3.1'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'redis', '~> 4.0'
gem 'sidekiq', '~> 7.0'
gem 'http', '~> 5.1'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'bootsnap', require: false
gem 'redis-rails', '~> 5.0'
# gem "rack-cors"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'guard-rspec', require: false
  gem 'rspec-rails', '~> 6.0'
  gem 'dotenv-rails'
end

group :development do
  gem 'rubocop', '~> 1.38'
  gem 'spring'
end

group :test do
  gem 'factory_bot_rails', '~> 6.2'
  gem 'shoulda-matchers', '~> 5.0'
  gem 'webmock', '~> 3.18'
  gem 'simplecov', '~> 0.21.2', require: false
end
