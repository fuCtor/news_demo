require 'capybara/rspec'
require 'database_cleaner'
require 'factory_girl'
require 'vcr'
require 'pry'

# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../../config/environment.rb", __FILE__)
require 'rspec/rails'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassetes'
  c.hook_into :webmock
  c.ignore_localhost = true
  c.default_cassette_options = { record: :new_episodes }
end

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do |example|
    if example.metadata[:type] == :feature
      DatabaseCleaner.strategy = :truncation
    else
      DatabaseCleaner.strategy = :transaction
    end
    DatabaseCleaner.start
  end

  config.append_after(:each) do
    DatabaseCleaner.clean
  end

  config.order = 'random'
end
