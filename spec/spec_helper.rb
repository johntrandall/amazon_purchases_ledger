require "bundler/setup"
require "amazon_csv_combiner"
require 'pry'


module FixtureCsvPaths
  def path1
    'spec/fixtures/orders.csv'
  end

  def path2
    'spec/fixtures/items.csv'
  end
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include FixtureCsvPaths
end


