ENV['TEST']='TRUE'

require "bundler/setup"
require "amazon_purchases_ledger"
require 'pry'


module FixtureCsvDetails
  def path1
    'spec/fixtures/orders.csv'
  end

  def path2
    'spec/fixtures/items.csv'
  end

  def orders_csv
    AmazonPurchasesLedger::MergeService.new(path1, path2).orders_csv
  end

  def items_csv
    AmazonPurchasesLedger::MergeService.new(path1, path2).items_csv
  end

  def order_id
    order_id_shipped
  end

  def order_id_shipped
    '114-6538430-6195405'
  end

  def order_id_unshipped
    '114-9487673-0555460'
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

  config.include FixtureCsvDetails
end


