# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.4.5"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.2.2.1"

gem "propshaft"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 6.6"

# Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
gem "jsbundling-rails"

# Bundle and process CSS [https://github.com/rails/cssbundling-rails]
gem "cssbundling-rails"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

gem "tzinfo-data"

gem "haml-rails", "~> 2.0"

gem "meta-tags", "~> 2.22"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

gem "citizens_advice_components",
    github: "citizensadvice/design-system",
    tag: "v8.1.0",
    glob: "engine/*.gemspec"

gem "citizens_advice_form_builder",
    github: "citizensadvice/rails-form-builder",
    tag: "v0.2.0"

gem "view_component", "~> 3.23"

gem "datadog"
gem "factory_bot_rails"
gem "faraday"
gem "faraday-net_http_persistent"
gem "graphql-client"
gem "preserve"
gem "rails_semantic_logger"
gem "rich_text_renderer"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "bundler-audit"
  gem "citizens-advice-style", github: "citizensadvice/citizens-advice-style-ruby"
  gem "debug", platforms: %i[mri mingw x64_mingw]
  gem "dotenv-rails"
  gem "haml-lint", require: false
  gem "hashie"
  gem "rails-controller-testing"
  gem "rspec-its"
  gem "rspec-rails"
  gem "rubocop-rails"
  gem "vcr"
  gem "webmock"
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
  gem "brakeman"
  gem "license_finder"
  gem "pry-remote"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "capybara_accessible_selectors", github: "citizensadvice/capybara_accessible_selectors", tag: "v0.12.0"
  gem "climate_control"
  gem "cucumber-rails", require: false
  gem "selenium-webdriver"
  gem "webdrivers"
end

gem "wizard_steps", "~> 0.1.4"
