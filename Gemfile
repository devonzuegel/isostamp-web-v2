source 'https://rubygems.org'
ruby '2.3.0'

gem 'rails',                      '4.2.6'
gem 'sass-rails',                 '~> 5.0'
gem 'uglifier',                   '>= 1.3.0'
gem 'coffee-rails',               '~> 4.1.0'
gem 'jquery-rails',               '4.1.1'
gem 'turbolinks',                 '2.5.3'
gem 'jbuilder',                   '~> 2.0'
gem 'bootstrap-sass',             '3.3.6'
gem 'omniauth',                   '1.3.1'
gem 'omniauth-facebook',          '3.0.0'
gem 'slim-rails',                 '3.0.1'
gem 'unicorn',                    '5.1.0'
gem 'unicorn-rails',              '2.2.0'
gem 'pry-rails',                  '0.3.4'
gem 'figaro',                     '1.1.1'
gem 'redcarpet',                  '3.3.4'
gem 'carrierwave',                '0.11.0'
gem 'fog',                        '1.38.0'
gem 'fog-aws',                    '0.9.2'
gem 'pg',                         '0.18.4'
gem 'chartkick',                  '1.4.2'
gem 'groupdate',                  '2.5.2'
gem 'colorize',                   '0.7.7'
gem 'que',                        '0.11.4'
gem 'delayed_job_active_record'   # REMOVE ME
gem 'carrierwave_backgrounder'    # REMOVE ME
gem 'daemons'                     # REMOVE ME
gem 'aws-sdk-v1',                 '1.66.0'  # S3 API
gem 'paperclip',                  '4.3.6'   # File attachment syntax and callbacks
gem 's3_direct_upload',           '0.1.7'   # Direct upload form helper and assets
gem 'draper',                     '~> 1.3'  # github.com/drapergem/draper
gem 'mailgun-ruby',               '~>1.0.2', require: 'mailgun'
gem 'delayed_job_active_record'

group :development, :test do
  gem 'byebug'
  gem 'spring'

  gem 'factory_girl_rails'
  gem 'faker'
  gem 'rspec-rails'
  gem 'sqlite3'

  gem 'awesome_print'
  gem 'fuubar'
end

group :development do
  gem 'web-console',              '~> 2.0'
  gem 'better_errors'
  gem 'guard-bundler'
  gem 'guard-rails'
  gem 'guard-rspec'
  gem 'hub',                      :require => nil
  gem 'quiet_assets'
  gem 'rails_layout'
  gem 'rb-fchange',               :require => false
  gem 'rb-fsevent',               :require => false
  gem 'rb-inotify',               :require => false
  gem 'spring-commands-rspec'
end

group :production do
  gem 'rails_12factor'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'selenium-webdriver'
  gem 'que-testing',           '0.1.1', :require => false
end