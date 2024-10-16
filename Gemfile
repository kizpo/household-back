source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.3.4"

# Use Rails version 7.0.8.4
gem "rails", "7.0.8.4"

# Use mysql as the database for Active Record
gem "mysql2", "~> 0.5"

# Use Puma web server
gem "puma", "5.6.8"

# Use Rack gem
gem "rack", "2.2.9"

# Use method_source gem
gem "method_source", "1.1.0"

# Use rack-cors gem
gem 'rack-cors'

# Use Active Job's default adapter
gem "activejob", "7.0.8.4"

# Use Active Model
gem "activemodel", "7.0.8.4"

# Use Active Record
gem "activerecord", "7.0.8.4"

# Use Active Storage
gem "activestorage", "7.0.8.4"

# Use Action Mailer
gem "actionmailer", "7.0.8.4"

# Use Action Mailbox
gem "actionmailbox", "7.0.8.4"

# Use Action Text
gem "actiontext", "7.0.8.4"

# Use Action Pack
gem "actionpack", "7.0.8.4"

# Use Action View
gem "actionview", "7.0.8.4"

# Use Action Cable
gem "actioncable", "7.0.8.4"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

gem "jwt", "2.8.2"

gem "net-imap", "0.4.15"

gem "minitest", "5.25.1"

gem "thor", "1.3.2"

gem 'bcrypt', '~> 3.1.7'
# Use Active Storage variants
# gem "image_processing", "~> 1.2"

gem 'bigdecimal'

gem 'mutex_m'

gem 'csv'

group :development, :test do
  # Debugging gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  # Speed up commands on slow machines / big apps
  # gem "spring"
end
