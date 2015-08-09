# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../../config/environment", __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require "spec_helper"
require "rspec/rails"

# Add additional requires below this line. Rails is not loaded until this point!
require "capybara/rails"
require "capybara/email/rspec"
require "faker"
require "nobrainer"

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.include AuthenticationHelpers::Controller, type: :controller
  config.include AuthenticationHelpers::Feature, type: :feature
  config.infer_spec_type_from_file_location!
  config.use_transactional_fixtures = false

  config.before(:all) do
    NoBrainer.drop!
    NoBrainer.sync_schema
  end

  config.before(:each) do
    NoBrainer.purge!
    # NoBrainer::Loader.cleanup
  end

#  config.before(:suite) do
#    DatabaseCleaner.clean_with(:truncation)
#  end

#  config.before(:each) do
    # DatabaseCleaner.strategy = :transaction
#    DatabaseCleaner.strategy = :truncation
#  end

#  config.before(:each, js: true) do
#    DatabaseCleaner.strategy = :truncation
#  end

#  config.before(:each) do
#    DatabaseCleaner.start
#  end

#  config.after(:each) do
#    DatabaseCleaner.clean
#  end
end
